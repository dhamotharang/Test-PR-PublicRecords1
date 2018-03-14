﻿EXPORT Model1_Score1_Tree138(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_138_Node_48 := IF ( le.p_v1_CrtRecLienJudgCnt < 10.5,141,142);
        Tree_138_Node_49 := IF ( le.p_LastNameChangeAge < 205.5,143,144);
        Tree_138_Node_30 := IF ( le.p_v1_LifeEvEverResidedCnt < 4.5,Tree_138_Node_48,Tree_138_Node_49);
        Tree_138_Node_50 := CHOOSE ( le.p_readmit_diag,146,146,146,146,146,146,145,145,146,146,146,146,146);
        Tree_138_Node_51 := IF ( le.p_NonDerogCount01 < 3.5,147,148);
        Tree_138_Node_31 := IF ( le.p_PrevAddrAgeNewestRecord < 330.5,Tree_138_Node_50,Tree_138_Node_51);
        Tree_138_Node_16 := IF ( le.p_LastNameChangeAge < 372.5,Tree_138_Node_30,Tree_138_Node_31);
        Tree_138_Node_55 := IF ( le.p_DerogAge < 201.5,153,154);
        Tree_138_Node_33 := IF ( le.p_age_in_years < 51.1875,130,Tree_138_Node_55);
        Tree_138_Node_52 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 2.5,149,150);
        Tree_138_Node_53 := CHOOSE ( le.p_readmit_lift,152,152,151,151,151,151,151,152,151,151,151,151,151);
        Tree_138_Node_32 := IF ( le.p_PrevAddrAgeNewestRecord < 163.5,Tree_138_Node_52,Tree_138_Node_53);
        Tree_138_Node_17 := CHOOSE ( le.p_readmit_diag,Tree_138_Node_33,Tree_138_Node_32,Tree_138_Node_33,Tree_138_Node_32,Tree_138_Node_33,Tree_138_Node_32,Tree_138_Node_32,Tree_138_Node_33,Tree_138_Node_32,Tree_138_Node_33,Tree_138_Node_33,Tree_138_Node_33,Tree_138_Node_32);
        Tree_138_Node_8 := IF ( le.p_LastNameChangeAge < 384.5,Tree_138_Node_16,Tree_138_Node_17);
        Tree_138_Node_56 := CHOOSE ( le.p_readmit_diag,156,156,156,156,155,156,156,155,155,156,155,155,156);
        Tree_138_Node_57 := IF ( le.p_PrevAddrCrimeIndex < 29.5,157,158);
        Tree_138_Node_34 := IF ( le.p_SSNIssueState < 29.5,Tree_138_Node_56,Tree_138_Node_57);
        Tree_138_Node_58 := IF ( le.p_SSNIssueState < 39.5,159,160);
        Tree_138_Node_35 := CHOOSE ( le.p_admit_diag,Tree_138_Node_58,Tree_138_Node_58,Tree_138_Node_58,131,Tree_138_Node_58,Tree_138_Node_58,Tree_138_Node_58,Tree_138_Node_58,131,131,131,Tree_138_Node_58,Tree_138_Node_58);
        Tree_138_Node_18 := IF ( le.p_v1_CrtRecTimeNewest < 232.5,Tree_138_Node_34,Tree_138_Node_35);
        Tree_138_Node_60 := IF ( le.p_RelativesPropOwnedCount < 1.5,161,162);
        Tree_138_Node_61 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 25.5,163,164);
        Tree_138_Node_36 := CHOOSE ( le.p_readmit_diag,Tree_138_Node_60,Tree_138_Node_60,Tree_138_Node_60,Tree_138_Node_61,Tree_138_Node_60,Tree_138_Node_60,Tree_138_Node_61,Tree_138_Node_61,Tree_138_Node_60,Tree_138_Node_60,Tree_138_Node_61,Tree_138_Node_61,Tree_138_Node_61);
        Tree_138_Node_63 := CHOOSE ( le.p_readmit_diag,167,168,167,167,167,168,167,167,168,167,167,168,167);
        Tree_138_Node_62 := IF ( le.p_PrevAddrCrimeIndex < 79.5,165,166);
        Tree_138_Node_37 := CHOOSE ( le.p_readmit_lift,Tree_138_Node_63,Tree_138_Node_63,Tree_138_Node_63,Tree_138_Node_62,Tree_138_Node_62,Tree_138_Node_63,Tree_138_Node_63,Tree_138_Node_62,Tree_138_Node_63,Tree_138_Node_62,Tree_138_Node_62,Tree_138_Node_62,Tree_138_Node_63);
        Tree_138_Node_19 := IF ( le.p_v1_ProspectTimeLastUpdate < 40.5,Tree_138_Node_36,Tree_138_Node_37);
        Tree_138_Node_9 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 7.5,Tree_138_Node_18,Tree_138_Node_19);
        Tree_138_Node_4 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_138_Node_8,Tree_138_Node_9);
        Tree_138_Node_64 := IF ( le.p_PrevAddrCrimeIndex < 159.5,169,170);
        Tree_138_Node_65 := IF ( le.p_PropAgeNewestPurchase < 576.5,171,172);
        Tree_138_Node_38 := CHOOSE ( le.p_readmit_lift,Tree_138_Node_64,Tree_138_Node_65,Tree_138_Node_64,Tree_138_Node_64,Tree_138_Node_64,Tree_138_Node_65,Tree_138_Node_64,Tree_138_Node_64,Tree_138_Node_64,Tree_138_Node_64,Tree_138_Node_64,Tree_138_Node_65,Tree_138_Node_64);
        Tree_138_Node_20 := IF ( le.p_AddrChangeCount24 < 1.5,Tree_138_Node_38,128);
        Tree_138_Node_67 := IF ( le.p_PrevAddrBurglaryIndex < 129.5,175,176);
        Tree_138_Node_66 := CHOOSE ( le.p_readmit_diag,173,174,173,174,173,173,173,173,173,173,173,173,173);
        Tree_138_Node_40 := CHOOSE ( le.p_admit_diag,Tree_138_Node_67,Tree_138_Node_67,Tree_138_Node_66,Tree_138_Node_66,Tree_138_Node_66,Tree_138_Node_67,Tree_138_Node_67,Tree_138_Node_66,Tree_138_Node_66,Tree_138_Node_66,Tree_138_Node_66,Tree_138_Node_66,Tree_138_Node_66);
        Tree_138_Node_41 := IF ( le.p_PrevAddrBurglaryIndex < 129.5,132,133);
        Tree_138_Node_21 := IF ( le.p_age_in_years < 88.02563,Tree_138_Node_40,Tree_138_Node_41);
        Tree_138_Node_10 := IF ( le.p_v1_ProspectTimeLastUpdate < 151.5,Tree_138_Node_20,Tree_138_Node_21);
        Tree_138_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10,122,Tree_138_Node_10,Tree_138_Node_10,Tree_138_Node_10);
        Tree_138_Node_2 := IF ( le.p_PrevAddrAgeOldestRecord < 507.0,Tree_138_Node_4,Tree_138_Node_5);
        Tree_138_Node_42 := CHOOSE ( le.p_financial_class,134,135,134,135,135,135,135,135,134,135,134,135,135,134,135,135);
        Tree_138_Node_43 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,136,137);
        Tree_138_Node_22 := CHOOSE ( le.p_admit_diag,Tree_138_Node_42,Tree_138_Node_43,Tree_138_Node_43,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42,Tree_138_Node_42);
        Tree_138_Node_12 := IF ( le.p_LastNameChangeAge < 265.5,Tree_138_Node_22,123);
        Tree_138_Node_74 := IF ( le.p_SrcsConfirmIDAddrCount < 5.5,177,178);
        Tree_138_Node_44 := CHOOSE ( le.p_financial_class,138,138,138,138,138,138,138,138,Tree_138_Node_74,138,138,Tree_138_Node_74,138,Tree_138_Node_74,Tree_138_Node_74,138);
        Tree_138_Node_76 := IF ( le.p_v1_ProspectAge < 62.5,179,180);
        Tree_138_Node_45 := CHOOSE ( le.p_financial_class,Tree_138_Node_76,139,139,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76,139,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76,Tree_138_Node_76);
        Tree_138_Node_24 := CHOOSE ( le.p_readmit_lift,Tree_138_Node_44,Tree_138_Node_45,Tree_138_Node_44,Tree_138_Node_45,Tree_138_Node_44,Tree_138_Node_44,Tree_138_Node_44,Tree_138_Node_44,Tree_138_Node_44,Tree_138_Node_44,Tree_138_Node_44,Tree_138_Node_44,Tree_138_Node_44);
        Tree_138_Node_13 := CHOOSE ( le.p_readmit_diag,Tree_138_Node_24,Tree_138_Node_24,124,Tree_138_Node_24,Tree_138_Node_24,Tree_138_Node_24,Tree_138_Node_24,124,124,Tree_138_Node_24,Tree_138_Node_24,Tree_138_Node_24,124);
        Tree_138_Node_6 := IF ( le.p_SSNLowIssueAge < 484.5,Tree_138_Node_12,Tree_138_Node_13);
        Tree_138_Node_79 := IF ( le.p_NonDerogCount < 8.5,181,182);
        Tree_138_Node_46 := IF ( le.p_v1_ProspectAge < 55.5,140,Tree_138_Node_79);
        Tree_138_Node_28 := IF ( le.p_PrevAddrMurderIndex < 159.5,Tree_138_Node_46,129);
        Tree_138_Node_15 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,Tree_138_Node_28,127);
        Tree_138_Node_14 := IF ( le.p_v1_RaAPropOwnerAVMMed < 158146.5,125,126);
        Tree_138_Node_7 := CHOOSE ( le.p_readmit_diag,Tree_138_Node_15,Tree_138_Node_15,Tree_138_Node_14,Tree_138_Node_15,Tree_138_Node_14,Tree_138_Node_14,Tree_138_Node_14,Tree_138_Node_15,Tree_138_Node_15,Tree_138_Node_14,Tree_138_Node_14,Tree_138_Node_15,Tree_138_Node_15);
        Tree_138_Node_3 := IF ( le.p_PrevAddrLenOfRes < 193.5,Tree_138_Node_6,Tree_138_Node_7);
        Tree_138_Node_1 := IF ( le.p_RelativesPropOwnedCount < 9.5,Tree_138_Node_2,Tree_138_Node_3);
    UNSIGNED2 Score1_Tree138_node := Tree_138_Node_1;
    REAL8 Score1_Tree138_score := CASE(Score1_Tree138_node,122=>0.018473206,123=>0.028216274,124=>4.2503615E-4,125=>-0.030123908,126=>-0.009454621,127=>-0.01447219,128=>0.029181976,129=>0.046235237,130=>0.03221082,131=>0.05500709,132=>4.5501755E-4,133=>0.045040354,134=>-0.028670385,135=>-0.027126487,136=>-0.020515054,137=>0.045238607,138=>-0.01878414,139=>-0.003144435,140=>0.032577436,141=>4.631568E-5,142=>-0.015451057,143=>-0.010073978,144=>0.0027186207,145=>-0.013054137,146=>0.006682578,147=>0.01284766,148=>0.063043945,149=>-0.0010244268,150=>-0.006945512,151=>-0.029434362,152=>-0.010350468,153=>-1.2420258E-4,154=>0.014128788,155=>-0.007716266,156=>0.008780357,157=>0.010525247,158=>-0.007646706,159=>0.0017725998,160=>0.050085835,161=>0.0064016515,162=>-0.001860313,163=>0.016567249,164=>-0.0015122412,165=>-0.02836175,166=>-0.0042229635,167=>-0.005896738,168=>0.0020723576,169=>-0.017182838,170=>0.003707169,171=>-0.0081743365,172=>0.03002258,173=>-0.029037446,174=>-0.011975884,175=>0.033296797,176=>-0.020410018,177=>-0.03033439,178=>-0.029142987,179=>-0.017792856,180=>-0.028132394,181=>0.01871566,182=>-0.022788778,0);
ENDMACRO;
