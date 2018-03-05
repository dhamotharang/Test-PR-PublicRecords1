﻿EXPORT Model1_Score1_Tree86(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_86_Node_46 := IF ( le.p_v1_HHCnt < 4.5,134,135);
        Tree_86_Node_47 := CHOOSE ( le.p_readmit_diag,136,136,136,136,136,136,136,136,137,136,137,136,136);
        Tree_86_Node_28 := IF ( le.p_LienFiledAge < 21.5,Tree_86_Node_46,Tree_86_Node_47);
        Tree_86_Node_48 := IF ( le.p_RelativesBankruptcyCount < 3.5,138,139);
        Tree_86_Node_49 := CHOOSE ( le.p_admit_diag,140,141,141,140,141,141,140,141,140,141,140,141,141);
        Tree_86_Node_29 := IF ( le.p_NonDerogCount < 8.5,Tree_86_Node_48,Tree_86_Node_49);
        Tree_86_Node_16 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 0.5,Tree_86_Node_28,Tree_86_Node_29);
        Tree_86_Node_50 := IF ( le.p_CurrAddrCarTheftIndex < 59.5,142,143);
        Tree_86_Node_51 := IF ( le.p_CurrAddrMurderIndex < 120.5,144,145);
        Tree_86_Node_30 := IF ( le.p_PropAgeNewestPurchase < 31.5,Tree_86_Node_50,Tree_86_Node_51);
        Tree_86_Node_53 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,146,147);
        Tree_86_Node_31 := IF ( le.p_CurrAddrMurderIndex < 69.5,129,Tree_86_Node_53);
        Tree_86_Node_17 := CHOOSE ( le.p_readmit_diag,Tree_86_Node_30,Tree_86_Node_30,Tree_86_Node_30,Tree_86_Node_31,Tree_86_Node_31,Tree_86_Node_31,Tree_86_Node_30,Tree_86_Node_31,Tree_86_Node_31,Tree_86_Node_30,Tree_86_Node_31,Tree_86_Node_30,Tree_86_Node_30);
        Tree_86_Node_8 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 370.5,Tree_86_Node_16,Tree_86_Node_17);
        Tree_86_Node_54 := IF ( le.p_P_EstimatedHHIncomePerCapita < 5.525,148,149);
        Tree_86_Node_55 := IF ( le.p_AgeOldestRecord < 484.0,150,151);
        Tree_86_Node_32 := CHOOSE ( le.p_readmit_diag,Tree_86_Node_54,Tree_86_Node_54,Tree_86_Node_55,Tree_86_Node_54,Tree_86_Node_54,Tree_86_Node_55,Tree_86_Node_54,Tree_86_Node_55,Tree_86_Node_55,Tree_86_Node_55,Tree_86_Node_54,Tree_86_Node_55,Tree_86_Node_54);
        Tree_86_Node_18 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 5.5,Tree_86_Node_32,125);
        Tree_86_Node_56 := IF ( le.p_PrevAddrCrimeIndex < 194.5,152,153);
        Tree_86_Node_57 := CHOOSE ( le.p_readmit_diag,155,155,154,155,154,155,155,154,154,154,155,155,154);
        Tree_86_Node_35 := IF ( le.p_v1_LifeEvEverResidedCnt < 2.5,Tree_86_Node_56,Tree_86_Node_57);
        Tree_86_Node_19 := IF ( le.p_NonDerogCount < 3.5,126,Tree_86_Node_35);
        Tree_86_Node_9 := IF ( le.p_CurrAddrCarTheftIndex < 176.5,Tree_86_Node_18,Tree_86_Node_19);
        Tree_86_Node_4 := IF ( le.p_PrevAddrCrimeIndex < 184.5,Tree_86_Node_8,Tree_86_Node_9);
        Tree_86_Node_58 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 5.5,156,157);
        Tree_86_Node_59 := IF ( le.p_PrevAddrBurglaryIndex < 189.0,158,159);
        Tree_86_Node_36 := IF ( le.p_v1_CrtRecTimeNewest < 173.0,Tree_86_Node_58,Tree_86_Node_59);
        Tree_86_Node_60 := CHOOSE ( le.p_admit_diag,161,160,161,160,160,161,161,160,160,161,160,160,161);
        Tree_86_Node_61 := CHOOSE ( le.p_readmit_diag,162,162,162,162,162,163,162,162,162,163,163,162,163);
        Tree_86_Node_37 := CHOOSE ( le.p_readmit_lift,Tree_86_Node_60,Tree_86_Node_61,Tree_86_Node_60,Tree_86_Node_60,Tree_86_Node_61,Tree_86_Node_60,Tree_86_Node_60,Tree_86_Node_60,Tree_86_Node_60,Tree_86_Node_61,Tree_86_Node_60,Tree_86_Node_60,Tree_86_Node_61);
        Tree_86_Node_20 := IF ( le.p_BPV_4 < -1.6297313,Tree_86_Node_36,Tree_86_Node_37);
        Tree_86_Node_62 := IF ( le.p_PhoneOtherAgeOldestRecord < 205.5,164,165);
        Tree_86_Node_63 := CHOOSE ( le.p_readmit_lift,167,166,166,166,166,166,166,166,166,166,166,166,166);
        Tree_86_Node_38 := IF ( le.p_v1_CrtRecMsdmeanCnt < 13.5,Tree_86_Node_62,Tree_86_Node_63);
        Tree_86_Node_39 := CHOOSE ( le.p_financial_class,130,130,130,130,131,130,130,130,130,130,131,131,130,131,130,130);
        Tree_86_Node_21 := CHOOSE ( le.p_readmit_lift,Tree_86_Node_38,Tree_86_Node_38,Tree_86_Node_38,Tree_86_Node_39,Tree_86_Node_38,Tree_86_Node_39,Tree_86_Node_38,Tree_86_Node_38,Tree_86_Node_38,Tree_86_Node_38,Tree_86_Node_38,Tree_86_Node_39,Tree_86_Node_39);
        Tree_86_Node_10 := IF ( le.p_PrevAddrMedianIncome < 39784.5,Tree_86_Node_20,Tree_86_Node_21);
        Tree_86_Node_5 := IF ( le.p_PRSearchLocateCount < 24.5,Tree_86_Node_10,120);
        Tree_86_Node_2 := IF ( le.p_PrevAddrBurglaryIndex < 177.0,Tree_86_Node_4,Tree_86_Node_5);
        Tree_86_Node_70 := IF ( le.p_CurrAddrBurglaryIndex < 69.5,172,173);
        Tree_86_Node_71 := CHOOSE ( le.p_readmit_diag,175,175,175,175,175,174,175,174,175,175,175,174,174);
        Tree_86_Node_44 := IF ( le.p_VariationDOBCount < 2.5,Tree_86_Node_70,Tree_86_Node_71);
        Tree_86_Node_72 := IF ( le.p_PrevAddrBurglaryIndex < 9.5,176,177);
        Tree_86_Node_73 := IF ( le.p_BP_3 < 1.5,178,179);
        Tree_86_Node_45 := IF ( le.p_BPV_4 < -1.9013531,Tree_86_Node_72,Tree_86_Node_73);
        Tree_86_Node_26 := IF ( le.p_PrevAddrDwellType < 2.0,Tree_86_Node_44,Tree_86_Node_45);
        Tree_86_Node_14 := CHOOSE ( le.p_readmit_lift,Tree_86_Node_26,Tree_86_Node_26,Tree_86_Node_26,124,Tree_86_Node_26,124,Tree_86_Node_26,Tree_86_Node_26,Tree_86_Node_26,Tree_86_Node_26,124,Tree_86_Node_26,Tree_86_Node_26);
        Tree_86_Node_7 := IF ( le.p_PRSearchOtherCount < 36.0,Tree_86_Node_14,121);
        Tree_86_Node_66 := IF ( le.p_age_in_years < 67.101,168,169);
        Tree_86_Node_40 := CHOOSE ( le.p_readmit_lift,Tree_86_Node_66,132,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66,Tree_86_Node_66);
        Tree_86_Node_22 := CHOOSE ( le.p_readmit_diag,127,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40,Tree_86_Node_40);
        Tree_86_Node_68 := CHOOSE ( le.p_financial_class,170,170,171,170,170,171,171,170,170,170,170,170,170,170,170,170);
        Tree_86_Node_42 := IF ( le.p_SSNLowIssueAge < 736.5,Tree_86_Node_68,133);
        Tree_86_Node_23 := CHOOSE ( le.p_readmit_diag,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42,128,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42,Tree_86_Node_42);
        Tree_86_Node_12 := IF ( le.p_SubjectAddrCount < 11.5,Tree_86_Node_22,Tree_86_Node_23);
        Tree_86_Node_13 := CHOOSE ( le.p_readmit_lift,123,122,123,123,123,123,123,123,123,123,122,122,122);
        Tree_86_Node_6 := IF ( le.p_PrevAddrAgeOldestRecord < 335.5,Tree_86_Node_12,Tree_86_Node_13);
        Tree_86_Node_3 := CHOOSE ( le.p_admit_diag,Tree_86_Node_7,Tree_86_Node_7,Tree_86_Node_7,Tree_86_Node_7,Tree_86_Node_6,Tree_86_Node_6,Tree_86_Node_7,Tree_86_Node_7,Tree_86_Node_6,Tree_86_Node_6,Tree_86_Node_7,Tree_86_Node_7,Tree_86_Node_6);
        Tree_86_Node_1 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 142.5,Tree_86_Node_2,Tree_86_Node_3);
    UNSIGNED2 Score1_Tree86_node := Tree_86_Node_1;
    REAL8 Score1_Tree86_score := CASE(Score1_Tree86_node,120=>0.065246694,121=>0.054578308,122=>-0.04720547,123=>0.034036193,124=>0.034329765,125=>0.038498543,126=>0.06322747,127=>-0.009182054,128=>0.013905288,129=>-0.03970101,130=>0.008186161,131=>0.06800354,132=>-0.04809922,133=>0.021564782,134=>-8.950203E-4,135=>0.0073608616,136=>-0.00625243,137=>0.015144354,138=>0.0031487055,139=>0.013884872,140=>-0.005497361,141=>0.0026719358,142=>0.022726966,143=>-0.03858135,144=>-0.044004295,145=>-0.013130729,146=>-8.9363917E-4,147=>0.060383063,148=>-0.018769303,149=>0.04885699,150=>-0.005092647,151=>0.050703645,152=>0.005275585,153=>-0.019105814,154=>-0.04206499,155=>0.049838975,156=>0.006746495,157=>0.058454175,158=>0.010827522,159=>0.045345068,160=>-0.041037418,161=>-0.009286784,162=>0.002359068,163=>0.07395042,164=>-0.005296946,165=>0.046107862,166=>0.005585328,167=>0.045498062,168=>-0.045303307,169=>-0.051972,170=>-0.0346164,171=>0.0061420123,172=>0.0028438517,173=>-0.050409738,174=>-0.042035636,175=>0.027076313,176=>0.06295887,177=>0.004179956,178=>-0.0094696665,179=>0.01599478,0);
ENDMACRO;
