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
// Функция для создания зернистости
float grain(vec2 uv, float time) {
    float x = (uv.x + 4.0) * (uv.y + 4.0) * (time * 10.0);
    return fract(sin(x) * 43758.5453);
}

void main() {
  // Нормализованные координаты пикселя
  vec2 uv = FlutterFragCoord().xy / uResolution;

  // Смещение из-за времени для анимации
  vec2 movement = vec2(uTime * 0.005, uTime * 0.003);

  // Создаем несколько слоев шума с разной частотой
  float n1 = fbm(uv * 1.5 + movement);
  float n2 = fbm(uv * 2.0 - movement * 0.5);
  float n3 = fbm(uv * 3.0 + vec2(movement.y, -movement.x));

  // Комбинируем шумы для создания более сложной формы
  float finalNoise = n1 * 0.5 + n2 * 0.3 + n3 * 0.2;

  // Добавляем центральность для бежевого
  // Расстояние от центра (будет маленьким в центре и большим по краям)
  float distFromCenter = length(uv - vec2(0.5, 0.5));

  // Модифицируем шум, делая его меньше в центре
  float modifiedNoise = finalNoise + distFromCenter * 0.7;

  // Обновленная палитра
  vec3 lightBlue = vec3(163.0/255.0, 199.0/255.0, 232.0/255.0);  // #A3C7E8 - Голубой
  vec3 lightGreen = vec3(169.0/255.0, 228.0/255.0, 200.0/255.0); // #A9E4C8 - Светло-зеленый
  vec3 beige = vec3(232.0/255.0, 213.0/255.0, 163.0/255.0);      // #E8D5A3 - Песочный
  vec3 brightGreen = vec3(110.0/255.0, 207.0/255.0, 105.0/255.0); // #6ECF69 - Ярко-зеленый

  // Создаем плавный переход между цветами с большим акцентом на бежевый
  vec3 color;
  if (modifiedNoise < 0.5) {  // Увеличили порог для бежевого
    float t = modifiedNoise / 0.5;
    color = mix(beige, lightBlue, t);
  } else if (modifiedNoise < 0.75) {
    float t = (modifiedNoise - 0.5) / 0.25;
    color = mix(lightBlue, lightGreen, t);
  } else {
    float t = (modifiedNoise - 0.75) / 0.25;
    color = mix(lightGreen, brightGreen, t);
  }

  // Добавляем зернистость
  float grainAmount = 0.07;
  float grainValue = grain(uv, uTime) * grainAmount;
  color = color * (1.0 - grainAmount) + color * grainValue;

  // Итоговый цвет
  fragColor = vec4(color, 1.0);
}