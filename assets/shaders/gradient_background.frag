#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

out vec4 fragColor;

float random(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

float grain(vec2 fragCoord, float intensity) {
    float noise = random(fragCoord * 0.5);
    return (noise - 0.5) * intensity; // Balanced noise
}

vec3 blurColor(vec3 color, float blurAmount) {
    float factor = clamp(blurAmount * 0.001, 0.0, 0.5);

    vec3 blurred = color * (1.0 - factor) + vec3(0.2) * factor;

    return clamp(blurred, 0.0, 1.0);
}

void main()
{
    vec2 uv = FlutterFragCoord().xy / uResolution.xy;

    float blur400 = 400.0;
    float blur230 = 230.0;
    float blur370 = 370.0;
    float blur300 = 300.0;

    vec3 topLeft     = blurColor(vec3(0.0, 0.0, 1.0) , blur400);
    vec3 topRight    = blurColor(vec3(1.0, 0.561, 0.0), blur370);
    vec3 bottomLeft  = blurColor(vec3(0.0, 0.784, 0.325), blur400);
    vec3 bottomRight = blurColor(vec3(0.3, 0.9, 0.5), blur230);
    vec3 midColor    = vec3(0.8, 0.5, 0.6);

    vec3 top = mix(topLeft, topRight, smoothstep(0.0, 1.0, uv.x));
    vec3 bottom = mix(bottomLeft, bottomRight, smoothstep(0.0, 1.0, uv.x));
    vec3 gradient = mix(top, bottom, smoothstep(0.0, 1.0, uv.y));

    float noiseIntensity = 0.1;
    float noise = grain(FlutterFragCoord().xy, noiseIntensity);

    vec3 finalColor = gradient + vec3(noise);
    finalColor = pow(finalColor, vec3(1.0 / 2.2));

    fragColor = vec4(finalColor, 1.0);
}