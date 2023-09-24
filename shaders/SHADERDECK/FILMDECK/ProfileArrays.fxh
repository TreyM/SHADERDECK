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
#if !CUSTOM_PRESET_ENABLED
    FilmStruct NegativeProfile[NEGATIVE_COUNT];
        NegativeProfile[0] = K5207D();
        NegativeProfile[1] = K5213T();
        NegativeProfile[2] = FR500D();

    FilmStruct PrintProfile[PRINT_COUNT];
        PrintProfile[0] = K2383();
        PrintProfile[1] = F3521();
        PrintProfile[2] = K2302();

#else
    FilmStruct NegativeProfile[NEGATIVE_COUNT + CUST_NEGATIVE_LUT_COUNT];
    FilmStruct PrintProfile[PRINT_COUNT + CUST_PRINT_LUT_COUNT];
    FilmStruct GenericProfile[3];
        GenericProfile[0] = Generic35mm();
        GenericProfile[1] = GenericSuper35();
        GenericProfile[2] = Generic16mm();

    #if   (CUST_NEGATIVE_LUT_COUNT == 1)
            NegativeProfile[0] = K5207D();
            NegativeProfile[1] = K5213T();
            NegativeProfile[2] = FR500D();
            NegativeProfile[3] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];

            PrintProfile[0] = K2383();
            PrintProfile[1] = F3521();
            PrintProfile[2] = K2302();
            PrintProfile[3] = GenericProfile[CUST_PRINT_PROFILE_1 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 2)
            NegativeProfile[0] = K5207D();
            NegativeProfile[1] = K5213T();
            NegativeProfile[2] = FR500D();
            NegativeProfile[3] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[4] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            
            PrintProfile[0] = K2383();
            PrintProfile[1] = F3521();
            PrintProfile[2] = K2302();
            PrintProfile[3] = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[4] = GenericProfile[CUST_PRINT_PROFILE_2 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 3)
            NegativeProfile[0] = K5207D();
            NegativeProfile[1] = K5213T();
            NegativeProfile[2] = FR500D();
            NegativeProfile[3] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[4] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[5] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];

            PrintProfile[0] = K2383();
            PrintProfile[1] = F3521();
            PrintProfile[2] = K2302();
            PrintProfile[3] = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[4] = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[5] = GenericProfile[CUST_PRINT_PROFILE_3 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 4)
            NegativeProfile[0] = K5207D();
            NegativeProfile[1] = K5213T();
            NegativeProfile[2] = FR500D();
            NegativeProfile[3] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[4] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[5] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];
            NegativeProfile[6] = GenericProfile[CUST_NEGATIVE_PROFILE_4 - 1];

            PrintProfile[0] = K2383();
            PrintProfile[1] = F3521();
            PrintProfile[2] = K2302();
            PrintProfile[3] = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[4] = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[5] = GenericProfile[CUST_PRINT_PROFILE_3 - 1];
            PrintProfile[6] = GenericProfile[CUST_PRINT_PROFILE_4 - 1];

    #elif (CUST_NEGATIVE_LUT_COUNT == 5)
            NegativeProfile[0] = K5207D();
            NegativeProfile[1] = K5213T();
            NegativeProfile[2] = FR500D();
            NegativeProfile[3] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[4] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[5] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];
            NegativeProfile[6] = GenericProfile[CUST_NEGATIVE_PROFILE_4 - 1];
            NegativeProfile[7] = GenericProfile[CUST_NEGATIVE_PROFILE_5 - 1];

            PrintProfile[0] = K2383();
            PrintProfile[1] = F3521();
            PrintProfile[2] = K2302();
            PrintProfile[3] = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[4] = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[5] = GenericProfile[CUST_PRINT_PROFILE_3 - 1];
            PrintProfile[6] = GenericProfile[CUST_PRINT_PROFILE_4 - 1];
            PrintProfile[7] = GenericProfile[CUST_PRINT_PROFILE_5 - 1];

    #else
            NegativeProfile[0] = K5207D();
            NegativeProfile[1] = K5213T();
            NegativeProfile[2] = FR500D();
            NegativeProfile[3] = GenericProfile[CUST_NEGATIVE_PROFILE_1 - 1];
            NegativeProfile[4] = GenericProfile[CUST_NEGATIVE_PROFILE_2 - 1];
            NegativeProfile[5] = GenericProfile[CUST_NEGATIVE_PROFILE_3 - 1];
            NegativeProfile[6] = GenericProfile[CUST_NEGATIVE_PROFILE_4 - 1];
            NegativeProfile[7] = GenericProfile[CUST_NEGATIVE_PROFILE_5 - 1];

            PrintProfile[0] = K2383();
            PrintProfile[1] = F3521();
            PrintProfile[2] = K2302();
            PrintProfile[3] = GenericProfile[CUST_PRINT_PROFILE_1 - 1];
            PrintProfile[4] = GenericProfile[CUST_PRINT_PROFILE_2 - 1];
            PrintProfile[5] = GenericProfile[CUST_PRINT_PROFILE_3 - 1];
            PrintProfile[6] = GenericProfile[CUST_PRINT_PROFILE_4 - 1];
            PrintProfile[7] = GenericProfile[CUST_PRINT_PROFILE_5 - 1];

    #endif
#endif