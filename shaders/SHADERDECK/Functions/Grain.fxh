uniform int red_x   < source = "random"; min = 0; max = 100; >;
uniform int red_y   < source = "random"; min = 0; max = 100; >;

uniform int green_x < source = "random"; min = 0; max = 100; >;
uniform int green_y < source = "random"; min = 0; max = 100; >;

uniform int blue_x  < source = "random"; min = 0; max = 100; >;
uniform int blue_y  < source = "random"; min = 0; max = 100; >;

TEXTURE_FULL_SRC (TexGrain, "SHADERDECK/Grain/Grain.png",   1024, 1024, RGBA8)
SAMPLER_UV       (TextureGrain,  TexGrain,  WRAP)

float3 FilmGrain(float3 color, int index, int intensity, float2 coord)
{
    float3 range, grain, hsl, shadows, midtones, highlights;
    float2 rpos, gpos, bpos, scale;
    float  luma;
    int    profile;

    // Randomize the texture position for the RGB channels (random value between 0.0 - 1.0)
    rpos       = float2(red_x,   red_y)   * 0.01;
    gpos       = float2(green_x, green_y) * 0.01;
    bpos       = float2(blue_x,  blue_y)  * 0.01;

    scale      = float2(BUFFER_WIDTH, BUFFER_HEIGHT) / 1024.0;

    profile = 0;

    switch(index)
    {
            case 0:
                // Pull the grain texture
                grain.r  = tex2D(TextureGrain, ((coord) + rpos) * scale).x;
                grain.g  = tex2D(TextureGrain, ((coord) + gpos) * scale).x;
                grain.b  = tex2D(TextureGrain, ((coord) + bpos) * scale).x;
            break;

            case 1:
                // Pull the grain texture
                grain.r  = tex2D(TextureGrain, ((coord) + rpos) * scale).y;
                grain.g  = tex2D(TextureGrain, ((coord) + gpos) * scale).y;
                grain.b  = tex2D(TextureGrain, ((coord) + bpos) * scale).y;
            break;

            case 2:
                // Pull the grain texture
                grain.r  = tex2D(TextureGrain, ((coord) + rpos) * scale).z;
                grain.g  = tex2D(TextureGrain, ((coord) + gpos) * scale).z;
                grain.b  = tex2D(TextureGrain, ((coord) + bpos) * scale).z;
            break;
    }

    // Film grain saturation for shadows, midtones, and highlights
    float3 satcurve[3] =
    {
        // Full Frame 35mm
        float3(1.0, 1.0, 1.0),

        // Super 35mm
        float3(0.33, 0.33, 0.25),

        // Super 16mm
        float3(0.55, 0.45, 0.25)
    };

    // Grain amount in shadows, midtones, and highlights
    float3 lumacurve[3] =
    {
        // Full Frame 35mm
        float3(1.0, 1.0, 1.0),

        // Super 35mm
        float3(0.25, 0.75, 0.25),

        // Super 16mm
        float3(1.0, 0.5, 0.75)
    };

    // Per-channel grain in shadows
    float3 rgbshadows[3] =
    {
        // Full Frame 35mm
        float3(1.0, 1.0, 1.0),

        // Super 35mm
        float3(0.33, 1.0, 0.5),

        // Super 16mm
        float3(1.0, 0.33, 0.75)
    };

    // Per-channel grain in midtones
    float3 rgbmids[3] =
    {
        // Full Frame 35mm
        float3(1.0, 1.0, 1.0),

        // Super 35mm
        float3(0.66, 0.25, 0.5),

        // Super 16mm
        float3(0.25, 1.0, 0.33)
    };

    // Per-channel grain in highlights
    float3 rgbhighs[3] =
    {
        // Full Frame 35mm
        float3(1.0, 1.0, 1.0),

        // Super 35mm
        float3(1.0, 0.15, 1.0),

        // Super 16mm
        float3(1.0, 0.33, 0.5)
    };

    // Setup the luma ranges
    luma        = GetLuma(pow(abs(color), 0.75));
    range.x     = smoothstep(0.25, 0.0, luma);
    range.z     = smoothstep(0.25, 1.0, luma);
    range.y     = saturate(1 - range.x - range.z);

    // Setup the RGB balance for shadows, midtones, and highlights
    shadows     = lerp(0.5, grain, rgbshadows[profile]);
    midtones    = lerp(0.5, grain, rgbmids[profile]);
    highlights  = lerp(0.5, grain, rgbhighs[profile]);

    // Setup grain for shadows, midtones, and highlights
    shadows     = lerp(0.5, shadows,    lumacurve[profile].x);
    midtones    = lerp(0.5, midtones,   lumacurve[profile].y);
    highlights  = lerp(0.5, highlights, lumacurve[profile].z);

    // Apply the saturation curve to the grain
    shadows     = lerp(GetLuma(shadows),    shadows,    satcurve[profile].x);
    midtones    = lerp(GetLuma(midtones),   midtones,   satcurve[profile].y);
    highlights  = lerp(GetLuma(highlights), highlights, satcurve[profile].z);

    // Apply the luma curve to the grain
    // grain       = 0.0;
    // grain      += lerp(0.0, shadows,    range.x);
    // grain      += lerp(0.0, midtones,   range.y);
    // grain      += lerp(0.0, highlights, range.z);

    // Overlay the grain
    color  = BlendHardLight(color, lerp(0.5, grain, intensity * 0.01));

    return color;
}