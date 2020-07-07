IMPORT DueDiligence;


EXPORT RegularExpressions := MODULE

    SHARED STARTS_WITH := '^';
    SHARED ENDS_WITH := '.*$';
    
    
    
    EXPORT NOT_PO_ADDRESS_EXPRESSION := '^((?!((P[\\s\\.]*O[\\.\\s]*)|(POST[\\s]*OFFICE[\\s]*))+BOX).)*$';  //finds reference to anything other than po box or post office box

    EXPORT FELONY_NOT_REDUCED := '^(?=.*(\\b|\\B)(FELONY))(?!.*(\\b|\\B)(REDUCED))(?!.*(\\b|\\B)(NON-FELONY)).*$';
    EXPORT SPECIFIC_KEYWORD_TRAFFIC := '^(?=.*\\b(TRAFFIC)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_INFRACTION := '^(?=.*\\b(INFRACTION)\\b).*$';
    EXPORT SPECIFIC_KEYWORD_MISDEMEANOR:= '^(?=.*\\b(MISDEMEANOR)\\b).*$';
    

    /*
      As of 01/14/2020 these will no longer be
      used as part of the Due Diligence suite.
      This is now being replaced with a
      ML (Machine Learning) model.
    */
    SHARED COMMON_INFRACTION_ORDINANCES_LIST := '((?=.*(\\b|\\B)(ORDINANCE|NOISE|MUSIC|LOUD|CODE|LITTER|TRASH|FIREWORK|CURFEW|CITATION|PEDDL|JAYWALK))|((?=.*(\\b|\\B)(PAN))(?=.*(\\b|\\B)(HANDL)))|((?=.*(\\b|\\B)(PUB))(?=.*(\\b|\\B)(NUIS|DIST)))|((?=.*(\\b|\\B)(CITY))(?=.*(\\b|\\B)(ORDIN)))|((?=.*(\\b|\\B)(CIVIL))(?=.*(\\b|\\B)(ASSESS))))';
    SHARED COMMON_LIVESTOCK_ANIMAL_LIST := '(((?=.*(\\b|\\B)(ANIMAL|AMNL|ANIML|ANMLS|DOG|RABIES|VACC|SPAY|NEUTER|LIVESTOCK|LVSTOK|LIVESTK|LVSTCK|L\\/STOCK|SWINE|HOG|COW|CATTLE|SHEEP|GOAT|MULE|HORSE|HRSE))|(?=.*(CAT|PET)\\b)|((?=.*(\\b|\\B)(EXOTIC))(?=.*(\\b|\\B)(SPEC))))(?!.*((\\b|\\B)(VERIFICAT|IDENTIFICAT|DEFACAT|INTOXICAT|REVOCAT|EQUIP|CERTIFICAT)|' + COMMON_INFRACTION_ORDINANCES_LIST + ')))';
    SHARED COMMON_FISH_GAME_ANIMAL_LIST := '(((?=.*(\\b|\\B)(DNR|WILDLIFE|WLDLIF|BOBCAT|PHEASANT|TURKEY|DUCK|WATERFOWL|PINTAIL|GEESE|GOOSE|PELICAN|DOVE|FOWL|BEAR|DEER|ELK|MOOSE|SQUIRREL|RABBIT|MINK|FOX|FISH|WALLEYE|CRAPPIE|BLUEGILL|SAUGER|SALMON|SNAPPER|TROUT|FLOUNDER|ROCKF|WELK|PERCH|TUNA|CRAB|CONCH|SHRIMP|LOBSTER|OYSTER|ANIMAL|BIRD|MIGRATORY|SWAN|BUCK|DOE(\\b)|RAC(C)?OON|GOPHER|STEELHEAD|GATOR|STURGEON|TORTOISE|F\\&W))|((?=.*(\\b|\\B)(GAM))(?=.*(\\b|\\B)(BIG|MAMMAL)))|((?=.*(\\b|\\B)(BG))(?=.*(\\b|\\B)(GAM)))|((?=.*(\\b|\\B)(NORTH))(?=.*(\\b|\\B)(PIKE)))|((?=.*(\\b|\\B)(BASS))(?=.*(\\b|\\B)(SEA|STRIP|MOUTH|BLACK|UNDERS)))|((?=.*(\\b|\\B)(BIRD))(?=.*(\\b|\\B)(GAM|WILD|MIG)))|((?=.*(\\b|\\B)(RED))(?=.*(\\b|\\B)(DRUM)))|((?=.*(\\b|\\B)(LARGE))(?=.*(\\b|\\B)(MOUTH))))(?!.*(\\b|\\B)(BEARING|BIGAMY|((?=.*(\\b|\\B)(CITY))(?=.*(\\b|\\B)(KILLDEER))))))';
    SHARED COMMON_HUNT_TRAP_FISH_TERMS_LIST := '(((?=.*(\\b|\\B)(FISH|HUNT|TRAP|SPORTSMAN|TAXIDERMY|CREEL|ANGLING))|((?=.*(\\b|\\B)(GAM))(?=.*(\\b|\\B)(TAG|TRANSP|STAMP|DARK)))|((?=.*(\\b|\\B)(SEAS))(?=.*(\\b|\\B)(OUT|CLOSED)))|((?=.*(\\b|\\B)(EXCEED|OVER))((?=.*(\\b|\\B)(DAIL))(?=.*(\\b|\\B)(LIMIT))))|((?=.*(\\b|\\B)(ICE))(?=.*(\\b|\\B)(HOUSE)))|((?=.*(\\b|\\B)(TREE))(?=.*(\\b|\\B)(STAN)))|((?=.*(\\b|\\B)(LIMIT))(?=.*(\\b|\\B)(BIRD|BASS|NORTH|PIKE))))(?!.*(\\b|\\B)(BEARING|TRAPSP|BOOBY|MANTRAP|RAPE|STAT|DANGLING|ROUTE)))';
    
    SHARED COMMON_DUI_LIST := '(((?=.*(\\b|\\B)(D(W|U)I|(D\\.(W|U)\\.I(\\.)?)|(D\\s(W|U)\\sI)|(D\\.\\s(W|U)\\.\\sI(\\.)?)|DWR))|((?=.*(\\b|\\B)(DRIV|DRVG|OPER|MV|DR|OPER|VESSEL))(?=.*(\\b|\\B)(IN(OT|TO)X|BAC|ALC|CHEM|IMPAIR|OWI|CONSUM|UNDER|DRINK|((?=.*(\\b|\\B)(UND))(?=.*(\\b|\\B)(INF)))))))(?!.*(\\b|\\B)(DRY|BACKING|KNOWI|((?=.*(\\b|\\B)(UND))(?=.*(\\b|\\B)(REVO|SUSP))))))';
    SHARED COMMON_ALCOHOL_LIST := '((((?=.*(\\b|\\B)(PUB))(?=.*(\\b|\\B)(INTOX|CONSUM|DRING|DRINK)))|((?=.*(\\b|\\B)(OPEN))(?=.*(\\b|\\B)(CON|CNT|CTN|BOTT|BTL|ALC)))|((?=.*(\\b|\\B)(ALC(\\.)?))(?=.*(\\b|\\B)(VIO|BAC|POSS(\\.)?|BLOOD|CON)))|((?=.*(\\b|\\B)(CONSUM))(?=.*(\\b|\\B)(UNDERAGE|MINOR)))|((?=.*(\\b|\\B)(SELL))(?=.*(\\b|\\B)(ALCH|LIQ)))|((?=.*(\\b|\\B)(DRY))(?=.*(\\b|\\B)(AREA)))|((?=.*(\\b|\\B)(UNDER))(?=.*(\\b|\\B)(INFL)))|((?=.*(\\b|\\B)(REFUSE))(?=.*(\\b|\\B)(BLOOD|BREA)))|(?=.*(\\b|\\B)(DRUNK|ABC|LIQUOR|ALCOH|BEER|MOONSHI|WHISKEY|KEG|MALT|WINE|INTOX)))(?!.*(\\b|\\B)(MALTREAT|SWINE)))';
    
    SHARED COMMON_GANG_LIST := '(((?=.*(\\b|\\B)(GANG))|((?=.*(\\b|\\B)(GNG))(?=.*(\\b|\\B)(STR|CR(I)?M)))|((?=.*(\\b|\\B)(GAN))(?=.*(\\b|\\B)(STR))(?=.*(\\b|\\B)(CR(I|M))))|((?=.*(\\b|\\B)(GAN))(?=.*(\\b|\\B)(STRE|CR(I)?M))))(?!.*(\\b|\\B)(ENGANG|ENDANGERING|DMGNG|ORGAN)))';
    
    SHARED COMMON_COMPUTER_CYBER_LIST := '((?=.*(\\b|\\B)(COMPU|CYBER|INTERNET))(?!.*(\\b|\\B)(RAPE|COMPUL)))';
    SHARED COMMON_STALK_INTIM_LIST := '(((?=.*(\\b|\\B)(STALK|HAR(R)?AS|TERRORI(ZE|STIC)|INTIMID|THREATEN|BULLY|PROWL|MENAC|BRANDISH))|((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(THREAT))))(?!.*(\\b|\\B)(BIAS|ETHNIC|RACIAL|RELIGIOUS)))';
    
    SHARED COMMON_ARSON_LIST := '(((?=.*(\\b|\\B)(ARSO|BURN))|((?=.*(\\b|\\B)(SET))(?=.*(\\b|\\B)(FIRE))))(?!.*(\\b|\\B)(FIREWORK)))';
    SHARED COMMON_BREAK_ENTER_LIST := '((((?=.*(\\b|\\B)(BREAK))(?=.*(\\b|\\B)(ENT|IN)))|((?=.*(\\b|\\B)(UNAUTH|UNLAW))(?=.*(\\b)(ENTER)))|((?=.*(\\b|\\B)(HOME))(?=.*(\\b|\\B)(INV)))|(?=.*(\\b|\\B)(B\\&E|B\\s\\&\\sE)))(?!.*(\\b|\\B)(BREAKAWAY|BRAK)))';
    SHARED COMMON_BURGLARY_LIST := '((?=.*(\\b|\\B)(BUR(G|L(A|G))|BRG|BUGL))(?!.*(\\b|\\B)(PITTSBURGH|PETERSBURG|REDUCED|((?=.*(\\b)(RED))(?=.*(\\b)(TO)(\\b))))))';
    SHARED COMMON_CAR_JACK_LIST := '(((?=.*(\\b|\\B)(JACK))(?=.*(\\b|\\B)(CAR|VEH)))|(?=.*(\\b|\\B)(CARJACK))|((?=.*(\\b|\\B)(UNAUTH|UNLAW))(?=.*(\\b|\\B)(USE))(?=.*(\\b|\\B)(VEH)))|(?=.*(\\b|\\B)(U(\\.)?U(\\.)?M(\\.)?V)))';
        
    SHARED COMMON_TRAFFIC_VEHICLES_LIST := '(((?=.*(\\b|\\B)(VEH))(?=.*(\\b|\\B)(FEE|COMM)))|((?=.*(\\b|\\B)(PICKUP))(?=.*(\\b|\\B)(BED)))|((?=.*(\\b|\\B)(JET))(?=.*(\\b|\\B)(SKI)))|((?=.*(\\b|\\B)(GLASS))(?=.*(\\b|\\B)(TINT)))|((?=.*(\\b|\\B)(WIND))(?=.*(\\b|\\B)(TINT|SIDE)))|((?=.*(\\b|\\B)(WATER))(?=.*(\\b|\\B)(VESS|SKI)))|(?=.*(\\b|\\B)(MOPED|VEHICLE|MOTOR|MOTCY|BIKE|BICYC|BOAT|JETSKI|PONTOON|WATERCRAFT|VESSEL|SURFBOARD|PWC|M\\/CYCLE|MOTORC|PEDES|HELMET|ODOMETER|SPEEDOMETER|AXLE|AXEL|WINDSHIELD|SUNSCREEN|SUNROOF|SNOWMOBILE|SNOWMACHIN|SNWMBL|SNWB|SNW\\/MBL|ATV|DRIVERSIDE|MUFFLER|EXHAUST|FENDER|MUDGUARD|TIRES|WINDOW))|((?=.*(\\b|\\B)(SNW))(?=.*(\\b|\\B)(OPR|TRAC|STOP)))|((?=.*(\\b|\\B)(HEAD|BR(K|AKE)|TAIL))(?=.*(\\b|\\B)(LAMP|LIGHT|LITE|LGT)))|((?=.*(\\b|\\B)(DEFECT))(?=.*(\\b|\\B)(EQUIP)))|((?=.*(\\b|\\B)(HAND))(?=.*(\\b|\\B)(BAR)))|((?=.*(\\b|\\B)(PHONE))(?=.*(\\b|\\B)(CELL|MOB|EAR))))';
    SHARED COMMON_TRAFFIC_TERM_SIGN_LIST := '(((?=.*(\\b|\\B)(SIGN))(?=.*(\\b|\\B)(STOP|HWY|HIGH)))|((?=.*(\\b|\\B)(RED))(?=.*(\\b|\\B)(LIGHT)))|((?=.*(\\b|\\B)(TRAF))(?=.*(\\b|\\B)(DEVIC|LIGHT|LANE|CONTR|BARRIER)))|((?=.*(\\b|\\B)(DIS))(?=.*(\\b|\\B)(TC))(?=.*(\\b|\\B)(DEV)))|((?=.*(\\b|\\B)(TRAFFIC))(?=.*(\\b|\\B)(LANE)))|((?=.*(\\b|\\B)(HIGHWAY))(?=.*(\\b|\\B)(OBSTRUCT|VEH|FIXTURE|DIV|STOP|MARK)))|(?=.*(\\b|\\B)(STNS|SIGNAL|ONE\\-WAY|SNWRMVL|SIDEWALK|FREEWAY|DRIVEWAY|BLOCKING|TRAVELING|METER|CROSSWALK|RADAR))|((?=.*(\\b|\\B)(RAIL))(?=.*(\\b|\\B)(ROAD)))|((?=.*(\\b|\\B)(BLOCK))(?=.*(\\b|\\B)(ROAD|PLATES|DRIVE|TRAFFIC))))';
    SHARED COMMON_TRAFFIC_ACCIDENT_VIOLATIONS_LIST := '((((?=.*(\\b)(SP)(\\b))(?=.*(MPH)(\\b)))|(?=.*(\\b)((\\d)+(\\s)+(SP(D)?|MPH)))|(?=.*(\\b)(SP(D)?(\\.|\\s|\\:|\\;|\\/)+\\d))|((?=.*(\\b|\\B)(SCEN|CRASH|ACCIDENT))(?=.*(\\b|\\B)(LEAV(E|ING)|LV)))|((?=.*(\\b|\\B)(HIT))(?=.*(\\b|\\B)(RUN)))|((?=.*(\\b|\\B)(RECK))(?=.*(\\b|\\B)(DRIV(E|I)|OPER)))|((?=.*(\\b|\\B)(ACCIDENT))(?=.*(\\b|\\B)(INFO)))|((?=.*(\\b|\\B)(FOLLO))(?=.*(\\b|\\B)(CLOS)))|((?=.*(\\b|\\B)(IMPRO))(?=.*(\\b|\\B)(BACK)))|((?=.*(\\b|\\B)(VIOL))(?=.*(\\b|\\B)(WEIG|PARK|METER|PLATE|((?=.*(\\b|\\B)(BAS))(?=.*(\\b|\\B)(RUL)))|((?=.*(\\b|\\B)(INST))(?=.*(\\b|\\B)(PERM))))))|((?=.*(\\b|\\B)(CLEAR))(?=.*(\\b|\\B)(DIST)))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(STOP|YIEL|YLD|YROW|TOLL)))|((?=.*(\\b|\\B)(SPEED))(?=.*(\\b|\\B)(RAC|EXCES|RECK|CONTEST|EXCEED|TOW|MPH|LIMIT|TRAFFIC|DRIV|EXHIB|MISD|MSD|POST|ENDANG|IDLE|REASONABLE|IMP|MAX|VEHIC|VIOLAT|RATE|(\\d(\\s)?(\\/|\\-|\\\\)(\\s)?\\d)|((?=.*(\\b|\\B)(MILES))(?=.*(\\b|\\B)(OVER))))))|((?=.*(\\b|\\B)(SEAT))(?=.*(\\b|\\B)(BELT|BLT|REST|CHILD)))|((?=.*(\\b|\\B)(SAFE|SFTY))(?=.*(\\b|\\B)(BELT|BLT|RESTR)))|((?=.*(\\b|\\B)(PASS))(?=.*(\\b|\\B)(OBS|REST|BELT|BLT)))|(?=.*(\\b|\\B)(ACDA|BACKING|PARKING|NONMOVING|DRVNG|OMV|SPDG|RACING|SPEEDING|MVI|YIELD))|((?=.*(\\b|\\B)(DRIV|TRAFFIC|DROV|OPER))(?=.*(\\b|\\B)(ROAD|MOVING|UNSAFE|CAR(ELESS)?|TIRE|RESTRIC|VIOL|RIGHT|LEFT|CENTER|CANCEL|REV|BARRICADE|FAST|OUTSIDE|VALID|EXCESS|IMPE|INAT|PERM|HRS|UNAUTH|RULE|TRAIL|IMPROP|CONSUMP|INFO|WITHDR|MEDIAN|COND|MIRROR|RECK|TEXT|TYPE|AGGRES|EXHIB|RECORD|GAS|NEGLIG|LIGHT|SUSP|VEHIC|((?=.*(\\b|\\B)(DL))(?=.*(\\b|\\B)(WRONG|CLASS)))|((?=.*(\\b|\\B)(TOO))(?=.*(\\b|\\B)(FAST))))))|((?=.*(\\b|\\B)(LANE))(?=.*(\\b|\\B)(CONTR|MAINT|IMPRO|CHANG|VIOLAT|TRF|TRAF|USAGE|USE|UNSAFE|WRONG|MARK|PASS|TURN|SWITCH|SINGLE|SNGL|NEGL|PRECAUTION|FIRE|RESTRIC|LEFT|RIGHT|CENTER|BLOCK)))|((?=.*(\\b|\\B)(OPER))(?=.*(\\b|\\B)(AGAINST))(?=.*(\\b|\\B)(TRAF)))|((?=.*(\\b|\\B)(RUN|RAN))((?=.*(\\b|\\B)(RD))(?=.*(\\b|\\B)(LT))))|((?=.*(\\b|\\B)(NON|SLOW))(?=.*(\\b|\\B)(MOVING)))|((?=.*(\\b|\\B)(PASS))(?=.*(\\b|\\B)(IMPRO)))|((?=.*(\\b|\\B)(CH(I)?LD))(?=.*(\\b|\\B)(REST|SEAT)))|((?=.*(\\b|\\B)(WRONG))(?=.*(\\b|\\B)(WAY|SIDE)))|((?=.*(\\b|\\B)(HAB))(?=.*(\\b|\\B)(TRAFF))(?=.*(\\b|\\B)(OFFEN)))|((?=.*(\\b|\\B)(WAKE))(?=.*(\\b|\\B)(ZONE|AREA)))|((?=.*(\\b|\\B)(FARE))(?=.*(\\b|\\B)(EVASION)))|((?=.*(\\b|\\B)(HOV))(?=.*(\\b|\\B)(VIO))))(?!.*(\\b|\\B)(COMVICTION)))';
    SHARED COMMON_TRAFFIC_LICENSE_REGISTRATION_LIST := '(((?=.*(\\b|\\B)(PLATES))(?=.*(\\b|\\B)(ALTER|IMPOUND|RVKD|REVOKE|EXP|ILL|IMPROP|DISPLAY|VALID|LICENSE|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(DISP))))))|(((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(CARRY|PROVIDE)))(?=.*(\\b|\\B)(INSUR|DRIVER|PROOF|LIAB|REGIST|VEHICLE)))|(?=.*(\\b|\\B)(DW(L|S)|UNINSUR|CDL))|((?=.*(\\b|\\B)(REG))(?=.*(\\b|\\B)(TAG|LIC|PLAT|FAIL)))|((?=.*(\\b|\\B)(EXP))(?=.*(\\b|\\B)(REG|METER)))|((?=.*(\\b|\\B)(TEMP))(?=.*(\\b|\\B)(REG|TAG)))|((?=.*(\\b|\\B)(SUS))(?=.*(\\b|\\B)(DRIV|MV|LIC)))|((?=.*(\\b|\\B)(LIC))(?=.*(\\b|\\B)(DRIV|VALID|PLAT|COMMER|OPERAT|REVOK)))|((?=.*(\\b|\\B)(INSURANCE))(?=.*(\\b|\\B)(FAIL|PROOF|VEHICLE)))|((?=.*(\\b|\\B)(INS))(?=.*(\\b|\\B)(VEH|PROOF|DRIV|MSD|M\\/V|LIAB|FAULT|VALID)))|((?=.*(\\b|\\B)(OPER))(?=.*(\\b|\\B)(UNINS|UNREG)))|((?=.*(\\b|\\B)(D(\\/)?L))(?=.*(\\b|\\B)(VALID|((?=.*(\\b|\\B)(DRIV))(?=.*(\\b|\\B)(W\\/O))))))|((?=.*(\\b|\\B)(MVI))(?=.*(\\b|\\B)(VALID|OPER)))|((?=.*(\\b|\\B)(DOT))(?=.*(\\b|\\B)(HEALTH|CARD)))|((?=.*(\\b|\\B)(VEH|PERIODIC))(?=.*(\\b|\\B)(INSP)))|((?=.*(\\b|\\B)(TRAFFIC))(?=.*(\\b|\\B)(LAW|OBEY|IMPEDE)))|((?=.*(\\b|\\B)(INS))(?=.*(\\b|\\B)(NO))(?=.*(\\b|\\B)(MSD|OWN|OPER)))|((?=.*(\\b|\\B)(LICENSE|DL))(?=.*(\\b|\\B)(RESTRIC(T)?))))';
    SHARED COMMON_TRAFFIC_GROUP_LIST := '(((?=.*(\\b)(DA(C|R|S))(\\b))|' + COMMON_TRAFFIC_VEHICLES_LIST + '|' + COMMON_TRAFFIC_TERM_SIGN_LIST + '|' + COMMON_TRAFFIC_ACCIDENT_VIOLATIONS_LIST + '|' + COMMON_TRAFFIC_LICENSE_REGISTRATION_LIST + ')(?!.*(\\b|\\B)(PEEP|' + COMMON_DUI_LIST + '|' + COMMON_LIVESTOCK_ANIMAL_LIST + ')))';
    
    SHARED COMMON_FALSE_ADVERTISING_LIST := '(((?=.*(\\b|\\B)(ADVER))(?=.*(\\b|\\B)(FALS|BAIT|FRAUD|MISLEAD)))|((?=.*(\\b|\\B)(BAIT))(?=.*(\\b|\\B)(SWITCH))))';
    SHARED COMMON_KIDNAPPING_LIST := '(((?=.*(\\b|\\B)(CHILD))(?=.*(\\b|\\B)(STEAL)))|((?=.*(\\b|\\B)(FALS))(?=.*(\\b|\\B)(I(N)?MPRIS)))|((?=.*(\\b|\\B)(HELD))(?=.*(\\b|\\B)(WILL)))|((?=.*(\\b|\\B)(SECRET))(?=.*(\\b|\\B)(CONFIN)))|((?=.*(\\b|\\B)(FELON))(?=.*(\\b|\\B)(RESTRAIN)))|(?=.*(\\b|\\B)(KIDN(A|AP|PNG)?|KIN(D)?AP|KIPN|KID(D|A)?|KDN(A)?P|KNDN|FALS\\.IMPR|ABDU)))';
    SHARED COMMON_SANCTIONS_GENERAL_LIST := '(?=.*(\\b|\\B)(SANCTION))';
    SHARED COMMON_CRIMINAL_SYNDICALISM_LIST := '(((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(AGAINST))(?=.*(\\b|\\B)(GOV)))|((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(SYNDICAL)))|((?=.*(\\b|\\B)(ADVO))(?=.*(\\b|\\B)(SYNDICA|SABOTAGE|VIOL|OVERTH)))|((?=.*(\\b|\\B)(OVERTH))(?=.*(\\b|\\B)(GOV|GVT|ORG)))|(?=.*(\\b|\\B)(SYNDICALISM|SEDITION)))';
    
    SHARED COMMON_SUPPORT_LIST := '(?=.*(\\b|\\B)(SP(PT|RT|T)|SUP(OORT|ORT|PORT|POT|PPORT|PRT|PT|RT|T)?))';
    SHARED COMMON_CHILD_SUPPORT_LIST := '((((?=.*(\\b|\\B)(CHILD|NON(\\-)?))' + COMMON_SUPPORT_LIST + ')|(?=.*(\\b|\\B)(NONSP(ORT|PRT)?|NS(PT|UP)|NUNSUPPORT)))(?!.*(\\b|\\B)((O|I|C|A)NSPT)))';
    SHARED COMMON_CHILD_CUSTODY_LIST := '(((?=.*(\\b|\\B)(CUSTODY))(?=.*(\\b|\\B)(CHILD|MINOR|VIOL|VISIT)))|(?=.*(\\b|\\B)(CUSTODIAL)))';
    
    SHARED COMMON_CHILD_LIST := '(((?=.*(\\b|\\B)(FEMAL|MALE))(?=.*(\\b|\\B)(UND|\\<)))|(?=.*(\\b|\\B)(CH(ILD|D|LD)|MINO|MNR|JUV|GIRL|BOY|YOUTH)))';
    SHARED COMMON_PORN_LIST := '(((?=.*(\\b|\\B)(POSS))(?=.*(\\b|\\B)(OBSC)))|((?=.*(\\b|\\B)(PHOTO))(?=.*(\\b|\\B)(INDEC|LEWD|OBSC)))|((?=.*(\\b|\\B)(OBSC))(?=.*(\\b|\\B)(MATER)))|(?=.*(\\b|\\B)(PORN)))';
    SHARED COMMON_SEX_LIST := '((((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(AG))(?=.*(\\b|\\B)(NATU)))|((?=.*(\\b|\\B)(EXPOS))(?=.*(\\b|\\B)(GENI)))|((?=.*(\\b|\\B)(LASC))(?=.*(\\b|\\B)(ACT)))|((?=.*(\\b|\\B)(IND))(?=.*(\\b|\\B)(LIB|PROP|EXPO)))|((?=.*(\\b|\\B)(VIOL))(?=.*(\\b|\\B)(DAT(E|ING))))|((?=.*(\\b|\\B)(PRED))(?=.*(\\b|\\B)(OFFEND)))|(' + COMMON_CHILD_LIST + '(?=.*(\\b|\\B)(MIST|MOL|MOE|MOSL)))|(' + COMMON_CHILD_LIST + '(?=.*(\\b|\\B)(ENTI))(?=.*(\\b|\\B)(INDE)))|(?=.*(\\b|\\B)(S(E)?X|INTERCOURSE|SOD(O)?MY|LEWD|INDEC(ENT)?|INCEST|ENTIC(I|EMENT)|MASTERBA|LASCIVI|LUR(E|ING)|FONDL|PEEP|FORNICA|LUSTFU|IMPREG(N)?|MOLEST|MLST|CSC|C\\.S\\.C\\.|SEDUCTION|VOYEUR|NUD(E|ITY))))(?!.*(\\b|\\B)(WINDSHIELD|SIGNATURE|SPEEDING|VACSC)))';
    SHARED COMMON_PROSTITUTION_LIST := '(?=.*(\\b|\\B)(PROST|POSTITUTION))';
    SHARED COMMON_THEFT_LIST := '((((?=.*(\\b|\\B)(KEEP|STOL|RETURN|RTN))(?=.*(\\b|\\B)(PROP|RENT)))|((?=.*(\\b|\\B)(FALS|FAK))(?=.*(\\b|\\B)(OWNER)))|((?=.*(\\b|\\B)(FAL))(?=.*(\\b|\\B)(DEC))(?=.*(\\b|\\B)(OWN)))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(RETURN|RTN)))|((?=.*(\\b|\\B)(OBT))(?=.*(\\b|\\B)(FALS))(?=.*(\\b|\\B)(PRETEN)))|(?=.*(\\b|\\B)(TH(E)?FT|THE(F|T)|STEAL|STL(G)?|STOLE|THT)))(?!.*(\\b|\\B)(' + COMMON_SEX_LIST + '|' + COMMON_DUI_LIST + ')))';
    SHARED COMMON_LARCENY_LIST := '(((?=.*(\\b|\\B)(LARC))|((?=.*(\\b|\\B)(LARA|LARY))(?=.*(\\b|\\B)(AUTO|MER))))(?!.*(\\b|\\B)(GR|DECLARATION)))';
    SHARED COMMON_GRAND_LARCENY_LIST := '(((?=.*(\\b|\\B)(GR))(?=.*(\\b|\\B)(LARC)))|((?=.*(\\b|\\B)(GRAN))(?=.*(\\b|\\B)(LAR))))';
    
    SHARED COMMON_DISORDERLY_CONDUCT_LIST := '((((?=.*(\\b|\\B)(DISOR))(?=.*(\\b|\\B)(CON)))|((?=.*(\\b|\\B)(PEAC))(?=.*(\\b|\\B)(DIST|BREACH)))|((?=.*(\\b|\\B)(RESID))(?=.*(\\b|\\B)(VIOL)))|((?=.*(\\b|\\B)(FAL))(?=.*(\\b|\\B)(911)))|((?=.*(\\b|\\B)(PROFAN))(?=.*(\\b|\\B)(LANG)))|(?=.*(\\b|\\B)(DISORDERLY|URINAT|DEFICATE|LOITER|FIGHTING|PROFANITY|LANGUAGE|SWEAR|CURSE|SHOUT|OBSCEN(E|ITY))))(?!.*(\\b|\\B)(' + COMMON_ALCOHOL_LIST + ')))';
    
    SHARED COMMON_FRAUD_LIST := '(?=.*(\\b|\\B)((DE)?FRAUD|DEFRD|CHEAT|SWINDLE|SKIM))';
    SHARED COMMON_FRAUD_CHECK_LIST := '(((((?=.*(\\b|\\B)(CK#|F\\/C|C(\\s)*#))|((?=.*(\\b)(C)(\\b))(?=.*(\\b|\\B)(#(\\s)*\\d))))(?=.*(\\b|\\B)(\\$)))|(?=.*(\\b)(NSF)(\\b))|(?=.*(\\b|\\B)(CHECK|CHK|CHE(C|K)))|((?=.*(\\b|\\B)(CHECK|C(H)?K))(?=.*(\\b|\\B)(ISSUE)))|((?=.*(\\b|\\B)(CK))(?=.*(\\b|\\B)(' + COMMON_FRAUD_LIST + '|WORTH|BAD|UTT|UTE(E)?R|BOGUS))))(?!.*(\\b|\\B)(TICKET)))';
    SHARED COMMON_CREDIT_CARD_LIST := '((?=.*(\\b|\\B)(CARD))(?=.*(\\b|\\B)(FIN|CR(ED)?|UNLAW|B(A)?NK|DEBIT)))';

    SHARED COMMON_IDENTITY_FRAUD_LIST := '((((?=.*(\\b|\\B)(ASSUME))(?=.*(\\b|\\B)(FALSE))(?=.*(\\b|\\B)(NAME)))|((?=.*(\\b|\\B)(FALSE|FICT|FAKE|SALE))((?=.*(\\b)(ID(EN)?|DL|DR|SS)(\\b))|(?=.*(\\b|\\B)(I\\.D\\.|D\\.L\\.|O\\/L|O\\.L\\.|SSN|CARD|DOCU|PASSP))|((?=.*(\\b|\\B)(BIR))(?=.*(\\b|\\B)(CE|REC)))|((?=.*(\\b|\\B)(SOC))(?=.*(\\b|\\B)(SEC)))))|(((?=.*(\\b)(ID(EN(TITY)?)?))(?=.*(\\b|\\B)(THEFT|THFT|THEF|FRAUD|ST(EA)?L|TAK|CRIM|OBTAIN|CONC)))))(?!.*(\\b|\\B)(MEDICAID|RIDSTLVEH|AVOID|DILANDID|((?=.*(\\b|\\B)(PUB))(?=.*(\\b|\\B)(AID))))))';
    SHARED COMMON_FALSE_STATEMENT_LIST := '((((?=.*(\\b|\\B)(FALS(E|LE)))(?=.*(\\b|\\B)(IDENTIF|PERSONAT|INFO|INO|STATE|REPORT|HOLD|ACT|PRESENT|SWEAR|DECLAR)))|((?=.*(\\b|\\B)(FALSE|FRAUD))(?=.*(\\b|\\B)(REPORT|STATE|INFO|REPR|STMT|EVID)))|(?=.*(\\b|\\B)(FICTICOUS|IMPERSON))|((?=.*(\\b)(ID))(?=.*(\\b|\\B)(MISREP))))(?!.*(\\b|\\B)(' + COMMON_IDENTITY_FRAUD_LIST + '|OWNER)))';
    SHARED COMMON_FORGE_LIST := '((((?=.*(\\b|\\B)(UT))(?=.*(\\b|\\B)(FRG|INSTRU)))|((?=.*(\\b|\\B)(ALTER))(?=.*(\\b|\\B)(ID|PLATE|TAG|LIC|REG|CERT|TITLE|DOC)))|(?=.*(\\b|\\B)(FORGR|FORG(E)?|FRGD|TRADEM|UT(T)?ER|UTEER)))(?!.*(\\b|\\B)(COMPUTER|(G|C|SH|COMM)UT|ALTERNATIVE)))';
    SHARED COMMON_COUNTERFEIT_LIST := '(((?=.*(\\b|\\B)(ILL|MAKE|SUB|IMA|ALT(ER)?|COUN|CNT|FAKE))(?=.*(\\b|\\B)(MONEY|CURRENCY)))|(?=.*(\\b|\\B)(COUNTER(F(E)?IT|\\.|\\/)|CNTERFEIT|CNTRFT)))';
    
    SHARED COMMON_VIOLATING_ORDERS := '(((?=.*(\\b)(ORD))(?=.*(\\b)(RESTRAIN|PR(O)?T|VIOL|DISOBEY)))|((?=.*(\\b)(CIV))(?=.*(\\b)(PROT)))|((?=.*(\\b)(VIO))(?=.*(\\b)(TPO|CPO|TRO)))|((?=.*(\\b|\\B)(VIOL))(?=.*(\\b|\\B)(CAPIAS|INJUC))))';
       
    SHARED COMMON_ASSAULT_LIST := '((((?=.*(\\b|\\B)(MAL))(?=.*(\\b|\\B)(WOUND|INJ|SHOOT|STAB)))|((?=.*(\\b|\\B)(CRIM))(?=.*(\\b)(ASS)))|((?=.*(\\b|\\B)(BOD))(?=.*(\\b|\\B)(HARM)))|(?=.*(\\b|\\B)(ASSA(ULT)?|ASLT|ASU(A)?LT|ASAULT|ASSLT|ALST|ASSU(A)?LT|BATT|B(A)?TRY|STRANG(U|l)|LYNCH|FIGHT|BEAT|RESTRAINT|VIOLENT|MAIM|TORTURE))|(?=.*(\\b)(ASS)))(?!.*(\\b|\\B)(TRESPASS|CLASS|ASSESSMENT|PASSENGER|ASSEMBLY|' + COMMON_SEX_LIST + '|' + COMMON_VIOLATING_ORDERS + '|' + COMMON_TRAFFIC_GROUP_LIST + ')))';
    
    
    SHARED COMMON_BANK_ROBBERY_LIST := '(((?=.*(\\b|\\B)(ROB))(?=.*(\\b|\\B)(BANK)))|((?=.*(\\b|\\B)(BAN))(?=.*(\\b|\\B)(ROBB|RBRY|' + COMMON_BURGLARY_LIST + ')))|((?=.*(\\b|\\B)(SAFE))(?=.*(\\b|\\B)(CRACK|BREAK)))|(?=.*(\\b|\\B)(SAFECRACK)))';
    SHARED COMMON_ROBBERY_LIST := '(((?=.*(\\b|\\B)(ATT|CONSP))(?=.*(\\b|\\B)(ROB)))|(?=.*(\\b|\\B)(ROBB|ROBER|RBRY)))';
    
  
    SHARED COMMON_MONEY_TRANSMITTER_LIST := '(((?=.*(\\b|\\B)(TRANSM))(?=.*(\\b|\\B)(EMB|MON|BUS|LICEN)))|(?=.*(\\b|\\B)(TRANSMITTER|\\$TRANS)))';
    SHARED COMMON_STRUCTURING_LIST := '((((?=.*(\\b|\\B)(STRUCT))(?=.*(\\b|\\B)(TRAN|FIN)))|(?=.*(\\b|\\B)(STRUCTUR(EF|ING)|STRUCTURESFINANCIALTRANSACTTOEVADEREPORT)))(?!.*(\\b|\\B)(DESTRUCT|BUILD|(OB|CON)STRUCT)))';
    
    SHARED COMMON_MISAPPROP_EMBEZZLE_LIST := '((?=.*(\\b|\\B)(EMB(E)?Z))|((?=.*(\\b|\\B)(MISAP(L|LY|P)?|MISMAN))(?=.*(\\b)(FID(U|C)?|(\\/)?FIDUC|FUD(U|I)C|PROP|FUNDS|TRUST|PUBLIC|ASSIST|MON(EY|IES)|SECURITY)))|((?=.*(\\b|\\B)(DIVER))(?=.*(\\b|\\B)(FUND|GAMIN|CHARIT|BENE|STATE))))';
    SHARED COMMON_TRANSPORT_PROCEEDS_LIST := '((((?=.*(\\b|\\B)(TRANSPORT))(?=.*(\\b|\\B)(VIOLATION)))|((?=.*(\\b|\\B)(TRANS))(?=.*(\\b|\\B)(PROCEED|STOLEN|UNLAW)))|((?=.*(\\b|\\B)(CURR))(?=.*(\\b|\\B)(EXCHA))))(?!.*(\\b|\\B)(PROBATION|' + COMMON_CHILD_LIST + ')))';
    SHARED COMMON_OBTAIN_PROPERTY_LIST := '(((?=.*(\\b|\\B)(PRET))(?=.*(\\b|\\B)(FAL|FLS)))|((?=.*(\\b|\\B)(OBT))(?=.*(\\b|\\B)(MONEY|PROP|MERCH|CASH))))';
    

    SHARED SCHEDULE_DRUG_LIST := '(((?=.*(\\b|\\B)(SCH[EDUAL\\s]*((I|II|III|IV|V|1|2|3|4|5)\\b(?!.*(6|7|8|9|0|X))))))(?!.*(\\b|\\B)(M(I)?SCH)))';
    SHARED WEIGHTS_LIST := '(?=.*(\\b|\\B)(\\d(\\s)?((M)?G|LB|OZ)(\\b)))';
    SHARED DRUGS_RAW_LIST := '((?=.*(\\b|\\B)(ACET(IC|ON(E)?|YL)|ACID|ALPHAZO|ALPRA(X)?|AMINE|AMMONIA|AMPH|ANALOG|ANHY|ATIVAN|AZINE|' +
                              'BARBIT(U)?|BATHSALT|BENZ|BIPHET|BOLDEN|BUPREN|BUTANE|BUTY(L|R)|' +
                              'CAINE|CANNA|CARFE|CARISOPR|CHM|CHLOR|CLONAZ|COCA|CODEIN|COKE|CONCERTA|CRA(N|C)K|CRYSTAL|CYCLIDI|' +
                              'DARVO|DEMEROL|DESOX|DESTROMETH|DEX(ED|TRO)|DFZ|DGS|DIACET|DIAZEPA|DICANDED|DIETHYL|DIHY|DILAU|DIMETHYL|DIOX(Y)?|DIPHENO|DIVINOR|DOPE|DR(GS|UG)|DURGS|DXM|' +
                              'ECSTASY|EPHED|EQUIPOI|ETHC|ENETH|' +
                              'FENT|FLUNIT|' +
                              'GAMMA|GHB|GRAMS|' +
                              'HALLUC|HARIHUANA|HASH|HER\\.|HERION|HEROI|HOX|HYDRO(CH)?|HYDROMORPH|' +
                              'IAZ|' + 
                              'KETA|KLONOP|' +
                              'L\\.S\\.D|LAUDAN|LORCET|LSD|LYS(ER)?G|' +
                              'MA(H)?IJ|MAIRHUANA|MARI(JU)?|MAR(RI)?J|MARU|MDMA|MESCAL|METH(YL)?|MOLLY|MORPH(INE)?|MRHNA|MUSHRO|MXE|' +
                              'NAL(LI|OR|OX)|NANDROLO|NARC|NEMBUT|NITROUS|NORCO|NORTEST|' +
                              'OPI(ATE|OD|UM)|OX(AND|IDE|Y)|' +
                              'PAREGORIC|PCP|PCRSR|PENTAZ|PENTEDR|PENTO(Z)?|PERC(A|O)CET|PERCOD|PETHID|PEYOTE|PHARM|PHEN(CYC|E(TH)?|LACET|O|TANYL|TER|YL)?|PHETAM|PHOSPH|PIPERA|PIPERONAL|POPPY|POXYP|PRECUR|PRESC|PROPANONE|PROPOX|PRSRSR|PSILO|PSUEDO|PSYCHOTOXIC|PSYLO|' +
                              'QUA(AL|LU)|QUALONE|' + 
                              'REAGENT|RESTORIL|RITALIN|ROCHE|ROCK|ROHY|ROOFI(E|NOL)|ROPHIE|ROPYL|ROXIC(ET|OD)|RX|' +
                              'SALVIA|SCHEDULE|SECOBAR|SINSEM|SOMA|STEROID|STIMULANT|SUBOX|SYNTHETIC|' +
                              'TEMPAZ|TESTOS|TETRAHYDRO|THORAZINE|TOLU(E|O)|TRAMADOL|TRIAZ|TRIFLU|TYLENOL|' +
                              'VALIUM|VALPROI|VICODIN|' +
                              'XANAX|' +
                              'Z(EP|OL)AM))|' +
                              '((?=.*(\\b|\\B)(GHA))(?!.*(\\b|\\B)(GHA(B|R|T))))|((?=.*(\\b|\\B)(CHEM))(?!.*(\\b|\\B)(WASTE)))|((?=.*(\\b|\\B)(SALT))(?!.*(\\b|\\B)(WATER)))|((?=.*(\\b|\\B)(THC))(?!.*(\\b|\\B)(THCA(RE|P)))))';
                              
    SHARED SCHED_WEIGHT_RAW_DRUG_LIST := '(' + SCHEDULE_DRUG_LIST + '|' + WEIGHTS_LIST + '|' + DRUGS_RAW_LIST + ')';

    
    SHARED COMMON_POSSESSION_LIST := '(((?=.*(\\b|\\B)(CONST))(?=.*(\\b|\\B)(POS)))|(?=.*(\\b|\\B)(POS(N)?|PCS)))';
    SHARED COMMON_MANUF_LIST := '((?=.*(\\b|\\B)(MAN((U)?F|F(CTR)?)?|MAUF|MFG|MNF|MDP))(?!.*(\\b|\\B)(MANATEE)))';
    SHARED COMMON_TRAFFICKING_TERMS_LIST := '(?=.*(\\b|\\B)(TRAF(\\.|\\/)|TRAFF(\\.|CK(G|ING|NG)|ICK(ING)?|IK(ING|GN)?|ING|KG|KICKING|KNG|RKG)?|TRAFICK(\\.|ING)?|TRAFIK(IN)?G|TRFFCKING|TRFFICKING|TRFFK(N)?G|TRFK((IN)?G)?|TRFF|SMUG|TRAFCK(G\\.|ING)))';
    SHARED COMMON_CONTROLED_SUBSTANCE_LIST := '((((?=.*(\\b|\\B)(CON\\\'T|CN|CTL|CNT(L|R|R(O)?L|ROLLED)?))(?=.*(\\b|\\B)(SUB)))|((?=.*(\\b|\\B)(CONTROLLED))(?=.*(\\b|\\B)(SUBSTANCE)))|((?=.*(\\b|\\B)(CONTR))(?=.*(\\b|\\B)(S(U|T)B)))|((?=.*(\\b|\\B)(CONT|CTR))(?=.*(\\b|\\B)(SU)))|((?=.*(\\b|\\B)(CON))(?=.*(\\b|\\B)(SB)))|((?=.*(\\b|\\B)(CNTRLD))(?=.*(\\b|\\B)(SBSTNC)))|(?=.*(\\b|\\B)(C\\/S|CONT\\/SUB|C\\/SUBSTANCE|C\\-SUB|CONSUB|C\\.S\\.|CONT\\.SUB)))(?!.*(\\b|\\B)(DWLC\\/S)))';
    SHARED COMMON_DRUGS_LIST := '((' + SCHED_WEIGHT_RAW_DRUG_LIST + '|' + COMMON_CONTROLED_SUBSTANCE_LIST + ')(?!.*(\\b|\\B)(SCHEME|CRACKING)))'; 
    SHARED COMMON_DRUG_PARAPHERNALIA_LIST := '((((?=.*(\\b|\\B)(DR))(?=.*(\\b|\\B)(PAR)))|((?=.*(\\b|\\B)(PAR(A(PH)?|P)))(?!.*(\\b|\\B)(PARA(L|DE|CHUTE)|PREPARA|SEPARAT|COMPARAB)))|(?=.*(\\b|\\B)(DGPARA|PHARAPH|SYRING|NEEDLE|PIPE|HYPODERMIC))|((?=.*(\\b|\\B)(HYPO))(?=.*(\\b|\\B)(SYR))))(?!.*(\\b|\\B)(PARAGRAPH)))';
    SHARED COMMON_SLIM_DRUG_LIST := '((((?=.*(\\b|\\B)(SC(\\/|\\.)?))(?=.*(\\b)(I|II|III|IV|V|VI|1|2|3|4|5|6)(\\b)))|((?=.*(\\b|\\B)(C))(?=.*(\\b|\\B)(SUB)))|((?=.*(\\b|\\B)(SPEED))(?!.*(\\b|\\B)(SPEEDING|INTERSECT|INTERST|DRIVE|SIGN)))|((?=.*(\\b|\\B)(ICE))(?!.*(\\b|\\B)((DEV|L)ICE)))|(?=.*(\\b|\\B)(DRUG|M(\\/)?J|THC|C(S|D(S)?)|COC|MUSHR|SUB|SYNTH|TEST|MAR|GLASS|CAN|SIM|IMITATION))|(?=.*(\\b)(DRU)(\\b))|((?=.*(\\b)(DR)(\\b))(?!.*(\\b|\\B)(DRIV|VEH|SUSPEN|LIC))))(?!.*(\\b|\\B)(SCISSORS|LITTER)))';
    SHARED COMMON_PRECURSOR_LIST := '((((?=.*(\\b|\\B)(PRECUR))(?=.*(\\b|\\B)(MAT|CHEM|REAG|SOLV|SUB)))|(?=.*(\\b|\\B)(PRECURSOR|REAGENT)))(?!.*(\\b|\\B)(INSOLVENT)))';
    SHARED COMMON_PLANT_GROW_LIST := '(?=.*(\\b|\\B)(PLANT|GROW|CULTIV))';
    SHARED COMMON_DRUGS_WITH_POSSESSION_LIST := '(' + COMMON_POSSESSION_LIST + '(' + COMMON_DRUGS_LIST + '|' + COMMON_SLIM_DRUG_LIST + '|' + COMMON_DRUG_PARAPHERNALIA_LIST + '))';
    SHARED COMMON_DRUGS_WITHOUT_POSSESSION_LIST := '((' + COMMON_DRUGS_LIST + '|' + COMMON_DRUG_PARAPHERNALIA_LIST + '|(' + COMMON_POSSESSION_LIST + COMMON_SLIM_DRUG_LIST + '))(?!.*' + COMMON_DUI_LIST + '))';
    SHARED COMMON_LAB_LIST := '(((?=.*(\\b|\\B)(LAB))(?=.*(\\b|\\B)(OPER\\/MAIN|OPERAT|MAIN)))|((?=.*(\\b|\\B)(DRUG))(?=.*(\\b|\\B)(FACTORY))))';
    SHARED COMMON_MANUF_DELIVER_SELL_LIST := '((?=.*(\\b|\\B)(' + COMMON_MANUF_LIST +'|ASSEMBL|ADVER|PRO(D|CS)|PREP|CONVERT|(\\-)?SELL|SALE|S\\/D|DEAL|DIST(RB|L)?|DST|DSPNS|DEL(IVERY)?|DLV|TRAN|SHP))(?!.*(\\b|\\B)(DIS(ARM|PLAY|C|AB|TURB|OBE|RU)|CHILD|BRANDISH|SENT|CONVICTED)))';
    SHARED COMMON_MANUF_ACRONYM_LIST := '(((?=.*(\\b|\\B)(MAN|MFG))(?=.*(\\b|\\B)(DEL|SELL|DST|DIST|SALE|PROD|POSS|TRAN|TRNS)))|((?=.*(\\b|\\B)(DEL))(?=.*(\\b|\\B)(TRAN|TRNS|SELL|MAN(U)?F)))|(?=.*(\\b|\\B)(MAN\\/DEL|MFG\\/DEL|(DIST\\/)?DEL\\/SELL|DEL\\/MAN|SL\\/DEL(\\/POS)?|S\\/M\\/D|POSS\\/SELL|DISTRIBUTE\\/PID|DISTRB\\/SELL|DIST\\/DEL|DIS(T)?\\/POSS|DIST\\,(\\s)?SELL|B\\/TRANS)))';
    SHARED COMMON_EXPLOSIVES_LIST := '((((?=.*(\\b|\\B)(THRO|SHOOT))(?=.*(\\b|\\B)(MISS)))|(((?=.*(\\b|\\B)(DEST))(?!.*(\\b|\\B)(PEDES)))(?=.*(\\b|\\B)(DEV|MASS)))|((?=.*(\\b|\\B)(WEAP))(?=.*(\\b|\\B)(MASS)))|((?=.*(\\b|\\B)(TEAR))(?=.*(\\b|\\B)(GAS)))|((?=.*(\\b|\\B)(BIO))(?=.*(\\b|\\B)(AGENT|TOXIN)))|((?=.*(\\b|\\B)(MOLOTOV))(?=.*(\\b|\\B)(COCK)))|(?=.*(\\b|\\B)(EXPLOS|NUCLEAR|BOMB|GRENADE|MISSILE|WMD|DYNAM)))(?!.*' + COMMON_ARSON_LIST + '))';
    SHARED COMMON_WEAPONS_LIST := '(((((?=.*(\\b|\\B)(DISCHARG))((?=.*(\\b|\\B)(FIREA|WEAPON|F\\/A|GUN|SHOOT))|(?=.*(\\b)(FA)(\\b))))|((?=.*(\\b|\\B)(UNLAW))(?=.*(\\b|\\B)(CARR)))|((?=.*(\\b|\\B)(SAW))(?=.*(\\b|\\B)(OFF)))|((?=.*(\\b|\\B)(SHO|SHRT))(?=.*(\\b|\\B)(BARR|BRL|GUN)))|((?=.*(\\b|\\B)(POSS))(?=.*(\\b)(FA)(\\b)))|((?=.*(\\b|\\B)(MACHINE))(?=.*(\\b|\\B)(GUN)))|(?=.*(\\b|\\B)(AMM(O|UNI)|ARM(ED|O)|BLADE|BLUDSWITCH|CCW|C\\.C\\.W\\.|CONTRA|F\\/A(RM)?|F\\-ARM|FIR(E)?ARM|FIREAMR|FREARM|FRIEARM|GUN|KNIFE|KNUCKLES|M(\\.)?I(\\.)?W|PIST(OL)?|RAZOR|RIFLE|RVOLV|SAWEDOFF|SHOTG|SHTGN|SWORD|U\\.U\\.W(\\.)?|U(\\s)?U(\\s)?W|UCW|WEA(P(ON)?)?|WEP|WPN)))(?!.*(\\b|\\B)(AMMONIA|(SUB)?CONTRACT|((?=.*(\\b|\\B)(ARM))(?=.*(\\b|\\B)(ROB)))|' + COMMON_BURGLARY_LIST + '|' + COMMON_DISORDERLY_CONDUCT_LIST + '|' + COMMON_HUNT_TRAP_FISH_TERMS_LIST + '|' + COMMON_FISH_GAME_ANIMAL_LIST + '|CONTRAD|CLAM|WEA(R|LTH|K)|PARKING|UNARMED|WEAVING)))|((?=.*(\\b|\\B)(GUN))(?=.*(\\b|\\B)(WEAR))))';
    SHARED COMMON_POSSESSION_WITH_INTENT_LIST := '(?=.*(\\b|\\B)(PWI(T|D)|PSNW\\/I|(P|W)ID|W\\.I\\.T\\.D\\.))';
    SHARED COMMON_WITH_INTENT_LIST := '(((?=.*(\\b)((W\\/)?INT(ENT|\\.)?|W\\.I\\.T\\.D|W\\/I(N)?))|((?=.*(\\b|\\B)(W\\/))(?=.*(\\b|\\B)(INTENT))))(?!.*(\\b|\\B)(WITH(IN|OUT)?|W\\/O(UT)?|W\\/INJURY|WILDLIFE|WIND|INTE(R|F))))';
    SHARED COMMON_TRAFFICKING_HUMAN_LIST := '((((?=.*(\\b|\\B)(PROM|ADVER|PLACE))(?=.*(\\b|\\B)(PROS|POST|PORN|STAT|S(E)?X|OBSC|PHOTO|SOLIC|SOLCT))' + COMMON_CHILD_LIST + ')|((?=.*(\\b|\\B)(PROST))(?=.*(\\d))(?=.*(\\b|\\B)(Y(EA)?R|AGE)))|(' + COMMON_CHILD_LIST + '(?=.*(\\b|\\B)(PROSTITU)))|((?=.*(\\b|\\B)(' + COMMON_TRAFFICKING_TERMS_LIST + '|TRAF|TRANSP|MOVE|SALE|EXPLO|EXPLT))(?=.*(\\b|\\B)(ALIEN|ORGAN|S(E)?X|LABOR|LBR|HUMAN|PEOPLE|DOMESTIC|(FE)?MALE|' + COMMON_CHILD_LIST + ')))|(?=.*(\\b|\\B)(PAND|PIMP|PAMPER|PROM\\.PROST|PROM\\/PROS|TRAFFCHILD|SLAVE|CSEC)))(?!.*(\\b|\\B)(OFFENSE|BLOCK|CHAPTER|OBSTRUCTING|ABANDON|SEAT|((?=.*(\\b|\\B)(PICKUP))(?=.*(\\b|\\B)(BED)))|((?=.*(\\b|\\B)(SALE|SELL))(?=.*(\\b)(TO)(\\b))(?=.*(\\b|\\B)(MINOR)))|((?=.*(\\b|\\B)(SER))(?=.*(\\b|\\B)(REM)))|TRANSMIT|TOBAC|((?=.*(\\b|\\B)(MOVE))(?!.*(\\b|\\B)(REMOVE)))|ORGANIZED|' + COMMON_DRUGS_LIST + '|' + COMMON_DUI_LIST + '|' + COMMON_ALCOHOL_LIST + '|' + COMMON_PORN_LIST + '|' + COMMON_PROSTITUTION_LIST + ')))';
    SHARED COMMON_DRUG_DEA_DIVERSION_LIST := '((?=.*(\\b|\\B)(DEA\\s(\\#|NUMBER)))|((?=.*(\\b|\\B)(DEA))(?=.*(\\b|\\B)(REGIST))(?=.*(\\b|\\B)(\\#|NUM))))';
    

    SHARED COMMON_AGG_ASSAULT_LIST := '((((?=.*(\\b|\\B)('+ COMMON_WITH_INTENT_LIST +'|AGG|AGRV|AG(A)?))(?=.*(\\b|\\B)(ASS(LT)?|BATT|B(A)?TRY|AS(L|T|LT)|ASU(A)?LT|ASAULT|ALST|INJ|UUW|ABUSE|TORTURE)))|(?=.*(\\b|\\B)(A(\\&|\\/)B|A\\s\\&\\sB|AA\\/(DW|PO|SBI)|AAWW|AWDW(ISI)?|AWDWWITKISI)))(?!.*(\\b|\\B)(TRESPASS|CLASS|INTRASTATE|' + COMMON_DUI_LIST + ')))';
    SHARED COMMON_ASSAULT_DEADLY_INTENT_LIST := '((' + COMMON_ASSAULT_LIST + '(?=.*(\\b|\\B)(DEAD|DANG|' + COMMON_WEAPONS_LIST + ')))|((?=.*(\\b|\\B)(IMPED))(?=.*(\\b|\\B)(BR)))|((?=.*(\\b|\\B)(INT|ASS|ASA))(?=.*(\\b|\\B)(KILL)))|(?=.*(\\b|\\B)(AA\\/DW|AAWW|AWDWISI|SHOOTING|AWI(K|T|TK))))';
    SHARED COMMON_ARM_ROBBERY_LIST := '(((((?=.*(\\b)(ROB))|(?=.*(\\b|\\B)(RBRY))|' + COMMON_BURGLARY_LIST + ')((?=.*(\\b|\\B)(ARM|AGG|DEAD|DDL|SER|BOD|' + COMMON_WEAPONS_LIST + '))|(?=.*(\\b)(ARM))))|(?=.*(\\b|\\B)(ARMED\\/ROB|A\\&ROB|A\\s\\&\\sROB)))(?!.*(\\b|\\B)(' + COMMON_CAR_JACK_LIST + '|UNARM|PROBATION|\\bNO\\b)))';
    SHARED COMMON_ASSULT_COMBINED_LIST := '((' + COMMON_ASSAULT_LIST + '|' + COMMON_ASSAULT_DEADLY_INTENT_LIST + '|' + COMMON_AGG_ASSAULT_LIST + ')(?!.*(\\b|\\B)(ASSIST(ANCE|ANT)?|ASSUR|ASSIGN|HARAS|ASST|ASSIS|MASSAGE|TRESPASS|ASSEMBLY|PASSENGER|' + COMMON_SEX_LIST + ')))';
    
    
    
    
    
    
    //These are offense specific expressions
    SHARED OFFENSE_FAMILY_PROVIDER_ABUSE := '((((?=.*(\\b|\\B)(AB(AN|ON|US|SE)|ABANDON|MSTR|MIST|CRUEL|ENDAN|NEG|INJ|RECK|VIOLENCE|WELF(R)?|DANGER|VULN|WLF))(?=.*(\\b|\\B)(FAMILY|DOMEST|SPOUSE|WIFE|DEPEND|ELDER|CARETAKER|ADULT|PARENT|CUST|RESIDENT|PATIENT|CH(D|LD|ILD)|MINO|MNR|JUV|WLF|((?=.*(\\b|\\B)(PERSON))(?=.*(\\b|\\B)(AGED|OLDER|VUL|VUNER|VLUN|CONFIN|DISAB|INCAP))))))|((?=.*(\\b|\\B)(DOMES))(?=.*(\\b|\\B)(VIOL)))|(?=.*(\\b|\\B)(CHILDEND|DOMESTIC)))(?!.*(\\b|\\B)(SECURITIES|DOMESTICALLY|TORTURE|AMENDED|PERSONAL|DEPENDENCY|' + COMMON_FISH_GAME_ANIMAL_LIST + '|' + COMMON_HUNT_TRAP_FISH_TERMS_LIST + '|' + COMMON_LIVESTOCK_ANIMAL_LIST + '|((?=.*(\\b|\\B)(AGG))(?=.*(\\b|\\B)(ABUSE)))|((?=.*(\\b|\\B)(RECK))(?=.*(\\b|\\B)(ENDA))))))';
    SHARED OFFENSE_ELDER_EXPLOITATION := '((?=.*(\\b|\\B)(EXPLOIT|EXPLT))(?=.*(\\b|\\B)(ELDER|CARETAK|ADULT|PARENT|RESIDENT|PATIENT|CUST|DISABLE|((?=.*(\\b|\\B)(PERS))(?=.*(\\b|\\B)(AGED|OLDER|VU(L|NER)|VLUN|DISAB|INCAP|CONFIN))))))';
    SHARED OFFENSE_LIVESTOCK_DOMESTIC_ANIMALS := COMMON_LIVESTOCK_ANIMAL_LIST;
    SHARED OFFENSE_HUNT_FISH_GAME := '(' + COMMON_FISH_GAME_ANIMAL_LIST + '|' + COMMON_HUNT_TRAP_FISH_TERMS_LIST + ')';
    SHARED OFFENSE_INFRACTION_AND_ORDINANCES := COMMON_INFRACTION_ORDINANCES_LIST;
    
    SHARED OFFENSE_ANIMAL_FIGHT := '(((?=.*(\\b|\\B)(ANIMA|COCK|DOG))(?=.*(\\b|\\B)(FIGHT)))|((?=.*(\\b|\\B)(DOG))(?=.*(\\b|\\B)(SPEC)))|(?=.*(\\b|\\B)(COCKFIGHT|DOGFIGHT)))';
    SHARED OFFENSE_DUI := '(' + COMMON_DUI_LIST + '(?!.*(\\b|\\B)(REDUCED)))';
    SHARED OFFENSE_ALCOHOL := '(' + COMMON_ALCOHOL_LIST + '(?!.*(\\b|\\B)(FTA)))';
    
    SHARED OFFENSE_EPA_WASTE := '(((?=.*(\\b|\\B)(CHEM))(?=.*(\\b|\\B)(WAST)))|((?=.*(\\b|\\B)(HAZ|TOXIC))(?=.*(\\b|\\B)(WAST|POLLUT)))|((?=.*(\\b|\\B)(DISPOSE))(?=.*(\\b|\\B)(GARBAGE)))|((?=.*(\\b|\\B)(ILL))(?=.*(\\b|\\B)(DUMP)))|((?=.*(\\b|\\B)(DISCHAR|DISPO|RELEASE|POSS|STOR|TRAN|CONCEAL))(?=.*(\\b|\\B)(POLLUT|HAZARD|((?=.*(\\b|\\B)(HAZ))(?=.*(\\b|\\B)(WAST)))|((?=.*(\\b|\\B)(MEDIC))(?=.*(\\b|\\B)(WAST))))))|((?=.*(\\b|\\B)(DISCHAR|DISPO|RELEASE))(?=.*(\\b|\\B)(MEDIC)))|((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(DISP))(?=.*(\\b|\\B)(WAST)))|((?=.*(\\b|\\B)(ENDANG))(?=.*(\\b|\\B)(ENVIRO)))|((?=.*(\\b|\\B)(WATER|AIR|ENVIRO))(?=.*(\\b|\\B)(POLLUT|PETRO)))|(?=.*(\\b|\\B)(POLLUTION)))';
    SHARED OFFENSE_POISONING := '(((?=.*(\\b|\\B)(POIS|TAMP))(?=.*(\\b|\\B)(FOOD|WATER|MED)))(?!.*(\\b|\\B)(METER|STAMP|' + COMMON_HUNT_TRAP_FISH_TERMS_LIST + '|' + COMMON_FISH_GAME_ANIMAL_LIST + ')))';
    SHARED OFFENSE_ZONING_BUILDING := '(((?=.*(\\b|\\B)(BUILD))(?=.*(\\b|\\B)(CODE)))|(?=.*(\\b|\\B)(ZONING)))';
    SHARED OFFENSE_FUGITIVE_WARRANT := '(((?=.*(\\b|\\B)(WARRANT|FUGITIVE|CAPIAS))|((?=.*(\\b|\\B)(WARR))(?=.*(\\b|\\B)(BENC|FUG))))(?!.*(\\b|\\B)(WARRANTLESS|((?=.*(\\b|\\B)(PARKING))(?=.*(\\b|\\B)(WARRANT))))))';
    SHARED OFFENSE_RIOT_CIVIL_DISORDER := '((((?=.*(\\b|\\B)(CIVIL))(?=.*(\\b|\\B)(DISORDER)))|(?=.*(\\b|\\B)(RIOT)))(?!.*(\\b|\\B)(DISORDERLY)))';
    SHARED OFFENSE_GANG := COMMON_GANG_LIST;
    
    SHARED OFFENSE_VIOLATING_ORDERS := COMMON_VIOLATING_ORDERS;
    SHARED OFFENSE_PAROLE_PROBATION_VIOLATION := '(((?=.*(\\b|\\B)(PROB|PARO|SRA|PRE(\\-)?TRIAL|((?=.*(\\b|\\B)(SUSP))(?=.*(\\b|\\B)(SENT)))))(?=.*(\\b|\\B)(VIO)))|((?=.*(\\b|\\B)(ADJUD))(?=.*(\\b|\\B)(GUILT)))|((?=.*(\\b|\\B)(ABSCON))(?=.*(\\b|\\B)(PAROLE)))|(?=.*(\\b)(VOP))|(?=.*(\\b|\\B)(PROBATION))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(APP))(?=.*(\\b|\\B)(PROB))(?=.*(\\b|\\B)(OFF))))';
    SHARED OFFENSE_MISCONDUCT := '(?=.*(\\b|\\B)(MISCONDUCT))';
    SHARED OFFENSE_CYBER_COMPUTER_CRIMES := COMMON_COMPUTER_CYBER_LIST;
    SHARED OFFENSE_CYBER_STALK := '(' + COMMON_COMPUTER_CYBER_LIST + COMMON_STALK_INTIM_LIST + ')';
    SHARED OFFENSE_STALK_INTIM := '(' + COMMON_STALK_INTIM_LIST + '(?!.*' + COMMON_COMPUTER_CYBER_LIST + '|' + COMMON_LIVESTOCK_ANIMAL_LIST + '|' + COMMON_FISH_GAME_ANIMAL_LIST + '))';
    SHARED OFFENSE_TREASON_ESPIONAGE := '((((?=.*(\\b|\\B)(DEF))(?=.*(\\b|\\B)(INFO))(?=.*(\\b|\\B)(FOREIGN)))|((?=.*(\\b|\\B)(TRADE))(?=.*(\\b|\\B)(SECRET))(?=.*(\\b|\\B)(GOV)))|(?=.*(\\b|\\B)(TREASO|ESPIO)))(?!.*(\\b|\\B)(NOTREASON|RESPIONS)))';
    
    SHARED OFFENSE_ARSON := COMMON_ARSON_LIST;
    SHARED OFFENSE_BURGLARY := COMMON_BURGLARY_LIST;
    SHARED OFFENSE_BREAK_AND_ENTER := COMMON_BREAK_ENTER_LIST;
    SHARED OFFENSE_CAR_JACK := COMMON_CAR_JACK_LIST;
    
    SHARED OFFENSE_TRAFFIC_DRIVING := '(' + COMMON_TRAFFIC_GROUP_LIST + '|(?=.*(\\b|\\B)(DRIV|SPEED|LANE|PLATE|HIGHWAY|HWY|ACCIDENT))|(?=.*(\\bTRAFFIC\\b))|((?=.*(\\b)(NO)(\\b))(?=.*(\\b|\\B)(INSURANCE))))';
    
    SHARED OFFENSE_KIDNAPPING := COMMON_KIDNAPPING_LIST;
    SHARED OFFENSE_MURDER := '((?=.*(\\b|\\B)(M(A)?NSL|MSLGRT|MUR|MRDER|HOM(I|O)C|KILL))(?!.*(\\b|\\B)(MURATIC|' + COMMON_LIVESTOCK_ANIMAL_LIST + '|' + COMMON_FISH_GAME_ANIMAL_LIST + ')))';
    SHARED OFFENSE_RETALIATION := '(?=.*(\\b|\\B)(RETALIAT))';
    SHARED OFFENSE_HATE_CRIME := '((((?=.*(\\b|\\B)(HATE))(?=.*(\\b|\\B)(CR)))|((?=.*(\\b|\\B)(BIAS))(?=.*(\\b|\\B)(INTIMID|CRIME)))|((?=.*(\\b|\\B)(RIGHT))(?=.*(\\b|\\B)(HUMAN|CIVIL)))|(?=.*(\\b|\\B)(ETHNIC|RACIAL|RELIGIOUS)))(?!.*(\\b|\\B)(PHOSPATE|MANSLAUGHATER|METHAMPHATEMINES|((?=.*(\\b|\\B)(RIGHT))(?=.*(\\b|\\B)(WAY))))))';
    SHARED OFFENSE_SANCTIONS_GENERAL := COMMON_SANCTIONS_GENERAL_LIST;
    SHARED OFFENSE_CRIMINAL_SYNDICALISM := COMMON_CRIMINAL_SYNDICALISM_LIST;
    
    SHARED OFFENSE_COURT_CHARGES := '((((?=.*(\\b)(FAIL))(?=.*(\\b|\\B)(REG|COMPLY))(?=.*(\\b|\\B)(SEX)))|((?=.*(\\b)(FT))(?=.*(\\b|\\B)(REG))(?=.*(\\b|\\B)(SEX)))|((?=.*(\\b|\\B)(FAIL))(?=.*(\\b|\\B)(APPEAR|SERV)))|((?=.*(\\b|\\B)(COURT))(?=.*(\\b|\\B)(ORDER)))|((?=.*(\\b|\\B)(COURT|PROMISE))(?=.*(\\b|\\B)(APPEAR)))|(?=.*(\\b|\\B)(FT\\/REG|FTA(\\/)?|FTC|JUMP|BAIL|BOND|CONTEMPT|WRIT\\b))|((?=.*(\\b|\\B)(VIOL))(?=.*(\\b|\\B)(PROM))(?=.*(\\b|\\B)(APP))))(?!.*(\\b|\\B)(OBSERV|CONSERV|FOOD)))';
    SHARED OFFENSE_CHILD_SUPPORT_CUSTODY := '((' + COMMON_CHILD_SUPPORT_LIST + '|' + COMMON_CHILD_CUSTODY_LIST + ')(?!.*(\\b|\\B)((O|I|C|A)NSPT)))';
    SHARED OFFENSE_BOOBY_TRAP := '((((?=.*(\\b|\\B)(TRAP))(?=.*(\\b|\\B)(BOOBY|DEVIC)))|(?=.*(\\b|\\B)(MANTRAP)))(?!.*(\\b|\\B)(RAPE|STAT)))';
    SHARED OFFENSE_SABOTAGE := '((?=.*(\\b|\\B)(SABOTAGE))(?!.*(\\b|\\B)(ADVO|SYNDICA)))';
    SHARED OFFENSE_VANDALISM := '((((?=.*(\\b|\\B)(VAND|GRAFFI|MISCHIEF))|((?=.*(\\b|\\B)(CRIMINAL|MALICOUS))(?=.*(\\b|\\B)(DAMAGE|D(A)?MG)))|((?=.*(\\b|\\B)(CR(I)?M|MAL))(?=.*(\\b|\\B)(MIS|MSCH|DAMA|D(A)?MG|DES|DST|DISTR|PRO|P(R)?P|DWELL|BUILD|BLDG)))|((?=.*(\\b|\\B)(PRO|P(R)?P|DWELL|BUILD|BLDG))(?=.*(\\b|\\B)(DAMA|D(A)?MG|DEST|DST|DISTRU))))(?!.*(\\b|\\B)(SERVAND|EVAND|DEV|ANIM|REG|' + COMMON_DUI_LIST + '|' + COMMON_ASSAULT_LIST + '))))';
    SHARED OFFENSE_CORRUPTION_MINOR := '(((?=.*(\\b|\\B)(CORRUP))(?=.*(\\b|\\B)(MINOR)))|((' + COMMON_CHILD_LIST + '|((?=.*(\\b)(UN))(?=.*(\\b)(21)(\\b)))|(?=.*(\\b|\\B)(\\<(\\s)?21))|(?=.*(\\b|\\B)(UNDERAGE)))(?=.*(\\b|\\B)(ALC|LIQ|CIG|TOB|INTOX|BEER|((?=.*(\\b|\\B)(MALS))(?=.*(\\b|\\B)(BEV)))))(?=.*(\\b|\\B)(SALE|SELL|GIVE|PROV|FUR|ALLOW|SERV))))';
    SHARED OFFENSE_RAPE := '(((?=.*(\\b|\\B)(STAT))(?=.*(\\b|\\B)(RAPE)))|(?=.*(\\b|\\B)(RAPE)))';
    
    SHARED OFFENSE_SEX_OFFENSES := '(' + COMMON_SEX_LIST + '(?!.*(\\b|\\B)(FAILURE)))';
    SHARED OFFENSE_PORN := COMMON_PORN_LIST;
    SHARED OFFENSE_PROSTITUTION := COMMON_PROSTITUTION_LIST;
    SHARED OFFENSE_SOLICITATION := '((?=.*(\\b|\\B)(SOL(IC|CT)))(?!.*(\\b|\\B)(' + COMMON_SEX_LIST + '|' + COMMON_PORN_LIST + '|' + COMMON_CHILD_LIST + ')))';
    SHARED OFFENSE_SOLICITATION_SEX := '(((?=.*(\\b|\\B)(IMPORTUN(E|ING)))|((?=.*(\\b|\\B)(SOL))(?=.*(\\b|\\B)(PROS(T)?|FEMALE|' + COMMON_SEX_LIST + '|' + COMMON_PORN_LIST + '|' + COMMON_CHILD_LIST + '))))(?!.*(\\b|\\B)(PANHAN|PEDDL|TOWNSHIP|ROADWAY)))';
    SHARED OFFENSE_FELONY_AGG_THEFT := '(((?=.*(\\b|\\B)(FEL|AGG|GRAND|GRD))' + COMMON_THEFT_LIST + ')|' + COMMON_GRAND_LARCENY_LIST + ')';
    SHARED OFFENSE_THEFT_GENERAL := '((((?=.*(\\b|\\B)(UNA(U)?TH|ENTER))(?=.*(\\b|\\B)(VEH|AUTO)))|((?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(CONVER)))|' + COMMON_THEFT_LIST + '|' + COMMON_LARCENY_LIST + ')(?!.*(\\b|\\B)(IDENTITY|FELON|SHOPL|((?=.*(\\b|\\B)(ORG))(?=.*(\\b|\\B)(RET))))))';
    
    SHARED OFFENSE_DISORDERLY_CONDUCT := COMMON_DISORDERLY_CONDUCT_LIST;
    SHARED OFFENSE_MONEY_LAUNDERING := '((?=.*(\\b|\\B)(LAU(ND(ER)?|DER|D)|LUADER))(?!.*(\\b|\\B)(DILAUDID|CART)))';
    SHARED OFFENSE_GAMING_CASINO := '(((?=.*(\\b|\\B)(PROM|DICE))(?=.*(\\b|\\B)(GAM)))|(?=.*(\\b|\\B)(GAMING|CASINO|GAMBL|PROM\\/GA(B)?M|LOTTERY)))';
    SHARED OFFENSE_TERRORISM := '((((?=.*(\\b|\\B)(TERROR))(?=.*(\\b|\\B)(ORG|FORE|GLOBAL|GR(O)?|ATTA|NARC)))|((?=.*(\\b|\\B)(MATERIAL))(?=.*(\\b|\\B)(SUPP)))|((?=.*(\\b|\\B)(MILIT))(?=.*(\\b|\\B)(TRAIN)))|(((?=.*(\\b|\\B)(PLAN|ATT|CONSP|PERF|THREAT))(?=.*(\\b|\\B)(ACT))(?=.*(\\b|\\B)(VIOLE))(?=.*(\\b|\\B)(TERROR)))(?!.*(\\b|\\B)(BATTERY|MANUFACTURE)))|((?=.*(\\b|\\B)(TEACH))(?=.*(\\b|\\B)(SYND|MILI)))|((?=.*(\\b|\\B)(THREAT))(?=.*(\\b|\\B)(CATAST)))|((?=.*(\\b|\\B)(AIRPL))(?=.*(\\b|\\B)(TAKE))(?=.*(\\b|\\B)(POSS)))|((?=.*(\\b|\\B)(GOV|GVT|POLIT))(?=.*(\\b|\\B)(ASSASSIN|KILL|' + COMMON_KIDNAPPING_LIST + ')))|(?=.*(\\b|\\B)(TERRORI(SM|ST)|PROLIF|SDGT|HIJACK)))(?!.*(\\b|\\B)(TERRORI(ZE|STIC)|' + COMMON_CAR_JACK_LIST + ')))';
    
    SHARED OFFENSE_ORGANIZED_CRIME := '(((((?=.*(\\b|\\B)(SYNDICATE|ORGAN|ORGIN|ORGN|ORG\\.|ORGN|ORGZ|ORGR|(\\-|\\/)(ORG|ORIG|OGR|ORI)|\\-ORA))|(?=.*(\\b)(OR(G|A|I(G)?)|OGR)))(?=.*(\\b|\\B)(ACT|CR(I)?M|CRM\\.|CIM)))|((?=.*(\\b|\\B)(OG))(?=.*(\\b|\\B)(CRIM))(?=.*(\\b|\\B)(ACT))))(?!.*(\\b|\\B)(RETAIL)))';
    SHARED OFFENSE_PERJURY := '((?=.*(\\b|\\B)(P(E|U)RJ))|((?=.*(\\b|\\B)(FALSE))(?=.*(\\b|\\B)(TESTIM|OATH))))';
    SHARED OFFENSE_TAMPERING := '((?=.*(\\b|\\B)(TAMP))(?!.*(\\b|\\B)(STAMP|METH|MEHT|META)))';
    SHARED OFFENSE_OBSTRUCTION_HINDER_GENERAL := '((?=.*(\\b|\\B)(OBSTR|HINDER))(?!.*(\\b|\\B)(HIGH|FIRE|WINDSHIELD|' + COMMON_TRAFFIC_GROUP_LIST + ')))';
    SHARED OFFENSE_CONSPIRACY_GENERAL := '(?=.*(\\b|\\B)(CONSPIR))';
    SHARED OFFENSE_OBSTRUCTION_JUSTICE := '((((?=.*(\\b|\\B)(JUST))(?=.*(\\b|\\B)(OBST|IMPEDE|INFLU|TAMP)))|((?=.*(\\b|\\B)(DESTROY|TAMPER))(?=.*(\\b|\\B)(EVIDENCE|RECORD)))|((?=.*(\\b|\\B)(INTERF|INFLU|DELAY|PREVENT))(?=.*(\\b|\\B)(PROCEED|TESTIMONY)))|((?=.*(\\b|\\B)(TAMP|INTIM|OBSTRU|INJURE|THREAT|[^EN]FORCE|CORRUPT|INFLU|BRIB|COERC|HINDER|OBSTRUCT))(?=.*(\\b|\\B)(WITN(SS)?|JURY|JUROR|JUDICIAL|VICTIM|INFORM|PROCEED|OFFIC|LAW|COURT|PROS|((?=.*(\\b|\\B)(JUD))(?=.*(\\b|\\B)(OFF)))))))(?!.*(\\b|\\B)(VISUAL|OPERATE|SEX|OBSCEN|PROST|DRIV(E|ING)?|INJURY|HIGH|FIRE|WINDSHIELD|ELECT|VOT(E|ING)|BALLOT|POLIT|' + COMMON_CHILD_LIST + ')))';
    SHARED OFFENSE_ELECTION_CRIMES := '(((?=.*(\\b|\\B)(ELECTION|VOT(ER|ING)|BALLOT))|((?=.*(\\b|\\B)(ELECTOR))(?=.*(\\b|\\B)(VOTE)))|((?=.*(\\b|\\B)(BALLOT|ELECT|VOTE))(?=.*(\\b|\\B)(' + COMMON_FRAUD_LIST + '|VIOL|TAMP|SOLIC|FALS|LAW|INFLU|CORR|BRIB|BUY|COERC|INTERF|CONSPIR|REGISTR|DEVICE))))(?!.*(\\b|\\B)(SELECT(ION)?|ELECTR(ON)?IC|WITN(SS)?|JURY|JUROR|JUDICIAL|VICTIM|INFORM|PROCEED|OFFIC|COURT|' + COMMON_CHILD_LIST + ')))';
    SHARED OFFENSE_CORRUPTION_BRIBERY := '((?=.*(\\b|\\B)(CORRUPT|BRIB|KICKBACK))(?!.*(\\b|\\B)(DISTRIBUTE|ELECT|VOT(E|ING)|BALLOT|WITN(SS)?|JURY|JURROR|JUDICIAL|VICTIM|INFORM|PROCEED|OOFIC|LAW|COURT|POLIT|CAMPAIGN|' + COMMON_CHILD_LIST + ')))';
    SHARED OFFENSE_POLITICAL_CAMPAIGN_CRIMES := '((?=.*(\\b|\\B)(POLITICAL))|((?=.*(\\b|\\B)(CONTRIB))(?=.*(\\b|\\B)(UNLAWFUL)))|((?=.*(\\b|\\B)(POLIT|CAMPAIGN|CANDID|LEGISL))(?=.*(\\b|\\B)(' + COMMON_FRAUD_LIST + '|BRIB|ENDOR|CONTRI|ADVER|TAMP|SOLIC|INFLU|CORR|VIOL|COERC|INTERF|CONSPIR|UNLAWFUL))))';
    SHARED OFFENSE_FRAUD_WIRE := '((' + COMMON_FRAUD_LIST + '(?=.*(\\b|\\B)(WIRE)))(?!.*' + COMMON_FRAUD_CHECK_LIST + '))';
    SHARED OFFENSE_FRAUD_BANK := '(((' + COMMON_FRAUD_LIST + '((?=.*(\\b|\\B)(BANK))|((?=.*(\\b|\\B)(FIN))(?=.*(\\b|\\B)(INST)))))|((?=.*(\\b|\\B)(FALSE))(?=.*(\\b|\\B)(EMBOSS))))(?!.*(\\b|\\B)(' + COMMON_FRAUD_CHECK_LIST + ')))';
    SHARED OFFENSE_FRAUD_CARD := '((' + COMMON_CREDIT_CARD_LIST + '|((?=.*(\\b|\\B)(CC))(?=.*(\\b|\\B)(ABUSE))))(?!.*' + COMMON_FRAUD_CHECK_LIST + '))';
    SHARED OFFENSE_FRAUD_TAX := '(((' + COMMON_FRAUD_LIST + '|(?=.*(\\b|\\B)(EVAS|CONV)))(?=.*(\\b|\\B)(TAX)))(?!.*(\\b|\\B)(TAXI)))';
    SHARED OFFENSE_FRAUD_MORTGAGE := '(' + COMMON_FRAUD_LIST + '(?=.*(\\b|\\B)(MORTGAGE)))';
    SHARED OFFENSE_FRAUD_HEALTHCARE := '(((' + COMMON_FRAUD_LIST + '(?=.*(\\b|\\B)(HEALTH)))|(?=.*(\\b|\\B)(MEDICAID))|((?=.*(\\b|\\B)(UNAUTH))(?=.*(\\b|\\B)(USE))(?=.*(\\b|\\B)(PROVIDER)))|((?=.*(\\b|\\B)(FRAUD|FALSE))(?=.*(\\b|\\B)(MED))(?=.*(\\b|\\B)(CLAIM))))(?!.*(\\b|\\B)(' + COMMON_ASSAULT_LIST + ')))';
    SHARED OFFENSE_FRAUD_EMPLOYMENT := '((' + COMMON_FRAUD_LIST + '(?=.*(\\b|\\B)(WORKER|COMPEN)))|((?=.*(\\b|\\B)(WORKER))(?=.*(\\b|\\B)(COMP))))';
    SHARED OFFENSE_FRAUD_INSURANCE := '((' + COMMON_FRAUD_LIST + '(?=.*(\\b|\\B)(INSUR)))|((?=.*(\\b|\\B)(FALSE))((?=.*(\\b|\\B)(INSUR))|((?=.*(\\b|\\B)(INS))(?=.*(\\b|\\B)(STATEMENT))))))';
    SHARED OFFENSE_FRAUD_ORGANIZED := '(((?=.*(\\b|\\B)(RETAIL|' + COMMON_FRAUD_LIST + '|' + COMMON_THEFT_LIST + '))((?=.*(\\b|\\B)(ORG(A|I)?N|ORG\\.|ORGZ|ORGR|(\\-|\\/)(ORG|ORIG|OGR|ORI)|\\-ORA))|(?=.*(\\b)(OR(G|I(G)?)|OGR))))(?!.*(\\b|\\B)(RETAL|ENDANGER|' + COMMON_FORGE_LIST + ')))';
    SHARED OFFENSE_FRAUD_INVOICE := '((((' + COMMON_FRAUD_LIST + '|(?=.*(\\b|\\B)(FALS)))((?=.*(\\b|\\B)(INVOI|RECEIPT|PAYMENT))|((?=.*(\\b|\\B)(SALES))(?=.*(\\b|\\B)(SLIP)))|((?=.*(\\b|\\B)(BUS))(?=.*(\\b|\\B)(REC)))|((?=.*(\\b|\\B)(PAY))(?=.*(\\b|\\B)(STAT)))))|((?=.*(\\b|\\B)(SERV))((?=.*(\\b|\\B)(NOT))(?=.*(\\b|\\B)(REND)))))(?!.*(\\b|\\B)(' + COMMON_FRAUD_CHECK_LIST + '|' + COMMON_CREDIT_CARD_LIST + ')))';
    SHARED OFFENSE_FRAUD_CHECK := '(' + COMMON_FRAUD_CHECK_LIST + '(?!.*(\\b|\\B)(' + COMMON_THEFT_LIST + '|' + COMMON_OBTAIN_PROPERTY_LIST + ')))';
    SHARED OFFENSE_FRAUD_GENERAL := '((((?=.*(\\b|\\B)(FT\\/REPORT|CHG|WRONG|FRAUD))((?=.*(\\b|\\B)(PUBLIC|GOV|GVT))(?=.*(\\b|\\B)(AID|ASSIST))))|((?=.*(\\b|\\B)(SECURE))(?=.*(\\b|\\B)(EXE))(?=.*(\\b|\\B)(DOC)))|((?=.*(\\b|\\B)(FALSE|MISLEAD))(?=.*(\\b|\\B)(ADVER)))|((?=.*(\\b|\\B)(DEC|UNFAIR|FALSE))(?=.*(\\b|\\B)(BUS|TRADE|PRAC)))|((?=.*(\\b|\\B)(FALS))(?=.*(\\b|\\B)(BENEFIT)))|' + COMMON_FRAUD_LIST + ')(?!.*' + COMMON_FRAUD_CHECK_LIST + '))';
   
    SHARED OFFENSE_FRAUD_IDENTITY := COMMON_IDENTITY_FRAUD_LIST;
    SHARED OFFENSE_FALSE_STATEMENT := COMMON_FALSE_STATEMENT_LIST;
    SHARED OFFENSE_FORGE_COUNTERFEIT := '((' + COMMON_FORGE_LIST + '|' + COMMON_COUNTERFEIT_LIST + '|((?=.*(\\b|\\B)(FIN))(?=.*(\\b|\\B)(DEVIC)))|((?=.*(\\b|\\B)(ILLEG))(?=.*(\\b|\\B)(PROCESS))(?=.*(\\b|\\B)(DOC))))(?!.*(\\b|\\B)(INVOICE|' + COMMON_FRAUD_CHECK_LIST + ')))';
   
    SHARED OFFENSE_RESIST_ESCAPE := '((((?=.*(\\b|\\B)(UNAUTH))(?=.*(\\b|\\B)(ABSEN))(?=.*(\\b|\\B)(CORRECTION|CCF)))|((?=.*(\\b|\\B)(HIND|AVOID))(?=.*(\\b|\\B)(APPR|ARREST|ARST|DETAIN)))|((?=.*(\\b|\\B)(EVAD|ELUD|EVD))(?=.*(\\b|\\B)(ARR|ARST|DET|FUGI|POL|OFFIC|APPR)))|((?=.*(\\b|\\B)(AID))(?=.*(\\b|\\B)(OFFENDER)))|((?=.*(\\b|\\B)(RES))(?=.*(\\b|\\B)(ARST|ARRST)))|(?=.*(\\b|\\B)(RESIST|(E)?SCAPE|ELUD(E|I)|FLEE|FLIGHT|ESC(A)?P|EVAD(E|ING)|HARBOR)))(?!.*(\\b|\\B)(RAPE|PERSISTENT|RESISTER|' + COMMON_SEX_LIST + '|' + COMMON_ALCOHOL_LIST + '|' + COMMON_DUI_LIST + '|' + COMMON_LIVESTOCK_ANIMAL_LIST + ')))';
    SHARED OFFENSE_ASSULT_COMBINED := COMMON_ASSULT_COMBINED_LIST;
    SHARED OFFENSE_DEADLY_CONDUCT := '(((?=.*(\\b|\\B)(DEAD|DDLY))(?=.*(\\b|\\B)(CONDUCT)))|((?=.*(\\b|\\B)(RECK))(?=.*(\\b|\\B)(CONDUCT|ENDANG))))';
    SHARED OFFENSE_CHOP_SHOP := '((((?=.*(\\b|\\B)(VEHIC))(?=.*(\\b|\\B)(DISMANTLE|DESTROY|DISASSEM|REASSEMB|DEFACE|DISGUISE)))|(?=.*(\\b|\\B)(CHOP)))(?!.*(\\b|\\B)(PSYCHOPATH)))';
    SHARED OFFENSE_EXTORTION := '((((?=.*(\\b|\\B)(BLACK))(?=.*(\\b|\\B)(MAIL)))|((?=.*(\\b|\\B)(FIN))(?=.*(\\b|\\B)(EXPLOIT)))|(?=.*(\\b|\\B)(EXTOR|BLACKM|RANSOM|KFR|HOSTAG)))(?!.*(\\b|\\B)(NO|WITHOUT|TRANSOM|TRANSPORT|ADULT|ELDER|CARETA)))';
    SHARED OFFENSE_DIGITAL_CURRENCY := '(((?=.*(\\b|\\B)(DIGIT))(?=.*(\\b|\\B)(CURR)))|(?=.*(\\b|\\B)(BITCOIN)))';
    SHARED OFFENSE_ARM_ROBBERY := COMMON_ARM_ROBBERY_LIST;
    SHARED OFFENSE_BANK_ROBBERY := COMMON_BANK_ROBBERY_LIST;
    SHARED OFFENSE_ROBBERY := COMMON_ROBBERY_LIST;
    
    SHARED OFFENSE_ANTITRUST_VIOLATIONS := '(((?=.*(\\b|\\B)(ANTI(\\-|\\s)?TRUST|MONOPOL(Y|IES)))|((?=.*(\\b|\\B)(FED|STATE))(?=.*(\\b|\\B)(FIN))(?=.*(\\b|\\B)(INST))(?=.*(\\b|\\B)(CRIM)))|((?=.*(\\b|\\B)(CRIME))(?=.*(\\b|\\B)(AGAINST))((?=.*(\\b|\\B)(GOV))|((?=.*(\\b|\\B)(FED|STATE))(?=.*(\\b|\\B)(INSTI)))))|((?=.*(\\b|\\B)(MERGER|ACQUISITION|TAKE(\\s)?OVER))(?=.*(\\b|\\B)(BUS|COMP))(?!.*(\\b|\\B)(CARD))))(?!.*' + COMMON_ALCOHOL_LIST + '|' + COMMON_TRAFFIC_LICENSE_REGISTRATION_LIST + '|' + COMMON_VIOLATING_ORDERS + '))';
    SHARED OFFENSE_SECURITIES_COMMODITIES_BROKERS := '(((' + COMMON_FRAUD_LIST + '(?=.*(\\b|\\B)(SECURITI|COMMOD)))|(?=.*(\\b|\\B)(COMMODIT(Y|IES)|SECURITIES))|((?=.*(\\b|\\B)(SECURITI|COMMOD))((?=.*(\\b|\\B)(ACT|DEC))|((?=.*(\\b|\\B)(FALSE))(?=.*(\\b|\\B)(REP|STATE)))))|((?=.*(\\b|\\B)(INSIDER))(?=.*(\\b|\\B)(TRAD)))|((?=.*(\\b|\\B)(SALE))(?=.*(\\b|\\B)(UNREG))(?=.*(\\b|\\B)(SECURIT)))|((?=.*(\\b|\\B)(SECURITI|COMMOD|TRAD|SALE))(?=.*(\\b|\\B)((UN)?REG|(UN)?LIC))(?=.*(\\b|\\B)(LOAN|BROK|ADVIS|BROKER\\/DEALER|AGENT|INVEST|SECURITI|STOCK|SHARE)))|((?=.*(\\b|\\B)(VIOL))(?=.*(\\b|\\B)(SECURITI))(?=.*(\\b|\\B)(ACT|LAW))))(?!.*(\\b|\\B)(LEWD|VEH|PLATE|DRIVER|SECURING|' + COMMON_FRAUD_CHECK_LIST + '|' + COMMON_FALSE_STATEMENT_LIST + ')))';
    SHARED OFFENSE_RACKETEERING := '((((?=.*(\\b|\\B)(PRED))(?=.*(\\b|\\B)(LEND)))|((?=.*(\\b|\\B)(CORRUP))(?=.*(\\b|\\B)(ORG)))|((?=.*(\\b|\\B)(WRONG))(?=.*(\\b|\\B)(CREDIT))(?=.*(\\b|\\B)(PRACT)))|((?=.*(\\b|\\B)(INTERSTATE))(?=.*(\\b|\\B)(SHIP|CORR|TRANS)))|(?=.*(\\b|\\B)(RACKET|RICO|USURY)))(?!.*(\\b|\\B)(STOLE|BRACKET)))';
    SHARED OFFENSE_MONEY_TRANSMITTER := COMMON_MONEY_TRANSMITTER_LIST;
    SHARED OFFENSE_STRUCTURING := COMMON_STRUCTURING_LIST;
    
    SHARED OFFENSE_MISSAPPROP_EMBEZZLE := COMMON_MISAPPROP_EMBEZZLE_LIST;
    SHARED OFFENSE_CONCEAL_FUNDS := '(((?=.*(\\b|\\B)(ACQ|CONCEAL))(?=.*(\\b|\\B)(FUN|MONEY|PRO(C|P))))(?!.*' + COMMON_CHILD_LIST + '))';
    SHARED OFFENSE_TAX_GENERAL := '((?=.*(\\b|\\B)(TAX))(?!.*(\\b|\\B)(TAXI)))';
    SHARED OFFENSE_OPERATE_NO_LICENSE := '((((?=.*(\\b|\\B)(PRACT))(?=.*(\\b|\\B)(WITHOUT|LICENSE|FALSE|UNLIC)))|((?=.*(\\b|\\B)(ILLEG))(?=.*(\\b|\\B)(BUS|OCCUP)))|((?=.*(\\b|\\B)(UNLIC))(?=.*(\\b|\\B)(OPERATE|SALE|MANUF|DEALER)))|((?=.*(\\b|\\B)(W\\/O|WITHOUT))(?=.*(\\b|\\B)(LICENSE)))|(?=.*(\\b|\\B)(UNLICENSED)))(?!.*' + COMMON_TRAFFIC_GROUP_LIST + '|' + COMMON_LIVESTOCK_ANIMAL_LIST + '|' + COMMON_HUNT_TRAP_FISH_TERMS_LIST + '))';
    SHARED OFFENSE_EXPORT_IMPORT := '((?=.*(\\b|\\B)(IMPORT|EXPORT))(?!.*(\\b|\\B)(IMPORTUN(E|ING))))';
    SHARED OFFENSE_TRANSPORT_PROCEEDS := COMMON_TRANSPORT_PROCEEDS_LIST;
    SHARED OFFENSE_GENERAL_DAMAGE_DESTROY := '(?=.*(\\b|\\B)(DESTR(U|OY)|DAMAGE))';
    SHARED OFFENSE_OBTAIN_PROPERTY := COMMON_OBTAIN_PROPERTY_LIST;
    SHARED OFFENSE_SHOPLIFTING := '((' + COMMON_THEFT_LIST + '(?=.*(\\b|\\B)(RET)))|(?=.*(\\b|\\B)(SHOPL))|((?=.*(\\b|\\B)(CONCEAL|ALTER))(?=.*(\\b|\\B)(MERCH|PRICE))))';
    SHARED OFFENSE_TRESPASSING := '((((?=.*(\\b|\\B)(ENTER))(?=.*(\\b|\\B)(B(UI)?LD|PREMISE)))|(?=.*(\\b|\\B)(TRES))|((?=.*(\\b|\\B)(DIST))(?=.*(\\b|\\B)(PRIV))(?=.*(\\b|\\B)(PROP))))(?!.*(\\b|\\B)(MATTRESS|' + COMMON_BREAK_ENTER_LIST + ')))';
    SHARED OFFENSE_COMMUNICATION_INTERCEPTION := '((((?=.*(\\b|\\B)(INTERCEPT))(?=.*(\\b|\\B)(MESS|WIRE|COMM|DEVICE)))|((?=.*(\\b|\\B)(INTERFERE))(?=.*(\\b|\\B)(W))(?=.*(\\b|\\B)(MSG|MESSA(GE)?)))|(?=.*(\\b|\\B)(WIRETAP))|((((?=.*(\\b|\\B)(DEV))(?=.*(\\b|\\B)(RECO|COMM)))|(?=.*(\\b|\\B)(EAVESDROP)))(?=.*(\\b|\\B)(INTERCEPT))))(?!.*(\\b|\\B)(DRUG|COP(PER)?|ELECTRICAL|PIPES|DAMAG|CELL|CABLE|WIRELESS|' + COMMON_FRAUD_LIST + '|' + COMMON_THEFT_LIST + ')))';
    
    SHARED OFFENSE_DRUGS := '((' + COMMON_DRUGS_WITH_POSSESSION_LIST + '|' + COMMON_DRUGS_WITHOUT_POSSESSION_LIST + ')(?!.*(' + COMMON_FISH_GAME_ANIMAL_LIST + '|' + COMMON_TRAFFIC_GROUP_LIST + '|' + COMMON_ALCOHOL_LIST + '|' + COMMON_DISORDERLY_CONDUCT_LIST + '|' + COMMON_ASSULT_COMBINED_LIST + '|' + COMMON_ROBBERY_LIST + '|' + COMMON_BANK_ROBBERY_LIST + '|' + COMMON_ARM_ROBBERY_LIST + '|' + COMMON_CAR_JACK_LIST + ')))';
    SHARED OFFENSE_EXPLOSIVES := COMMON_EXPLOSIVES_LIST;
    SHARED OFFENSE_WEAPONS := '(' + COMMON_WEAPONS_LIST + '(?!.*(' + COMMON_SEX_LIST + '|' + COMMON_TRAFFIC_GROUP_LIST + '|' + COMMON_THEFT_LIST + '|' + COMMON_ASSULT_COMBINED_LIST + '|' + COMMON_ROBBERY_LIST + '|' + COMMON_BANK_ROBBERY_LIST + '|' + COMMON_CAR_JACK_LIST + '|' + COMMON_KIDNAPPING_LIST + ')))';
    SHARED OFFENSE_CRIMINAL_PROCEED := '((((?=.*(\\b|\\B)(PROCEED))(?=.*(\\b|\\B)(ACQ(UIR)?|CRIM|DRUG|ILLEG|' + COMMON_DRUGS_LIST + '|' + COMMON_WEAPONS_LIST +')))|((?=.*(\\b|\\B)(ACQ))(?=.*(\\b|\\B)(CRIM)))|((?=.*(\\b|\\B)(PROCEEDS))(?=.*(\\b|\\B)(CONCEAL))))(?!.*(\\b|\\B)(COURT)))';
    SHARED OFFENSE_TRAFFICKING_HUMANS := COMMON_TRAFFICKING_HUMAN_LIST;
    SHARED OFFENSE_TRAFFICKING_ARMS := '(((?=.*(\\b|\\B)(' + COMMON_TRAFFICKING_TERMS_LIST + '))' + COMMON_WEAPONS_LIST + ')(?!.*(\\b|\\B)(OFFENSE|BLOCK|CHAPTER|OBSTRUCTING|ABANDON|((?=.*(\\b|\\B)(SER))(?=.*(\\b|\\B)(REM)))|TRANSMIT|' + COMMON_DUI_LIST + '|' + COMMON_ALCOHOL_LIST + ')))';
    SHARED OFFENSE_TRAFFICKING_DRUGS := '(((?=.*(\\b|\\B)(' + COMMON_TRAFFICKING_TERMS_LIST + '))(' + COMMON_SLIM_DRUG_LIST + '|' + COMMON_DRUGS_LIST + '))(?!.*(\\b|\\B)(GOODS|SERVICES|OFFENSE|BLOCK|CHAPTER|OBSTRUCTING|ABANDON|((?=.*(\\b|\\B)(SER))(?=.*(\\b|\\B)(REM)))|TRANSMIT|' + COMMON_DUI_LIST + '|' + COMMON_ALCOHOL_LIST + ')))';
    SHARED OFFENSE_TRAFFICKING_GENERAL := '(((?=.*(\\b|\\B)(TRAFFICK))|(' + COMMON_TRAFFICKING_TERMS_LIST + '(?=.*(\\b|\\B)(GOODS|STOLEN|PROP|SERVICES|FOOD|CONTR(A|O)|CNTRBD))))(?!.*(\\b|\\B)(OFFENSE|BLOCK|CHAPTER|OBSTRUCTING|ABANDON|((?=.*(\\b|\\B)(SER))(?=.*(\\b|\\B)(REM)))|TRANSMIT|' + COMMON_DUI_LIST + '|' + COMMON_ALCOHOL_LIST + '|' + COMMON_TRAFFIC_GROUP_LIST + ')))';
    SHARED OFFENSE_ALIEN_IMMIGRATION := '((?=.*(\\b|\\B)(IMMIGR|ALIEN|NATURALIZATION|STOWAWAY))(?!.*(\\b|\\B)(SMUG)))';
    SHARED OFFENSE_MANU_DIST_DRUGS_AND_WEAPONS := '(((' +  COMMON_LAB_LIST  + ')|' +
                                                  '(' + COMMON_WITH_INTENT_LIST + '(' + COMMON_MANUF_DELIVER_SELL_LIST + '|' + COMMON_PLANT_GROW_LIST + '))|' +
                                                  '(((' + COMMON_POSSESSION_LIST + COMMON_WITH_INTENT_LIST + ')|' + COMMON_POSSESSION_WITH_INTENT_LIST + '|' + COMMON_WITH_INTENT_LIST + '|' + COMMON_MANUF_DELIVER_SELL_LIST + '|' + COMMON_PLANT_GROW_LIST + '|(?=.*(\\b|\\B)(DWELL|VEH|HOUSE|LAB)))(' + COMMON_DRUGS_LIST + '|' + COMMON_DRUG_PARAPHERNALIA_LIST + '|' + COMMON_SLIM_DRUG_LIST + '))|' +
                                                  '(' + COMMON_MANUF_DELIVER_SELL_LIST + COMMON_WEAPONS_LIST + ')|' +
                                                  '((' + COMMON_WEAPONS_LIST + '|' + COMMON_DRUGS_LIST + '|' + COMMON_DRUG_PARAPHERNALIA_LIST + '|' + COMMON_SLIM_DRUG_LIST + ')(' + COMMON_MANUF_ACRONYM_LIST + '|' + COMMON_PRECURSOR_LIST + '|' + COMMON_DRUG_DEA_DIVERSION_LIST + ')))' +
                                                  '(?!.*(\\b|\\B)(DRIV|DOMESTIC|INTOXICATION|DISORDERLY|((?=.*(\\b|\\B)(CONV))(?=.*(\\b|\\B)(FE)))|' + COMMON_DUI_LIST + '|' + COMMON_THEFT_LIST + '|' + COMMON_ALCOHOL_LIST + '|' + COMMON_ROBBERY_LIST + '|' + COMMON_BANK_ROBBERY_LIST + '|' + COMMON_ASSULT_COMBINED_LIST + '|' + COMMON_CAR_JACK_LIST + '|' + COMMON_BURGLARY_LIST + '|' + COMMON_TRAFFIC_GROUP_LIST + '|' + COMMON_SEX_LIST + '|' + COMMON_FISH_GAME_ANIMAL_LIST + '|' + COMMON_HUNT_TRAP_FISH_TERMS_LIST + '|' + COMMON_FRAUD_CHECK_LIST + ')))';
    
   
    
    
    
    
    
    
    
    //These are expressions used in logic
    EXPORT HUNT_FISH_GAME_OFFENSES := STARTS_WITH + OFFENSE_HUNT_FISH_GAME + ENDS_WITH;
    EXPORT LIVESTOCK_DOMESTIC_ANIMALS := STARTS_WITH + OFFENSE_LIVESTOCK_DOMESTIC_ANIMALS + ENDS_WITH;
    EXPORT ORDINANCES_AND_INFRACTIONS := STARTS_WITH + OFFENSE_INFRACTION_AND_ORDINANCES + ENDS_WITH;
    EXPORT ELDER_EXPLOITATION := STARTS_WITH + OFFENSE_ELDER_EXPLOITATION + ENDS_WITH;
    EXPORT FAMILY_AND_PROVIDER_ABUSE := STARTS_WITH + OFFENSE_FAMILY_PROVIDER_ABUSE + ENDS_WITH;

    EXPORT ANIMAL_FIGHTING := STARTS_WITH + OFFENSE_ANIMAL_FIGHT + ENDS_WITH;
    EXPORT DUI := STARTS_WITH + OFFENSE_DUI + ENDS_WITH;
    EXPORT ALCOHOL := STARTS_WITH + OFFENSE_ALCOHOL + ENDS_WITH;

    EXPORT GANG_ACTIVITIES := STARTS_WITH + OFFENSE_GANG + ENDS_WITH;
    EXPORT FUGITIVE_OR_WARRANT := STARTS_WITH + OFFENSE_FUGITIVE_WARRANT + ENDS_WITH;
    EXPORT RIOTS_AND_CIVIL_DISORDER := STARTS_WITH + OFFENSE_RIOT_CIVIL_DISORDER + ENDS_WITH;
    EXPORT POISONING := STARTS_WITH + OFFENSE_POISONING + ENDS_WITH;
    EXPORT EPA_WASTE := STARTS_WITH + OFFENSE_EPA_WASTE + ENDS_WITH;
    EXPORT ZONING_BUILDING_VIOLATIONS := STARTS_WITH + OFFENSE_ZONING_BUILDING + ENDS_WITH;

    EXPORT TREASON_ESPIONAGE := STARTS_WITH + OFFENSE_TREASON_ESPIONAGE + ENDS_WITH;
    EXPORT STALKING_TERRORIZE := STARTS_WITH + OFFENSE_STALK_INTIM + ENDS_WITH;
    EXPORT CYBER_STALKING := STARTS_WITH + OFFENSE_CYBER_STALK + ENDS_WITH;
    EXPORT VIOLATING_ORDERS := STARTS_WITH + OFFENSE_VIOLATING_ORDERS + ENDS_WITH;
    EXPORT PROBATION_PAROLE_VIOLATION := STARTS_WITH + OFFENSE_PAROLE_PROBATION_VIOLATION + ENDS_WITH;
    EXPORT MISCONDUCT := STARTS_WITH + OFFENSE_MISCONDUCT + ENDS_WITH;
    EXPORT COMPUTER_AND_CYBER := STARTS_WITH + OFFENSE_CYBER_COMPUTER_CRIMES + ENDS_WITH;
    
    EXPORT ARSON := STARTS_WITH + OFFENSE_ARSON + ENDS_WITH;
    EXPORT CAR_JACKING := STARTS_WITH + OFFENSE_CAR_JACK + ENDS_WITH;
    EXPORT BURGLARY := STARTS_WITH + OFFENSE_BURGLARY + ENDS_WITH;
    EXPORT BREAKING_AND_ENTERING := STARTS_WITH + OFFENSE_BREAK_AND_ENTER + ENDS_WITH;
    
    EXPORT TRAFFIC_RELATED := STARTS_WITH + OFFENSE_TRAFFIC_DRIVING + ENDS_WITH;
    
    EXPORT CRIMINAL_SYNDICALISM := STARTS_WITH + OFFENSE_CRIMINAL_SYNDICALISM + ENDS_WITH;
    EXPORT SANCTIONS_GENERAL := STARTS_WITH + OFFENSE_SANCTIONS_GENERAL + ENDS_WITH;
    EXPORT MURDER_HOMOCIDE := STARTS_WITH + OFFENSE_MURDER + ENDS_WITH;
    EXPORT KIDNAPPING_FALSE_IMPRISONMENT := STARTS_WITH + OFFENSE_KIDNAPPING + ENDS_WITH;
    EXPORT HATE_CRIME_AND_CIVIL_RIGHTS := STARTS_WITH + OFFENSE_HATE_CRIME + ENDS_WITH;
    EXPORT RETALIATION := STARTS_WITH + OFFENSE_RETALIATION + ENDS_WITH;
    
    EXPORT CORRUPT_MINOR := STARTS_WITH + OFFENSE_CORRUPTION_MINOR + ENDS_WITH;
    EXPORT RAPE := STARTS_WITH + OFFENSE_RAPE + ENDS_WITH;
    EXPORT BOOBY_TRAP := STARTS_WITH + OFFENSE_BOOBY_TRAP + ENDS_WITH;
    EXPORT SABOTAGE := STARTS_WITH + OFFENSE_SABOTAGE + ENDS_WITH;
    EXPORT VANDALISM := STARTS_WITH + OFFENSE_VANDALISM + ENDS_WITH;
    EXPORT CHILD_SUPPORT_AND_CUSTODY := STARTS_WITH + OFFENSE_CHILD_SUPPORT_CUSTODY + ENDS_WITH;
    EXPORT COURT_CHARGES := STARTS_WITH + OFFENSE_COURT_CHARGES + ENDS_WITH;
  
    EXPORT FELONY_AGGRAVATED_THEFT := STARTS_WITH + OFFENSE_FELONY_AGG_THEFT + ENDS_WITH;
    EXPORT GENERAL_THEFT := STARTS_WITH + OFFENSE_THEFT_GENERAL + ENDS_WITH;
    EXPORT SOLICITATION := STARTS_WITH + OFFENSE_SOLICITATION + ENDS_WITH;
    EXPORT SOLICITATION_SEX := STARTS_WITH + OFFENSE_SOLICITATION_SEX + ENDS_WITH;
    EXPORT PORN := STARTS_WITH + OFFENSE_PORN + ENDS_WITH;
    EXPORT PROSTITUTION := STARTS_WITH + OFFENSE_PROSTITUTION + ENDS_WITH;
    EXPORT SEX_OFFENSES := STARTS_WITH + OFFENSE_SEX_OFFENSES + ENDS_WITH;
    
    EXPORT MONEY_LAUNDERING := STARTS_WITH + OFFENSE_MONEY_LAUNDERING + ENDS_WITH;
    EXPORT GAMBLING_AND_CASINO := STARTS_WITH + OFFENSE_GAMING_CASINO + ENDS_WITH;
    EXPORT DISORDERY_CONDUCT := STARTS_WITH + OFFENSE_DISORDERLY_CONDUCT + ENDS_WITH;
    EXPORT TERRORISM := STARTS_WITH + OFFENSE_TERRORISM + ENDS_WITH;
    
    EXPORT ORGANIZED_CRIME := STARTS_WITH + OFFENSE_ORGANIZED_CRIME + ENDS_WITH;
    EXPORT OBSTRUCTION_OF_JUSTICE := STARTS_WITH + OFFENSE_OBSTRUCTION_JUSTICE + ENDS_WITH;
    EXPORT ELECTION_CRIMES_CORRUPTION := STARTS_WITH + OFFENSE_ELECTION_CRIMES + ENDS_WITH;
    EXPORT POLITICAL_CRIMES_CORRUPTION := STARTS_WITH + OFFENSE_POLITICAL_CAMPAIGN_CRIMES + ENDS_WITH;
    EXPORT CORRUPTION_BRIBERY_KICKBACKS := STARTS_WITH + OFFENSE_CORRUPTION_BRIBERY + ENDS_WITH;
    EXPORT WIRE_FRAUD := STARTS_WITH + OFFENSE_FRAUD_WIRE + ENDS_WITH;
    EXPORT BANK_FRAUD := STARTS_WITH + OFFENSE_FRAUD_BANK + ENDS_WITH;
    EXPORT FINANCIAL_CARD_FRAUD := STARTS_WITH + OFFENSE_FRAUD_CARD + ENDS_WITH;
    EXPORT TAX_FRAUD := STARTS_WITH + OFFENSE_FRAUD_TAX + ENDS_WITH;
    EXPORT MORTGAGE_FRAUD := STARTS_WITH + OFFENSE_FRAUD_MORTGAGE + ENDS_WITH;
    EXPORT HEALTHCARE_FRAUD := STARTS_WITH + OFFENSE_FRAUD_HEALTHCARE + ENDS_WITH;
    EXPORT EMPLOYEMENT_WORK_COMP_FRAUD := STARTS_WITH + OFFENSE_FRAUD_EMPLOYMENT + ENDS_WITH;
    EXPORT INSURANCE_FRAUD := STARTS_WITH + OFFENSE_FRAUD_INSURANCE + ENDS_WITH;
    EXPORT ORGANIZED_FRAUD := STARTS_WITH + OFFENSE_FRAUD_ORGANIZED + ENDS_WITH;
    EXPORT INVOICE_FRAUD := STARTS_WITH + OFFENSE_FRAUD_INVOICE + ENDS_WITH;
    EXPORT CHECK_FRAUD := STARTS_WITH + OFFENSE_FRAUD_CHECK + ENDS_WITH;
    EXPORT GENERAL_FRAUD := STARTS_WITH + OFFENSE_FRAUD_GENERAL + ENDS_WITH;
    EXPORT CONSPIRACY := STARTS_WITH + OFFENSE_CONSPIRACY_GENERAL + ENDS_WITH;
    EXPORT PERJURY := STARTS_WITH + OFFENSE_PERJURY + ENDS_WITH;
    EXPORT OBSTRUCTION_HINDER := STARTS_WITH + OFFENSE_OBSTRUCTION_HINDER_GENERAL + ENDS_WITH;
    EXPORT TAMPERING := STARTS_WITH + OFFENSE_TAMPERING + ENDS_WITH;
    
    EXPORT FORGE_AND_COUNTERFEIT := STARTS_WITH + OFFENSE_FORGE_COUNTERFEIT + ENDS_WITH;
    EXPORT ID_FRAUD_AND_THEFT := STARTS_WITH + OFFENSE_FRAUD_IDENTITY + ENDS_WITH;
    EXPORT FALSE_STATEMENT_OR_IMPERSONATION := STARTS_WITH + OFFENSE_FALSE_STATEMENT + ENDS_WITH;
    
    EXPORT EXTORTION_AND_BLACKMAIL := STARTS_WITH + OFFENSE_EXTORTION + ENDS_WITH;
    EXPORT CHOP_SHOP := STARTS_WITH + OFFENSE_CHOP_SHOP + ENDS_WITH;
    EXPORT BANK_ROBBERY := STARTS_WITH + OFFENSE_BANK_ROBBERY + ENDS_WITH;
    EXPORT ARMED_ROBBERY := STARTS_WITH + OFFENSE_ARM_ROBBERY + ENDS_WITH;
    EXPORT ROBBERY := STARTS_WITH + OFFENSE_ROBBERY + ENDS_WITH;
    EXPORT DEADLY_CONDUCT := STARTS_WITH + OFFENSE_DEADLY_CONDUCT + ENDS_WITH;
    EXPORT ASSAULT := STARTS_WITH + OFFENSE_ASSULT_COMBINED + ENDS_WITH;
    EXPORT RESIST_ARREST_OR_ESCAPE := STARTS_WITH + OFFENSE_RESIST_ESCAPE + ENDS_WITH;
    EXPORT DIGITAL_CURRENCY := STARTS_WITH + OFFENSE_DIGITAL_CURRENCY + ENDS_WITH;
    
    EXPORT ANTITRUST_VIOLATIONS := STARTS_WITH + OFFENSE_ANTITRUST_VIOLATIONS + ENDS_WITH;
    EXPORT SECURITIES_AND_COMMODITIES := STARTS_WITH + OFFENSE_SECURITIES_COMMODITIES_BROKERS + ENDS_WITH;
    EXPORT RACKETEERING := STARTS_WITH + OFFENSE_RACKETEERING + ENDS_WITH;
    EXPORT MONEY_TRANSMITTER := STARTS_WITH + OFFENSE_MONEY_TRANSMITTER + ENDS_WITH;
    EXPORT STRUCTURING := STARTS_WITH + OFFENSE_STRUCTURING + ENDS_WITH;
    
    EXPORT IMPORT_EXPORT_OFFENSES := STARTS_WITH + OFFENSE_EXPORT_IMPORT + ENDS_WITH;
    EXPORT TRANSPORTATION_VIOLATIONS := STARTS_WITH + OFFENSE_TRANSPORT_PROCEEDS + ENDS_WITH;
    EXPORT COMMUNICATION_INTERCEPTION := STARTS_WITH + OFFENSE_COMMUNICATION_INTERCEPTION + ENDS_WITH;
    EXPORT OPERATE_WITHOUT_LICENSE := STARTS_WITH + OFFENSE_OPERATE_NO_LICENSE + ENDS_WITH;
    EXPORT EMBEZZLE_MISAPPROPRIATE_MISMANAGE_FUNDS := STARTS_WITH + OFFENSE_MISSAPPROP_EMBEZZLE + ENDS_WITH;
    EXPORT TAX_OFFENSES := STARTS_WITH + OFFENSE_TAX_GENERAL + ENDS_WITH;
    EXPORT CONCEAL_FUNDS_OR_PROPERTY := STARTS_WITH + OFFENSE_CONCEAL_FUNDS + ENDS_WITH;
    EXPORT OBTAIN_PROPERTY_BY_FALSE_PRETENSE := STARTS_WITH + OFFENSE_OBTAIN_PROPERTY + ENDS_WITH;
    EXPORT DAMAGE_AND_DESTROY := STARTS_WITH + OFFENSE_GENERAL_DAMAGE_DESTROY + ENDS_WITH;
    EXPORT SHOPLIFTING := STARTS_WITH + OFFENSE_SHOPLIFTING + ENDS_WITH;
    EXPORT TRESPASSING := STARTS_WITH + OFFENSE_TRESPASSING + ENDS_WITH;
    
    EXPORT CRIMINAL_PROCEEDS := STARTS_WITH + OFFENSE_CRIMINAL_PROCEED + ENDS_WITH;
    EXPORT HUMAN_TRAFFICKING_SMUGGLING := STARTS_WITH + OFFENSE_TRAFFICKING_HUMANS + ENDS_WITH;
    EXPORT DRUG_TRAFFICKING_SMUGGLING := STARTS_WITH + OFFENSE_TRAFFICKING_DRUGS + ENDS_WITH;
    EXPORT ARMS_TRAFFICKING_SMUGGLING := STARTS_WITH + OFFENSE_TRAFFICKING_ARMS + ENDS_WITH;
    EXPORT OTHER_TRAFFICKING_SMUGGLING := STARTS_WITH + OFFENSE_TRAFFICKING_GENERAL + ENDS_WITH;
    EXPORT EXPLOSIVES_DEVICES := STARTS_WITH + OFFENSE_EXPLOSIVES + ENDS_WITH;
    EXPORT WEAPONS := STARTS_WITH + OFFENSE_WEAPONS + ENDS_WITH;
    EXPORT DRUGS := STARTS_WITH + OFFENSE_DRUGS + ENDS_WITH;
    EXPORT IMMIGRATION_ALIEN := STARTS_WITH + OFFENSE_ALIEN_IMMIGRATION + ENDS_WITH;
    EXPORT MANUFACTURE_DISTRIBUTE_DRUGS_WEAPONS := STARTS_WITH + OFFENSE_MANU_DIST_DRUGS_AND_WEAPONS + ENDS_WITH;
		
END;