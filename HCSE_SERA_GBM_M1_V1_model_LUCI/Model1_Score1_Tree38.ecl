﻿EXPORT Model1_Score1_Tree38(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_38_Node_54 := IF ( le.p_age_in_years < 92.82,160,161);
        Tree_38_Node_55 := IF ( le.p_PropAgeOldestPurchase < 383.5,162,163);
        Tree_38_Node_30 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_54,Tree_38_Node_54,Tree_38_Node_54,Tree_38_Node_54,Tree_38_Node_54,Tree_38_Node_55,Tree_38_Node_55,Tree_38_Node_55,Tree_38_Node_55,Tree_38_Node_54,Tree_38_Node_55,Tree_38_Node_54,Tree_38_Node_54);
        Tree_38_Node_56 := IF ( le.p_v1_HHEstimatedIncomeRange < 1.5,164,165);
        Tree_38_Node_31 := IF ( le.p_DerogAge < 147.5,Tree_38_Node_56,144);
        Tree_38_Node_16 := IF ( le.p_v1_CrtRecCnt12Mo < 0.5,Tree_38_Node_30,Tree_38_Node_31);
        Tree_38_Node_58 := IF ( le.p_CurrAddrBurglaryIndex < 150.5,166,167);
        Tree_38_Node_32 := CHOOSE ( le.p_admit_diag,Tree_38_Node_58,Tree_38_Node_58,145,Tree_38_Node_58,Tree_38_Node_58,145,Tree_38_Node_58,Tree_38_Node_58,145,145,Tree_38_Node_58,145,Tree_38_Node_58);
        Tree_38_Node_60 := CHOOSE ( le.p_admit_diag,168,169,169,168,169,168,169,168,168,168,168,168,168);
        Tree_38_Node_33 := IF ( le.p_PrevAddrCrimeIndex < 129.5,Tree_38_Node_60,146);
        Tree_38_Node_17 := CHOOSE ( le.p_financial_class,Tree_38_Node_32,Tree_38_Node_32,Tree_38_Node_32,Tree_38_Node_32,Tree_38_Node_32,Tree_38_Node_33,Tree_38_Node_32,Tree_38_Node_32,Tree_38_Node_32,Tree_38_Node_32,Tree_38_Node_33,Tree_38_Node_33,Tree_38_Node_32,Tree_38_Node_33,Tree_38_Node_32,Tree_38_Node_32);
        Tree_38_Node_8 := IF ( le.p_PrevAddrAgeLastSale < 327.5,Tree_38_Node_16,Tree_38_Node_17);
        Tree_38_Node_62 := IF ( le.p_PropAgeNewestPurchase < 191.5,170,171);
        Tree_38_Node_35 := IF ( le.p_PRSearchOtherCount < 1.5,Tree_38_Node_62,147);
        Tree_38_Node_18 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_35,Tree_38_Node_35,Tree_38_Node_35,139,139,Tree_38_Node_35,Tree_38_Node_35,139,139,139,139,139,139);
        Tree_38_Node_36 := CHOOSE ( le.p_readmit_diag,148,149,149,148,148,148,148,148,149,148,149,149,148);
        Tree_38_Node_37 := CHOOSE ( le.p_admit_diag,150,151,150,151,151,151,150,150,150,150,150,150,150);
        Tree_38_Node_19 := CHOOSE ( le.p_financial_class,Tree_38_Node_36,Tree_38_Node_36,Tree_38_Node_37,Tree_38_Node_36,Tree_38_Node_36,Tree_38_Node_36,Tree_38_Node_36,Tree_38_Node_36,Tree_38_Node_36,Tree_38_Node_36,Tree_38_Node_37,Tree_38_Node_37,Tree_38_Node_36,Tree_38_Node_37,Tree_38_Node_36,Tree_38_Node_36);
        Tree_38_Node_9 := IF ( le.p_RecentActivityIndex < 1.5,Tree_38_Node_18,Tree_38_Node_19);
        Tree_38_Node_4 := IF ( le.p_PrevAddrBurglaryIndex < 184.5,Tree_38_Node_8,Tree_38_Node_9);
        Tree_38_Node_68 := IF ( le.p_SSNIssueState < 28.5,172,173);
        Tree_38_Node_38 := IF ( le.p_DivSSNAddrMSourceCount < 8.5,Tree_38_Node_68,152);
        Tree_38_Node_20 := IF ( le.p_age_in_years < 87.20891,Tree_38_Node_38,140);
        Tree_38_Node_70 := CHOOSE ( le.p_readmit_lift,174,175,174,175,175,174,175,175,175,175,175,175,175);
        Tree_38_Node_71 := IF ( le.p_v1_ProspectTimeLastUpdate < 129.5,176,177);
        Tree_38_Node_40 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_70,Tree_38_Node_71,Tree_38_Node_71,Tree_38_Node_71,Tree_38_Node_71,Tree_38_Node_71,Tree_38_Node_70,Tree_38_Node_70,Tree_38_Node_70,Tree_38_Node_70,Tree_38_Node_70,Tree_38_Node_70,Tree_38_Node_70);
        Tree_38_Node_73 := IF ( le.p_DivSSNAddrMSourceCount < 5.5,180,181);
        Tree_38_Node_72 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 0.5,178,179);
        Tree_38_Node_41 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_73,Tree_38_Node_72,Tree_38_Node_73,Tree_38_Node_72,Tree_38_Node_73,Tree_38_Node_73,Tree_38_Node_73,Tree_38_Node_72,Tree_38_Node_72,Tree_38_Node_73,Tree_38_Node_73,Tree_38_Node_72,Tree_38_Node_72);
        Tree_38_Node_21 := IF ( le.p_PhoneOtherAgeOldestRecord < 90.5,Tree_38_Node_40,Tree_38_Node_41);
        Tree_38_Node_10 := CHOOSE ( le.p_readmit_lift,Tree_38_Node_20,Tree_38_Node_21,Tree_38_Node_21,Tree_38_Node_21,Tree_38_Node_21,Tree_38_Node_21,Tree_38_Node_20,Tree_38_Node_21,Tree_38_Node_20,Tree_38_Node_21,Tree_38_Node_20,Tree_38_Node_21,Tree_38_Node_21);
        Tree_38_Node_22 := CHOOSE ( le.p_readmit_diag,141,142,141,141,141,142,141,141,142,142,141,141,141);
        Tree_38_Node_11 := CHOOSE ( le.p_financial_class,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,137,137,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22,Tree_38_Node_22);
        Tree_38_Node_5 := IF ( le.p_IdentityRiskLevel < 1.5,Tree_38_Node_10,Tree_38_Node_11);
        Tree_38_Node_2 := IF ( le.p_PrevAddrCrimeIndex < 173.0,Tree_38_Node_4,Tree_38_Node_5);
        Tree_38_Node_74 := IF ( le.p_BP_1 < 9.5,182,183);
        Tree_38_Node_75 := IF ( le.p_PrevAddrBurglaryIndex < 190.5,184,185);
        Tree_38_Node_44 := IF ( le.p_SSNIssueState < 34.5,Tree_38_Node_74,Tree_38_Node_75);
        Tree_38_Node_76 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 246.5,186,187);
        Tree_38_Node_77 := IF ( le.p_CurrAddrAgeLastSale < 95.5,188,189);
        Tree_38_Node_45 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_76,Tree_38_Node_76,Tree_38_Node_77,Tree_38_Node_76,Tree_38_Node_76,Tree_38_Node_77,Tree_38_Node_77,Tree_38_Node_77,Tree_38_Node_77,Tree_38_Node_76,Tree_38_Node_77,Tree_38_Node_77,Tree_38_Node_77);
        Tree_38_Node_24 := IF ( le.p_SSNIssueState < 45.5,Tree_38_Node_44,Tree_38_Node_45);
        Tree_38_Node_78 := IF ( le.p_SSNLowIssueAge < 720.5,190,191);
        Tree_38_Node_79 := IF ( le.p_BPV_4 < -2.462705,192,193);
        Tree_38_Node_46 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_78,Tree_38_Node_78,Tree_38_Node_78,Tree_38_Node_79,Tree_38_Node_78,Tree_38_Node_78,Tree_38_Node_78,Tree_38_Node_79,Tree_38_Node_79,Tree_38_Node_78,Tree_38_Node_78,Tree_38_Node_78,Tree_38_Node_78);
        Tree_38_Node_80 := IF ( le.p_PhoneOtherAgeOldestRecord < 247.5,194,195);
        Tree_38_Node_81 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 289.5,196,197);
        Tree_38_Node_47 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 2.5,Tree_38_Node_80,Tree_38_Node_81);
        Tree_38_Node_25 := IF ( le.p_PrevAddrDwellType < 1.5,Tree_38_Node_46,Tree_38_Node_47);
        Tree_38_Node_12 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_38_Node_24,Tree_38_Node_25);
        Tree_38_Node_49 := IF ( le.p_BP_1 < 4.5,153,154);
        Tree_38_Node_26 := IF ( le.p_age_in_years < 42.72625,143,Tree_38_Node_49);
        Tree_38_Node_13 := IF ( le.p_PhoneOtherAgeOldestRecord < 103.5,Tree_38_Node_26,138);
        Tree_38_Node_6 := IF ( le.p_v1_CrtRecCnt < 100.0,Tree_38_Node_12,Tree_38_Node_13);
        Tree_38_Node_84 := IF ( le.p_v1_ProspectTimeOnRecord < 383.5,198,199);
        Tree_38_Node_50 := IF ( le.p_PrevAddrAgeOldestRecord < 703.5,Tree_38_Node_84,155);
        Tree_38_Node_51 := IF ( le.p_v1_RaAPropOwnerAVMMed < 107740.5,156,157);
        Tree_38_Node_28 := IF ( le.p_PrevAddrCrimeIndex < 160.5,Tree_38_Node_50,Tree_38_Node_51);
        Tree_38_Node_88 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 6.5,200,201);
        Tree_38_Node_89 := IF ( le.p_AgeOldestRecord < 552.5,202,203);
        Tree_38_Node_52 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_88,Tree_38_Node_88,Tree_38_Node_88,Tree_38_Node_88,Tree_38_Node_88,Tree_38_Node_88,Tree_38_Node_88,Tree_38_Node_88,Tree_38_Node_89,Tree_38_Node_88,Tree_38_Node_89,Tree_38_Node_89,Tree_38_Node_89);
        Tree_38_Node_53 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 0.5,158,159);
        Tree_38_Node_29 := IF ( le.p_PropAgeNewestPurchase < 576.5,Tree_38_Node_52,Tree_38_Node_53);
        Tree_38_Node_14 := CHOOSE ( le.p_readmit_lift,Tree_38_Node_28,Tree_38_Node_29,Tree_38_Node_28,Tree_38_Node_28,Tree_38_Node_28,Tree_38_Node_29,Tree_38_Node_28,Tree_38_Node_28,Tree_38_Node_29,Tree_38_Node_28,Tree_38_Node_28,Tree_38_Node_29,Tree_38_Node_28);
        Tree_38_Node_7 := CHOOSE ( le.p_readmit_diag,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14,136,Tree_38_Node_14,Tree_38_Node_14,Tree_38_Node_14);
        Tree_38_Node_3 := IF ( le.p_PrevAddrAgeOldestRecord < 507.0,Tree_38_Node_6,Tree_38_Node_7);
        Tree_38_Node_1 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 0.5,Tree_38_Node_2,Tree_38_Node_3);
    UNSIGNED2 Score1_Tree38_node := Tree_38_Node_1;
    REAL8 Score1_Tree38_score := CASE(Score1_Tree38_node,136=>0.059230015,137=>0.089470424,138=>-0.0033534903,139=>-0.046816215,140=>0.00855654,141=>-0.06595748,142=>0.06396477,143=>-0.030770196,144=>0.13217811,145=>0.078760706,146=>-0.032340005,147=>0.25275296,148=>-0.080795094,149=>-0.07703697,150=>-0.020403031,151=>0.14378418,152=>-0.04609411,153=>-0.06992122,154=>-0.09264698,155=>0.010521912,156=>0.07962844,157=>-0.0452257,158=>-0.0021829563,159=>0.12508354,160=>-0.011549983,161=>-0.032259807,162=>0.0036380913,163=>0.04514566,164=>0.08095746,165=>0.003275915,166=>-0.06257442,167=>0.030748624,168=>0.061220452,169=>0.23330376,170=>-0.00486824,171=>0.10762252,172=>-0.08458632,173=>-0.08085686,174=>-0.08034807,175=>-0.06785374,176=>-0.03733442,177=>0.054605775,178=>-0.061140448,179=>0.032525387,180=>-0.014519497,181=>0.09089886,182=>0.005581472,183=>0.051403575,184=>-0.0077777654,185=>0.04470895,186=>0.0051472844,187=>0.09133359,188=>0.025593052,189=>0.12959416,190=>-0.0031042139,191=>0.016251842,192=>-0.013542297,193=>0.039315335,194=>-0.0021041187,195=>-0.052030414,196=>0.011828333,197=>0.13577117,198=>-0.023645587,199=>-0.069105595,200=>-0.037122868,201=>0.028279662,202=>0.101477444,203=>-0.010389429,0);
ENDMACRO;
