EXPORT Model1_Score1_Tree23(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_23_Node_68 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 8.5,207,208);
        Tree_23_Node_69 := CHOOSE ( le.p_readmit_diag,209,210,209,210,209,209,210,210,210,209,210,210,209);
        Tree_23_Node_38 := IF ( le.p_v1_ProspectTimeLastUpdate < 42.5,Tree_23_Node_68,Tree_23_Node_69);
        Tree_23_Node_70 := CHOOSE ( le.p_admit_diag,211,212,211,211,212,211,212,211,211,211,211,212,211);
        Tree_23_Node_71 := CHOOSE ( le.p_admit_diag,213,214,214,214,213,214,213,214,214,213,214,214,214);
        Tree_23_Node_39 := IF ( le.p_NonDerogCount06 < 2.5,Tree_23_Node_70,Tree_23_Node_71);
        Tree_23_Node_20 := IF ( le.p_DerogAge < 75.5,Tree_23_Node_38,Tree_23_Node_39);
        Tree_23_Node_74 := CHOOSE ( le.p_readmit_lift,218,218,218,217,218,218,218,217,218,217,217,217,218);
        Tree_23_Node_75 := CHOOSE ( le.p_financial_class,219,219,219,219,219,219,219,219,220,219,219,219,219,220,219,219);
        Tree_23_Node_41 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,Tree_23_Node_74,Tree_23_Node_75);
        Tree_23_Node_72 := IF ( le.p_SSNAddrCount < 16.5,215,216);
        Tree_23_Node_40 := IF ( le.p_BPV_2 < 2.4244,Tree_23_Node_72,182);
        Tree_23_Node_21 := CHOOSE ( le.p_readmit_diag,Tree_23_Node_41,Tree_23_Node_40,Tree_23_Node_41,Tree_23_Node_41,Tree_23_Node_40,Tree_23_Node_40,Tree_23_Node_41,Tree_23_Node_41,Tree_23_Node_40,Tree_23_Node_41,Tree_23_Node_41,Tree_23_Node_40,Tree_23_Node_40);
        Tree_23_Node_10 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,Tree_23_Node_20,Tree_23_Node_21);
        Tree_23_Node_5 := IF ( le.p_BP_2 < 2.5,Tree_23_Node_10,174);
        Tree_23_Node_54 := IF ( le.p_EvictionAge < 37.5,185,186);
        Tree_23_Node_55 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 107.5,187,188);
        Tree_23_Node_30 := IF ( le.p_v1_CrtRecLienJudgCnt < 1.5,Tree_23_Node_54,Tree_23_Node_55);
        Tree_23_Node_16 := IF ( le.p_v1_CrtRecTimeNewest < 202.5,Tree_23_Node_30,177);
        Tree_23_Node_56 := IF ( le.p_CurrAddrLenOfRes < 54.5,189,190);
        Tree_23_Node_57 := IF ( le.p_RecentActivityIndex < 1.5,191,192);
        Tree_23_Node_32 := IF ( le.p_P_EstimatedHHIncomePerCapita < 4.484375,Tree_23_Node_56,Tree_23_Node_57);
        Tree_23_Node_58 := IF ( le.p_v1_ProspectTimeLastUpdate < 11.5,193,194);
        Tree_23_Node_33 := CHOOSE ( le.p_admit_diag,Tree_23_Node_58,179,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58,Tree_23_Node_58);
        Tree_23_Node_17 := IF ( le.p_EstimatedAnnualIncome < 34781.5,Tree_23_Node_32,Tree_23_Node_33);
        Tree_23_Node_8 := CHOOSE ( le.p_readmit_diag,Tree_23_Node_16,Tree_23_Node_16,Tree_23_Node_17,Tree_23_Node_16,Tree_23_Node_17,Tree_23_Node_17,Tree_23_Node_17,Tree_23_Node_17,Tree_23_Node_17,Tree_23_Node_16,Tree_23_Node_16,Tree_23_Node_17,Tree_23_Node_16);
        Tree_23_Node_60 := CHOOSE ( le.p_readmit_diag,195,195,195,195,195,195,196,195,195,196,196,195,195);
        Tree_23_Node_61 := IF ( le.p_SubjectPhoneCount < 0.5,197,198);
        Tree_23_Node_34 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 0.5,Tree_23_Node_60,Tree_23_Node_61);
        Tree_23_Node_35 := IF ( le.p_AgeOldestRecord < 102.5,180,181);
        Tree_23_Node_18 := IF ( le.p_BPV_2 < 2.5201,Tree_23_Node_34,Tree_23_Node_35);
        Tree_23_Node_64 := CHOOSE ( le.p_readmit_diag,200,199,200,200,199,199,199,199,200,200,199,199,200);
        Tree_23_Node_65 := IF ( le.p_v1_ProspectTimeLastUpdate < 10.5,201,202);
        Tree_23_Node_36 := CHOOSE ( le.p_financial_class,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_65,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_65,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64,Tree_23_Node_64);
        Tree_23_Node_66 := IF ( le.p_AssocRiskLevel < 8.5,203,204);
        Tree_23_Node_67 := IF ( le.p_RelativesBankruptcyCount < 0.5,205,206);
        Tree_23_Node_37 := CHOOSE ( le.p_admit_diag,Tree_23_Node_66,Tree_23_Node_66,Tree_23_Node_67,Tree_23_Node_67,Tree_23_Node_66,Tree_23_Node_67,Tree_23_Node_66,Tree_23_Node_67,Tree_23_Node_66,Tree_23_Node_66,Tree_23_Node_66,Tree_23_Node_66,Tree_23_Node_66);
        Tree_23_Node_19 := CHOOSE ( le.p_readmit_lift,Tree_23_Node_36,Tree_23_Node_37,Tree_23_Node_36,Tree_23_Node_36,Tree_23_Node_36,Tree_23_Node_36,Tree_23_Node_37,Tree_23_Node_36,Tree_23_Node_37,Tree_23_Node_36,Tree_23_Node_36,Tree_23_Node_37,Tree_23_Node_37);
        Tree_23_Node_9 := IF ( le.p_SubjectAddrCount < 9.5,Tree_23_Node_18,Tree_23_Node_19);
        Tree_23_Node_4 := IF ( le.p_AddrChangeCount24 < 1.5,Tree_23_Node_8,Tree_23_Node_9);
        Tree_23_Node_2 := CHOOSE ( le.p_financial_class,Tree_23_Node_5,Tree_23_Node_5,Tree_23_Node_4,Tree_23_Node_4,Tree_23_Node_5,Tree_23_Node_4,Tree_23_Node_4,Tree_23_Node_4,Tree_23_Node_5,Tree_23_Node_5,Tree_23_Node_4,Tree_23_Node_4,Tree_23_Node_4,Tree_23_Node_5,Tree_23_Node_5,Tree_23_Node_4);
        Tree_23_Node_86 := CHOOSE ( le.p_admit_diag,239,239,240,239,239,240,240,239,240,240,239,239,240);
        Tree_23_Node_87 := IF ( le.p_CurrAddrCrimeIndex < 120.5,241,242);
        Tree_23_Node_48 := IF ( le.p_LienFiledAge < 243.5,Tree_23_Node_86,Tree_23_Node_87);
        Tree_23_Node_88 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.4861112,243,244);
        Tree_23_Node_89 := CHOOSE ( le.p_readmit_diag,245,246,245,245,245,245,246,246,246,246,245,245,246);
        Tree_23_Node_49 := IF ( le.p_CurrAddrMedianValue < 145595.5,Tree_23_Node_88,Tree_23_Node_89);
        Tree_23_Node_26 := IF ( le.p_v1_RaAPropOwnerAVMMed < 90897.5,Tree_23_Node_48,Tree_23_Node_49);
        Tree_23_Node_90 := IF ( le.p_BP_3 < 2.5,247,248);
        Tree_23_Node_91 := CHOOSE ( le.p_financial_class,249,250,249,249,249,249,249,249,249,249,250,249,249,250,249,249);
        Tree_23_Node_50 := IF ( le.p_SearchUnverifiedSSNCountYear < 1.5,Tree_23_Node_90,Tree_23_Node_91);
        Tree_23_Node_92 := CHOOSE ( le.p_readmit_diag,251,252,252,251,251,252,251,251,252,252,252,252,252);
        Tree_23_Node_93 := CHOOSE ( le.p_readmit_diag,254,254,254,253,254,254,254,254,253,253,254,253,254);
        Tree_23_Node_51 := IF ( le.p_v1_RaASeniorMmbrCnt < 1.5,Tree_23_Node_92,Tree_23_Node_93);
        Tree_23_Node_27 := IF ( le.p_BPV_1 < 2.896375,Tree_23_Node_50,Tree_23_Node_51);
        Tree_23_Node_14 := IF ( le.p_EstimatedAnnualIncome < 25937.5,Tree_23_Node_26,Tree_23_Node_27);
        Tree_23_Node_94 := IF ( le.p_CurrAddrAgeLastSale < 335.5,255,256);
        Tree_23_Node_52 := CHOOSE ( le.p_readmit_lift,Tree_23_Node_94,Tree_23_Node_94,Tree_23_Node_94,184,Tree_23_Node_94,Tree_23_Node_94,184,Tree_23_Node_94,184,184,Tree_23_Node_94,Tree_23_Node_94,Tree_23_Node_94);
        Tree_23_Node_97 := IF ( le.p_NonDerogCount60 < 5.5,259,260);
        Tree_23_Node_96 := IF ( le.p_age_in_years < 96.416,257,258);
        Tree_23_Node_53 := CHOOSE ( le.p_readmit_diag,Tree_23_Node_97,Tree_23_Node_97,Tree_23_Node_96,Tree_23_Node_97,Tree_23_Node_96,Tree_23_Node_96,Tree_23_Node_97,Tree_23_Node_97,Tree_23_Node_96,Tree_23_Node_96,Tree_23_Node_96,Tree_23_Node_96,Tree_23_Node_96);
        Tree_23_Node_28 := IF ( le.p_CurrAddrAgeOldestRecord < 207.5,Tree_23_Node_52,Tree_23_Node_53);
        Tree_23_Node_15 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 370.5,Tree_23_Node_28,176);
        Tree_23_Node_7 := IF ( le.p_age_in_years < 88.63252,Tree_23_Node_14,Tree_23_Node_15);
        Tree_23_Node_76 := IF ( le.p_PrevAddrMedianValue < 750000.5,221,222);
        Tree_23_Node_77 := CHOOSE ( le.p_readmit_diag,224,223,223,224,223,224,224,224,224,224,224,224,224);
        Tree_23_Node_42 := IF ( le.p_CurrAddrMurderIndex < 49.5,Tree_23_Node_76,Tree_23_Node_77);
        Tree_23_Node_78 := IF ( le.p_CurrAddrAgeLastSale < 154.0,225,226);
        Tree_23_Node_79 := CHOOSE ( le.p_admit_diag,227,227,227,227,227,227,227,227,227,228,227,227,228);
        Tree_23_Node_43 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,Tree_23_Node_78,Tree_23_Node_79);
        Tree_23_Node_22 := IF ( le.p_SSNIssueState < 45.5,Tree_23_Node_42,Tree_23_Node_43);
        Tree_23_Node_12 := IF ( le.p_BPV_2 < 3.6988301,Tree_23_Node_22,175);
        Tree_23_Node_80 := IF ( le.p_v1_ProspectTimeLastUpdate < 35.5,229,230);
        Tree_23_Node_81 := IF ( le.p_PrevAddrMedianIncome < 179227.5,231,232);
        Tree_23_Node_44 := IF ( le.p_PrevAddrMedianValue < 376952.5,Tree_23_Node_80,Tree_23_Node_81);
        Tree_23_Node_82 := IF ( le.p_SSNAddrRecentCount < 0.5,233,234);
        Tree_23_Node_83 := IF ( le.p_PrevAddrBurglaryIndex < 89.5,235,236);
        Tree_23_Node_45 := IF ( le.p_WealthIndex < 5.5,Tree_23_Node_82,Tree_23_Node_83);
        Tree_23_Node_24 := IF ( le.p_LastNameChangeAge < 384.5,Tree_23_Node_44,Tree_23_Node_45);
        Tree_23_Node_84 := IF ( le.p_NonDerogCount01 < 2.5,237,238);
        Tree_23_Node_46 := IF ( le.p_EstimatedAnnualIncome < 51359.5,Tree_23_Node_84,183);
        Tree_23_Node_25 := CHOOSE ( le.p_financial_class,178,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,178,178,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46,Tree_23_Node_46);
        Tree_23_Node_13 := IF ( le.p_BPV_2 < 2.8073173,Tree_23_Node_24,Tree_23_Node_25);
        Tree_23_Node_6 := CHOOSE ( le.p_admit_diag,Tree_23_Node_12,Tree_23_Node_13,Tree_23_Node_12,Tree_23_Node_13,Tree_23_Node_12,Tree_23_Node_12,Tree_23_Node_12,Tree_23_Node_12,Tree_23_Node_12,Tree_23_Node_12,Tree_23_Node_12,Tree_23_Node_13,Tree_23_Node_12);
        Tree_23_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_23_Node_7,Tree_23_Node_6,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7,Tree_23_Node_7);
        Tree_23_Node_1 := IF ( le.p_age_in_years < 41.696484,Tree_23_Node_2,Tree_23_Node_3);
    UNSIGNED2 Score1_Tree23_node := Tree_23_Node_1;
    REAL8 Score1_Tree23_score := CASE(Score1_Tree23_node,256=>0.1077445,257=>-0.034681,258=>0.07637277,259=>-0.004597413,260=>0.0420715,174=>0.0955594,175=>0.07452908,176=>0.07854865,177=>0.1130338,178=>0.10730903,179=>0.059466124,180=>-0.04130455,181=>0.12165865,182=>0.06533668,183=>-0.045140076,184=>0.073353365,185=>-0.030449685,186=>0.026269384,187=>-0.07440682,188=>-0.0052893925,189=>0.020408612,190=>-0.023185289,191=>-0.03454314,192=>0.09347194,193=>-0.06766939,194=>-0.0019775818,195=>-0.05613925,196=>0.057429247,197=>-0.0025937154,198=>0.101179644,199=>-0.10180667,200=>-0.05811693,201=>-0.090246946,202=>0.013138054,203=>-0.060409445,204=>0.03198762,205=>-0.090336435,206=>0.033422694,207=>-0.011329267,208=>-0.06605057,209=>-0.038674314,210=>0.12863351,211=>-0.07105377,212=>0.1204175,213=>-0.09417785,214=>-0.06500597,215=>-0.02160545,216=>0.050047465,217=>-0.081893586,218=>0.09984176,219=>0.0011033439,220=>0.050442476,221=>-0.02201216,222=>0.117952056,223=>-0.012812867,224=>0.0018168807,225=>0.026237901,226=>0.12874812,227=>-0.021089388,228=>0.13935305,229=>0.0022382096,230=>0.01735834,231=>-0.026935924,232=>0.08070756,233=>-0.018294904,234=>0.061007805,235=>0.13124335,236=>-0.036439005,237=>-0.045618586,238=>0.05553282,239=>-0.005525013,240=>0.029562479,241=>0.17320617,242=>0.033797186,243=>0.029911203,244=>0.09504852,245=>-0.032640565,246=>0.06208001,247=>0.00564573,248=>0.045396674,249=>-0.052485406,250=>0.12788053,251=>0.02091988,252=>0.07475647,253=>-0.065189436,254=>0.018655812,255=>-0.03283236,0);
ENDMACRO;
