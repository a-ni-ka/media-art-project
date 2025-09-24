shader_type canvas_item;

uniform float tolerance: hint_range(0.0, 1.0, 0.01) = 0.1;
uniform vec4 prev_color_1: source_color = vec4(1.0);
uniform vec4 new_color_1: source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 prev_color_2: source_color = vec4(1.0);
uniform vec4 new_color_2: source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
    vec4 color = texture(TEXTURE, UV);
    vec4 initial_color = color;

	float color_distance_1 = distance(prev_color_1, color);
	float color_distance_2 = distance(prev_color_2, color);

    if (color_distance_1 <= tolerance) {
		color = mix(new_color_1, color, color_distance_1);
		color.a = initial_color.a;
    }

	if (color_distance_2 <= tolerance) {
		color = mix(new_color_2, color, color_distance_2);
		color.a = initial_color.a;
    }

    COLOR = color;
}
