#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uResolution;
uniform float uTime;

out vec4 fragColor;

void main() {
  // Нормализованные координаты пикселя
  vec2 uv = FlutterFragCoord().xy / uResolution;

  // Вычисляем положение центра градиента
  // Для данного изображения центр смещен немного влево от центра экрана
  vec2 center = vec2(0.35, 0.5);

  // Расстояние от текущего пикселя до центра
  float dist = length(uv - center);

  // Создаем базовый радиальный градиент
  // Белый в центре, затем голубой, затем синий
  vec3 color;

  // Белый центр
  if (dist < 0.2) {
    float t = dist / 0.2; // Нормализуем значение от 0 до 1
    color = mix(vec3(1.0, 1.0, 1.0), vec3(0.0, 0.9, 1.0), t);
  }
  // Голубой к синему
  else if (dist < 0.6) {
    float t = (dist - 0.2) / 0.4; // Нормализуем значение от 0 до 1
    color = mix(vec3(0.0, 0.9, 1.0), vec3(0.0, 0.2, 0.9), t);
  }
  // Синий к более темному синему
  else {
    float t = (dist - 0.6) / 0.4; // Нормализуем значение от 0 до 1
    t = min(t, 1.0); // Ограничиваем максимальное значение до 1
    color = mix(vec3(0.0, 0.2, 0.9), vec3(0.0, 0.0, 0.5), t);
  }

  // Добавляем небольшую анимацию "дыхания" для оживления градиента
  float breathing = 1.0 + 0.03 * sin(uTime * 0.5);
  color *= breathing;

  // Итоговый цвет с прозрачностью
  fragColor = vec4(color, 1.0);
}