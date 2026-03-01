shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform int num_colors;
uniform sampler2D palette_in;
uniform sampler2D palette_out;
uniform float precision : hint_range(0.0, 1.0, 0.2) = 0.1;
uniform float brightness : hint_range(0.0, 2.0, 0.1) = 1.0;

vec4 swap_color(vec4 color) {
  float inc = 1.0 / float(num_colors);
  float min_dist = 999999.0;
  vec4 closest_color = color;

  for (float i = 0.0; i < 1.0; i += inc) {
    vec2 uv = vec2(i + (inc / 2.0), 0.0);
    vec4 color_in = texture(palette_in, uv);
    float dist = distance(color, color_in);

    if (dist <= precision) {
      return texture(palette_out, uv);
    }

    if (dist < min_dist) {
      min_dist = dist;
      closest_color = texture(palette_out, uv);
    }
  }

  return closest_color;
}

void fragment() {
	vec4 color = texture(screen_texture, SCREEN_UV);
	color.rgb *= brightness;
	color.rgb = clamp(color.rgb, 0.0, 1.0);
	COLOR = swap_color(color);
}
