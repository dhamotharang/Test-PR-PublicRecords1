﻿EXPORT Model1_Score1_Tree4(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_4_Node_78 := IF ( le.p_age_in_years < 18.8575,227,228);
        Tree_4_Node_42 := IF ( le.p_EstimatedAnnualIncome < 23750.5,Tree_4_Node_78,198);
        Tree_4_Node_80 := CHOOSE ( le.p_readmit_lift,230,229,230,229,229,229,229,230,229,229,229,229,229);
        Tree_4_Node_81 := IF ( le.p_StatusMostRecent < 1.5,231,232);
        Tree_4_Node_43 := CHOOSE ( le.p_financial_class,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_81,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_81,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80,Tree_4_Node_80);
        Tree_4_Node_23 := IF ( le.p_age_in_years < 41.1029,Tree_4_Node_42,Tree_4_Node_43);
        Tree_4_Node_11 := IF ( le.p_age_in_years < 0.853125,188,Tree_4_Node_23);
        Tree_4_Node_72 := IF ( le.p_RelativesPropOwnedCount < 0.5,221,222);
        Tree_4_Node_39 := IF ( le.p_IdentityRiskLevel < 3.5,Tree_4_Node_72,195);
        Tree_4_Node_70 := CHOOSE ( le.p_gender,219,220);
        Tree_4_Node_38 := IF ( le.p_SubjectLastNameCount < 4.5,Tree_4_Node_70,194);
        Tree_4_Node_20 := CHOOSE ( le.p_readmit_lift,Tree_4_Node_39,Tree_4_Node_38,Tree_4_Node_39,Tree_4_Node_38,Tree_4_Node_38,Tree_4_Node_38,Tree_4_Node_38,Tree_4_Node_38,Tree_4_Node_38,Tree_4_Node_38,Tree_4_Node_38,Tree_4_Node_39,Tree_4_Node_39);
        Tree_4_Node_40 := CHOOSE ( le.p_admit_diag,197,197,196,197,197,196,197,197,197,197,197,197,197);
        Tree_4_Node_76 := IF ( le.p_age_in_years < 5.46,223,224);
        Tree_4_Node_77 := CHOOSE ( le.p_admit_diag,225,226,226,226,226,226,226,226,226,226,226,226,226);
        Tree_4_Node_41 := CHOOSE ( le.p_readmit_lift,Tree_4_Node_76,Tree_4_Node_77,Tree_4_Node_76,Tree_4_Node_76,Tree_4_Node_76,Tree_4_Node_77,Tree_4_Node_76,Tree_4_Node_76,Tree_4_Node_76,Tree_4_Node_76,Tree_4_Node_77,Tree_4_Node_77,Tree_4_Node_77);
        Tree_4_Node_21 := CHOOSE ( le.p_readmit_diag,Tree_4_Node_40,Tree_4_Node_40,Tree_4_Node_41,Tree_4_Node_40,Tree_4_Node_41,Tree_4_Node_41,Tree_4_Node_40,Tree_4_Node_40,Tree_4_Node_40,Tree_4_Node_40,Tree_4_Node_40,Tree_4_Node_40,Tree_4_Node_40);
        Tree_4_Node_10 := CHOOSE ( le.p_financial_class,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_21,Tree_4_Node_20,Tree_4_Node_20,Tree_4_Node_21,Tree_4_Node_20,Tree_4_Node_20);
        Tree_4_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_4_Node_11,Tree_4_Node_10,Tree_4_Node_10,Tree_4_Node_11,Tree_4_Node_10,Tree_4_Node_10,Tree_4_Node_11,Tree_4_Node_11,Tree_4_Node_11,Tree_4_Node_10,Tree_4_Node_11,Tree_4_Node_10,Tree_4_Node_10);
        Tree_4_Node_64 := CHOOSE ( le.p_readmit_diag,211,211,211,211,211,211,211,212,212,211,211,211,212);
        Tree_4_Node_34 := CHOOSE ( le.p_financial_class,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,192,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64,Tree_4_Node_64);
        Tree_4_Node_17 := IF ( le.p_age_in_years < 8.397949,Tree_4_Node_34,189);
        Tree_4_Node_60 := IF ( le.p_age_in_years < 9.717627,205,206);
        Tree_4_Node_61 := IF ( le.p_SSNLowIssueAge < 30.0,207,208);
        Tree_4_Node_32 := IF ( le.p_age_in_years < 10.797363,Tree_4_Node_60,Tree_4_Node_61);
        Tree_4_Node_62 := IF ( le.p_SSNLowIssueAge < 53.5,209,210);
        Tree_4_Node_33 := IF ( le.p_age_in_years < 0.7998047,Tree_4_Node_62,191);
        Tree_4_Node_16 := CHOOSE ( le.p_readmit_diag,Tree_4_Node_32,Tree_4_Node_32,Tree_4_Node_32,Tree_4_Node_33,Tree_4_Node_32,Tree_4_Node_32,Tree_4_Node_33,Tree_4_Node_32,Tree_4_Node_32,Tree_4_Node_32,Tree_4_Node_32,Tree_4_Node_32,Tree_4_Node_32);
        Tree_4_Node_8 := CHOOSE ( le.p_readmit_diag,Tree_4_Node_17,Tree_4_Node_16,Tree_4_Node_16,Tree_4_Node_16,Tree_4_Node_17,Tree_4_Node_17,Tree_4_Node_16,Tree_4_Node_17,Tree_4_Node_17,Tree_4_Node_17,Tree_4_Node_17,Tree_4_Node_17,Tree_4_Node_17);
        Tree_4_Node_66 := IF ( le.p_BPV_4 < -2.02811,213,214);
        Tree_4_Node_67 := IF ( le.p_PrevAddrCarTheftIndex < 89.5,215,216);
        Tree_4_Node_36 := IF ( le.p_CurrAddrAVMValue12 < 235094.5,Tree_4_Node_66,Tree_4_Node_67);
        Tree_4_Node_68 := CHOOSE ( le.p_financial_class,218,217,217,218,218,218,218,218,217,218,217,218,217,217,218,218);
        Tree_4_Node_37 := CHOOSE ( le.p_readmit_diag,Tree_4_Node_68,Tree_4_Node_68,Tree_4_Node_68,Tree_4_Node_68,193,193,193,193,Tree_4_Node_68,193,Tree_4_Node_68,193,193);
        Tree_4_Node_18 := IF ( le.p_SSNIssueState < 37.5,Tree_4_Node_36,Tree_4_Node_37);
        Tree_4_Node_9 := IF ( le.p_PrevAddrLenOfRes < 338.5,Tree_4_Node_18,187);
        Tree_4_Node_4 := IF ( le.p_age_in_years < 12.796875,Tree_4_Node_8,Tree_4_Node_9);
        Tree_4_Node_2 := CHOOSE ( le.p_admit_diag,Tree_4_Node_5,Tree_4_Node_4,Tree_4_Node_5,Tree_4_Node_4,Tree_4_Node_5,Tree_4_Node_5,Tree_4_Node_4,Tree_4_Node_4,Tree_4_Node_4,Tree_4_Node_5,Tree_4_Node_4,Tree_4_Node_4,Tree_4_Node_5);
        Tree_4_Node_96 := IF ( le.p_BPV_3 < 1.79688,257,258);
        Tree_4_Node_97 := CHOOSE ( le.p_financial_class,259,259,259,259,259,259,260,259,259,260,259,260,260,259,259,259);
        Tree_4_Node_52 := IF ( le.p_age_in_years < 46.34,Tree_4_Node_96,Tree_4_Node_97);
        Tree_4_Node_98 := IF ( le.p_SSNLowIssueAge < 383.5,261,262);
        Tree_4_Node_99 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 3.5,263,264);
        Tree_4_Node_53 := IF ( le.p_PrevAddrAgeNewestRecord < 101.5,Tree_4_Node_98,Tree_4_Node_99);
        Tree_4_Node_28 := CHOOSE ( le.p_readmit_lift,Tree_4_Node_52,Tree_4_Node_52,Tree_4_Node_52,Tree_4_Node_53,Tree_4_Node_53,Tree_4_Node_53,Tree_4_Node_52,Tree_4_Node_53,Tree_4_Node_53,Tree_4_Node_52,Tree_4_Node_52,Tree_4_Node_52,Tree_4_Node_53);
        Tree_4_Node_100 := IF ( le.p_SearchUnverifiedSSNCountYear < 1.5,265,266);
        Tree_4_Node_101 := IF ( le.p_BP_3 < 2.5,267,268);
        Tree_4_Node_54 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_4_Node_100,Tree_4_Node_101);
        Tree_4_Node_102 := CHOOSE ( le.p_readmit_lift,269,269,269,270,269,269,270,269,269,269,269,269,269);
        Tree_4_Node_103 := IF ( le.p_SSNIdentitiesCount < 1.5,271,272);
        Tree_4_Node_55 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 63.5,Tree_4_Node_102,Tree_4_Node_103);
        Tree_4_Node_29 := CHOOSE ( le.p_readmit_lift,Tree_4_Node_54,Tree_4_Node_54,Tree_4_Node_54,Tree_4_Node_55,Tree_4_Node_54,Tree_4_Node_55,Tree_4_Node_55,Tree_4_Node_55,Tree_4_Node_54,Tree_4_Node_54,Tree_4_Node_54,Tree_4_Node_54,Tree_4_Node_54);
        Tree_4_Node_14 := CHOOSE ( le.p_financial_class,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_29,Tree_4_Node_28,Tree_4_Node_29,Tree_4_Node_28,Tree_4_Node_28,Tree_4_Node_29,Tree_4_Node_29,Tree_4_Node_29);
        Tree_4_Node_105 := IF ( le.p_BPV_2 < 3.578485,275,276);
        Tree_4_Node_104 := IF ( le.p_PrevAddrMedianValue < 49999.5,273,274);
        Tree_4_Node_56 := CHOOSE ( le.p_financial_class,Tree_4_Node_105,Tree_4_Node_104,Tree_4_Node_104,Tree_4_Node_104,Tree_4_Node_105,Tree_4_Node_104,Tree_4_Node_105,Tree_4_Node_104,Tree_4_Node_105,Tree_4_Node_104,Tree_4_Node_105,Tree_4_Node_104,Tree_4_Node_104,Tree_4_Node_105,Tree_4_Node_104,Tree_4_Node_104);
        Tree_4_Node_106 := IF ( le.p_CurrAddrMurderIndex < 119.5,277,278);
        Tree_4_Node_57 := IF ( le.p_BPV_2 < 2.9930031,Tree_4_Node_106,201);
        Tree_4_Node_30 := CHOOSE ( le.p_readmit_lift,Tree_4_Node_56,Tree_4_Node_56,Tree_4_Node_56,Tree_4_Node_57,Tree_4_Node_57,Tree_4_Node_56,Tree_4_Node_57,Tree_4_Node_56,Tree_4_Node_56,Tree_4_Node_57,Tree_4_Node_57,Tree_4_Node_57,Tree_4_Node_56);
        Tree_4_Node_58 := IF ( le.p_AssocRiskLevel < 3.5,202,203);
        Tree_4_Node_110 := CHOOSE ( le.p_readmit_diag,279,280,279,280,279,280,280,280,280,279,280,280,280);
        Tree_4_Node_59 := IF ( le.p_SSNHighIssueAge < 592.5,Tree_4_Node_110,204);
        Tree_4_Node_31 := CHOOSE ( le.p_financial_class,Tree_4_Node_58,Tree_4_Node_59,Tree_4_Node_58,Tree_4_Node_58,Tree_4_Node_58,Tree_4_Node_58,Tree_4_Node_59,Tree_4_Node_58,Tree_4_Node_59,Tree_4_Node_58,Tree_4_Node_58,Tree_4_Node_58,Tree_4_Node_58,Tree_4_Node_59,Tree_4_Node_58,Tree_4_Node_58);
        Tree_4_Node_15 := IF ( le.p_BPV_3 < 2.3864813,Tree_4_Node_30,Tree_4_Node_31);
        Tree_4_Node_7 := IF ( le.p_BP_2 < 0.5,Tree_4_Node_14,Tree_4_Node_15);
        Tree_4_Node_82 := IF ( le.p_BP_1 < 1.5,233,234);
        Tree_4_Node_83 := CHOOSE ( le.p_admit_diag,236,236,236,236,236,235,235,236,236,235,235,236,236);
        Tree_4_Node_44 := IF ( le.p_v1_ProspectAge < 35.0,Tree_4_Node_82,Tree_4_Node_83);
        Tree_4_Node_84 := CHOOSE ( le.p_readmit_diag,237,237,238,237,237,237,237,237,238,237,237,237,237);
        Tree_4_Node_85 := IF ( le.p_BPV_3 < 2.02149,239,240);
        Tree_4_Node_45 := IF ( le.p_age_in_years < 44.47531,Tree_4_Node_84,Tree_4_Node_85);
        Tree_4_Node_24 := CHOOSE ( le.p_admit_diag,Tree_4_Node_44,Tree_4_Node_45,Tree_4_Node_44,Tree_4_Node_44,Tree_4_Node_44,Tree_4_Node_44,Tree_4_Node_44,Tree_4_Node_44,Tree_4_Node_45,Tree_4_Node_44,Tree_4_Node_44,Tree_4_Node_45,Tree_4_Node_44);
        Tree_4_Node_86 := CHOOSE ( le.p_readmit_diag,241,241,241,241,241,241,241,242,242,241,242,242,241);
        Tree_4_Node_87 := IF ( le.p_age_in_years < 81.245,243,244);
        Tree_4_Node_46 := IF ( le.p_BPV_3 < 2.1057189,Tree_4_Node_86,Tree_4_Node_87);
        Tree_4_Node_88 := IF ( le.p_age_in_years < 38.3435,245,246);
        Tree_4_Node_89 := IF ( le.p_CurrAddrCarTheftIndex < 49.5,247,248);
        Tree_4_Node_47 := CHOOSE ( le.p_readmit_diag,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_89,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88,Tree_4_Node_88);
        Tree_4_Node_25 := CHOOSE ( le.p_admit_diag,Tree_4_Node_46,Tree_4_Node_47,Tree_4_Node_46,Tree_4_Node_47,Tree_4_Node_46,Tree_4_Node_46,Tree_4_Node_46,Tree_4_Node_46,Tree_4_Node_46,Tree_4_Node_47,Tree_4_Node_46,Tree_4_Node_47,Tree_4_Node_46);
        Tree_4_Node_12 := CHOOSE ( le.p_financial_class,Tree_4_Node_24,Tree_4_Node_24,Tree_4_Node_24,Tree_4_Node_24,Tree_4_Node_24,Tree_4_Node_24,Tree_4_Node_24,Tree_4_Node_25,Tree_4_Node_25,Tree_4_Node_24,Tree_4_Node_25,Tree_4_Node_24,Tree_4_Node_24,Tree_4_Node_25,Tree_4_Node_25,Tree_4_Node_24);
        Tree_4_Node_92 := IF ( le.p_CurrAddrBurglaryIndex < 190.5,251,252);
        Tree_4_Node_93 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 240.5,253,254);
        Tree_4_Node_49 := IF ( le.p_StatusMostRecent < 2.5,Tree_4_Node_92,Tree_4_Node_93);
        Tree_4_Node_90 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 1.5,249,250);
        Tree_4_Node_48 := CHOOSE ( le.p_readmit_diag,Tree_4_Node_90,Tree_4_Node_90,Tree_4_Node_90,Tree_4_Node_90,199,199,Tree_4_Node_90,199,Tree_4_Node_90,Tree_4_Node_90,199,Tree_4_Node_90,Tree_4_Node_90);
        Tree_4_Node_26 := CHOOSE ( le.p_financial_class,Tree_4_Node_49,Tree_4_Node_48,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_48,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49,Tree_4_Node_49);
        Tree_4_Node_94 := CHOOSE ( le.p_financial_class,256,255,255,255,255,256,255,255,255,256,255,255,255,256,255,255);
        Tree_4_Node_51 := IF ( le.p_BP_2 < 2.5,Tree_4_Node_94,200);
        Tree_4_Node_27 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 2.5,190,Tree_4_Node_51);
        Tree_4_Node_13 := IF ( le.p_BPV_2 < 3.1034014,Tree_4_Node_26,Tree_4_Node_27);
        Tree_4_Node_6 := IF ( le.p_BPV_2 < 2.0865195,Tree_4_Node_12,Tree_4_Node_13);
        Tree_4_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_4_Node_7,Tree_4_Node_6,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7,Tree_4_Node_7);
        Tree_4_Node_1 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.0546875,Tree_4_Node_2,Tree_4_Node_3);
    UNSIGNED2 Score1_Tree4_node := Tree_4_Node_1;
    REAL8 Score1_Tree4_score := CASE(Score1_Tree4_node,256=>0.20992638,257=>-0.02634152,258=>0.07521046,259=>0.006128374,260=>0.033342622,261=>-0.005077565,262=>0.08090876,263=>0.102287315,264=>0.22625291,265=>0.05700543,266=>0.24087666,267=>0.03279737,268=>0.23440501,269=>0.048352893,270=>0.14272898,271=>0.08577989,272=>0.21362326,273=>0.11772293,274=>0.006717784,275=>0.09263211,276=>0.19489318,277=>0.07101968,278=>0.20199086,279=>0.18775289,280=>0.2974985,187=>0.061944492,188=>0.20062041,189=>0.039774776,190=>0.2843106,191=>-0.0032968807,192=>0.033619326,193=>-0.06147344,194=>0.0101972,195=>0.10771571,196=>-0.10662118,197=>-0.029214725,198=>-0.0775033,199=>0.11043059,200=>0.24624796,201=>0.24037455,202=>0.17988427,203=>0.012689315,204=>0.096819185,205=>-0.10523628,206=>-0.10534228,207=>-0.10599854,208=>-0.10602148,209=>-0.089811996,210=>-0.014682623,211=>-0.10681876,212=>-0.023962231,213=>-0.04714973,214=>-0.10650922,215=>-0.053038124,216=>0.1376805,217=>-0.10586631,218=>-0.105555736,219=>-0.09961835,220=>-0.053642303,221=>-8.808332E-4,222=>-0.10624062,223=>-0.02640393,224=>0.06002035,225=>0.03801492,226=>0.2134503,227=>0.05483459,228=>0.20696121,229=>-0.1063656,230=>-0.010716868,231=>0.1262082,232=>-0.05096234,233=>-0.024529688,234=>0.21532854,235=>-0.07367625,236=>-0.041675024,237=>-0.03987032,238=>0.06110156,239=>-0.008421053,240=>0.07531955,241=>-0.019524438,242=>0.017240873,243=>0.04361082,244=>0.25904146,245=>-0.02897912,246=>0.017153967,247=>0.23506556,248=>0.08060751,249=>-0.0036282684,250=>-0.08457718,251=>0.015261595,252=>0.2230615,253=>0.08062839,254=>0.31785965,255=>-0.028854104,0);
ENDMACRO;
