﻿EXPORT Model1_Score1_Tree75(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_75_Node_50 := CHOOSE ( le.p_gender,146,147);
        Tree_75_Node_51 := CHOOSE ( le.p_readmit_lift,149,149,149,148,148,148,149,149,149,148,148,149,149);
        Tree_75_Node_28 := IF ( le.p_PropAgeNewestPurchase < 351.5,Tree_75_Node_50,Tree_75_Node_51);
        Tree_75_Node_52 := IF ( le.p_CurrAddrMedianIncome < 61107.5,150,151);
        Tree_75_Node_53 := IF ( le.p_PhoneOtherAgeNewestRecord < 14.5,152,153);
        Tree_75_Node_29 := CHOOSE ( le.p_readmit_lift,Tree_75_Node_52,Tree_75_Node_52,Tree_75_Node_53,Tree_75_Node_52,Tree_75_Node_53,Tree_75_Node_53,Tree_75_Node_52,Tree_75_Node_53,Tree_75_Node_53,Tree_75_Node_52,Tree_75_Node_52,Tree_75_Node_52,Tree_75_Node_52);
        Tree_75_Node_16 := IF ( le.p_PrevAddrAgeNewestRecord < 15.5,Tree_75_Node_28,Tree_75_Node_29);
        Tree_75_Node_55 := IF ( le.p_v1_ProspectTimeOnRecord < 173.5,156,157);
        Tree_75_Node_54 := IF ( le.p_DerogAge < 172.5,154,155);
        Tree_75_Node_30 := CHOOSE ( le.p_financial_class,Tree_75_Node_55,Tree_75_Node_54,Tree_75_Node_55,Tree_75_Node_54,Tree_75_Node_55,Tree_75_Node_54,Tree_75_Node_54,Tree_75_Node_54,Tree_75_Node_55,Tree_75_Node_55,Tree_75_Node_54,Tree_75_Node_54,Tree_75_Node_54,Tree_75_Node_55,Tree_75_Node_54,Tree_75_Node_55);
        Tree_75_Node_56 := IF ( le.p_PRSearchLocateCount < 3.5,158,159);
        Tree_75_Node_31 := IF ( le.p_PrevAddrBurglaryIndex < 109.5,Tree_75_Node_56,127);
        Tree_75_Node_17 := IF ( le.p_LienReleasedAge < 147.5,Tree_75_Node_30,Tree_75_Node_31);
        Tree_75_Node_9 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 127.5,Tree_75_Node_16,Tree_75_Node_17);
        Tree_75_Node_42 := IF ( le.p_AddrChangeCount24 < 1.5,134,135);
        Tree_75_Node_43 := IF ( le.p_v1_CrtRecTimeNewest < 84.5,136,137);
        Tree_75_Node_24 := CHOOSE ( le.p_readmit_diag,Tree_75_Node_42,Tree_75_Node_43,Tree_75_Node_42,Tree_75_Node_43,Tree_75_Node_43,Tree_75_Node_43,Tree_75_Node_43,Tree_75_Node_43,Tree_75_Node_42,Tree_75_Node_43,Tree_75_Node_43,Tree_75_Node_43,Tree_75_Node_43);
        Tree_75_Node_44 := IF ( le.p_PhoneOtherAgeOldestRecord < 16.5,138,139);
        Tree_75_Node_45 := CHOOSE ( le.p_gender,141,140);
        Tree_75_Node_25 := IF ( le.p_v1_PropTimeLastSale < 160.5,Tree_75_Node_44,Tree_75_Node_45);
        Tree_75_Node_14 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 7.5,Tree_75_Node_24,Tree_75_Node_25);
        Tree_75_Node_46 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,142,143);
        Tree_75_Node_47 := CHOOSE ( le.p_financial_class,144,145,144,144,144,145,144,144,145,145,144,144,145,145,144,144);
        Tree_75_Node_26 := IF ( le.p_PrevAddrMedianValue < 142298.5,Tree_75_Node_46,Tree_75_Node_47);
        Tree_75_Node_27 := IF ( le.p_StatusMostRecent < 2.5,125,126);
        Tree_75_Node_15 := IF ( le.p_LienFiledAge < 130.5,Tree_75_Node_26,Tree_75_Node_27);
        Tree_75_Node_8 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 0.5,Tree_75_Node_14,Tree_75_Node_15);
        Tree_75_Node_4 := CHOOSE ( le.p_admit_diag,Tree_75_Node_9,Tree_75_Node_9,Tree_75_Node_9,Tree_75_Node_8,Tree_75_Node_9,Tree_75_Node_9,Tree_75_Node_8,Tree_75_Node_8,Tree_75_Node_9,Tree_75_Node_8,Tree_75_Node_8,Tree_75_Node_9,Tree_75_Node_9);
        Tree_75_Node_58 := IF ( le.p_CurrAddrBurglaryIndex < 59.5,160,161);
        Tree_75_Node_59 := IF ( le.p_SSNIssueState < 28.5,162,163);
        Tree_75_Node_32 := IF ( le.p_SSNIdentitiesCount < 1.5,Tree_75_Node_58,Tree_75_Node_59);
        Tree_75_Node_60 := IF ( le.p_DivSSNAddrMSourceCount < 5.5,164,165);
        Tree_75_Node_61 := CHOOSE ( le.p_readmit_diag,166,166,166,166,166,167,166,167,166,167,167,166,166);
        Tree_75_Node_33 := IF ( le.p_PropAgeOldestPurchase < 95.5,Tree_75_Node_60,Tree_75_Node_61);
        Tree_75_Node_18 := IF ( le.p_SSNHighIssueAge < 225.0,Tree_75_Node_32,Tree_75_Node_33);
        Tree_75_Node_64 := IF ( le.p_age_in_years < 75.9525,170,171);
        Tree_75_Node_65 := CHOOSE ( le.p_readmit_diag,172,172,172,173,172,172,172,172,172,173,172,173,172);
        Tree_75_Node_35 := IF ( le.p_SSNIdentitiesCount < 1.5,Tree_75_Node_64,Tree_75_Node_65);
        Tree_75_Node_63 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 155.5,168,169);
        Tree_75_Node_34 := CHOOSE ( le.p_readmit_lift,Tree_75_Node_63,Tree_75_Node_63,Tree_75_Node_63,128,128,128,128,128,128,128,128,128,128);
        Tree_75_Node_19 := CHOOSE ( le.p_financial_class,Tree_75_Node_35,Tree_75_Node_34,Tree_75_Node_35,Tree_75_Node_34,Tree_75_Node_34,Tree_75_Node_35,Tree_75_Node_35,Tree_75_Node_35,Tree_75_Node_35,Tree_75_Node_35,Tree_75_Node_34,Tree_75_Node_35,Tree_75_Node_35,Tree_75_Node_34,Tree_75_Node_34,Tree_75_Node_35);
        Tree_75_Node_10 := IF ( le.p_v1_RaAPropOwnerAVMMed < 234374.5,Tree_75_Node_18,Tree_75_Node_19);
        Tree_75_Node_66 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 2.5,174,175);
        Tree_75_Node_67 := IF ( le.p_PhoneEDAAgeNewestRecord < 131.5,176,177);
        Tree_75_Node_36 := CHOOSE ( le.p_readmit_diag,Tree_75_Node_66,Tree_75_Node_66,Tree_75_Node_66,Tree_75_Node_66,Tree_75_Node_67,Tree_75_Node_67,Tree_75_Node_67,Tree_75_Node_66,Tree_75_Node_66,Tree_75_Node_67,Tree_75_Node_66,Tree_75_Node_66,Tree_75_Node_66);
        Tree_75_Node_37 := CHOOSE ( le.p_financial_class,129,130,129,129,129,129,129,129,129,129,129,130,129,130,129,129);
        Tree_75_Node_20 := IF ( le.p_DerogAge < 286.5,Tree_75_Node_36,Tree_75_Node_37);
        Tree_75_Node_71 := CHOOSE ( le.p_readmit_diag,179,178,178,179,178,178,178,178,178,178,178,179,178);
        Tree_75_Node_38 := IF ( le.p_CurrAddrBurglaryIndex < 19.5,131,Tree_75_Node_71);
        Tree_75_Node_39 := IF ( le.p_AgeOldestRecord < 415.5,132,133);
        Tree_75_Node_21 := IF ( le.p_PhoneOtherAgeOldestRecord < 150.5,Tree_75_Node_38,Tree_75_Node_39);
        Tree_75_Node_11 := IF ( le.p_age_in_years < 82.75313,Tree_75_Node_20,Tree_75_Node_21);
        Tree_75_Node_5 := CHOOSE ( le.p_admit_diag,Tree_75_Node_10,Tree_75_Node_10,Tree_75_Node_11,Tree_75_Node_11,Tree_75_Node_10,Tree_75_Node_10,Tree_75_Node_10,Tree_75_Node_10,Tree_75_Node_10,Tree_75_Node_11,Tree_75_Node_10,Tree_75_Node_10,Tree_75_Node_11);
        Tree_75_Node_2 := IF ( le.p_SearchSSNSearchCount < 1.5,Tree_75_Node_4,Tree_75_Node_5);
        Tree_75_Node_23 := IF ( le.p_PhoneEDAAgeOldestRecord < 132.5,123,124);
        Tree_75_Node_12 := CHOOSE ( le.p_readmit_lift,122,Tree_75_Node_23,122,122,122,122,122,122,122,122,122,122,122);
        Tree_75_Node_6 := IF ( le.p_CurrAddrAVMValue60 < 83329.0,Tree_75_Node_12,121);
        Tree_75_Node_3 := IF ( le.p_LastNameChangeAge < 314.5,Tree_75_Node_6,120);
        Tree_75_Node_1 := IF ( le.p_PhoneOtherAgeNewestRecord < 153.5,Tree_75_Node_2,Tree_75_Node_3);
    UNSIGNED2 Score1_Tree75_node := Tree_75_Node_1;
    REAL8 Score1_Tree75_score := CASE(Score1_Tree75_node,120=>0.012474076,121=>-9.733616E-4,122=>-0.055519287,123=>-0.028877575,124=>-0.05751438,125=>0.117852695,126=>0.018258331,127=>-0.0037817347,128=>-0.05624515,129=>-0.008468468,130=>0.09775639,131=>0.07837428,132=>0.12624297,133=>0.008283345,134=>-0.016995808,135=>0.049027283,136=>-0.0046564704,137=>0.00600993,138=>-0.0010137986,139=>-0.02839406,140=>-0.004766893,141=>0.085306995,142=>-0.027473377,143=>0.020306313,144=>-0.010204615,145=>0.07807956,146=>0.0013161488,147=>0.0058480385,148=>-0.031699985,149=>-0.00510255,150=>-0.007053643,151=>0.0014479355,152=>0.00790747,153=>-0.009394593,154=>-0.027373115,155=>0.03845423,156=>0.037984423,157=>0.0068856874,158=>0.04521733,159=>0.13337924,160=>0.10224902,161=>0.017171498,162=>-0.05297837,163=>0.016260233,164=>-0.017885406,165=>-0.0020866368,166=>5.6856143E-4,167=>0.018861152,168=>-0.02244753,169=>0.021792078,170=>-0.0228933,171=>0.009668687,172=>-0.0011651625,173=>0.03969239,174=>-0.0018714868,175=>0.034437254,176=>0.012275797,177=>0.061684713,178=>-0.021285739,179=>0.025833322,0);
ENDMACRO;
