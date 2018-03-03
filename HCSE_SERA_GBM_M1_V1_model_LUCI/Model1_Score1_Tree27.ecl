﻿EXPORT Model1_Score1_Tree27(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_27_Node_45 := IF ( le.p_age_in_years < 0.13141784,126,127);
        Tree_27_Node_26 := CHOOSE ( le.p_readmit_lift,116,116,Tree_27_Node_45,Tree_27_Node_45,Tree_27_Node_45,Tree_27_Node_45,116,Tree_27_Node_45,Tree_27_Node_45,Tree_27_Node_45,Tree_27_Node_45,Tree_27_Node_45,116);
        Tree_27_Node_14 := IF ( le.p_age_in_years < 0.34472615,Tree_27_Node_26,112);
        Tree_27_Node_15 := CHOOSE ( le.p_gender,114,113);
        Tree_27_Node_8 := IF ( le.p_age_in_years < 0.76231384,Tree_27_Node_14,Tree_27_Node_15);
        Tree_27_Node_48 := IF ( le.p_SSNLowIssueAge < 29.5,130,131);
        Tree_27_Node_31 := IF ( le.p_age_in_years < 0.39990234,Tree_27_Node_48,118);
        Tree_27_Node_47 := IF ( le.p_age_in_years < 1.199707,128,129);
        Tree_27_Node_30 := CHOOSE ( le.p_financial_class,Tree_27_Node_47,117,Tree_27_Node_47,Tree_27_Node_47,117,Tree_27_Node_47,Tree_27_Node_47,Tree_27_Node_47,Tree_27_Node_47,Tree_27_Node_47,Tree_27_Node_47,Tree_27_Node_47,Tree_27_Node_47,117,117,Tree_27_Node_47);
        Tree_27_Node_16 := CHOOSE ( le.p_readmit_lift,Tree_27_Node_31,Tree_27_Node_30,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31,Tree_27_Node_31);
        Tree_27_Node_9 := CHOOSE ( le.p_admit_diag,109,Tree_27_Node_16,109,Tree_27_Node_16,109,109,Tree_27_Node_16,109,109,109,109,109,109);
        Tree_27_Node_4 := CHOOSE ( le.p_readmit_diag,Tree_27_Node_8,Tree_27_Node_9,Tree_27_Node_8,Tree_27_Node_9,Tree_27_Node_8,Tree_27_Node_8,Tree_27_Node_8,Tree_27_Node_9,Tree_27_Node_9,Tree_27_Node_8,Tree_27_Node_8,Tree_27_Node_8,Tree_27_Node_9);
        Tree_27_Node_2 := CHOOSE ( le.p_admit_diag,108,Tree_27_Node_4,Tree_27_Node_4,Tree_27_Node_4,108,Tree_27_Node_4,Tree_27_Node_4,Tree_27_Node_4,Tree_27_Node_4,Tree_27_Node_4,Tree_27_Node_4,Tree_27_Node_4,Tree_27_Node_4);
        Tree_27_Node_58 := IF ( le.p_BP_2 < 2.5,144,145);
        Tree_27_Node_59 := IF ( le.p_PhoneEDAAgeNewestRecord < 101.0,146,147);
        Tree_27_Node_36 := IF ( le.p_SubjectSSNCount < 1.5,Tree_27_Node_58,Tree_27_Node_59);
        Tree_27_Node_60 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 36.5,148,149);
        Tree_27_Node_37 := IF ( le.p_PhoneOtherAgeNewestRecord < 120.5,Tree_27_Node_60,121);
        Tree_27_Node_20 := IF ( le.p_v1_ProspectTimeOnRecord < 512.5,Tree_27_Node_36,Tree_27_Node_37);
        Tree_27_Node_11 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 546874.5,Tree_27_Node_20,110);
        Tree_27_Node_51 := IF ( le.p_PrevAddrCarTheftIndex < 180.5,134,135);
        Tree_27_Node_50 := IF ( le.p_BPV_3 < 2.69532,132,133);
        Tree_27_Node_32 := CHOOSE ( le.p_financial_class,Tree_27_Node_51,Tree_27_Node_50,Tree_27_Node_51,Tree_27_Node_50,Tree_27_Node_51,Tree_27_Node_50,Tree_27_Node_51,Tree_27_Node_51,Tree_27_Node_51,Tree_27_Node_51,Tree_27_Node_50,Tree_27_Node_50,Tree_27_Node_51,Tree_27_Node_51,Tree_27_Node_51,Tree_27_Node_50);
        Tree_27_Node_52 := CHOOSE ( le.p_admit_diag,137,137,137,137,137,136,136,137,137,136,137,137,136);
        Tree_27_Node_53 := IF ( le.p_PrevAddrCarTheftIndex < 9.5,138,139);
        Tree_27_Node_33 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 1.5,Tree_27_Node_52,Tree_27_Node_53);
        Tree_27_Node_18 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 94928.5,Tree_27_Node_32,Tree_27_Node_33);
        Tree_27_Node_54 := IF ( le.p_PhoneOtherAgeNewestRecord < 57.5,140,141);
        Tree_27_Node_55 := IF ( le.p_PrevAddrMedianIncome < 34316.5,142,143);
        Tree_27_Node_34 := IF ( le.p_NonDerogCount06 < 5.5,Tree_27_Node_54,Tree_27_Node_55);
        Tree_27_Node_35 := IF ( le.p_StatusMostRecent < 1.5,119,120);
        Tree_27_Node_19 := IF ( le.p_BPV_2 < 3.110811,Tree_27_Node_34,Tree_27_Node_35);
        Tree_27_Node_10 := CHOOSE ( le.p_gender,Tree_27_Node_18,Tree_27_Node_19);
        Tree_27_Node_6 := CHOOSE ( le.p_readmit_lift,Tree_27_Node_11,Tree_27_Node_10,Tree_27_Node_10,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11,Tree_27_Node_11);
        Tree_27_Node_62 := IF ( le.p_AgeOldestRecord < 626.5,150,151);
        Tree_27_Node_63 := IF ( le.p_DerogAge < 27.5,152,153);
        Tree_27_Node_38 := IF ( le.p_PRSearchOtherCount < 43.5,Tree_27_Node_62,Tree_27_Node_63);
        Tree_27_Node_64 := CHOOSE ( le.p_financial_class,155,154,155,154,154,154,154,154,155,154,154,154,154,155,154,154);
        Tree_27_Node_65 := IF ( le.p_v1_LifeEvEverResidedCnt < 1.5,156,157);
        Tree_27_Node_39 := IF ( le.p_NonDerogCount < 8.5,Tree_27_Node_64,Tree_27_Node_65);
        Tree_27_Node_22 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 2.5,Tree_27_Node_38,Tree_27_Node_39);
        Tree_27_Node_66 := CHOOSE ( le.p_readmit_lift,158,158,158,158,158,158,158,158,159,158,159,159,158);
        Tree_27_Node_40 := IF ( le.p_DerogAge < 262.5,Tree_27_Node_66,122);
        Tree_27_Node_69 := IF ( le.p_RelativesPropOwnedCount < 6.5,160,161);
        Tree_27_Node_41 := IF ( le.p_PrevAddrMedianIncome < 20966.0,123,Tree_27_Node_69);
        Tree_27_Node_23 := IF ( le.p_CurrAddrBurglaryIndex < 160.5,Tree_27_Node_40,Tree_27_Node_41);
        Tree_27_Node_12 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_27_Node_22,Tree_27_Node_23);
        Tree_27_Node_43 := IF ( le.p_PrevAddrCrimeIndex < 78.5,124,125);
        Tree_27_Node_24 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 0.5,115,Tree_27_Node_43);
        Tree_27_Node_13 := IF ( le.p_age_in_years < 70.53125,Tree_27_Node_24,111);
        Tree_27_Node_7 := CHOOSE ( le.p_readmit_lift,Tree_27_Node_12,Tree_27_Node_12,Tree_27_Node_12,Tree_27_Node_13,Tree_27_Node_12,Tree_27_Node_12,Tree_27_Node_13,Tree_27_Node_12,Tree_27_Node_12,Tree_27_Node_12,Tree_27_Node_12,Tree_27_Node_12,Tree_27_Node_12);
        Tree_27_Node_3 := IF ( le.p_EstimatedAnnualIncome < 41484.5,Tree_27_Node_6,Tree_27_Node_7);
        Tree_27_Node_1 := IF ( le.p_age_in_years < 1.5996094,Tree_27_Node_2,Tree_27_Node_3);
    UNSIGNED2 Score1_Tree27_node := Tree_27_Node_1;
    REAL8 Score1_Tree27_score := CASE(Score1_Tree27_node,108=>0.06902051,109=>0.08135975,110=>0.09630012,111=>-0.0535303,112=>0.0097436,113=>-0.08444286,114=>-0.082871996,115=>0.13238645,116=>-0.085366905,117=>-0.07946751,118=>0.057971004,119=>0.10489088,120=>-0.011034938,121=>0.0641391,122=>0.08614792,123=>0.24748516,124=>-0.025444385,125=>0.055129595,126=>-0.08263261,127=>-0.035218313,128=>-0.079380274,129=>-0.079622425,130=>-0.039683014,131=>0.055441704,132=>-0.015851561,133=>0.05704972,134=>-0.003602661,135=>0.01812434,136=>-0.025785709,137=>0.008622617,138=>0.11271497,139=>0.02324661,140=>0.010404211,141=>-0.005411185,142=>-0.058148585,143=>-0.010846697,144=>0.005768607,145=>0.044441845,146=>0.012114426,147=>0.03841076,148=>-0.026353722,149=>0.036652017,150=>-0.0042747785,151=>0.04458125,152=>-0.051613238,153=>0.1912958,154=>0.008960653,155=>0.15335391,156=>0.08232363,157=>-0.025436645,158=>-0.032442857,159=>0.10192998,160=>-0.015357304,161=>0.13375334,0);
ENDMACRO;
