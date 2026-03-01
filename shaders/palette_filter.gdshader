shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

uniform int num_colors;
uniform sampler2D palette_in;
uniform sampler2D palette_out;
uniform float precision : hint_range(0.0, 1.0, 0.2) = 0.1;
uniform float brightness : hint_range(0.0, 2.0, 0.1) = 1.0;
uniform bool transparent_bg = false;

vec4 swap_color(vec4 color) {
  float inc = 1.0 / float(num_colors);
  float min_dist = 999999.0;
  vec4 closest_color = color;

  // Get the first color in the input palette for transparency check
  vec4 first_color_in = texture(palette_in, vec2(inc / 2.0, 0.0));

  for (float i = 0.0; i < 1.0; i += inc) {
    vec2 uv = vec2(i + (inc / 2.0), 0.0);
    vec4 color_in = texture(palette_in, uv);
    float dist = distance(color, color_in);

    if (dist <= precision) {
      vec4 result = texture(palette_out, uv);
      // If transparent_bg is enabled and this matches the first color, make it transparent
      if (transparent_bg && distance(color_in, first_color_in) <= precision) {
        result.a = 0.0;
      }
      return result;
    }

    if (dist < min_dist) {
      min_dist = dist;
      closest_color = texture(palette_out, uv);
      // If transparent_bg is enabled and this is the first color, make it transparent
      if (transparent_bg && distance(color_in, first_color_in) <= precision) {
        closest_color.a = 0.0;
      }
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
