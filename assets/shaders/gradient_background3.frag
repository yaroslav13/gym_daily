#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

out vec4 fragColor;

// Функция для шума Перлина (упрощенная версия)
float noise(vec2 p) {
  vec2 i = floor(p);
  vec2 f = fract(p);
  vec2 u = f * f * (3.0 - 2.0 * f);

  float a = fract(sin(dot(i, vec2(127.1, 311.7))) * 43758.5453);
  float b = fract(sin(dot(i + vec2(1.0, 0.0), vec2(127.1, 311.7))) * 43758.5453);
  float c = fract(sin(dot(i + vec2(0.0, 1.0), vec2(127.1, 311.7))) * 43758.5453);
  float d = fract(sin(dot(i + vec2(1.0, 1.0), vec2(127.1, 311.7))) * 43758.5453);

  return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

// Функция fbm (fractional Brownian motion) для создания более сложного шума
float fbm(vec2 p) {
  float value = 0.0;
  float amplitude = 0.5;
  float frequency = 3.0;

  for (int i = 0; i < 5; i++) {
    value += amplitude * noise(p * frequency);
    amplitude *= 0.5;
    frequency *= 2.0;
  }

  return value;
}

void main() {
  // Нормализованные координаты пикселя
  vec2 uv = FlutterFragCoord().xy / uResolution;

  // Смещение из-за времени для анимации
  vec2 movement = vec2(uTime * 0.01, uTime * 0.005);

  // Создаем несколько слоев шума с разной частотой
  float n1 = fbm(uv * 1.5 + movement);
  float n2 = fbm(uv * 2.0 - movement * 0.5);
  float n3 = fbm(uv * 3.0 + vec2(movement.y, -movement.x));

  // Комбинируем шумы для создания более сложной формы
  float finalNoise = n1 * 0.5 + n2 * 0.3 + n3 * 0.2;

  // Определяем цвета для градиента
  vec3 color1 = vec3(0.0, 0.9, 1.0);  // Голубой
  vec3 color2 = vec3(0.0, 0.2, 0.9);  // Синий
  vec3 color3 = vec3(1.0, 1.0, 1.0);  // Белый

  // Создаем плавный переход между цветами на основе шума
  vec3 color;
  if (finalNoise < 0.4) {
    float t = finalNoise / 0.4;
    color = mix(color3, color1, t);
  } else {
    float t = (finalNoise - 0.4) / 0.6;
    color = mix(color1, color2, t);
  }

  // Добавляем легкое свечение в зависимости от позиции
  float glow = 0.05 * sin(uTime * 0.1 + uv.x * 10.0) * sin(uTime * 0.13 + uv.y * 10.0);
  color += glow;

  // Итоговый цвет
  fragColor = vec4(color, 1.0);
}