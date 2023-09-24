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

// STRUCT ARRAYS //////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#ifdef __NEG_ARRAY_LIST
    #undef __NEG_ARRAY_LIST
#endif
#define __NEG_ARRAY_LIST \
        NegativeProfile[0]  = ACI21();    \
        NegativeProfile[1]  = K5294();    \
        NegativeProfile[2]  = K5247();    \
        NegativeProfile[3]  = K5222();    \
        NegativeProfile[4]  = K5245();    \
        NegativeProfile[5]  = K5231();    \
        NegativeProfile[6]  = FC200D();   \
        NegativeProfile[7]  = FP400H();   \
        NegativeProfile[8]  = FR500D();   \
        NegativeProfile[9]  = FS200D();   \
        NegativeProfile[10] = KEK100D();  \
        NegativeProfile[11] = KECH200D(); \
        NegativeProfile[12] = KEC200D();  \
        NegativeProfile[13] = KG200D();   \
        NegativeProfile[14] = KUM400D();  \
        NegativeProfile[15] = K5203D();   \
        NegativeProfile[16] = K5203D();   \
        NegativeProfile[17] = K5207D();   \
        NegativeProfile[18] = K5213T();   \
        NegativeProfile[19] = K5219T();   \
        NegativeProfile[20] = K5219T();   \
        NegativeProfile[21] = Tetra();

#ifdef __PRI_ARRAY_LIST
    #undef __PRI_ARRAY_LIST
#endif
#define __PRI_ARRAY_LIST \
        PrintProfile[0] = GFC1(); \
        PrintProfile[1] = GFC2(); \
        PrintProfile[2] = FCust(); \
        PrintProfile[3] = F3510(); \
        PrintProfile[4] = F3513(); \
        PrintProfile[5] = F3513(); \
        PrintProfile[6] = F3513(); \
        PrintProfile[7] = F3514(); \
        PrintProfile[8] = F3521(); \
        PrintProfile[9] = F3521(); \
        PrintProfile[10] = F3523(); \
        PrintProfile[11] = K2383(); \
        PrintProfile[12] = K2383(); \
        PrintProfile[13] = K2383(); \
        PrintProfile[14] = K2383(); \
        PrintProfile[15] = K2383(); \
        PrintProfile[16] = K2383(); \
        PrintProfile[17] = K2383(); \
        PrintProfile[18] = K2383(); \
        PrintProfile[19] = K2393(); \
        PrintProfile[20] = K2393(); \
        PrintProfile[21] = K2393(); \
        PrintProfile[22] = Koda(); \
        PrintProfile[23] = K2302();

#if !CUSTOM_PRESET_ENABLED
    FilmStruct NegativeProfile[NEGATIVE_COUNT];
        __NEG_ARRAY_LIST

    FilmStruct PrintProfile[PRINT_COUNT];
        __PRI_ARRAY_LIST

#else
    FilmStruct NegativeProfile[NEGATIVE_COUNT + CUST_NEGATIVE_LUT_COUNT];
    FilmStruct PrintProfile[PRINT_COUNT + CUST_PRINT_LUT_COUNT];
    FilmStruct GenericProfile[3];
        GenericProfile[0] = Generic35mm();
        GenericProfile[1] = GenericSuper35();
        GenericProfile[2] = Generic16mm();

    #if   (CUST_NEGATIVE_LUT_COUNT == 1)
            __NEG_ARRAY_LIST
            NegativeProfile[NEGATIVE_COUNT]    = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];

            __PRI_ARRAY_LIST
            PrintProfile[PRINT_COUNT]          = GenericProfile[CUST_PRINT_PROFILE_1 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 2)
            __NEG_ARRAY_LIST
            NegativeProfile[NEGATIVE_COUNT    ] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[NEGATIVE_COUNT + 1] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            
            __PRI_ARRAY_LIST
            PrintProfile[PRINT_COUNT    ]       = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[PRINT_COUNT + 1]       = GenericProfile[CUST_PRINT_PROFILE_2 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 3)
            __NEG_ARRAY_LIST
            NegativeProfile[NEGATIVE_COUNT    ] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[NEGATIVE_COUNT + 1] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[NEGATIVE_COUNT + 2] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];

            __PRI_ARRAY_LIST
            PrintProfile[PRINT_COUNT    ]       = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[PRINT_COUNT + 1]       = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[PRINT_COUNT + 2]       = GenericProfile[CUST_PRINT_PROFILE_3 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 4)
            __NEG_ARRAY_LIST
            NegativeProfile[NEGATIVE_COUNT    ] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[NEGATIVE_COUNT + 1] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[NEGATIVE_COUNT + 2] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];
            NegativeProfile[NEGATIVE_COUNT + 3] = GenericProfile[CUST_NEGATIVE_PROFILE_4 - 1];

            __PRI_ARRAY_LIST
            PrintProfile[PRINT_COUNT    ]       = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[PRINT_COUNT + 1]       = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[PRINT_COUNT + 2]       = GenericProfile[CUST_PRINT_PROFILE_3 - 1];
            PrintProfile[PRINT_COUNT + 3]       = GenericProfile[CUST_PRINT_PROFILE_4 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 5)
            __NEG_ARRAY_LIST
            NegativeProfile[NEGATIVE_COUNT    ] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[NEGATIVE_COUNT + 1] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[NEGATIVE_COUNT + 2] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];
            NegativeProfile[NEGATIVE_COUNT + 3] = GenericProfile[CUST_NEGATIVE_PROFILE_4 - 1];
            NegativeProfile[NEGATIVE_COUNT + 4] = GenericProfile[CUST_NEGATIVE_PROFILE_5 - 1];

            __PRI_ARRAY_LIST
            PrintProfile[PRINT_COUNT    ]       = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[PRINT_COUNT + 1]       = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[PRINT_COUNT + 2]       = GenericProfile[CUST_PRINT_PROFILE_3 - 1];
            PrintProfile[PRINT_COUNT + 3]       = GenericProfile[CUST_PRINT_PROFILE_4 - 1];
            PrintProfile[PRINT_COUNT + 4]       = GenericProfile[CUST_PRINT_PROFILE_5 - 1];

    #else
            __NEG_ARRAY_LIST
            NegativeProfile[NEGATIVE_COUNT    ] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[NEGATIVE_COUNT + 1] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[NEGATIVE_COUNT + 2] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];
            NegativeProfile[NEGATIVE_COUNT + 3] = GenericProfile[CUST_NEGATIVE_PROFILE_4 - 1];
            NegativeProfile[NEGATIVE_COUNT + 4] = GenericProfile[CUST_NEGATIVE_PROFILE_5 - 1];

            __PRI_ARRAY_LIST
            PrintProfile[PRINT_COUNT    ]       = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[PRINT_COUNT + 1]       = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[PRINT_COUNT + 2]       = GenericProfile[CUST_PRINT_PROFILE_3 - 1];
            PrintProfile[PRINT_COUNT + 3]       = GenericProfile[CUST_PRINT_PROFILE_4 - 1];
            PrintProfile[PRINT_COUNT + 4]       = GenericProfile[CUST_PRINT_PROFILE_5 - 1];

    #endif
#endif