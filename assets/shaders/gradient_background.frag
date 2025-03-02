#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

out vec4 fragColor;

vec3 palette(float t) {
  // Базовые цвета градиента (голубой, зеленый и нейтральный цвет в центре)
  vec3 a = vec3(0.5, 0.5, 0.5);
  vec3 b = vec3(0.5, 0.5, 0.5);
  vec3 c = vec3(1.0, 1.0, 1.0);
  vec3 d = vec3(0.3, 0.2, 0.2);

  // Голубой полюс
  vec3 blue = vec3(0.1, 0.4, 0.8);
  // Зеленый полюс
  vec3 green = vec3(0.1, 0.8, 0.4);
  // Смешивание цветов
  return a + b * cos(6.28318 * (c * t + d)) +
         mix(blue, green, sin(uTime * 0.05 + t * 3.0) * 0.5 + 0.5);
}

void main() {
  // Нормализованные координаты пикселя
  vec2 uv = FlutterFragCoord().xy / uResolution;

  // Смещение для анимации
  float tx = 0.3 * sin(uTime * 0.05);
  float ty = 0.3 * cos(uTime * 0.05);

  // Создаем зернистость
  vec2 center = vec2(0.5 + tx, 0.5 + ty);
  float dist = length(uv - center);

  // Плавное смешивание цветов
  vec3 color = palette(dist + uTime * 0.05);

  // Добавляем зернистость/шум
  float noise = fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
  color += noise * 0.02;

  // Эффект размытия через сглаживание
  color = smoothstep(0.0, 1.0, color);

  // Итоговый цвет с прозрачностью
  fragColor = vec4(color, 1.0);
}