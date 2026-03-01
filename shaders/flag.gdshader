shader_type canvas_item;

uniform float speed = 2.0;
uniform float frequency_y = 5.0;
uniform float amplitude_y = 4.0;

void vertex() {
	VERTEX.y += sin((UV.y - TIME * speed) * frequency_y) * amplitude_y * UV.x;
}
