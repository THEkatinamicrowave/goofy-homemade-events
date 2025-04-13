#pragma header

void main() {
    // Shift texture coordinates up by 15 pixels
    vec2 shiftedCoord = openfl_TextureCoordv - vec2(0.0, 15.0 / openfl_TextureSize.y);

    // Sample the base color and the shifted mask color
    vec4 baseColor = texture2D(bitmap, openfl_TextureCoordv);
    vec4 maskColor = texture2D(bitmap, shiftedCoord);

    // Redscale conversion for the base color (grayscale mapped to red shades)
    float grayscale = dot(baseColor.rgb, vec3(0.299, 0.587, 0.114)) * 0.25; // Standard grayscale calculation
    vec4 redScaledColor = vec4(grayscale, 0.0, 0.0, baseColor.a); // Map grayscale to red

    // Apply the mask logic: reverse the mask alpha and add it to redScaledColor
    if (baseColor.rgb != vec3(0.0, 0.0, 0.0)) { // Only apply mask if baseColor is not black
        float invertedAlpha = (1.0 - maskColor.a) * baseColor.a; // Reverse mask alpha and combine with pixel alpha
        vec4 redMaskEffect = vec4(invertedAlpha, 0.0, 0.0, 0.0); // Red mask contribution
        gl_FragColor = redScaledColor + redMaskEffect; // Add the red mask effect to the redscaled color
    } else {
        gl_FragColor = redScaledColor; // Keep redscale effect for black pixels
    }
}