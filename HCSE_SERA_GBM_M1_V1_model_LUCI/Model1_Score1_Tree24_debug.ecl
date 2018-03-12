﻿EXPORT Model1_Score1_Tree24_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_24_Node_50 := IF ( le.p_EvictionAge < 76.5,143,144);
        Tree_24_Node_51 := IF ( le.p_v1_CrtRecTimeNewest < 208.5,145,146);
        Tree_24_Node_30 := IF ( le.p_v1_PropTimeLastSale < 79.5,Tree_24_Node_50,Tree_24_Node_51);
        Tree_24_Node_53 := CHOOSE ( le.p_admit_diag,147,147,147,147,148,147,147,148,147,148,147,148,147);
        Tree_24_Node_31 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,136,Tree_24_Node_53);
        Tree_24_Node_16 := IF ( le.p_v1_HHPropCurrOwnedCnt < 4.5,Tree_24_Node_30,Tree_24_Node_31);
        Tree_24_Node_17 := IF ( le.p_SSNIssueState < 31.5,131,132);
        Tree_24_Node_8 := IF ( le.p_PRSearchOtherCount24 < 13.5,Tree_24_Node_16,Tree_24_Node_17);
        Tree_24_Node_9 := IF ( le.p_CurrAddrLenOfRes < 23.5,127,128);
        Tree_24_Node_4 := IF ( le.p_BPV_1 < 2.899849,Tree_24_Node_8,Tree_24_Node_9);
        Tree_24_Node_54 := IF ( le.p_PrevAddrAgeLastSale < 170.0,149,150);
        Tree_24_Node_55 := IF ( le.p_AgeOldestRecord < 511.5,151,152);
        Tree_24_Node_34 := CHOOSE ( le.p_readmit_diag,Tree_24_Node_54,Tree_24_Node_54,Tree_24_Node_54,Tree_24_Node_54,Tree_24_Node_54,Tree_24_Node_54,Tree_24_Node_55,Tree_24_Node_54,Tree_24_Node_55,Tree_24_Node_55,Tree_24_Node_55,Tree_24_Node_55,Tree_24_Node_54);
        Tree_24_Node_56 := CHOOSE ( le.p_readmit_lift,153,154,154,153,153,153,153,153,153,153,153,153,153);
        Tree_24_Node_35 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 156.0,Tree_24_Node_56,137);
        Tree_24_Node_20 := IF ( le.p_v1_RaAPropOwnerAVMMed < 77512.5,Tree_24_Node_34,Tree_24_Node_35);
        Tree_24_Node_10 := CHOOSE ( le.p_financial_class,Tree_24_Node_20,Tree_24_Node_20,129,Tree_24_Node_20,Tree_24_Node_20,Tree_24_Node_20,Tree_24_Node_20,Tree_24_Node_20,Tree_24_Node_20,Tree_24_Node_20,129,129,Tree_24_Node_20,Tree_24_Node_20,Tree_24_Node_20,Tree_24_Node_20);
        Tree_24_Node_5 := IF ( le.p_CurrAddrAVMValue12 < 408694.5,Tree_24_Node_10,126);
        Tree_24_Node_2 := IF ( le.p_PropAgeOldestPurchase < 465.0,Tree_24_Node_4,Tree_24_Node_5);
        Tree_24_Node_60 := IF ( le.p_NonDerogCount01 < 3.5,159,160);
        Tree_24_Node_38 := IF ( le.p_BPV_3 < 3.7902937,Tree_24_Node_60,138);
        Tree_24_Node_62 := IF ( le.p_v1_RaAMedIncomeRange < 4.5,161,162);
        Tree_24_Node_63 := IF ( le.p_PhoneEDAAgeNewestRecord < 44.5,163,164);
        Tree_24_Node_39 := CHOOSE ( le.p_readmit_diag,Tree_24_Node_62,Tree_24_Node_62,Tree_24_Node_62,Tree_24_Node_63,Tree_24_Node_63,Tree_24_Node_62,Tree_24_Node_62,Tree_24_Node_62,Tree_24_Node_62,Tree_24_Node_63,Tree_24_Node_62,Tree_24_Node_62,Tree_24_Node_63);
        Tree_24_Node_24 := IF ( le.p_SubjectLastNameCount < 5.5,Tree_24_Node_38,Tree_24_Node_39);
        Tree_24_Node_64 := IF ( le.p_v1_CrtRecTimeNewest < 24.5,165,166);
        Tree_24_Node_65 := IF ( le.p_LienReleasedAge < 126.5,167,168);
        Tree_24_Node_40 := IF ( le.p_PrevAddrCarTheftIndex < 180.5,Tree_24_Node_64,Tree_24_Node_65);
        Tree_24_Node_66 := IF ( le.p_SubjectAddrCount < 7.5,169,170);
        Tree_24_Node_67 := CHOOSE ( le.p_admit_diag,171,172,172,172,172,171,171,172,172,171,171,172,171);
        Tree_24_Node_41 := IF ( le.p_CurrAddrAVMValue60 < 105787.5,Tree_24_Node_66,Tree_24_Node_67);
        Tree_24_Node_25 := IF ( le.p_age_in_years < 68.69422,Tree_24_Node_40,Tree_24_Node_41);
        Tree_24_Node_13 := CHOOSE ( le.p_financial_class,Tree_24_Node_24,Tree_24_Node_24,Tree_24_Node_24,Tree_24_Node_24,Tree_24_Node_24,Tree_24_Node_24,Tree_24_Node_25,Tree_24_Node_24,Tree_24_Node_25,Tree_24_Node_25,Tree_24_Node_24,Tree_24_Node_24,Tree_24_Node_24,Tree_24_Node_25,Tree_24_Node_25,Tree_24_Node_24);
        Tree_24_Node_58 := IF ( le.p_RelativesCount < 2.5,155,156);
        Tree_24_Node_59 := IF ( le.p_IdentityRiskLevel < 2.5,157,158);
        Tree_24_Node_36 := IF ( le.p_PrevAddrMedianValue < 281249.5,Tree_24_Node_58,Tree_24_Node_59);
        Tree_24_Node_23 := IF ( le.p_v1_RaAPropOwnerAVMMed < 492217.5,Tree_24_Node_36,133);
        Tree_24_Node_12 := IF ( le.p_age_in_years < 16.754688,130,Tree_24_Node_23);
        Tree_24_Node_6 := CHOOSE ( le.p_patient_type,Tree_24_Node_13,Tree_24_Node_12);
        Tree_24_Node_68 := CHOOSE ( le.p_financial_class,173,174,174,174,173,174,173,174,174,174,174,174,174,174,173,173);
        Tree_24_Node_69 := CHOOSE ( le.p_financial_class,175,175,175,175,175,176,176,175,176,175,176,176,175,175,176,175);
        Tree_24_Node_42 := CHOOSE ( le.p_readmit_lift,Tree_24_Node_68,Tree_24_Node_68,Tree_24_Node_68,Tree_24_Node_69,Tree_24_Node_68,Tree_24_Node_69,Tree_24_Node_69,Tree_24_Node_68,Tree_24_Node_69,Tree_24_Node_69,Tree_24_Node_68,Tree_24_Node_68,Tree_24_Node_69);
        Tree_24_Node_71 := CHOOSE ( le.p_readmit_diag,179,179,179,179,179,180,180,180,179,180,180,179,179);
        Tree_24_Node_70 := CHOOSE ( le.p_readmit_diag,178,178,178,178,177,178,177,177,178,177,178,177,178);
        Tree_24_Node_43 := CHOOSE ( le.p_admit_diag,Tree_24_Node_71,Tree_24_Node_71,Tree_24_Node_71,Tree_24_Node_70,Tree_24_Node_70,Tree_24_Node_70,Tree_24_Node_71,Tree_24_Node_71,Tree_24_Node_71,Tree_24_Node_71,Tree_24_Node_71,Tree_24_Node_70,Tree_24_Node_70);
        Tree_24_Node_26 := IF ( le.p_NonDerogCount01 < 4.5,Tree_24_Node_42,Tree_24_Node_43);
        Tree_24_Node_72 := IF ( le.p_PrevAddrLenOfRes < 85.5,181,182);
        Tree_24_Node_73 := IF ( le.p_PhoneOtherAgeNewestRecord < 73.0,183,184);
        Tree_24_Node_44 := CHOOSE ( le.p_readmit_lift,Tree_24_Node_72,Tree_24_Node_73,Tree_24_Node_73,Tree_24_Node_72,Tree_24_Node_72,Tree_24_Node_72,Tree_24_Node_72,Tree_24_Node_72,Tree_24_Node_72,Tree_24_Node_72,Tree_24_Node_73,Tree_24_Node_72,Tree_24_Node_72);
        Tree_24_Node_75 := IF ( le.p_v1_ProspectTimeLastUpdate < 126.5,185,186);
        Tree_24_Node_45 := IF ( le.p_SSNHighIssueAge < 361.5,139,Tree_24_Node_75);
        Tree_24_Node_27 := IF ( le.p_EstimatedAnnualIncome < 58031.5,Tree_24_Node_44,Tree_24_Node_45);
        Tree_24_Node_14 := IF ( le.p_IdentityRiskLevel < 1.5,Tree_24_Node_26,Tree_24_Node_27);
        Tree_24_Node_76 := IF ( le.p_v1_ProspectTimeLastUpdate < 38.5,187,188);
        Tree_24_Node_46 := IF ( le.p_BP_3 < 2.5,Tree_24_Node_76,140);
        Tree_24_Node_47 := IF ( le.p_SSNAddrCount < 11.5,141,142);
        Tree_24_Node_28 := IF ( le.p_PhoneOtherAgeNewestRecord < 63.5,Tree_24_Node_46,Tree_24_Node_47);
        Tree_24_Node_29 := IF ( le.p_BPV_3 < 2.1057189,134,135);
        Tree_24_Node_15 := CHOOSE ( le.p_readmit_diag,Tree_24_Node_28,Tree_24_Node_28,Tree_24_Node_28,Tree_24_Node_28,Tree_24_Node_29,Tree_24_Node_29,Tree_24_Node_29,Tree_24_Node_29,Tree_24_Node_29,Tree_24_Node_28,Tree_24_Node_29,Tree_24_Node_28,Tree_24_Node_28);
        Tree_24_Node_7 := IF ( le.p_BP_2 < 2.5,Tree_24_Node_14,Tree_24_Node_15);
        Tree_24_Node_3 := IF ( le.p_EstimatedAnnualIncome < 35607.5,Tree_24_Node_6,Tree_24_Node_7);
        Tree_24_Node_1 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 0.5,Tree_24_Node_2,Tree_24_Node_3);
    SELF.Score1_Tree24_node := Tree_24_Node_1;
    SELF.Score1_Tree24_score := CASE(SELF.Score1_Tree24_node,126=>0.16686895,127=>0.08138487,128=>0.03239799,129=>0.17107157,130=>0.1840868,131=>-0.05662449,132=>0.23549064,133=>0.1373817,134=>0.14739579,135=>0.040661998,136=>0.044887997,137=>0.038672455,138=>0.081029624,139=>0.11949558,140=>0.04731671,141=>0.09409994,142=>-0.016104223,143=>-0.018482467,144=>-0.07203396,145=>0.004632256,146=>0.0891711,147=>-0.07112192,148=>0.017850291,149=>-0.0064267116,150=>0.10176352,151=>0.20937231,152=>0.047246605,153=>-0.095616326,154=>-0.056276474,155=>0.03265716,156=>-0.029679408,157=>0.0049203103,158=>0.16206877,159=>0.0085265795,160=>-0.012653532,161=>-0.07738575,162=>-0.030316558,163=>-0.041428693,164=>0.10316839,165=>0.033662602,166=>0.006358332,167=>0.035019215,168=>0.13721481,169=>-0.005317371,170=>0.012691934,171=>0.0027572846,172=>0.035283685,173=>-0.02921231,174=>5.791491E-4,175=>-0.0049624597,176=>0.038650107,177=>-0.07858682,178=>-0.039338607,179=>-0.013771393,180=>0.037324764,181=>-0.07556918,182=>-0.09454897,183=>-0.059643943,184=>0.03159804,185=>-0.0482338,186=>0.057796046,187=>-0.00448658,188=>-0.09142767,0);
ENDMACRO;
