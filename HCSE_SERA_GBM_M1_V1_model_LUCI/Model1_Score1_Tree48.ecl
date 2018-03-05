﻿EXPORT Model1_Score1_Tree48(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_48_Node_52 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 1.5,171,172);
        Tree_48_Node_53 := IF ( le.p_v1_HHCnt < 11.5,173,174);
        Tree_48_Node_28 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,Tree_48_Node_52,Tree_48_Node_53);
        Tree_48_Node_54 := IF ( le.p_PrevAddrAgeLastSale < 191.5,175,176);
        Tree_48_Node_29 := CHOOSE ( le.p_financial_class,Tree_48_Node_54,159,Tree_48_Node_54,Tree_48_Node_54,159,Tree_48_Node_54,Tree_48_Node_54,Tree_48_Node_54,Tree_48_Node_54,159,Tree_48_Node_54,Tree_48_Node_54,Tree_48_Node_54,Tree_48_Node_54,Tree_48_Node_54,Tree_48_Node_54);
        Tree_48_Node_16 := IF ( le.p_SSNIdentitiesCount < 5.0,Tree_48_Node_28,Tree_48_Node_29);
        Tree_48_Node_56 := CHOOSE ( le.p_readmit_diag,178,177,177,178,177,178,178,178,177,177,177,177,177);
        Tree_48_Node_30 := IF ( le.p_VariationDOBCount < 3.5,Tree_48_Node_56,160);
        Tree_48_Node_59 := IF ( le.p_PrevAddrAgeOldestRecord < 298.5,181,182);
        Tree_48_Node_58 := CHOOSE ( le.p_financial_class,179,180,179,179,179,179,179,179,179,179,179,180,179,179,179,179);
        Tree_48_Node_31 := CHOOSE ( le.p_admit_diag,Tree_48_Node_59,Tree_48_Node_58,Tree_48_Node_59,Tree_48_Node_58,Tree_48_Node_58,Tree_48_Node_58,Tree_48_Node_59,Tree_48_Node_58,Tree_48_Node_58,Tree_48_Node_58,Tree_48_Node_58,Tree_48_Node_59,Tree_48_Node_58);
        Tree_48_Node_17 := IF ( le.p_PrevAddrAgeOldestRecord < 79.5,Tree_48_Node_30,Tree_48_Node_31);
        Tree_48_Node_8 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 226.5,Tree_48_Node_16,Tree_48_Node_17);
        Tree_48_Node_60 := CHOOSE ( le.p_readmit_lift,184,183,183,183,183,183,183,184,183,183,184,184,183);
        Tree_48_Node_61 := IF ( le.p_v1_CrtRecMsdmeanCnt < 21.5,185,186);
        Tree_48_Node_32 := IF ( le.p_PrevAddrMedianIncome < 77999.5,Tree_48_Node_60,Tree_48_Node_61);
        Tree_48_Node_62 := CHOOSE ( le.p_readmit_lift,187,187,188,187,188,188,187,187,187,188,187,187,187);
        Tree_48_Node_33 := IF ( le.p_CurrAddrCrimeIndex < 180.5,Tree_48_Node_62,161);
        Tree_48_Node_18 := IF ( le.p_CurrAddrMedianIncome < 56011.5,Tree_48_Node_32,Tree_48_Node_33);
        Tree_48_Node_64 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 2.5,189,190);
        Tree_48_Node_65 := CHOOSE ( le.p_admit_diag,191,192,191,191,191,192,192,191,191,191,192,191,191);
        Tree_48_Node_34 := IF ( le.p_SSNIdentitiesCount < 5.5,Tree_48_Node_64,Tree_48_Node_65);
        Tree_48_Node_66 := IF ( le.p_SSNIssueState < 47.5,193,194);
        Tree_48_Node_67 := CHOOSE ( le.p_readmit_diag,195,195,196,196,195,195,195,195,196,196,195,196,195);
        Tree_48_Node_35 := IF ( le.p_WealthIndex < 2.5,Tree_48_Node_66,Tree_48_Node_67);
        Tree_48_Node_19 := IF ( le.p_EvictionAge < 13.5,Tree_48_Node_34,Tree_48_Node_35);
        Tree_48_Node_9 := IF ( le.p_EstimatedAnnualIncome < 30422.5,Tree_48_Node_18,Tree_48_Node_19);
        Tree_48_Node_4 := IF ( le.p_SubjectAddrCount < 10.5,Tree_48_Node_8,Tree_48_Node_9);
        Tree_48_Node_68 := CHOOSE ( le.p_financial_class,197,197,197,197,198,197,197,197,198,197,197,197,197,198,198,197);
        Tree_48_Node_69 := CHOOSE ( le.p_financial_class,199,200,199,199,199,200,199,199,200,199,199,200,199,199,199,199);
        Tree_48_Node_36 := CHOOSE ( le.p_readmit_lift,Tree_48_Node_68,Tree_48_Node_68,Tree_48_Node_68,Tree_48_Node_68,Tree_48_Node_68,Tree_48_Node_68,Tree_48_Node_69,Tree_48_Node_69,Tree_48_Node_69,Tree_48_Node_69,Tree_48_Node_68,Tree_48_Node_68,Tree_48_Node_68);
        Tree_48_Node_70 := CHOOSE ( le.p_readmit_diag,201,202,201,201,201,202,201,201,201,201,201,202,201);
        Tree_48_Node_71 := CHOOSE ( le.p_readmit_diag,203,203,203,204,203,203,203,204,204,203,203,203,203);
        Tree_48_Node_37 := CHOOSE ( le.p_admit_diag,Tree_48_Node_70,Tree_48_Node_71,Tree_48_Node_71,Tree_48_Node_70,Tree_48_Node_70,Tree_48_Node_71,Tree_48_Node_71,Tree_48_Node_71,Tree_48_Node_71,Tree_48_Node_70,Tree_48_Node_71,Tree_48_Node_70,Tree_48_Node_71);
        Tree_48_Node_20 := IF ( le.p_PrevAddrCrimeIndex < 140.5,Tree_48_Node_36,Tree_48_Node_37);
        Tree_48_Node_38 := CHOOSE ( le.p_admit_diag,162,162,163,163,162,162,162,163,162,162,163,162,162);
        Tree_48_Node_39 := IF ( le.p_SubjectSSNCount < 1.5,164,165);
        Tree_48_Node_21 := IF ( le.p_PrevAddrBurglaryIndex < 130.5,Tree_48_Node_38,Tree_48_Node_39);
        Tree_48_Node_10 := IF ( le.p_DivSSNIdentityMSourceUrelCount < 2.5,Tree_48_Node_20,Tree_48_Node_21);
        Tree_48_Node_5 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 267.5,Tree_48_Node_10,154);
        Tree_48_Node_2 := IF ( le.p_AddrChangeCount60 < 4.5,Tree_48_Node_4,Tree_48_Node_5);
        Tree_48_Node_76 := IF ( le.p_AssocSuspicousIdentitiesCount < 4.5,205,206);
        Tree_48_Node_77 := IF ( le.p_AssocRiskLevel < 2.5,207,208);
        Tree_48_Node_40 := CHOOSE ( le.p_readmit_diag,Tree_48_Node_76,Tree_48_Node_76,Tree_48_Node_76,Tree_48_Node_77,Tree_48_Node_77,Tree_48_Node_77,Tree_48_Node_77,Tree_48_Node_76,Tree_48_Node_76,Tree_48_Node_76,Tree_48_Node_77,Tree_48_Node_77,Tree_48_Node_76);
        Tree_48_Node_78 := IF ( le.p_age_in_years < 73.962,209,210);
        Tree_48_Node_79 := IF ( le.p_CurrAddrAgeLastSale < 103.5,211,212);
        Tree_48_Node_41 := IF ( le.p_CurrAddrMedianIncome < 35746.5,Tree_48_Node_78,Tree_48_Node_79);
        Tree_48_Node_22 := IF ( le.p_v1_RaAPropOwnerAVMMed < 223593.5,Tree_48_Node_40,Tree_48_Node_41);
        Tree_48_Node_80 := IF ( le.p_AddrStability < 4.5,213,214);
        Tree_48_Node_42 := IF ( le.p_v1_CrtRecCnt < 19.0,Tree_48_Node_80,166);
        Tree_48_Node_82 := IF ( le.p_CurrAddrCarTheftIndex < 182.5,215,216);
        Tree_48_Node_43 := IF ( le.p_CurrAddrAgeOldestRecord < 297.5,Tree_48_Node_82,167);
        Tree_48_Node_23 := IF ( le.p_BP_4 < 2.5,Tree_48_Node_42,Tree_48_Node_43);
        Tree_48_Node_12 := IF ( le.p_CurrAddrBurglaryIndex < 176.5,Tree_48_Node_22,Tree_48_Node_23);
        Tree_48_Node_84 := IF ( le.p_PhoneOtherAgeOldestRecord < 130.5,217,218);
        Tree_48_Node_85 := IF ( le.p_AddrChangeCount24 < 0.5,219,220);
        Tree_48_Node_44 := IF ( le.p_CurrAddrCountyIndex < 0.8225,Tree_48_Node_84,Tree_48_Node_85);
        Tree_48_Node_86 := CHOOSE ( le.p_readmit_lift,222,221,222,221,221,221,221,221,221,221,221,222,221);
        Tree_48_Node_45 := CHOOSE ( le.p_readmit_diag,Tree_48_Node_86,168,Tree_48_Node_86,Tree_48_Node_86,Tree_48_Node_86,168,Tree_48_Node_86,168,Tree_48_Node_86,Tree_48_Node_86,Tree_48_Node_86,168,Tree_48_Node_86);
        Tree_48_Node_24 := IF ( le.p_v1_HHSeniorMmbrCnt < 0.5,Tree_48_Node_44,Tree_48_Node_45);
        Tree_48_Node_25 := IF ( le.p_CurrAddrCountyIndex < 0.169375,156,157);
        Tree_48_Node_13 := CHOOSE ( le.p_readmit_diag,Tree_48_Node_24,Tree_48_Node_24,Tree_48_Node_24,Tree_48_Node_25,Tree_48_Node_24,Tree_48_Node_24,Tree_48_Node_25,Tree_48_Node_24,Tree_48_Node_25,Tree_48_Node_24,Tree_48_Node_25,Tree_48_Node_24,Tree_48_Node_24);
        Tree_48_Node_6 := IF ( le.p_CurrAddrAgeLastSale < 159.5,Tree_48_Node_12,Tree_48_Node_13);
        Tree_48_Node_48 := IF ( le.p_AssocSuspicousIdentitiesCount < 1.5,169,170);
        Tree_48_Node_91 := CHOOSE ( le.p_readmit_diag,225,225,225,225,225,225,226,225,225,226,225,226,226);
        Tree_48_Node_90 := IF ( le.p_PhoneEDAAgeOldestRecord < 193.5,223,224);
        Tree_48_Node_49 := CHOOSE ( le.p_admit_diag,Tree_48_Node_91,Tree_48_Node_91,Tree_48_Node_91,Tree_48_Node_90,Tree_48_Node_91,Tree_48_Node_90,Tree_48_Node_91,Tree_48_Node_91,Tree_48_Node_90,Tree_48_Node_90,Tree_48_Node_90,Tree_48_Node_90,Tree_48_Node_91);
        Tree_48_Node_26 := IF ( le.p_CurrAddrMedianIncome < 26999.5,Tree_48_Node_48,Tree_48_Node_49);
        Tree_48_Node_92 := CHOOSE ( le.p_readmit_diag,227,227,228,227,227,228,228,227,228,228,227,227,227);
        Tree_48_Node_93 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 7.5,229,230);
        Tree_48_Node_51 := IF ( le.p_RelativesCount < 9.5,Tree_48_Node_92,Tree_48_Node_93);
        Tree_48_Node_27 := IF ( le.p_DivSSNIdentityMSourceUrelCount < 0.5,158,Tree_48_Node_51);
        Tree_48_Node_15 := IF ( le.p_PrevAddrBurglaryIndex < 127.5,Tree_48_Node_26,Tree_48_Node_27);
        Tree_48_Node_7 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.58203125,155,Tree_48_Node_15);
        Tree_48_Node_3 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 83062.5,Tree_48_Node_6,Tree_48_Node_7);
        Tree_48_Node_1 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_48_Node_2,Tree_48_Node_3);
    UNSIGNED2 Score1_Tree48_node := Tree_48_Node_1;
    REAL8 Score1_Tree48_score := CASE(Score1_Tree48_node,154=>0.06384034,155=>0.085234515,156=>-0.0010293963,157=>0.12801854,158=>0.166735,159=>0.11597279,160=>0.10520403,161=>0.088866726,162=>-0.07049642,163=>0.011692888,164=>0.100945674,165=>-0.008690924,166=>0.0014606804,167=>0.14583614,168=>0.11572334,169=>-0.0032315883,170=>0.138451,171=>-0.0021953762,172=>0.008593211,173=>-0.008463877,174=>0.054329515,175=>0.0045119976,176=>0.08406362,177=>-0.04266062,178=>0.032655746,179=>-0.052583598,180=>0.0118215615,181=>-0.036997996,182=>0.01053279,183=>0.0057953876,184=>0.029658373,185=>0.044515647,186=>0.13025375,187=>-0.024650004,188=>0.012230168,189=>0.00932661,190=>6.1192573E-4,191=>-0.05550026,192=>-0.0075331843,193=>-0.02124839,194=>0.03979505,195=>-0.009553015,196=>0.035697177,197=>-0.021299222,198=>0.0059434366,199=>-0.0249957,200=>0.091591336,201=>-0.05189018,202=>0.019055625,203=>-0.017834503,204=>0.045856453,205=>-0.02241779,206=>0.017132564,207=>0.028186727,208=>-0.022850307,209=>0.028779982,210=>0.15214625,211=>0.014623485,212=>-0.07232177,213=>-0.053064678,214=>-0.07445248,215=>-2.568084E-4,216=>0.06970343,217=>-0.0038061982,218=>-0.07322077,219=>-0.017006947,220=>0.1304226,221=>-0.058381423,222=>0.04721134,223=>-0.05048621,224=>0.017124105,225=>0.0049652276,226=>0.110601425,227=>0.047992844,228=>0.16676274,229=>-0.033318873,230=>0.038572,0);
ENDMACRO;
