﻿EXPORT Model1_Score1_Tree5(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_5_Node_83 := IF ( le.p_age_in_years < 1.7915626,232,233);
        Tree_5_Node_44 := CHOOSE ( le.p_admit_diag,Tree_5_Node_83,202,202,202,202,202,202,202,202,202,202,202,202);
        Tree_5_Node_22 := CHOOSE ( le.p_readmit_lift,192,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44,Tree_5_Node_44);
        Tree_5_Node_85 := IF ( le.p_SubjectPhoneCount < 0.5,236,237);
        Tree_5_Node_84 := IF ( le.p_CurrAddrMedianValue < 49999.5,234,235);
        Tree_5_Node_46 := CHOOSE ( le.p_readmit_lift,Tree_5_Node_85,Tree_5_Node_84,Tree_5_Node_85,Tree_5_Node_85,Tree_5_Node_85,Tree_5_Node_85,Tree_5_Node_85,Tree_5_Node_85,Tree_5_Node_84,Tree_5_Node_85,Tree_5_Node_85,Tree_5_Node_84,Tree_5_Node_84);
        Tree_5_Node_23 := CHOOSE ( le.p_readmit_lift,Tree_5_Node_46,Tree_5_Node_46,Tree_5_Node_46,Tree_5_Node_46,Tree_5_Node_46,Tree_5_Node_46,193,193,Tree_5_Node_46,Tree_5_Node_46,193,Tree_5_Node_46,Tree_5_Node_46);
        Tree_5_Node_11 := IF ( le.p_age_in_years < 11.94375,Tree_5_Node_22,Tree_5_Node_23);
        Tree_5_Node_76 := CHOOSE ( le.p_readmit_lift,224,224,224,224,225,225,224,224,224,224,225,225,225);
        Tree_5_Node_77 := IF ( le.p_BPV_4 < -2.172975,226,227);
        Tree_5_Node_40 := IF ( le.p_StatusMostRecent < 2.5,Tree_5_Node_76,Tree_5_Node_77);
        Tree_5_Node_20 := IF ( le.p_PhoneEDAAgeOldestRecord < 122.0,Tree_5_Node_40,191);
        Tree_5_Node_78 := IF ( le.p_AddrChangeCount60 < 0.5,228,229);
        Tree_5_Node_79 := IF ( le.p_NonDerogCount < 8.5,230,231);
        Tree_5_Node_42 := CHOOSE ( le.p_financial_class,Tree_5_Node_78,Tree_5_Node_78,Tree_5_Node_79,Tree_5_Node_79,Tree_5_Node_79,Tree_5_Node_79,Tree_5_Node_79,Tree_5_Node_79,Tree_5_Node_79,Tree_5_Node_79,Tree_5_Node_78,Tree_5_Node_78,Tree_5_Node_79,Tree_5_Node_78,Tree_5_Node_79,Tree_5_Node_78);
        Tree_5_Node_43 := IF ( le.p_CurrAddrCarTheftIndex < 79.5,200,201);
        Tree_5_Node_21 := IF ( le.p_PrevAddrAgeLastSale < 47.5,Tree_5_Node_42,Tree_5_Node_43);
        Tree_5_Node_10 := IF ( le.p_AgeOldestRecord < 295.5,Tree_5_Node_20,Tree_5_Node_21);
        Tree_5_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_5_Node_11,Tree_5_Node_10,Tree_5_Node_10,Tree_5_Node_11,Tree_5_Node_10,Tree_5_Node_10,Tree_5_Node_11,Tree_5_Node_11,Tree_5_Node_11,Tree_5_Node_10,Tree_5_Node_11,Tree_5_Node_10,Tree_5_Node_10);
        Tree_5_Node_68 := CHOOSE ( le.p_admit_diag,212,212,212,212,212,212,212,212,213,213,213,213,212);
        Tree_5_Node_69 := CHOOSE ( le.p_readmit_lift,214,214,214,214,214,215,214,214,214,214,214,214,214);
        Tree_5_Node_34 := IF ( le.p_age_in_years < 1.0934937,Tree_5_Node_68,Tree_5_Node_69);
        Tree_5_Node_17 := IF ( le.p_age_in_years < 8.397949,Tree_5_Node_34,189);
        Tree_5_Node_64 := IF ( le.p_age_in_years < 9.717627,206,207);
        Tree_5_Node_65 := IF ( le.p_IDVerSSNCreditBureauCount < -0.5,208,209);
        Tree_5_Node_32 := IF ( le.p_age_in_years < 10.797363,Tree_5_Node_64,Tree_5_Node_65);
        Tree_5_Node_66 := IF ( le.p_SSNLowIssueAge < 26.0,210,211);
        Tree_5_Node_33 := IF ( le.p_age_in_years < 0.7998047,Tree_5_Node_66,197);
        Tree_5_Node_16 := CHOOSE ( le.p_admit_diag,Tree_5_Node_32,Tree_5_Node_32,Tree_5_Node_32,Tree_5_Node_33,Tree_5_Node_32,Tree_5_Node_32,Tree_5_Node_33,Tree_5_Node_32,Tree_5_Node_32,Tree_5_Node_32,Tree_5_Node_32,Tree_5_Node_32,Tree_5_Node_32);
        Tree_5_Node_8 := CHOOSE ( le.p_readmit_diag,Tree_5_Node_17,Tree_5_Node_16,Tree_5_Node_16,Tree_5_Node_16,Tree_5_Node_17,Tree_5_Node_17,Tree_5_Node_16,Tree_5_Node_17,Tree_5_Node_17,Tree_5_Node_17,Tree_5_Node_17,Tree_5_Node_17,Tree_5_Node_17);
        Tree_5_Node_72 := IF ( le.p_age_in_years < 20.447,218,219);
        Tree_5_Node_38 := IF ( le.p_NonDerogCount < 8.5,Tree_5_Node_72,199);
        Tree_5_Node_74 := IF ( le.p_RelativesBankruptcyCount < 0.5,220,221);
        Tree_5_Node_75 := IF ( le.p_DivSSNAddrMSourceCount < 4.5,222,223);
        Tree_5_Node_39 := IF ( le.p_NonDerogCount01 < 3.5,Tree_5_Node_74,Tree_5_Node_75);
        Tree_5_Node_19 := CHOOSE ( le.p_financial_class,Tree_5_Node_38,Tree_5_Node_39,Tree_5_Node_39,Tree_5_Node_38,Tree_5_Node_38,Tree_5_Node_38,Tree_5_Node_38,Tree_5_Node_38,Tree_5_Node_39,Tree_5_Node_38,Tree_5_Node_39,Tree_5_Node_38,Tree_5_Node_38,Tree_5_Node_39,Tree_5_Node_39,Tree_5_Node_38);
        Tree_5_Node_70 := IF ( le.p_CurrAddrCarTheftIndex < 58.5,216,217);
        Tree_5_Node_36 := IF ( le.p_SSNIssueState < 37.5,Tree_5_Node_70,198);
        Tree_5_Node_18 := CHOOSE ( le.p_financial_class,Tree_5_Node_36,190,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36,Tree_5_Node_36);
        Tree_5_Node_9 := CHOOSE ( le.p_readmit_diag,Tree_5_Node_19,Tree_5_Node_19,Tree_5_Node_19,Tree_5_Node_19,Tree_5_Node_18,Tree_5_Node_18,Tree_5_Node_19,Tree_5_Node_18,Tree_5_Node_19,Tree_5_Node_18,Tree_5_Node_18,Tree_5_Node_18,Tree_5_Node_18);
        Tree_5_Node_4 := IF ( le.p_age_in_years < 12.796875,Tree_5_Node_8,Tree_5_Node_9);
        Tree_5_Node_2 := CHOOSE ( le.p_admit_diag,Tree_5_Node_5,Tree_5_Node_4,Tree_5_Node_5,Tree_5_Node_4,Tree_5_Node_5,Tree_5_Node_5,Tree_5_Node_4,Tree_5_Node_4,Tree_5_Node_4,Tree_5_Node_5,Tree_5_Node_4,Tree_5_Node_4,Tree_5_Node_5);
        Tree_5_Node_100 := CHOOSE ( le.p_financial_class,264,264,264,264,264,264,264,264,264,265,264,264,265,264,264,264);
        Tree_5_Node_101 := IF ( le.p_BP_1 < 0.5,266,267);
        Tree_5_Node_56 := IF ( le.p_age_in_years < 43.03,Tree_5_Node_100,Tree_5_Node_101);
        Tree_5_Node_102 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,268,269);
        Tree_5_Node_57 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 5.5,Tree_5_Node_102,204);
        Tree_5_Node_28 := CHOOSE ( le.p_readmit_lift,Tree_5_Node_56,Tree_5_Node_57,Tree_5_Node_56,Tree_5_Node_57,Tree_5_Node_57,Tree_5_Node_57,Tree_5_Node_57,Tree_5_Node_57,Tree_5_Node_56,Tree_5_Node_56,Tree_5_Node_57,Tree_5_Node_57,Tree_5_Node_57);
        Tree_5_Node_106 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,274,275);
        Tree_5_Node_59 := IF ( le.p_BP_3 < 2.5,Tree_5_Node_106,205);
        Tree_5_Node_104 := IF ( le.p_EstimatedAnnualIncome < 66400.5,270,271);
        Tree_5_Node_105 := CHOOSE ( le.p_readmit_diag,273,272,273,273,272,273,272,273,273,272,273,272,273);
        Tree_5_Node_58 := IF ( le.p_BPV_3 < 2.3864813,Tree_5_Node_104,Tree_5_Node_105);
        Tree_5_Node_29 := CHOOSE ( le.p_readmit_lift,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_58,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59,Tree_5_Node_59);
        Tree_5_Node_14 := CHOOSE ( le.p_financial_class,Tree_5_Node_28,Tree_5_Node_28,Tree_5_Node_28,Tree_5_Node_28,Tree_5_Node_28,Tree_5_Node_28,Tree_5_Node_29,Tree_5_Node_28,Tree_5_Node_29,Tree_5_Node_28,Tree_5_Node_29,Tree_5_Node_28,Tree_5_Node_28,Tree_5_Node_29,Tree_5_Node_29,Tree_5_Node_29);
        Tree_5_Node_108 := CHOOSE ( le.p_financial_class,277,276,276,276,277,276,277,276,277,276,277,276,276,277,276,276);
        Tree_5_Node_109 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.8433332,278,279);
        Tree_5_Node_60 := CHOOSE ( le.p_readmit_lift,Tree_5_Node_108,Tree_5_Node_108,Tree_5_Node_108,Tree_5_Node_109,Tree_5_Node_109,Tree_5_Node_108,Tree_5_Node_109,Tree_5_Node_108,Tree_5_Node_108,Tree_5_Node_109,Tree_5_Node_109,Tree_5_Node_109,Tree_5_Node_108);
        Tree_5_Node_110 := CHOOSE ( le.p_readmit_lift,280,280,280,281,280,280,281,280,281,280,281,281,280);
        Tree_5_Node_111 := IF ( le.p_CurrAddrBurglaryIndex < 139.5,282,283);
        Tree_5_Node_61 := CHOOSE ( le.p_readmit_diag,Tree_5_Node_110,Tree_5_Node_111,Tree_5_Node_110,Tree_5_Node_110,Tree_5_Node_110,Tree_5_Node_110,Tree_5_Node_111,Tree_5_Node_110,Tree_5_Node_110,Tree_5_Node_111,Tree_5_Node_111,Tree_5_Node_110,Tree_5_Node_111);
        Tree_5_Node_30 := IF ( le.p_BPV_3 < 2.3864813,Tree_5_Node_60,Tree_5_Node_61);
        Tree_5_Node_31 := CHOOSE ( le.p_readmit_diag,195,196,195,196,196,196,196,195,196,195,196,195,196);
        Tree_5_Node_15 := IF ( le.p_BP_2 < 5.5,Tree_5_Node_30,Tree_5_Node_31);
        Tree_5_Node_7 := IF ( le.p_BP_2 < 0.5,Tree_5_Node_14,Tree_5_Node_15);
        Tree_5_Node_86 := IF ( le.p_PhoneOtherAgeNewestRecord < 106.5,238,239);
        Tree_5_Node_87 := IF ( le.p_v1_HHPropCurrOwnedCnt < 8.5,240,241);
        Tree_5_Node_48 := IF ( le.p_v1_ProspectAge < 35.0,Tree_5_Node_86,Tree_5_Node_87);
        Tree_5_Node_88 := CHOOSE ( le.p_readmit_diag,242,242,243,242,242,242,242,242,242,242,242,242,242);
        Tree_5_Node_89 := IF ( le.p_CurrAddrMurderIndex < 79.5,244,245);
        Tree_5_Node_49 := IF ( le.p_v1_ProspectAge < 41.0,Tree_5_Node_88,Tree_5_Node_89);
        Tree_5_Node_24 := CHOOSE ( le.p_admit_diag,Tree_5_Node_48,Tree_5_Node_49,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_48,Tree_5_Node_49,Tree_5_Node_48);
        Tree_5_Node_91 := CHOOSE ( le.p_admit_diag,249,249,248,249,248,248,248,248,249,248,248,249,248);
        Tree_5_Node_90 := IF ( le.p_AccidentAge < 92.5,246,247);
        Tree_5_Node_50 := CHOOSE ( le.p_patient_type,Tree_5_Node_91,Tree_5_Node_90);
        Tree_5_Node_92 := CHOOSE ( le.p_admit_diag,250,251,250,251,250,250,250,251,250,251,250,251,251);
        Tree_5_Node_93 := CHOOSE ( le.p_admit_diag,252,253,253,252,252,253,252,252,252,252,253,252,252);
        Tree_5_Node_51 := IF ( le.p_age_in_years < 78.54094,Tree_5_Node_92,Tree_5_Node_93);
        Tree_5_Node_25 := IF ( le.p_EstimatedAnnualIncome < 38718.5,Tree_5_Node_50,Tree_5_Node_51);
        Tree_5_Node_12 := CHOOSE ( le.p_financial_class,Tree_5_Node_24,Tree_5_Node_24,Tree_5_Node_24,Tree_5_Node_24,Tree_5_Node_24,Tree_5_Node_24,Tree_5_Node_24,Tree_5_Node_25,Tree_5_Node_25,Tree_5_Node_25,Tree_5_Node_25,Tree_5_Node_24,Tree_5_Node_24,Tree_5_Node_25,Tree_5_Node_25,Tree_5_Node_24);
        Tree_5_Node_96 := IF ( le.p_CurrAddrBurglaryIndex < 190.5,258,259);
        Tree_5_Node_97 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 240.5,260,261);
        Tree_5_Node_53 := IF ( le.p_StatusMostRecent < 2.5,Tree_5_Node_96,Tree_5_Node_97);
        Tree_5_Node_94 := CHOOSE ( le.p_admit_diag,254,255,255,255,255,254,254,254,254,254,255,254,254);
        Tree_5_Node_95 := IF ( le.p_VariationDOBCount < 2.5,256,257);
        Tree_5_Node_52 := CHOOSE ( le.p_readmit_diag,Tree_5_Node_94,Tree_5_Node_94,Tree_5_Node_94,Tree_5_Node_94,Tree_5_Node_95,Tree_5_Node_95,Tree_5_Node_94,Tree_5_Node_95,Tree_5_Node_94,Tree_5_Node_94,Tree_5_Node_95,Tree_5_Node_94,Tree_5_Node_94);
        Tree_5_Node_26 := CHOOSE ( le.p_financial_class,Tree_5_Node_53,Tree_5_Node_52,Tree_5_Node_53,Tree_5_Node_53,Tree_5_Node_53,Tree_5_Node_52,Tree_5_Node_52,Tree_5_Node_53,Tree_5_Node_53,Tree_5_Node_53,Tree_5_Node_53,Tree_5_Node_52,Tree_5_Node_53,Tree_5_Node_53,Tree_5_Node_53,Tree_5_Node_53);
        Tree_5_Node_98 := IF ( le.p_PrevAddrCrimeIndex < 119.5,262,263);
        Tree_5_Node_54 := IF ( le.p_BP_2 < 2.5,Tree_5_Node_98,203);
        Tree_5_Node_27 := IF ( le.p_BP_4 < 19.5,Tree_5_Node_54,194);
        Tree_5_Node_13 := IF ( le.p_BPV_2 < 3.1034014,Tree_5_Node_26,Tree_5_Node_27);
        Tree_5_Node_6 := IF ( le.p_BPV_2 < 2.0865195,Tree_5_Node_12,Tree_5_Node_13);
        Tree_5_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_5_Node_7,Tree_5_Node_6,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7,Tree_5_Node_7);
        Tree_5_Node_1 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.0546875,Tree_5_Node_2,Tree_5_Node_3);
    UNSIGNED2 Score1_Tree5_node := Tree_5_Node_1;
    REAL8 Score1_Tree5_score := CASE(Score1_Tree5_node,256=>-0.0215266,257=>0.2472569,258=>0.012741414,259=>0.19334888,260=>0.07183028,261=>0.2263726,262=>-0.045522634,263=>0.118993305,264=>-0.030984785,265=>0.12620392,266=>0.010261743,267=>0.105448276,268=>0.011373779,269=>0.08030071,270=>0.03007543,271=>-0.015090025,272=>-0.03978675,273=>0.169289,274=>0.06320832,275=>0.039619666,276=>0.021591377,277=>0.08058096,278=>0.09399868,279=>0.18915594,280=>0.087832175,281=>0.2068367,282=>0.16033559,283=>0.31315252,189=>0.0343123,190=>-0.068636276,191=>0.15255742,192=>0.15686812,193=>0.12395742,194=>0.27598593,195=>0.12635705,196=>0.2375338,197=>-0.0029525491,198=>-0.10399006,199=>-2.3033396E-4,200=>0.056814484,201=>-0.10514443,202=>-0.032634463,203=>0.19063185,204=>0.18503843,205=>0.19243328,206=>-0.10346931,207=>-0.1035632,208=>-0.10414314,209=>-0.104163416,210=>-0.08706902,211=>-0.023565715,212=>-0.037821945,213=>0.05778683,214=>-0.10433328,215=>-0.016968397,216=>-0.10491603,217=>-0.10437199,218=>-0.058542926,219=>-0.1044901,220=>-0.031631455,221=>-0.097062826,222=>0.18936284,223=>-0.049650535,224=>-0.014900768,225=>0.10520568,226=>-0.106507026,227=>-0.065741904,228=>-0.10523772,229=>-0.106054954,230=>-0.10461411,231=>-0.10382974,232=>0.13670273,233=>0.057345577,234=>-0.031567194,235=>-0.10454516,236=>-0.0027131469,237=>0.10904353,238=>-0.020157052,239=>0.17522901,240=>-0.04759768,241=>0.05779822,242=>-0.036868274,243=>0.05069155,244=>-0.018310213,245=>0.011455462,246=>-0.037064474,247=>0.101049736,248=>-0.006689972,249=>0.022147343,250=>-0.039406877,251=>-0.010376892,252=>-0.015683029,253=>0.020722471,254=>-0.09219231,255=>-0.006425717,0);
ENDMACRO;
