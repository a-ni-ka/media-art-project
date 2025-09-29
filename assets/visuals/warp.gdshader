shader_type canvas_item;

// made by imjustnerdio on godotshaders.com
uniform float alpha : hint_range(0.0, 1.0, 0.1) = 1.0; // blend strength of the effect
uniform float strength : hint_range(0.0, 1.0) = 0.34;
uniform float speed : hint_range(0.0, 2.0) = 0.333;

void fragment() {
    float t = TIME * speed;
    vec3 effect = vec3(0.0);

    // Use the canvas_item UV so we sample the item's texture
    vec2 uv = UV;

    // Aspect correction using the texture resolution
    vec2 tex_res = 1.0 / TEXTURE_PIXEL_SIZE; // pixels in x,y
    vec2 pos = uv * 2.0 - 1.0; // center to [-1,1]
    pos.y *= (tex_res.y / tex_res.x);
    pos *= 4.0; // scale effect

    for (float k = 1.0; k < 7.0; k += 1.0) {
        pos.x += strength * sin(2.0 * t + k * 1.5 * pos.y) + t * 0.5;
        pos.y += strength * cos(2.0 * t + k * 1.5 * pos.x);
    }

    effect += 0.5 + 0.5 * cos(TIME + pos.xyx + vec3(0.0, 2.0, 4.0));
    effect = pow(effect, vec3(0.4545));

    // Sample the existing canvas_item texture
    vec4 base = texture(TEXTURE, uv);

    // Blend: replace the base color with the effect by alpha.
    // Change the mix() to another blend if you prefer (e.g., add, multiply).
    vec3 out_rgb = mix(base.rgb, effect, alpha);

    COLOR = vec4(out_rgb, base.a);
}
