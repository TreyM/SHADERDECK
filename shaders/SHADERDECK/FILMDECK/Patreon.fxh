///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///                                                                                             ///
///    8888888888 8888888 888      888b     d888 8888888b.  8888888888  .d8888b.  888    d8P    ///
///    888          888   888      8888b   d8888 888  "Y88b 888        d88P  Y88b 888   d8P     ///
///    888          888   888      88888b.d88888 888    888 888        888    888 888  d8P      ///
///    8888888      888   888      888Y88888P888 888    888 8888888    888        888d88K       ///
///    888          888   888      888 Y888P 888 888    888 888        888        8888888b      ///
///    888          888   888      888  Y8P  888 888    888 888        888    888 888  Y88b     ///
///    888          888   888      888   "   888 888  .d88P 888        Y88b  d88P 888   Y88b    ///
///    888        8888888 88888888 888       888 8888888P"  8888888888  "Y8888P"  888    Y88b   ///
///                                                                                             ///
///    FILM EMULATION SUITE FOR RESHADE                                                         ///
///    <> BY TREYM                                                                              ///
///                                                                                             ///
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

/*  ///////////////////////////////////////////////////////////////////////////////////////////  **
**  ///////////////////////////////////////////////////////////////////////////////////////////  **

    Welcome to FILMDECK, the spiritual successor to Film Workshop!

**  ///////////////////////////////////////////////////////////////////////////////////////////  **
**  ///////////////////////////////////////////////////////////////////////////////////////////  */

// Bit depth modes for the internal render targets
// 0 = Use game's internal bit depth (not recommended for SDR)
// 1 = RGB10A2 - 10-bit RGB, 2-bit Alpha
// 2 = RGBA16  - 16-bit RGBA (default mode)
// 3 = RGBA16F - 16-bit RGBA Float
#ifndef SWAPCHAIN_PRECISION
    #define SWAPCHAIN_PRECISION 2
#endif
#if   (SWAPCHAIN_PRECISION == 0)
    #define INTERNAL_DEPTH     BUFFER_FORMAT
    #if (BUFFER_COLOR_BIT_DEPTH > 8)
        #define INTERNAL_DEPTH_1CH R16
    #else
        #define INTERNAL_DEPTH_1CH R8
    #endif
#elif (SWAPCHAIN_PRECISION == 1)
    #define INTERNAL_DEPTH     RGB10A2
    #define INTERNAL_DEPTH_1CH R16
#elif (SWAPCHAIN_PRECISION == 2)
    #define INTERNAL_DEPTH     RGBA16
    #define INTERNAL_DEPTH_1CH R16
#elif (SWAPCHAIN_PRECISION == 3)
    #define INTERNAL_DEPTH     RGBA16F
    #define INTERNAL_DEPTH_1CH R16F
#else
    #define INTERNAL_DEPTH     RGB10A2
    #define INTERNAL_DEPTH_1CH R16
#endif

// If a user only has an 8-bit monitor, but the game uses RGB10A2
// It is possible to force the final dithering to be 8-bit to avoid
// banding on the user's 8-bit panel
#ifndef FORCE_8_BIT_OUTPUT
    #define FORCE_8_BIT_OUTPUT 0
#endif

#ifndef ENABLE_WATERMARK
    #define ENABLE_WATERMARK 0
#endif

// A meme and easter egg
#define LET_ME_COOK 0

#include "SHADERDECK/FILMDECK/Custom.fxh"
#define PATREON_NAG \
    ""

// TEXTURES & SAMPLERS ////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#define NEGATIVE_COUNT 22
texture NegativeStocks < source = "SHADERDECK/LUTs/PatreonNegativeAtlas.png"; > { Width  = 7056; Height = 1848; };
sampler NegativeAtlas
{
    Texture   = NegativeStocks;
    MagFilter = LINEAR;
    MinFilter = LINEAR;
    MipFilter = LINEAR;
};

#define PRINT_COUNT 24
texture PrintStocks < source = "SHADERDECK/LUTs/PatreonPrintAtlas.png"; > { Width  = 7056; Height = 2016; };
sampler PrintAtlas
{
    Texture   = PrintStocks;
    MagFilter = LINEAR;
    MinFilter = LINEAR;
    MipFilter = LINEAR;
};

texture CustomNegativeStocks < source = "SHADERDECK/LUTs/" CUST_NEGATIVE_FILENAME; >
{
    Width     = CUST_NEGATIVE_TEXTURE_WIDTH;
    Height    = CUST_NEGATIVE_TEXTURE_HEIGHT;
};
sampler CustomNegativeAtlas
{
    Texture   = CustomNegativeStocks;
    MagFilter = LINEAR;
    MinFilter = LINEAR;
    MipFilter = LINEAR;
};

texture CustomPrintStocks < source = "SHADERDECK/LUTs/"CUST_PRINT_FILENAME; >
{
    Width     = CUST_PRINT_TEXTURE_WIDTH;
    Height    = CUST_PRINT_TEXTURE_HEIGHT;
};
sampler CustomPrintAtlas
{
    Texture   = CustomPrintStocks;
    MagFilter = LINEAR;
    MinFilter = LINEAR;
    MipFilter = LINEAR;
};


// FILM PROFILE STRUCT ////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
struct FilmStruct
{
    float  iso;
    float3 halation;
    int    temp;
};

FilmStruct Default()
{
    FilmStruct film;

    film.iso        = 800;

    film.halation.x = 50.0; // Intensity
    film.halation.y = 85.0; // Sensitivity
    film.halation.z = 75.0; // Size

    film.temp       = 6500;

    return film;
};


// FILM NEGATIVE PROFILES /////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
FilmStruct ACI21()
{
    FilmStruct film = Default();

    film.iso        = 21;

    film.halation.x = 75.0; // Intensity
    film.halation.y = 45.0; // Sensitivity
    film.halation.z = 65.0; // Size

    film.temp       = 6500;

    return film;
};

FilmStruct K5294()
{
    FilmStruct film = Default();

    film.iso        = 400;

    film.halation.x = 50.0; // Intensity
    film.halation.y = 100.0; // Sensitivity
    film.halation.z = 35.0; // Size

    film.temp       = 3200;

    return film;
};

FilmStruct K5247()
{
    FilmStruct film = Default();

    film.iso        = 100;

    film.halation.x = 100.0; // Intensity
    film.halation.y = 100.0; // Sensitivity
    film.halation.z = 10.0; // Size

    film.temp       = 3200;

    return film;
};

FilmStruct K5222()
{
    FilmStruct film = Default();

    film.iso        = 200;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct K5245()
{
    FilmStruct film = Default();

    film.iso        = 50;

    film.halation.x = 45.0; // Intensity
    film.halation.y = 100.0; // Sensitivity
    film.halation.z = 100.0; // Size

    film.temp       = 6500;

    return film;
};

FilmStruct K5231()
{
    FilmStruct film = Default();

    film.iso        = 80;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct FC200D()
{
    FilmStruct film = Default();

    film.iso        = 200;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct FP400H()
{
    FilmStruct film = Default();

    film.iso        = 400;

    film.halation.x = 75.0; // Intensity
    film.halation.y = 45.0; // Sensitivity
    film.halation.z = 65.0; // Size

    film.temp       = 6500;

    return film;
};

FilmStruct FR500D()
{
    FilmStruct film;

    film.iso        = 500;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct FS200D()
{
    FilmStruct film;

    film.iso        = 200;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct KEK100D()
{
    FilmStruct film;

    film.iso        = 100;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct KECH200D()
{
    FilmStruct film;

    film.iso        = 200;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct KEC200D()
{
    FilmStruct film;

    film.iso        = 200;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct KG200D()
{
    FilmStruct film;

    film.iso        = 200;

    film.halation.x = 0.0; // Intensity

    film.temp       = 6500;

    return film;
};

FilmStruct KUM400D()
{
    FilmStruct film;

    film.iso        = 400;

    film.halation.x = 35.0; // Intensity
    film.halation.y = 80.0; // Sensitivity
    film.halation.z = 70.0; // Size

    film.temp       = 6500;

    return film;
};

FilmStruct K5203D()
{
    FilmStruct film;

    film.iso        = 50;

    film.halation.x = 75.0; // Intensity
    film.halation.y = 45.0; // Sensitivity
    film.halation.z = 65.0; // Size

    film.temp       = 6500;

    return film;
};

FilmStruct K5207D()
{
    FilmStruct film = Default();

    film.iso        = 250;

    film.halation.x = 40.0; // Intensity
    film.halation.y = 100.0; // Sensitivity
    film.halation.z = 40.0; // Size

    film.temp       = 6500;

    return film;
};

FilmStruct K5213T()
{
    FilmStruct film = Default();

    film.iso        = 200;

    film.halation.x = 100.0; // Intensity
    film.halation.y = 80.0; // Sensitivity
    film.halation.z = 20.0; // Size

    film.temp       = 3200;

    return film;
};

FilmStruct K5219T()
{
    FilmStruct film = Default();

    film.iso        = 500;

    film.halation.x = 75.0; // Intensity
    film.halation.y = 45.0; // Sensitivity
    film.halation.z = 65.0; // Size

    film.temp       = 3200;

    return film;
};

FilmStruct Tetra()
{
    FilmStruct film = Default();

    film.iso        = 250;

    film.halation.x = 100.0; // Intensity
    film.halation.y = 100.0; // Sensitivity
    film.halation.z = 100.0; // Size

    film.temp       = 6500;

    return film;
};



// FILM PRINT PROFILES ////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
FilmStruct GFC1()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct GFC2()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct FCust()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct F3510()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct F3513()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct F3514()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct F3521()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct F3523()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct K2383()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct K2393()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct Koda()
{
    FilmStruct film = Default();

    return film;
};

FilmStruct K2302()
{
    FilmStruct film = Default();

    return film;
};


// STANDARD NEGATIVE AND PRINT LISTS //////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#define NEGATIVE_LIST \
    "Bypass\0" \
    "Adox Color Implosion 21\0" \
    "Eastman Color Negative 400T 5294\0" \
    "Eastman Color Negative II 100T 5247\0" \
    "Eastman DOUBLE-X 200D 5222 (B&W)\0" \
    "Eastman EXR 50D 5245\0" \
    "Eastman PLUS-X 80D 5231 (B&W)\0" \
    "Fujifilm FujiColor 200D\0" \
    "Fujifilm Pro 400H\0" \
    "Fujifilm Reala 500D 8592\0" \
    "Fujifilm Superia 200D\0" \
    "Kodak Ektar 100\0" \
    "Kodak Elite Chrome 200D\0" \
    "Kodak Elite Color 200D\0" \
    "Kodak Gold 200D\0" \
    "Kodak Ultramax 400D\0" \
    "Kodak VISION3 50D 5203\0" \
    "Kodak VISION3 50D 5203 (ALT)\0" \
    "Kodak VISION3 250D 5207\0" \
    "Kodak VISION3 200T 5213\0" \
    "Kodak VISION3 500T 5219\0" \
    "Kodak VISION3 500T 5219 (ALT)\0" \
    "Kodak VISION3 Tetrachrome C41\0"
    
#define PRINT_LIST \
    "Bypass\0" \
    "Generic Film Contrast\0" \
    "Generic Film Contrast (BLEACH)\0" \
    "Fuji Custom Print (D65)\0" \
    "Fuji Super F-CP 3510\0" \
    "Fuji Eterna-CP 3513DI (D55)\0" \
    "Fuji Eterna-CP 3513DI (D60)\0" \
    "Fuji Eterna-CP 3513DI (D65)\0" \
    "Fuji Eterna-CP 3514DI\0" \
    "Fuji Eterna-CP 3521XD\0" \
    "Fuji Eterna-CP 3521XD (ALT)\0" \
    "Fuji Eterna-CP 3523XD\0" \
    "Kodak VISION 2383\0" \
    "Kodak VISION 2383 (ALT)\0" \
    "Kodak VISION 2383 (ALT2)\0" \
    "Kodak VISION 2383 (D50)\0" \
    "Kodak VISION 2383 (D55)\0" \
    "Kodak VISION 2383 (D60)\0" \
    "Kodak VISION 2383 (D60 ALT)\0" \
    "Kodak VISION 2383 (D65)\0" \
    "Kodak VISION Premier 2393\0" \
    "Kodak VISION Premier 2393 (ALT)\0" \
    "Kodak VISION Premier 2393 (D55)\0" \
    "Kodak Kodachrome 828\0" \
    "Kodak B&W 2302\0"


// GENERIC PROFILES ///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
FilmStruct Generic35mm()
{
    FilmStruct film = Default();

    film.halation.x = 25.0; // Intensity

    return film;
};

FilmStruct GenericSuper35()
{
    FilmStruct film = Default();

    film.halation.x = 25.0; // Intensity

    return film;
};

FilmStruct Generic16mm()
{
    FilmStruct film = Default();

    film.halation.x = 25.0; // Intensity

    return film;
};

#define PROFILE_1 Generic35mm()
#define PROFILE_2 GenericSuper35()
#define PROFILE_3 Generic16mm()
#define CUST_PROFILE(x) \
    PROFILE_##x

#if   (CUST_NEGATIVE_PROFILE_1 < 1)
    #undef  CUST_NEGATIVE_PROFILE_1
    #define CUST_NEGATIVE_PROFILE_1 1
#elif (CUST_NEGATIVE_PROFILE_1 > 3)
    #undef  CUST_NEGATIVE_PROFILE_1
    #define CUST_NEGATIVE_PROFILE_1 3
#endif

#if   (CUST_NEGATIVE_PROFILE_2 < 1)
    #undef  CUST_NEGATIVE_PROFILE_2
    #define CUST_NEGATIVE_PROFILE_2 1
#elif (CUST_NEGATIVE_PROFILE_2 > 3)
    #undef  CUST_NEGATIVE_PROFILE_2
    #define CUST_NEGATIVE_PROFILE_2 3
#endif

#if   (CUST_NEGATIVE_PROFILE_3 < 1)
    #undef  CUST_NEGATIVE_PROFILE_3
    #define CUST_NEGATIVE_PROFILE_3 1
#elif (CUST_NEGATIVE_PROFILE_3 > 3)
    #undef  CUST_NEGATIVE_PROFILE_3
    #define CUST_NEGATIVE_PROFILE_3 3
#endif

#if   (CUST_NEGATIVE_PROFILE_4 < 1)
    #undef  CUST_NEGATIVE_PROFILE_4
    #define CUST_NEGATIVE_PROFILE_4 1
#elif (CUST_NEGATIVE_PROFILE_4 > 3)
    #undef  CUST_NEGATIVE_PROFILE_4
    #define CUST_NEGATIVE_PROFILE_4 3
#endif

#if   (CUST_NEGATIVE_PROFILE_5 < 1)
    #undef  CUST_NEGATIVE_PROFILE_5
    #define CUST_NEGATIVE_PROFILE_5 1
#elif (CUST_NEGATIVE_PROFILE_5 > 3)
    #undef  CUST_NEGATIVE_PROFILE_5
    #define CUST_NEGATIVE_PROFILE_5 3
#endif

#if   (CUST_PRINT_PROFILE_1 < 1)
    #undef  CUST_PRINT_PROFILE_1
    #define CUST_PRINT_PROFILE_1 1
#elif (CUST_PRINT_PROFILE_1 > 2)
    #undef  CUST_PRINT_PROFILE_1
    #define CUST_PRINT_PROFILE_1 2
#endif

#if   (CUST_PRINT_PROFILE_2 < 1)
    #undef  CUST_PRINT_PROFILE_2
    #define CUST_PRINT_PROFILE_2 1
#elif (CUST_PRINT_PROFILE_2 > 2)
    #undef  CUST_PRINT_PROFILE_2
    #define CUST_PRINT_PROFILE_2 2
#endif

#if   (CUST_PRINT_PROFILE_3 < 1)
    #undef  CUST_PRINT_PROFILE_3
    #define CUST_PRINT_PROFILE_3 1
#elif (CUST_PRINT_PROFILE_3 > 2)
    #undef  CUST_PRINT_PROFILE_3
    #define CUST_PRINT_PROFILE_3 2
#endif

#if   (CUST_NEGATIVEPRINT_4 < 1)
    #undef  CUST_PRINT_PROFILE_4
    #define CUST_PRINT_PROFILE_4 1
#elif (CUST_PRINT_PROFILE_4 > 2)
    #undef  CUST_PRINT_PROFILE_4
    #define CUST_PRINT_PROFILE_4 2
#endif

#if   (CUST_PRINT_PROFILE_5 < 1)
    #undef  CUST_PRINT_PROFILE_5
    #define CUST_PRINT_PROFILE_5 1
#elif (CUST_PRINT_PROFILE_5 > 2)
    #undef  CUST_PRINT_PROFILE_5
    #define CUST_PRINT_PROFILE_5 2
#endif


// GLOBAL ARRAY WORKAROUND ////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#define FILM_PROFILES "SHADERDECK/FILMDECK/PatreonProfileArrays.fxh"


// CUSTOM PRESET SUPPORT MACROS ///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#if   (CUST_NEGATIVE_LUT_COUNT == 1)
    #define CUSTOM_NEGATIVE_LIST(x) \
        NEGATIVE_LIST \
        "["##x##"] "##CUST_NEGATIVE_NAME_1##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 2)
    #define CUSTOM_NEGATIVE_LIST(x) \
        NEGATIVE_LIST \
        "["##x##"] "##CUST_NEGATIVE_NAME_1##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_2##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 3)
    #define CUSTOM_NEGATIVE_LIST(x) \
        NEGATIVE_LIST \
        "["##x##"] "##CUST_NEGATIVE_NAME_1##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_2##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_3##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 4)
    #define CUSTOM_NEGATIVE_LIST(x) \
        NEGATIVE_LIST \
        "["##x##"] "##CUST_NEGATIVE_NAME_1##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_2##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_3##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_4##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 5)
    #define CUSTOM_NEGATIVE_LIST(x) \
        NEGATIVE_LIST \
        "["##x##"] "##CUST_NEGATIVE_NAME_1##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_2##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_3##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_4##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_5##"\0"

#else
    #define CUSTOM_NEGATIVE_LIST(x) \
        NEGATIVE_LIST \
        "["##x##"] "##CUST_NEGATIVE_NAME_1##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_2##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_3##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_4##"\0" \
        "["##x##"] "##CUST_NEGATIVE_NAME_5##"\0"
#endif

#if   (CUST_PRINT_LUT_COUNT == 1)
    #define CUSTOM_PRINT_LIST(x) \
        PRINT_LIST \
        "["##x##"] "##CUST_PRINT_NAME_1##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 2)
    #define CUSTOM_PRINT_LIST(x) \
        PRINT_LIST \
        "["##x##"] "##CUST_PRINT_NAME_1##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_2##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 3)
    #define CUSTOM_PRINT_LIST(x) \
        PRINT_LIST \
        "["##x##"] "##CUST_PRINT_NAME_1##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_2##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_3##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 4)
    #define CUSTOM_PRINT_LIST(x) \
        PRINT_LIST \
        "["##x##"] "##CUST_PRINT_NAME_1##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_2##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_3##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_4##"\0"

#elif (CUST_NEGATIVE_LUT_COUNT == 5)
    #define CUSTOM_PRINT_LIST(x) \
        PRINT_LIST \
        "["##x##"] "##CUST_PRINT_NAME_1##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_2##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_3##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_4##"\0" \
        "["##x##"] "##CUST_PRINT_NAME_5##"\0"

#else
    #define CUSTOM_PRINT_LIST(x) \
        PRINT_LIST \
        "["##x##"]"" "##CUST_PRINT_NAME_1##"\0" \
        "["##x##"]"" "##CUST_PRINT_NAME_2##"\0" \
        "["##x##"]"" "##CUST_PRINT_NAME_3##"\0" \
        "["##x##"]"" "##CUST_PRINT_NAME_4##"\0" \
        "["##x##"]"" "##CUST_PRINT_NAME_5##"\0"
#endif

#define CUSTOM_LIST_N CUSTOM_NEGATIVE_LIST (CUST_PRESET_NAME)
#define CUSTOM_LIST_P CUSTOM_PRINT_LIST    (CUST_PRESET_NAME)