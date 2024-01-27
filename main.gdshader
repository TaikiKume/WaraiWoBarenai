shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// 色を取得
    vec4 color = texture(TEXTURE, UV);
    // アルファ値以外を置き換える
    color.rgb = vec3(1, 1, 1);
    // 反映
    COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
