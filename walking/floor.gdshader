shader_type spatial;

uniform vec2 line_width = vec2(0.05, 0.05);
uniform vec2 uv_scale = vec2(10.0, 10.0);

float pristineGrid(vec2 uv, vec2 lineWidth) {
    vec2 ddx = dFdx(uv);
    vec2 ddy = dFdy(uv);
    vec2 uvDeriv = vec2(length(vec2(ddx.x, ddy.x)), length(vec2(ddx.y, ddy.y)));
    bvec2 invertLine = bvec2(lineWidth.x > 0.5, lineWidth.y > 0.5);
    vec2 targetWidth = vec2(
        invertLine.x ? 1.0 - lineWidth.x : lineWidth.x,
        invertLine.y ? 1.0 - lineWidth.y : lineWidth.y
    );
    vec2 drawWidth = clamp(targetWidth, uvDeriv, vec2(0.5));
    vec2 lineAA = uvDeriv * 1.5;
    vec2 gridUV = abs(fract(uv) * 2.0 - 1.0);
    gridUV.x = invertLine.x ? gridUV.x : 1.0 - gridUV.x;
    gridUV.y = invertLine.y ? gridUV.y : 1.0 - gridUV.y;
    vec2 grid2 = smoothstep(drawWidth + lineAA, drawWidth - lineAA, gridUV);
    grid2 *= clamp(targetWidth / drawWidth, 0.0, 1.0);
    grid2 = mix(grid2, targetWidth, clamp(uvDeriv * 2.0 - 1.0, 0.0, 1.0));
    grid2.x = invertLine.x ? 1.0 - grid2.x : grid2.x;
    grid2.y = invertLine.y ? 1.0 - grid2.y : grid2.y;
    return mix(grid2.x, 1.0, grid2.y);
}

void fragment() {
    vec2 uv = UV * uv_scale;
    float grid_val = pristineGrid(uv, line_width);
    ALBEDO = vec3(grid_val);
}