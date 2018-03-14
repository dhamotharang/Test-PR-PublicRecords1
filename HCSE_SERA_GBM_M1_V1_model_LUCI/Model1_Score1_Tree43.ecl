﻿EXPORT Model1_Score1_Tree43(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_43_Node_52 := IF ( le.p_PrevAddrCrimeIndex < 170.5,151,152);
        Tree_43_Node_53 := CHOOSE ( le.p_readmit_lift,153,153,153,153,153,154,153,153,153,154,153,153,153);
        Tree_43_Node_30 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 1.5,Tree_43_Node_52,Tree_43_Node_53);
        Tree_43_Node_54 := IF ( le.p_CurrAddrMurderIndex < 69.5,155,156);
        Tree_43_Node_31 := IF ( le.p_AssocRiskLevel < 3.5,Tree_43_Node_54,144);
        Tree_43_Node_16 := IF ( le.p_LienReleasedAge < 108.5,Tree_43_Node_30,Tree_43_Node_31);
        Tree_43_Node_56 := IF ( le.p_LastNameChangeAge < 239.5,157,158);
        Tree_43_Node_57 := CHOOSE ( le.p_financial_class,159,159,159,159,160,160,160,159,159,159,159,160,159,160,159,159);
        Tree_43_Node_32 := CHOOSE ( le.p_readmit_lift,Tree_43_Node_56,Tree_43_Node_56,Tree_43_Node_56,Tree_43_Node_56,Tree_43_Node_56,Tree_43_Node_56,Tree_43_Node_57,Tree_43_Node_57,Tree_43_Node_56,Tree_43_Node_56,Tree_43_Node_56,Tree_43_Node_57,Tree_43_Node_56);
        Tree_43_Node_17 := IF ( le.p_v1_CrtRecMsdmeanCnt < 17.5,Tree_43_Node_32,138);
        Tree_43_Node_8 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_43_Node_16,Tree_43_Node_17);
        Tree_43_Node_58 := IF ( le.p_PrevAddrMedianIncome < 52999.5,161,162);
        Tree_43_Node_59 := CHOOSE ( le.p_admit_diag,164,163,164,163,163,164,163,164,163,163,164,163,163);
        Tree_43_Node_34 := CHOOSE ( le.p_readmit_lift,Tree_43_Node_58,Tree_43_Node_59,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58,Tree_43_Node_58);
        Tree_43_Node_18 := IF ( le.p_CurrAddrLenOfRes < 431.5,Tree_43_Node_34,139);
        Tree_43_Node_9 := IF ( le.p_PRSearchLocateCount < 4.5,Tree_43_Node_18,135);
        Tree_43_Node_4 := IF ( le.p_LienReleasedAge < 166.5,Tree_43_Node_8,Tree_43_Node_9);
        Tree_43_Node_60 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 1.5,165,166);
        Tree_43_Node_61 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 5.5,167,168);
        Tree_43_Node_36 := CHOOSE ( le.p_readmit_lift,Tree_43_Node_60,Tree_43_Node_61,Tree_43_Node_60,Tree_43_Node_60,Tree_43_Node_60,Tree_43_Node_60,Tree_43_Node_61,Tree_43_Node_60,Tree_43_Node_60,Tree_43_Node_60,Tree_43_Node_60,Tree_43_Node_60,Tree_43_Node_60);
        Tree_43_Node_21 := IF ( le.p_NonDerogCount12 < 4.5,Tree_43_Node_36,140);
        Tree_43_Node_10 := IF ( le.p_IDVerSSNCreditBureauCount < 2.5,136,Tree_43_Node_21);
        Tree_43_Node_5 := CHOOSE ( le.p_admit_diag,Tree_43_Node_10,Tree_43_Node_10,Tree_43_Node_10,Tree_43_Node_10,134,134,Tree_43_Node_10,Tree_43_Node_10,Tree_43_Node_10,134,Tree_43_Node_10,Tree_43_Node_10,134);
        Tree_43_Node_2 := IF ( le.p_v1_CrtRecMsdmeanCnt < 23.5,Tree_43_Node_4,Tree_43_Node_5);
        Tree_43_Node_62 := IF ( le.p_SrcsConfirmIDAddrCount < 4.5,169,170);
        Tree_43_Node_38 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 1562499.5,Tree_43_Node_62,145);
        Tree_43_Node_64 := IF ( le.p_PrevAddrMurderIndex < 110.5,171,172);
        Tree_43_Node_65 := IF ( le.p_CurrAddrCarTheftIndex < 59.5,173,174);
        Tree_43_Node_39 := CHOOSE ( le.p_admit_diag,Tree_43_Node_64,Tree_43_Node_65,Tree_43_Node_64,Tree_43_Node_65,Tree_43_Node_64,Tree_43_Node_64,Tree_43_Node_64,Tree_43_Node_64,Tree_43_Node_64,Tree_43_Node_65,Tree_43_Node_64,Tree_43_Node_64,Tree_43_Node_65);
        Tree_43_Node_22 := IF ( le.p_EvictionAge < 147.5,Tree_43_Node_38,Tree_43_Node_39);
        Tree_43_Node_23 := CHOOSE ( le.p_financial_class,141,142,141,141,141,142,141,141,142,142,141,141,141,141,141,141);
        Tree_43_Node_12 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 3.5,Tree_43_Node_22,Tree_43_Node_23);
        Tree_43_Node_66 := CHOOSE ( le.p_financial_class,176,175,176,176,176,176,176,176,175,176,176,175,176,176,176,175);
        Tree_43_Node_67 := CHOOSE ( le.p_financial_class,177,177,177,177,178,177,178,177,178,177,178,177,177,177,177,177);
        Tree_43_Node_42 := CHOOSE ( le.p_readmit_lift,Tree_43_Node_66,Tree_43_Node_67,Tree_43_Node_66,Tree_43_Node_66,Tree_43_Node_67,Tree_43_Node_67,Tree_43_Node_67,Tree_43_Node_66,Tree_43_Node_67,Tree_43_Node_67,Tree_43_Node_67,Tree_43_Node_67,Tree_43_Node_67);
        Tree_43_Node_68 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,179,180);
        Tree_43_Node_43 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 1.5,Tree_43_Node_68,146);
        Tree_43_Node_24 := IF ( le.p_PhoneEDAAgeOldestRecord < 163.5,Tree_43_Node_42,Tree_43_Node_43);
        Tree_43_Node_71 := IF ( le.p_CurrAddrBurglaryIndex < 160.5,183,184);
        Tree_43_Node_70 := IF ( le.p_PrevAddrMedianValue < 100520.0,181,182);
        Tree_43_Node_44 := CHOOSE ( le.p_admit_diag,Tree_43_Node_71,Tree_43_Node_70,Tree_43_Node_70,Tree_43_Node_70,Tree_43_Node_71,Tree_43_Node_71,Tree_43_Node_71,Tree_43_Node_70,Tree_43_Node_70,Tree_43_Node_70,Tree_43_Node_70,Tree_43_Node_70,Tree_43_Node_71);
        Tree_43_Node_25 := CHOOSE ( le.p_financial_class,Tree_43_Node_44,Tree_43_Node_44,Tree_43_Node_44,Tree_43_Node_44,143,Tree_43_Node_44,Tree_43_Node_44,Tree_43_Node_44,Tree_43_Node_44,143,Tree_43_Node_44,143,Tree_43_Node_44,143,Tree_43_Node_44,Tree_43_Node_44);
        Tree_43_Node_13 := CHOOSE ( le.p_readmit_diag,Tree_43_Node_24,Tree_43_Node_24,Tree_43_Node_25,Tree_43_Node_25,Tree_43_Node_24,Tree_43_Node_25,Tree_43_Node_24,Tree_43_Node_24,Tree_43_Node_25,Tree_43_Node_25,Tree_43_Node_25,Tree_43_Node_25,Tree_43_Node_25);
        Tree_43_Node_6 := IF ( le.p_BPV_1 < 2.310711,Tree_43_Node_12,Tree_43_Node_13);
        Tree_43_Node_72 := IF ( le.p_PropAgeNewestSale < 204.5,185,186);
        Tree_43_Node_73 := IF ( le.p_PrevAddrMurderIndex < 79.5,187,188);
        Tree_43_Node_46 := IF ( le.p_BPV_3 < 2.6672437,Tree_43_Node_72,Tree_43_Node_73);
        Tree_43_Node_74 := IF ( le.p_SSNHighIssueAge < 710.5,189,190);
        Tree_43_Node_75 := IF ( le.p_CurrAddrCarTheftIndex < 29.5,191,192);
        Tree_43_Node_47 := IF ( le.p_CurrAddrLenOfRes < 348.5,Tree_43_Node_74,Tree_43_Node_75);
        Tree_43_Node_26 := IF ( le.p_CurrAddrLenOfRes < 244.5,Tree_43_Node_46,Tree_43_Node_47);
        Tree_43_Node_76 := IF ( le.p_AssocSuspicousIdentitiesCount < 3.5,193,194);
        Tree_43_Node_48 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 4.5,Tree_43_Node_76,147);
        Tree_43_Node_78 := IF ( le.p_BPV_3 < 2.069015,195,196);
        Tree_43_Node_49 := IF ( le.p_CurrAddrBurglaryIndex < 170.5,Tree_43_Node_78,148);
        Tree_43_Node_27 := IF ( le.p_NonDerogCount < 8.5,Tree_43_Node_48,Tree_43_Node_49);
        Tree_43_Node_14 := IF ( le.p_RelativesBankruptcyCount < 7.5,Tree_43_Node_26,Tree_43_Node_27);
        Tree_43_Node_50 := IF ( le.p_PrevAddrMedianIncome < 39677.5,149,150);
        Tree_43_Node_82 := IF ( le.p_BP_4 < 15.0,197,198);
        Tree_43_Node_83 := CHOOSE ( le.p_admit_diag,200,200,200,200,199,200,200,200,200,200,200,199,199);
        Tree_43_Node_51 := IF ( le.p_CurrAddrMurderIndex < 170.5,Tree_43_Node_82,Tree_43_Node_83);
        Tree_43_Node_28 := IF ( le.p_EstimatedAnnualIncome < 21875.5,Tree_43_Node_50,Tree_43_Node_51);
        Tree_43_Node_15 := IF ( le.p_EvictionAge < 167.5,Tree_43_Node_28,137);
        Tree_43_Node_7 := CHOOSE ( le.p_financial_class,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_14,Tree_43_Node_15,Tree_43_Node_14,Tree_43_Node_14);
        Tree_43_Node_3 := IF ( le.p_AssocRiskLevel < 2.5,Tree_43_Node_6,Tree_43_Node_7);
        Tree_43_Node_1 := IF ( le.p_SSNAddrCount < 6.5,Tree_43_Node_2,Tree_43_Node_3);
    UNSIGNED2 Score1_Tree43_node := Tree_43_Node_1;
    REAL8 Score1_Tree43_score := CASE(Score1_Tree43_node,134=>0.038922876,135=>0.074159205,136=>0.041915417,137=>0.09695117,138=>0.120651074,139=>-0.015558087,140=>0.0135997,141=>-0.011689613,142=>0.17362252,143=>0.09621294,144=>0.14742376,145=>0.10101598,146=>-0.02176014,147=>0.12285564,148=>0.06884623,149=>0.13454904,150=>0.015922273,151=>-0.0037215175,152=>-0.0128317615,153=>0.008646258,154=>0.10462291,155=>-0.07447155,156=>0.036055285,157=>-0.008348767,158=>0.019925056,159=>0.006850859,160=>0.121300064,161=>-0.07869716,162=>-0.06172895,163=>-0.07388472,164=>-0.07249113,165=>-0.08177626,166=>-0.06002565,167=>-0.069529235,168=>0.008191019,169=>0.007945572,170=>7.7067484E-4,171=>-0.03459834,172=>-0.0764562,173=>0.08066416,174=>-0.037209995,175=>-0.069463685,176=>-0.023370456,177=>-0.031714913,178=>0.047044896,179=>0.07688695,180=>0.029964425,181=>-0.056680694,182=>0.014774771,183=>0.039102625,184=>0.10868145,185=>-0.007481858,186=>-0.05285435,187=>-0.022023903,188=>0.0357446,189=>0.011538082,190=>0.07101138,191=>0.04879634,192=>-0.024995832,193=>0.07667097,194=>0.0027691454,195=>-0.05281907,196=>0.03032997,197=>-0.003590566,198=>0.06023683,199=>-0.078720056,200=>0.033358045,0);
ENDMACRO;
