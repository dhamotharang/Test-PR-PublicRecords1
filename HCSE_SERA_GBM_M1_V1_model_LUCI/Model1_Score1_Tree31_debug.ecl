﻿EXPORT Model1_Score1_Tree31_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_31_Node_62 := IF ( le.p_CurrAddrBurglaryIndex < 120.5,193,194);
        Tree_31_Node_63 := IF ( le.p_SubjectLastNameCount < 5.5,195,196);
        Tree_31_Node_32 := IF ( le.p_NonDerogCount06 < 5.5,Tree_31_Node_62,Tree_31_Node_63);
        Tree_31_Node_64 := IF ( le.p_LastNameChangeAge < 60.5,197,198);
        Tree_31_Node_33 := IF ( le.p_LienReleasedAge < 88.5,Tree_31_Node_64,178);
        Tree_31_Node_16 := IF ( le.p_AddrChangeCount24 < 2.5,Tree_31_Node_32,Tree_31_Node_33);
        Tree_31_Node_66 := IF ( le.p_PropAgeOldestPurchase < 480.0,199,200);
        Tree_31_Node_34 := IF ( le.p_v1_CrtRecMsdmeanCnt < 18.5,Tree_31_Node_66,179);
        Tree_31_Node_17 := IF ( le.p_CurrAddrAgeLastSale < 327.5,Tree_31_Node_34,171);
        Tree_31_Node_8 := IF ( le.p_PropAgeNewestSale < 63.5,Tree_31_Node_16,Tree_31_Node_17);
        Tree_31_Node_69 := IF ( le.p_PhoneEDAAgeOldestRecord < 183.5,203,204);
        Tree_31_Node_68 := CHOOSE ( le.p_readmit_diag,202,202,202,201,201,201,201,201,201,201,201,201,201);
        Tree_31_Node_36 := CHOOSE ( le.p_admit_diag,Tree_31_Node_69,Tree_31_Node_68,Tree_31_Node_69,Tree_31_Node_68,Tree_31_Node_68,Tree_31_Node_68,Tree_31_Node_68,Tree_31_Node_68,Tree_31_Node_69,Tree_31_Node_68,Tree_31_Node_68,Tree_31_Node_68,Tree_31_Node_69);
        Tree_31_Node_18 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 2.5,Tree_31_Node_36,172);
        Tree_31_Node_72 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 2.5,207,208);
        Tree_31_Node_73 := CHOOSE ( le.p_readmit_diag,209,209,209,209,209,209,210,209,210,209,209,210,209);
        Tree_31_Node_39 := CHOOSE ( le.p_financial_class,Tree_31_Node_72,Tree_31_Node_73,Tree_31_Node_73,Tree_31_Node_72,Tree_31_Node_72,Tree_31_Node_72,Tree_31_Node_73,Tree_31_Node_72,Tree_31_Node_72,Tree_31_Node_73,Tree_31_Node_72,Tree_31_Node_72,Tree_31_Node_72,Tree_31_Node_73,Tree_31_Node_72,Tree_31_Node_72);
        Tree_31_Node_71 := CHOOSE ( le.p_admit_diag,205,205,205,206,205,205,205,205,205,205,205,206,205);
        Tree_31_Node_38 := CHOOSE ( le.p_readmit_lift,180,Tree_31_Node_71,Tree_31_Node_71,180,180,180,180,180,180,180,180,180,180);
        Tree_31_Node_19 := CHOOSE ( le.p_readmit_diag,Tree_31_Node_39,Tree_31_Node_39,Tree_31_Node_39,Tree_31_Node_39,Tree_31_Node_39,Tree_31_Node_38,Tree_31_Node_39,Tree_31_Node_38,Tree_31_Node_39,Tree_31_Node_38,Tree_31_Node_39,Tree_31_Node_39,Tree_31_Node_39);
        Tree_31_Node_9 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 83155.5,Tree_31_Node_18,Tree_31_Node_19);
        Tree_31_Node_4 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 159.5,Tree_31_Node_8,Tree_31_Node_9);
        Tree_31_Node_22 := IF ( le.p_CurrAddrBlockIndex < 0.43484375,173,174);
        Tree_31_Node_82 := IF ( le.p_RelativesPropOwnedCount < 1.5,213,214);
        Tree_31_Node_46 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 16.5,Tree_31_Node_82,188);
        Tree_31_Node_23 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_31_Node_46,175);
        Tree_31_Node_11 := CHOOSE ( le.p_financial_class,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_23,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_23,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_22,Tree_31_Node_23,Tree_31_Node_23,Tree_31_Node_22);
        Tree_31_Node_40 := IF ( le.p_PrevAddrCrimeIndex < 39.5,181,182);
        Tree_31_Node_41 := IF ( le.p_v1_HHPropCurrOwnedCnt < 0.5,183,184);
        Tree_31_Node_20 := IF ( le.p_PrevAddrBurglaryIndex < 99.5,Tree_31_Node_40,Tree_31_Node_41);
        Tree_31_Node_78 := CHOOSE ( le.p_readmit_diag,211,211,212,212,212,211,212,212,212,212,211,212,211);
        Tree_31_Node_42 := IF ( le.p_PhoneEDAAgeOldestRecord < 183.5,Tree_31_Node_78,185);
        Tree_31_Node_43 := CHOOSE ( le.p_financial_class,186,186,187,187,187,187,187,187,186,187,186,187,187,186,187,186);
        Tree_31_Node_21 := IF ( le.p_CurrAddrAVMValue60 < 120708.5,Tree_31_Node_42,Tree_31_Node_43);
        Tree_31_Node_10 := IF ( le.p_CurrAddrMedianIncome < 42010.5,Tree_31_Node_20,Tree_31_Node_21);
        Tree_31_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_31_Node_11,Tree_31_Node_10,Tree_31_Node_10,Tree_31_Node_10,Tree_31_Node_11,Tree_31_Node_10,Tree_31_Node_10,Tree_31_Node_11,Tree_31_Node_10,Tree_31_Node_10,Tree_31_Node_10,Tree_31_Node_10,Tree_31_Node_11);
        Tree_31_Node_2 := IF ( le.p_VariationDOBCount < 4.5,Tree_31_Node_4,Tree_31_Node_5);
        Tree_31_Node_84 := IF ( le.p_v1_RaAMedIncomeRange < 4.5,215,216);
        Tree_31_Node_85 := CHOOSE ( le.p_admit_diag,217,218,217,218,217,217,217,217,218,218,218,217,217);
        Tree_31_Node_48 := IF ( le.p_v1_CrtRecCnt < 101.5,Tree_31_Node_84,Tree_31_Node_85);
        Tree_31_Node_86 := CHOOSE ( le.p_readmit_diag,219,219,219,220,220,220,219,219,220,219,220,219,219);
        Tree_31_Node_49 := CHOOSE ( le.p_readmit_lift,Tree_31_Node_86,Tree_31_Node_86,Tree_31_Node_86,189,Tree_31_Node_86,Tree_31_Node_86,189,Tree_31_Node_86,189,Tree_31_Node_86,Tree_31_Node_86,Tree_31_Node_86,189);
        Tree_31_Node_24 := IF ( le.p_LastNameChangeAge < 364.5,Tree_31_Node_48,Tree_31_Node_49);
        Tree_31_Node_88 := CHOOSE ( le.p_readmit_diag,221,221,222,221,221,221,222,222,221,221,222,221,221);
        Tree_31_Node_89 := IF ( le.p_v1_ProspectAge < 48.5,223,224);
        Tree_31_Node_51 := IF ( le.p_v1_HHCnt < 3.5,Tree_31_Node_88,Tree_31_Node_89);
        Tree_31_Node_25 := IF ( le.p_NonDerogCount60 < 4.5,176,Tree_31_Node_51);
        Tree_31_Node_12 := IF ( le.p_SrcsConfirmIDAddrCount < 10.5,Tree_31_Node_24,Tree_31_Node_25);
        Tree_31_Node_90 := IF ( le.p_CurrAddrAgeLastSale < 672.5,225,226);
        Tree_31_Node_52 := IF ( le.p_v1_PropTimeLastSale < 180.5,Tree_31_Node_90,190);
        Tree_31_Node_92 := IF ( le.p_v1_HHPropCurrOwnedCnt < 0.5,227,228);
        Tree_31_Node_93 := CHOOSE ( le.p_admit_diag,229,230,230,230,230,230,229,230,229,229,229,229,230);
        Tree_31_Node_53 := IF ( le.p_EstimatedAnnualIncome < 63000.5,Tree_31_Node_92,Tree_31_Node_93);
        Tree_31_Node_26 := IF ( le.p_NonDerogCount60 < 5.5,Tree_31_Node_52,Tree_31_Node_53);
        Tree_31_Node_94 := IF ( le.p_PrevAddrMurderIndex < 150.5,231,232);
        Tree_31_Node_95 := CHOOSE ( le.p_readmit_diag,233,233,233,233,234,233,233,234,233,233,233,234,234);
        Tree_31_Node_54 := IF ( le.p_CurrAddrMedianIncome < 19741.5,Tree_31_Node_94,Tree_31_Node_95);
        Tree_31_Node_96 := IF ( le.p_PrevAddrMedianIncome < 52034.5,235,236);
        Tree_31_Node_97 := CHOOSE ( le.p_readmit_diag,238,237,237,237,237,237,237,237,238,237,237,237,237);
        Tree_31_Node_55 := IF ( le.p_CurrAddrAgeLastSale < 127.5,Tree_31_Node_96,Tree_31_Node_97);
        Tree_31_Node_27 := IF ( le.p_DivSSNIdentityMSourceCount < 2.5,Tree_31_Node_54,Tree_31_Node_55);
        Tree_31_Node_13 := IF ( le.p_PrevAddrBurglaryIndex < 47.5,Tree_31_Node_26,Tree_31_Node_27);
        Tree_31_Node_6 := IF ( le.p_LastNameChangeAge < 385.5,Tree_31_Node_12,Tree_31_Node_13);
        Tree_31_Node_100 := IF ( le.p_v1_ProspectTimeOnRecord < 143.5,243,244);
        Tree_31_Node_57 := IF ( le.p_SubjectAddrCount < 36.5,Tree_31_Node_100,191);
        Tree_31_Node_98 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 19.5,239,240);
        Tree_31_Node_99 := CHOOSE ( le.p_readmit_diag,241,241,242,241,241,241,241,241,242,241,241,241,242);
        Tree_31_Node_56 := CHOOSE ( le.p_admit_diag,Tree_31_Node_98,Tree_31_Node_99,Tree_31_Node_98,Tree_31_Node_99,Tree_31_Node_98,Tree_31_Node_98,Tree_31_Node_98,Tree_31_Node_98,Tree_31_Node_99,Tree_31_Node_99,Tree_31_Node_98,Tree_31_Node_99,Tree_31_Node_99);
        Tree_31_Node_28 := CHOOSE ( le.p_readmit_lift,Tree_31_Node_57,Tree_31_Node_56,Tree_31_Node_57,Tree_31_Node_57,Tree_31_Node_57,Tree_31_Node_57,Tree_31_Node_56,Tree_31_Node_57,Tree_31_Node_57,Tree_31_Node_56,Tree_31_Node_56,Tree_31_Node_57,Tree_31_Node_56);
        Tree_31_Node_102 := IF ( le.p_BP_4 < 20.5,245,246);
        Tree_31_Node_103 := CHOOSE ( le.p_readmit_diag,248,247,247,247,247,248,247,247,248,247,248,247,247);
        Tree_31_Node_58 := IF ( le.p_v1_ProspectTimeOnRecord < 383.5,Tree_31_Node_102,Tree_31_Node_103);
        Tree_31_Node_104 := CHOOSE ( le.p_admit_diag,249,249,249,250,250,249,249,250,249,249,249,249,249);
        Tree_31_Node_59 := IF ( le.p_RecentActivityIndex < 5.0,Tree_31_Node_104,192);
        Tree_31_Node_29 := CHOOSE ( le.p_financial_class,Tree_31_Node_58,Tree_31_Node_58,Tree_31_Node_59,Tree_31_Node_58,Tree_31_Node_59,Tree_31_Node_58,Tree_31_Node_59,Tree_31_Node_58,Tree_31_Node_58,Tree_31_Node_58,Tree_31_Node_59,Tree_31_Node_58,Tree_31_Node_58,Tree_31_Node_59,Tree_31_Node_58,Tree_31_Node_59);
        Tree_31_Node_14 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 6.5,Tree_31_Node_28,Tree_31_Node_29);
        Tree_31_Node_106 := IF ( le.p_PrevAddrMedianIncome < 134429.5,251,252);
        Tree_31_Node_107 := IF ( le.p_RecentActivityIndex < 1.5,253,254);
        Tree_31_Node_61 := CHOOSE ( le.p_admit_diag,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_107,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106,Tree_31_Node_106);
        Tree_31_Node_30 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.19140625,177,Tree_31_Node_61);
        Tree_31_Node_15 := IF ( le.p_PRSearchOtherCount < 8.0,Tree_31_Node_30,170);
        Tree_31_Node_7 := IF ( le.p_PrevAddrAgeNewestRecord < 143.5,Tree_31_Node_14,Tree_31_Node_15);
        Tree_31_Node_3 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,Tree_31_Node_6,Tree_31_Node_7);
        Tree_31_Node_1 := IF ( le.p_LastNameChangeAge < 63.5,Tree_31_Node_2,Tree_31_Node_3);
    SELF.Score1_Tree31_node := Tree_31_Node_1;
    SELF.Score1_Tree31_score := CASE(SELF.Score1_Tree31_node,170=>0.07323033,171=>0.1743494,172=>0.11821269,173=>0.044915292,174=>-0.08389684,175=>0.190108,176=>0.1641816,177=>0.0825606,178=>0.0596088,179=>0.11946704,180=>-0.08878681,181=>0.030863024,182=>0.20835532,183=>0.05279273,184=>-0.08478343,185=>0.053712033,186=>-0.084379636,187=>-0.05280198,188=>0.18534145,189=>0.11349503,190=>0.06567805,191=>0.11901844,192=>0.1490746,193=>-0.01521488,194=>0.004311391,195=>-0.048635557,196=>0.031885706,197=>-0.049317703,198=>0.060839657,199=>0.0023028199,200=>0.10926571,201=>-0.08659648,202=>-0.04050376,203=>-0.027769715,204=>0.13393466,205=>-0.08454328,206=>-0.059428927,207=>-0.05537466,208=>0.015466441,209=>-0.018687228,210=>0.10159552,211=>-0.079215325,212=>0.015094948,213=>-0.06520308,214=>0.06807124,215=>-0.0027281328,216=>0.0067483713,217=>-0.08560509,218=>-0.022611462,219=>0.008330031,220=>0.042798273,221=>0.033909474,222=>0.16440259,223=>0.14266096,224=>-0.010610996,225=>-0.037734903,226=>0.053386766,227=>0.06541149,228=>-0.018952057,229=>-0.037395913,230=>0.16825993,231=>-0.051937915,232=>0.099758506,233=>-0.0062142164,234=>0.02274079,235=>0.021097124,236=>0.12017282,237=>-0.07261628,238=>0.022118635,239=>-0.019664211,240=>0.0040318714,241=>0.0023398781,242=>0.045666713,243=>-0.006558755,244=>0.009454174,245=>-0.01889312,246=>0.07858319,247=>-0.0778235,248=>-0.018650116,249=>-0.008070637,250=>0.032782007,251=>-0.029002475,252=>0.06874733,253=>0.15676925,254=>-0.084204525,0);
ENDMACRO;
