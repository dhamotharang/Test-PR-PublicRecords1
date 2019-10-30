
EXPORT SRC_Allowed := MODULE
//1
EXPORT Consumers_allowed_and_extracted :=[ 

        
        // These sources are used in the bulk extract and will be sub-source-filtered based on the recornds found in the extract dataset file

        'VO',      //       471,098,311       Voters v2

        'GO',      //       1,095,448,334       Gong History
        'WP',      //       371,782,031       Targus White pages
        'PN',      //       353,662,315       PCNSR Phones
        'GN',      //       327,998,600       Gong Neustar

        'SL',      //       185,932,655       American Students List

        'L2',      //       184,557,218       Liens v2
        'LI',      //       23,915,064       Liens

        'PL',      //       91,181,174       Professional License
        'BA',      //       48,584,535       Bankruptcy
        'AM',      //       3,911,090       Airmen
        'E3',      //       2,489,364       EMerge CCW
        'AR'       //       525,243       Aircrafts
];

// for source 'DS' filter on STATE code.
EXPORT Death_state_NOT_allowed := [

        'MI',   // 15173      Michigan Death Records      Michigan Department of Community Health
        'VA'    // 17349      Virginia Death Records      Virginia Department of Health Division
        
];

// src
Consumers_allowed := [

        'TS',      //       2,163,551,849       TUCS_Ptrack  (19607)                          // Consumer allowed. But no more than 70% to any customer
        'IF',      //       1,282,733,656       Infutor TRK - Name and Address Resource (18075) // Consumer allowed. No vehicle. No more that 33% of the file
        // 'LT',      //       1,128,094,614       Lexis Trans Union (18059)                       // Bulk and consumer defauled to restricted (consult legal)
        // 'TU',      //       374,328,480       TransUnion (historiclal: 18061   )  (20033, TU)       // Bulk and consumer defauled to restricted (consult legal)
        // 'CY',      //       173,512,778       Certegy ( 19353 )                                         //  Bulk and Consumer defaulted to restricted (consult legal)
        // 'DE',      //       118,207,909       Death Master

        'E2',              //       44,782,821       EMerge Fish // no bulk and no consumer restrictions on orbit for non-source-reporting sources. orbit items:
        'E1',              //      23,148,453       EMerge Hunt // 12709,12821,13069,13219,13821,13823,14279,15111,15263,15273,15457,15467,15529,15611,15789,16081,16153,16275,16461,17259,17319,17529,

        'DS',              //       6,193,279       Death State             // ** SEE Death_state_NOT_allowed ** //
        // 'DA',      //       5,263,494       DEA                     // SSA // 

        // 'E4',      //       5,129,587       EMerge Cens             //  No Orbit entry found (34338 is source code reporting only) 

        'AK',              //       4,097,139       AK Perm Fund            // Bulk consumer not restricted:  12827      Alaska Permanent Fund      Alaska Permanent Fund Dividend Division
        // 'EB',      //       4,046,658       EMerge Boat     // cannot find orbit entry
        // 'MW',      //       400,139       MS Worker Comp  // overlap results in no bulk or consumer possible. Orbit entires: 
                        // 13773,13775,15329,16441,18349,19785,20472,20474,20476,20478,20482,20484,20486,20488,20490,20492,20496,20498,20502,20508,20510,
                        // 20512,20514,20516,20518,20520,20528,20530,20534,20536,20538,20540,20542,20544,20546,20548,20550,20590,20624,20776,20834,20876,
                        // 20878,20880,20882,20884,20886,20888,20890,20892,20894,20896,20916,20918,20922,20932,20938,20942,20954,20958,20960,20992,20996,
                        // 21074,21076,21080,21082,21092,21100,21102,21106,21108,21110,21112,21114,21116,21118,21120,21124,21126,21128,21146,21148,21150,
                        // 21154,21156,21232,21274,21276,21286,21288,21290,21292,21298,21306,21332,30166,30194,30284,31436,

        'FF',      //       172,494       Federal Firearms        // bulk consumer allowed  18055      Federal Firearms Licenses      Bureau of Alcohol, Tobacco and Firearms (ATF)
                                                                // bulk consumer allowed  14091      Georgia Firearm Instructors      Georgia Secretary of State
        // 'FE'      //       18,145       Federal Explosives           //   18053      Federal Explosives Licenses      Bureau of Alcohol, Tobacco and Firearms (ATF)
        'LA',      //       410,513,410       LN_Propertyv2 Lexis Assessors
        'LP',      //       395,407,380       LN_Propertyv2 Lexis Deeds and Mortgages

        Consumers_allowed_and_extracted

        // These sources from Infutor are indicated as bulk and/or consumer use is NOT allowed on orbit

        // '[W',      //       2,144,794       TX Watercraft
        // 'OW',      //       1,345,333       OH Watercraft
        // 'LW',      //       1,300,522       AL Watercraft
        // 'YW',      //       970,720       NY Watercraft
        // 'GW',      //       918,777       GA Watercraft
        // 'WW',      //       884,385       WI Watercraft
        // 'CG',      //       849,288       US Coastguard
        // 'RW',      //       821,864       AR Watercraft
        // '2W',      //       817,689       MS Watercraft
        // 'IW',      //       807,327       IA Watercraft
        // 'VW',      //       803,091       VA Watercraft
        // '1W',      //       739,703       MN Watercraft
        // 'PW',      //       696,582       IL Watercraft
        // 'ZW',      //       639,091       AZ Watercraft
        // 'QW',      //       624,779       ME Watercraft
        // 'NW',      //       478,666       NC Watercraft
        // 'TW',      //       415,880       TN Watercraft
        // 'SW',      //       387,896       SC Watercraft
        // 'JW',      //       360,151       MA Watercraft
        // 'CW',      //       322,162       CO Watercraft
        // 'EW',      //       315,029       CT Watercraft
        // 'HW',      //       281,394       KS Watercraft
        // '!W',      //       197,322       WV Watercraft
        // '7W',      //       162,623       NV Watercraft
        // '@W',      //       137,603       WY Watercraft

];
// 2
AddressHist_allowed:= []; //  Uses consumer N/A
// 3
Akas_allowed      := []; // Uses consumer N/A
// 4
Relatives_allowed := []; //  Uses consumer N/A
// 5
Bankruptcy_NOT_allowed:=[


        /*

        PACER is the only source indicated as bulk and consumer restricted by default (consult legal)

        SOURCE IS NOT AVAILALBE IN THE DATASET

        16385       Oklahoma Bankruptcy       E.J. Copy Service       Historical      No      No
        18247       Bankruptcies (old)       LexisNexis/Oklahoma City       Historical      No      No
        18249       Bankruptcies       Superior Information Services, LLC       Historical      No      No
        18251       Bankruptcies       PACER      Gateway      Yes      Yes <===
        19381       Bankruptcies*       LexisNexis/Minneapolis Minnesota       Updating      No      No
        19837       Bankruptcy Deletes       LexisNexis/Minneapolis Minnesota       Updating      No      No

        */

];


// 6 // "Concealed Weapons Permits" // source_state
CWP_NOT_allowed       := [ 

        /*
            ## source source_code cnt
        1      EMERGES      SC      2674667
        2      FL GUNS            339917
        3      EMERGES      E7      309069
        4      EMERGES      VC      82758
        5      EMERGES      CS      4786
        6      IN CCW            3962
        */

                // 13065      Item       Arkansas Concealed Weapons Permits       e-mererges, Inc.       Historical      No      No      FALSE
                // 13815      Item       Florida Concealed Weapons Permits       e-mererges, Inc.       Historical      No      No      FALSE
                // 14291      Item       Indiana Concealed Weapons Permits       e-mererges, Inc.       Historical      No      No      FALSE
                // 14691      Item       Louisiana Concealed Weapons Permits       e-mererges, Inc.       Removed From Production      No      No      FALSE
                // 14921      Item       Maine Concealed Weapons Permits       e-mererges, Inc.       Historical      No      No      FALSE
        'NY'    // 15969      Item       New York Concealed Weapons Permits       e-mererges, Inc.       Historical      Yes      Yes      TRUE <=== NOT ALLOWED
                // 16157      Item       North Dakota Concealed Weapons Permits       e-mererges, Inc.       Historical      No      No      FALSE
                // 16805      Item       Tennessee Concealed Weapons       e-mererges, Inc.       Historical      No      No      FALSE
                // 17321      Item       Virginia Concealed Weapons Permits       e-mererges, Inc.       Historical      No      No      FALSE
                // 31646      Item       eMerges Removal List       e-mererges, Inc.       Tracking      NotSet      NotSet      FALSE

];

// 7 vendor
Crims_NOT_allowed     := [

// These are all sources of Court Venture which have NOT been replaced by hygenics
        'B7',                   //CA-SanJoaquinArr          81066            11073      Item      San Joaquin County, CA Arrest Logs      Court Ventures, Inc. (Experian)
        'W0021',                   //CA_SAN_JOAQUIN_CTY        3675                              
        'W0116',                   //CA_SANJOAQUINCTY_BKN      1083                              

        'UH',                   //CA_SANTA_CRUZ_CTY_AF      180163            11089      Item      Santa Cruz County, CA Criminal Court      Court Ventures, Inc. (Experian)
        'W0321',                   //CA_SANTA_CRUZ_PD          5281                              

        'W0046',                   //CA_SOLANO_CTY_JAIL        59265            11091      Item      Solano County, CA Arrest Logs      Court Ventures, Inc. (Experian)
        'B8',                   //CA-Solano_Arr             30803                              
        'W0117',                   //CA_SOLANO_CTY_BKNS        824                              

        'UZ',                   //MI_OAKLAND_CTY            98654            11571      Item      Oakland County, MI Arrest Logs      Court Ventures, Inc. (Experian)
        'D4',                   //MI-Oakland Co Arrest      10759                              
                                                    
        'BE',                   //AL_MOBILE_CTY_ARR         126997            12719      Item      Alabama Department of Corrections      Court Ventures, Inc. (Experian)
        'DA',                   //AL_DOC                    99530                              
        'BH',                   //AL_TUSCALOOSA_CTY_AR      41690                              
        'W0101',                   //AL_BALDWIN_CTY_COR        40943                              
        'BG',                   //AL_SHELBY_CTY_ARR         26908                              
        'BB',                   //AL_CALHOUN_CTY_ARR        25227                              
        'BD',                   //AL_JEFFERSON_CTY_ARR      24459                              
        'BF',                   //AL_MONTGOMERY_CTY_AR      16135                              
        'BA',                   //AL_BALDWIN_CTY_ARR        11590                              
        'BC',                   //AL_HOUSTON_CTY_ARR        6169                              
        'W0161',                   //AL_JEFFERSON_CTY_SO       3043                              

        'FO',                   //FL_DADE_CTY               31268529            13765      Item      Florida Administrative Office of the Courts
        'FV',                   //FL_AOC                    10034810                        
        'DI',                   //FL_DOC                    9446228                        
        'FS',                   //FL_PINELLAS_CTY           8507451                        
        'FE',                   //FL_BROWARD_CTY            7118833                        
        'DI',                   //FL_DOC_HISTORY_FILE       5679978                        
        '8I',                   //FL_HILLSBORO_CTY_TRA      5228849                        
        'FG',                   //FL_HILLSBOROUGH_CTY       4361072                        
        'FJ',                   //FL_OSCEOLA_CTY            3163644                        
        'FN',                   //FL_DUVAL_CTY              2811336                        
        'I0044',                   //FL DOC_REL                2695548                        
        'FC',                   //FL_LEE_CTY                2593443                        
        '9L',                   //FL_ST_LUCIE_CTY_CRC       2447302                        
        '7X',                   //FL_MANATEE_CRC_CTYCO      2433624                        
        'FM',                   //FL_LEON_CTY               2382281                        
        'FR',                   //FL_ORANGE_CTY             1747378                        
        'GE',                   //FL_HILSBOROUG_CTY_AR      1468362                        
        'I0041',                   //FL_SARASOTA_COC           1339678                        
        '7E',                   //FL_COLLIER_TRAFFIC        1289247                        
        'FD',                   //FL_PALM_BEACH_CTY         1263279                        
        '7V',                   //FL_ESCAMBIA_CTY_CRC       1110991                        
        'AT',                   //FL-DadeCtyArrest          1032847                        
        'I0043',                   //FL DOC_INM                918268                        
        'W0040',                   //FL_POLK_CTY_TRAFFIC       834989                        
        'FP',                   //FL_BREVARD_CTY            825657                        
        'FH',                   //FL_ALACHUA_CTY            804609                        
        'FU',                   //FL_MARION_CTY             497651                        
        '7W',                   //FL_FLAGLER_CTY_CRC        414718                        
        '63',                   //FL-LAKE_CTY_TRAFFIC       384377                        
        'GK',                   //FL_ORANGE_CTY_ARR         383958                        
        '1B',                   //FL-MANATEE-CTY-CRIM       368356                        
        'FI',                   //FL_BAY_CTY                366145                        
        '7D',                   //FL_COLLIER                336966                        
        'GN',                   //FL_POLK_CTY_ARR           333652                        
        'QM',                   //FL_LAKE_CTY               331818                        
        'UQ',                   //FL_SEMINOLE_CTY           316938                        
        '8B',                   //FL_PUTNAM_CTY             295191                        
        'W0041',                   //FL_HIGHLANDS_CTY_TRA      286752                        
        '7R',                   //FL_PASCO_CTY              272335                        
        'UP',                   //FL_OKALOOSA_CTY           246369                        
        'W0175',                   //FL_HILSBOROUGH_CTYSO      245999                        
        '9Z',                   //FL_MANATEE_CTY            234190                        
        '7F',                   //FL_MARTIN_CTY             223813                        
        'FT',                   //FL_MONROE_CTY             191178                        
        'GM',                   //FL_PALM_BEACH_CTY_AR      190348                        
        'UR',                   //FL_ST_JOHNS_CTY           186604                        
        'FK',                   //FL_CHARLOTTE_CTY          164554                        
        '8C',                   //FL_PUTNAM_CTY_TRAFFI      153967                        
        'CW',                   //FL_BREVARD_CTY_ARR        149671                        
        'UO',                   //FL_INDIAN_RIVER_CTY       146041                        
        'GI',                   //FL_MARTIN_CTY_ARR         138184                        
        'CX',                   //FL_BROWARD_CTY_ARR        136421                        
        'A4',                   //FL-SarasotaCtyArrest      133060                        
        'FQ',                   //FL_HERNANDO_CTY           128968                        
        'GH',                   //FL_LEE_CTY_ARR            128900                        
        'FX',                   //FL_ESCAMBIA_CTY_ARBF      100376                        
        'FA',                   //FL_HIGHLANDS_CTY          85103                        
        '7S',                   //FL_PASCO_CTY_TRAFFIC      83751                        
        'GP',                   //FL_SEMINOLE_CTY_ARR       79159                        
        '8T',                   //FL_CITRUS_CTY             74258                        
        'UN',                   //FL_FLAGLER_CTY            68313                        
        'W0049',                   //FL_PASCO_SO               64608                        
        'W0173',                   //FL_BREVARD_CTY_SO         64440                        
        'GL',                   //FL_OSCEOLA_CTY_ARR        63914                        
        'W0181',                   //FL_VOLUSIA_CTY_CORR       63688                        
        'W0179',                   //FL_PALM_BEACH_CTY_SO      63658                        
        'FW',                   //FL_ESCAMBIA_CTY_ARR       63282                        
        'GJ',                   //FL_MONROE_CTY_ARR         63005                        
        'W0253',                   //FL_ESCAMBIA_CTY           59777                        
        'GG',                   //FL_LAKE_CTY_ARR           56529                        
        'I0001',                   //FL_CAREER_OFNDER_REG      48211                        
        'W0047',                   //FL_MANATEE_CTY_SO         46949                        
        'W0174',                   //FL_CHARLOTTE_CTY_SO       46910                        
        'GR',                   //FL_VOLUSIA_CTY_ARR        41962                        
        'W0177',                   //FL_LAKE_CTY_SO            38083                        
        'FZ',                   //FL_HERNANDO_CTY_ARR       34869                        
        'CY',                   //FL_CHARLOTTE_CTY_ARR      34849                        
        'W0050',                   //FL_MARION_CTY_SO          34700                        
        'FB',                   //FL_SARASOTA_CTY           26049                        
        'GO',                   //FL_PUTNAM_CTY_ARR         23468                        
        'W0065',                   //FL_OKALOOSA_CTY_SO        23004                        
        'W0310',                   //FL_OSCEOLA_CTY_CORR       21211                        
        'W0120',                   //FL_BAY_CTY_JAIL           19423                        
        'W0176',                   //FL_INDIANRIVER_CTYSO      18719                        
        'Z5',                   //FL_DESOTO_CTY_ARR         18014                        
        'W0178',                   //FL_MONROE_CTY_SO          17359                        
        'W0322',                   //FL_ALACHUA_CTY_SO_V2      17145                        
        'W0080',                   //FL_FLAGLER_CTY_SO         15418                        
        'CZ',                   //FL_CITRUS_CTY_ARR         14175                        
        'W0064',                   //FL_HENDRY_CTY_SO          13673                        
        'GQ',                   //FL_SUWANNEE_CTY_ARR       13656                        
        'W0180',                   //FL_PUTNAM_CTY_SO          12076                        
        'W0121',                   //FL_WALTON_CTY_DOC         8111                        
        'GF',                   //FL_INDINRIVER_CTY_AR      8103                        
        'W0095',                   //FL_BRADFORD_CTY_SO        6551                        
        'W0201',                   //FL_ALACHUA_CTY_SO         5991                        
        'W0079',                   //FL_COLUMBIA_CTY_SO        5747                        
        'W0059',                   //FL_OKEECHOBEE_CTY_SO      5529                        
        'W0273',                   //FL_LEE_CTY_SO             5516                        
        'W0209',                   //FL_COLLIER_CTY_SO         4896                        
        'FY',                   //FL_HARDEE_CTY_ARR         3392                        
        'W0082',                   //FL_JACKSON_CTY_SO         3130                        
        'W0323',                   //FL_CLAY_CTY_SO            3096                        
        'W0214',                   //FL_SARASOTA_CTY_SO        3056                        
        'W0068',                   //FL_GLADES_CTY_SO          3016                        
        'W0238',                   //FL_PINELLAS_CTY_SO        1936                        
        'W0271',                   //FL_CITRUS_CTY_SO          1650                        
        'W0324',                   //FL_DIXIE_CTY_SO_V2        1413                        
        'W0229',                   //FL_LEVY_CTY_SO            1118                        
        'W0239',                   //FL_HIGHLANDS_CTY_SO       998                        
        'W0119',                   //FL_BAKER_CTY_SO           948                        
        'W0274',                   //FL_ST_JOHNS_CTY_SO        396                        
        'W0275',                   //FL_ST_LUCIE_CTY_SO        284                        
        'W0272',                   //FL_DIXIE_CTY_SO           251                        

        'GD',                   //GA_BUREAU_OF_INVESTI      5548348            13853      Item      Georgia Criminal Court      Court Ventures, Inc. (Experian)
        'DJ',                   //GA_DOC                    1590076                              
        'VE',                   //GA_DOC_WEBSITE            1542692                              
        'I0010',                   //GA_DEKALB_CTY_JUD         906983                              
        'GC',                   //GA_GWINNETT_CTY           365474                              
        'GW',                   //GA_FULTON_CTY_ARR         308287                              
        'GS',                   //GA_BIBB_CTY_ARR           240676                              
        'W0183',                   //GA_GWINNETT_CTY_DTC       206625                              
        'I0017',                   //GA_GWINET_LWRNCVILSC      149373                              
        'GB',                   //GA_COBB_CTY               135100                              
        'DK',                   //GA_PAROLE                 130402                              
        'GT',                   //GA_CHATHAM_CTY_ARR        108755                              
        'GX',                   //GA_GWINNETT_CTY_ARR       86208                              
        'W0182',                   //GA_CHATHAM_CTY_SO         68737                              
        'I0016',                   //GA_CARROLL_SUP_COC        47047                              
        'GU',                   //GA_CLARKE_CTY_ARR         35054                              
        '10G',                   //GA_PAR_RELEASED_INM       30644                              
        'UX',                   //GA_CHATHAM_CTY            26281                              
        'GV',                   //GA_DAWSON_CTY_ARR         7235                              

        '16371',                   //Item      Oklahoma Criminal Court      Court Ventures, Inc. (Experian)      Historical
        '16373',                   //Item      Oklahoma Sentencing Criminal Court      Court Ventures, Inc. (Experian)      Historical
        '5W',                   //OK_DCS                    3414541                              
        'EF',                   //OK_DOC                    2488718                              
        '5W',                   //OK_DISTRICT_COURTSH       2222723                              
        'WH',                   //OK_DOC_WEBSITE            1638355                              
        'I0030',                   //OK_TULSA_DC               1302950            12035      Item      Tulsa County, OK Criminal Court      Court Ventures, Inc. (Experian)
        'PS',                   //OK_AOC                    1262266                              
        'I0027',                   //OK_OKLAHOMA_DC            769468            12023      Item      Oklahoma County, OK Criminal Court      Court Ventures, Inc. (Experian)
        '2A',                   //OK_OKLAHOMA_CRIM_COU      448619                              
        '2E',                   //OK_TULSA_CRIM_COURT       356396                              
        'I0025',                   //OK_CLEVELAND_DC           299545            12011      Item      Cleveland County, OK Criminal Court      Court Ventures, Inc. (Experian)
        '1U',                   //OK_CLEVELAND_CRIM_CO      107723                              
        'I0028',                   //OK_PAYNE_DC               92096            12027      Item      Payne County, OK Criminal Court      Court Ventures, Inc. (Experian)
        'I0026',                   //OK_COMANCHE_DC            88481            12013      Item      Comanche County, OK Criminal Court      Court Ventures, Inc. (Experian)
        '1V',                   //OK_COMANCHE_CRIM_COU      54890                              
        'I0029',                   //OK_ROGERS_DC              50684            12031      Item      Roger Mills County, OK Criminal Court      Court Ventures, Inc. (Experian)
                                            // 12033      Item      Rogers County, OK Criminal Court      Court Ventures, Inc. (Experian)
        '2B',                   //OK_PAYNE_CRIM_COURT       41331                              
        '1W',                   //OK_GARFIELD_CRIM_COU      38654            12019      Item      Garfield County, OK Criminal Court      Court Ventures, Inc. (Experian)
        '1T',                   //OK_CANADIAN_CRIM_COU      33687            12007      Item      Canadian County, OK Criminal Court      Court Ventures, Inc. (Experian)
        '2D',                   //OK_ROGERS_CRIM_COURT      31076                              
        '1Z',                   //OK_LOGAN_CRIM_COURT       12653            12021      Item      Logan County, OK Criminal Court      Court Ventures, Inc. (Experian)
        'KV',                   //OK_CARTER_CTY_ARR         11938                              
        'KX',                   //OK_OSAGE_CTY_ARR          10899                              
        '1S',                   //OK_ADAIR_CRIM_COURT       9698            12005      Item      Adair County, OK Criminal Court      Court Ventures, Inc. (Experian)
        '2C',                   //OK_PUSHMATAHA_CRIM_C      4923            12029      Item      Pushmataha County, OK Criminal Court      Court Ventures, Inc. (Experian)
        'ZB',                   //OK_DOC_VIOL_OFND_REG      2091                              
        'I0007',                   //OK_VIOLENT_OFNREG         1949                              
        '2F',                   //OK_ROGERMILLS_CRIM_C      1642                              
        '1X',                   //OK_ELLIS_CRIM_COURT       1207            12017      Item      Ellis County, OK Criminal Court      Court Ventures, Inc. (Experian)
        'KW',                   //OK_COMANCHE_CTY_ARR       18                              

        '16561',                   //Item      Pennsylvania Criminal Court      Themis Data Solutions (formerly known as Experian/Court Ventures)
        '16577',                   //Item      Pennsylvania Criminal Statewide Historic      Court Ventures, Inc. (Experian)      Historical
        'PU',                   //PA_AOC                    13559153            
        'PV',                   //PA_AOC_COURT_OF_CPC       3250094                              
        'EH',                   //PA_DOC                    562084                              
        'LQ',                   //PA_LANCASTER_CTY_ARR      23418                              
        'LR'                    //PA_YORK_CTY_ARR           1867                              

];
// 8 vendor
Civil_allowed     := [

        // 90% of sources: (see: Crim_Common\File_In_Court_Offender.ecl)
        '59',  //       8,381,202       16%      NJ-STATEWIDE             // 15811 no bulk and no consumer restrictions in orbit
        // '18',  //       4,440,247       8%      CA-LA-CNTY-CIV-COURT // 11047 bulk and consumer not allowed
        '25',  //       3,918,392       7%      NY-STATEWIDE-CIV-CRT    //  20181, 20183 no bulk and no consumer restrictions in orbit


        '47',  //       3,486,914       7%      UT-STATEWIDE-CIV-CRT
        '04',  //       2,516,734       5%      CT-CIVIL-COURT
        '34',  //       2,381,338       5%      Criminal Court Fl Duval Statewide Traffic and Criminal
        '61',  //       2,359,860       4%      MD-CIVIL-COURT
        '26',  //       1,704,386       3%      FL-HILLSBOROUGH-DMV
        '13',  //       1,573,286       3%      VA_Statewide_Offender
        '11',  //       1,305,581       2%      AZ-CRIM-CIVIL-COURT
        '17',  //       1,271,794       2%      Criminal Court CA Los Angeles County
        '29',  //       1,259,150       2%      FL-BREVARD-CO-CIV-CT
        '90',  //       1,225,738       2%      TX-HarrisCntyCivil
        '88',  //       1,216,823       2%      IA STATEWIDE
        '30',  //       1,180,877       2%      NY-UPSTATE-CIV-COURT
        '42',  //       1,066,167       2%      FL-ORANGE_CTY
        '19',  //       1,001,011       2%      CA-S-BDNO-CO-CIV-CRT
        '54',  //       935,151       2%      Criminal Court Convictions for Chambers County, Texas
        '27',  //       840,676       2%      Criminal Court Convictions for Broward County, Florida
        '63',  //       753,777       1%      fl_lake_traffic_crim
        '60',  //       738,179       1%      PA-BUCKS-CIVIL-COURT
        '06',  //       732,029       1%      Criminal Court AR Statewide
        '21',  //       719,084       1%      CA-FRESNO-CO-CIV-CRT
        '01',  //       681,624       1%      AK-CRIM-CIVIL-COURT
        '38',  //       645,103       1%      CA-MARIN_CTY
        '49',  //       531,601       1%      CA-CIV-KERN-CO
        '03'   //       522,600       1%      WA-CIVIL-LTD-JURI

];
// 9 email_src
Emails_allowed    := [

        // 'AW',//      1785070539 Acquired Web     (Claritas LLC. (formerly AcquireWeb c/o Venture Development Center, Inc.) // 19431 - no bulk allowed
        '!I',//      1569609036 Infutor Nare - Consumer Name and Email Resource         // 18751 - no restrictions
        // 'ET',//      675969028 - src_Entiera -                               // 19621 - no consumer allowed
        'AN',//      570636458 Anchor Computer Email Addresses              // 30202 - no restrictions
        'DG',//      380546029 Datagence                                 // 19931 - no restrictions
        'RS',//      337844521 RealSource Inc Email Addresses           // 30288 - no restrictions
        'M1',//      332071022 Media One Email                        // 20093 - no restrictions
        //'TM',//      142995111 Thrive LT (Lending Transactions)   // 19781  - no bulk allowed
        'SC'//      104864181 Sales Channel                          // 19947 - no bulk allowed
        // 'W@',//      68216647 - src_Wired_Assets_Email - UNSURE // 19471, 20043 - no consumer allowed
        //'T$',//      29507199 Thrive PD (Pay Day)                 // 19781 - no bulk allowed
        // 'IM',//      19855364 - src_Impulse                            // 19473 - no consumer allowed, no bulk allowed
        // 'AO' //      8889175 Alloy Media Opt-in Consumer non-directory   // 19999 - no bulk allowed

];
// 10
Aircraft_NOT_allowed  := [

        /* no source code */    // 18273      Aircrafts. Single source. No bulk and no consumer restrictions

]; 
// 11
Airmen_allowed    := [
        
        'AM' // 18321 - only source. No bulk and no consumer restrictions in orbit

];
// 12
Hunting_allowed   := [ //Motznik Computer Service not allowed but status = Removed From Production      

        // these amount to over 99% of records
        'SH',
        'VH',
        'HF',
        'CV',
        '',
        'H',
        'SC',
        'F' 
        // EMerge_CCW_NY             := 'E7'; // this is the only known exclusion (2 records on this date)
];

// 13 
Liens_NOT_allowed     := [

        'MA' // 15097 no bulk and no consumer (even though 15083 and 15095 are ok)

];
// 14 filing_jurisdiction
UCC_allowed       := [

        'TX',    // No bulk or consumer restrictions:      17139
        'WA',    // No bulk or consumer restrictions:       31648,12243,12315
        // 'CA', //      Cannot separate from bulk restricted source (17375): 13091 (is ok to use)
        'MA'    // No bulk or consumer restrictions:       15099
        //'NY', //       can't separate restricted dun/experian (15925, 15937): 20157 (is ok to use)
        // 17897 is the only generic source with restrictions:      American Samoa UCC Filings      Dun & Bradstreet.
        // However, the status of this source is=Don't Process
];
// 15 source
People_At_Work_NOT_allowed :=[
 
        // 'QQ',//      125,975,695 // Eq Employer
        // 'ZM',//       93,562,531 // ZOOM
        'BR',//       54,574,353 // Business Registration 
                                   // 18253      Item      National Business Registrations      Dun & Bradstreet

        'IA',//       52,251,593 // INFOUSA ABIUS(USABIZ) // 18209, 18217, 18219, 18275, 18315 - Bulk sale restricted in Orbit
        // 'C0',//       34,148,464 // FL Corporations
        // 'CN',//       19,846,810 // TX Corporations
        // 'C,',//       16,239,391 // CA Corporations
        // 'SK',//       12,233,208 // SK&A Medical Professionals // 18031      Item      SKA Licensed Physicians - Bulk restricted on Orbit
        // 'C<',//       11,809,083 // MA Corporations
        // 'C)',//        9,442,993 // AK Corporations
        'UF'//        9,093,347 // src_FBNV2_INF  INF FBNV2 Infousa // 18209, 18217, 18219, 18275, 18315 - Bulk sale restricted in Orbit

];
// 16 vendor
Phones_allowed         :=[

        'IR', //       3,818,811,254 // Infutor CID - Phones  // 17907 - no oribt restrictions
/* ** UNSURE ** */ // // 'HD', //       2,646,805,026 // Header UNSURE
/* ** UNSURE ** */ // // 'IQ', //       1,850,797,480 // INQUIRY UNSURE
        
        // 'PN', //       1,432,062,004 // PCNSR Phones  (infoUSA)    // 18221 - bulk restricted
        // pcnsr is the master build.  the underlying source is white pages and consumer universe

        // // 'GO', //       304,113,781   // Gong History               
        'N2', //       251,337,629   // Neustar Wireless Phones    // 20437 - bulk restricted
        // 'WP', //       155,311,403   // WHITE PAGES               // 17955, 19605 - bulk and consumer restricted
        '02', //       78,775,546    // Cellphones Traffix        // 17919 - no orbit restriction
        // 'TM', //       66,227,671    // Thrive LT (Lending Transactions)  // 19781 - bulk restricted
        // '01', //       41,352,583    // Cellphones Kroll              // 17921 - bulk restricted
        'IO' //       23,319,482    // INTRADO                       // 17815 - bulk restricted
        // 'T$', //       19,717,925    // Thrive PD (Pay Day)           // // 19781 - bulk restricted
        // 'AO', //       13,177,142    // ?? src_AlloyMedia_consumer ?? 'Alloy Media Opt-in Consumer non-directory' ?? ONLY EMAIL ?? // 18985 - bulk restricted
/* ** UNSURE ** */ // // 'L9', //       2,537,826     //src_Link2Tek    UNSURE
/* ** UNSURE ** */ // // '05', //       1,789,871     // CELL - NEXTONES    UNSURE
        // 'WO', //       617,897       // WIRED // 19471 , 19743, 20043 - Consumer restricted

/* ** UNSURE ** */ // Possible Now       - Is this in Phones?
/* ** UNSURE ** */ // Link2Tek           - Is this in Phones?
/* ** UNSURE ** */ // Qsent phone data   - Now sure how to find these records

];  
//17 vendor
Professional_Licenses_NOT_allowed := [
        
        'INFOGROUP', 'INFOUSA',                            // D2C unrestricted, bulk restricted      (19%)  (20840)
        'ALC',                                             // D2C unrestricted, bulk restricted       (9%)  (20446)
        // 'CALIFORNIA DEPARTMENT OF CONSUMER AFFAIRS'     // D2C unrestricted, bulk unrestricted     (8%)  (13107)
        // 'HMS_PL_FL_32'                                  // D2C unrestricted, bulk unrestricted     (4%)  (13755, 13757, 13759)
        'MICHIGAN DEPARTMENT OF CONSUMER & INDUSTRY'       // D2C unrestricted, bulk estricted (..41) (2%)  (15141, 15143, 15145)
        // 'ILLINOIS DEPARTMENT OF PROFESSIONAL REGULATION'// D2C unrestricted, bulk unrestricted     (2%)  (14247)
        // 'COMMONWEALTH OF PENNSYLVANIA'                  // D2C unrestricted, bulk unrestricted     (2%)  (16497,16499,16501,16503,16505,16507,16509,16511,16513,16515,16517,16519,16521,16523,16525,16527,16529,16531,16533,16535,16537,16539,16541,16543,16545,16547,16549,16581)
                                                           // note: 16541 is defaulted to restricted, but no legal input is available
        // 'HMS_PL_CA_21'                                  // D2C unrestricted, bulk unrestricted     (2%)  (13107)
        // NEW JERSEY DIVISION OF CONSUMER AFFAIRS         //  D2C unrestricted, bulk unrestricted    (2%)  (15783,15825)

];
//18 // source_file
Sex_Offenders_NOT_allowed := [

        // 19135	Item	Sex Offender Registry	HDI/Appriss (formerly Hygenics)
        // All hygenics allowed but must be filtered down to only 30% of RECRODS.

        // 'TX_OFFENDER_REGISTRY', //       382,292       16% // 13103 bulk and consumer restricted
        // 'CA_SEX_OFFENDER_REGI' //       369,923       16% // 13129 (historical) no orbit restrictions
        // 'FL_SEX_OFFENDER_REGI', //       258,821       11% // 13723, 13761 says removed from production. 761 bulk and consumer restricted
        // 'MI_SEX_OFFENDER_REGI', //       92,063       4% // 15137 bulk and consumer restricted
        // 'MO_SEX_OFFENDER_REGI', //       81,019       3% // 15403, 15423 bulk and consumer restricted
        // 'GA_SEX_OFFENDER_REGI', //       79,448       3% // 13857, 14099  bulk and consumer restricted
        // 'NC_WEB_SEX_OFFENDER_', //       78,798       3% // 16007, 16025  bulk and consumer restricted
        // 'PA_SEX_OFFENDER_REGI', //       68,731       3% // 16571, 16599  bulk and consumer restricted
        // 'VA_OFFENDER_REGISTRY', //       64,542       3% // 17335         bulk and consumer restricted
        // 'SC_SEX_OFFENDER_REGI', //       59,565       3% // 16671, 16687  bulk and consumer restricted
        // 'TN_SEX_OFFENDER_REGI', //       53,374       2% // 16817, 16839  bulk and consumer restricted
        // 'NY_SEX_OFFENDER_REGI', //       50,939       2% // 15947, 15957  bulk and consumer restricted
        // 'CO_SEX_OFFENDER_REGI', //       49,281       2% // 13147, 13167 167 bulk and consumer restricted
        // 'IL_SEX_OFFENDER_REGI', //       49,084       2%  bulk and consumer restricted
        // 'KY_SEX_OFFENDER_REGI', //       48,524       2%  bulk and consumer restricted
        // 'CO_BUREAU_OF_INVESTI', //       47,988       2%  bulk and consumer restricted
        // 'NV_OFFENDER_REGISTRY' //       38,766       2%  bulk and consumer restricted

];
//19 source
Voter_Registration_allowed :=[

    'EMERGES'

];
//20 ln_fares_id
Deeds_Mortgages_bulk_D2C_allowed := [

        //'RD' // corelogic deeds no bulk 17989
        'OD' // okc deeds no restrictions 17991
        //'OM' // okc mortgages defaulted to restricted (pending review still) (17993)
        //'DD' // Dayton Deed (historical)
        //'DM' // Dayton Mortgage (historical)

];
//21 ln_fares_id
Tax_Assessments_bulk_D2C_allowed := [

        //'RA' // corelogic assessement no bulk 17985
        'OA' // OKC assessment no restrictions 17987
        //'DA' // Dayton Assessments (historical)

];
//22
Student_NOT_allowed := [

        'SL'                  // 18065 bulk restricted
        /* not in file? */    // 18765 bulk restricted
        /* not in file? */    // 21446  (OKC) - ok

];

EXPORT Check(UNSIGNED1 rec_type, STRING src) := CASE(rec_type,

    1  =>    (src       in Consumers_allowed                  ),
    2  =>    (src       in AddressHist_allowed                ),
    3  =>    (src       in Akas_allowed                       ),
    4  =>    (src       in Relatives_allowed                  ),
    5  => ~  (src       in Bankruptcy_NOT_allowed             ), // NO SOURCE IN DATASET. ONE SOURCE (PACER) NEEDS LEGAL CONSULT
    6  => ~  (src       in CWP_NOT_allowed                    ),
    7  => ~  (src       in Crims_NOT_allowed                  ), // 19403 does this mean we must exclude all crim recodds? "National Criminal Suppression"      Themis Data Solutions (formerly known as Experian/Court Ventures)
    8  =>    (src       in Civil_allowed                      ),
    9  =>    (src       in Emails_allowed                     ),
    10 => ~  (src       in Aircraft_NOT_allowed               ), // ONE source. All allowed. No source field
    11 =>    (src       in Airmen_allowed                     ),
    12 =>    (src       in Hunting_allowed                    ),
    13 => ~  (src       in Liens_NOT_allowed                  ),
    14 =>    (src       in UCC_allowed                        ),
    15 => ~  (src       in People_At_Work_NOT_allowed         ),
    16 =>    (src       in Phones_allowed                     ),
    17 => ~  (src       in Professional_Licenses_NOT_allowed  ) AND ~(src[1..3] in ['ENC','HMS'] ), 
    18 => ~  (src       in Sex_Offenders_NOT_allowed          ),
    19 =>    (src       in Voter_Registration_allowed         ),
    20 =>    (src[1..2] in Deeds_Mortgages_bulk_D2C_allowed   ),
    21 =>    (src[1..2] in Tax_Assessments_bulk_D2C_allowed   ),
    22 => ~  (src       in Student_NOT_allowed                ),
    false);

END;
