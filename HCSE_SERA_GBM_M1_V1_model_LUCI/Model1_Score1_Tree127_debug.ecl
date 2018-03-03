﻿EXPORT Model1_Score1_Tree127_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_127_Node_38 := IF ( le.p_AccidentAge < 338.5,118,119);
        Tree_127_Node_39 := IF ( le.p_SubjectAddrCount < 14.5,120,121);
        Tree_127_Node_22 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,Tree_127_Node_38,Tree_127_Node_39);
        Tree_127_Node_40 := CHOOSE ( le.p_financial_class,122,123,122,122,123,122,123,122,122,123,122,122,122,122,122,122);
        Tree_127_Node_41 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,124,125);
        Tree_127_Node_23 := IF ( le.p_PrevAddrAgeLastSale < 73.5,Tree_127_Node_40,Tree_127_Node_41);
        Tree_127_Node_14 := IF ( le.p_LienReleasedAge < 229.5,Tree_127_Node_22,Tree_127_Node_23);
        Tree_127_Node_42 := IF ( le.p_PrevAddrAgeNewestRecord < 138.5,126,127);
        Tree_127_Node_43 := CHOOSE ( le.p_readmit_lift,129,129,129,128,129,129,129,128,129,129,128,129,129);
        Tree_127_Node_24 := IF ( le.p_P_EstimatedHHIncomePerCapita < 4.15625,Tree_127_Node_42,Tree_127_Node_43);
        Tree_127_Node_44 := IF ( le.p_PhoneOtherAgeOldestRecord < 141.5,130,131);
        Tree_127_Node_45 := IF ( le.p_v1_RaAMedIncomeRange < 4.5,132,133);
        Tree_127_Node_25 := IF ( le.p_v1_CrtRecCnt < 9.5,Tree_127_Node_44,Tree_127_Node_45);
        Tree_127_Node_15 := IF ( le.p_age_in_years < 75.075,Tree_127_Node_24,Tree_127_Node_25);
        Tree_127_Node_8 := CHOOSE ( le.p_gender,Tree_127_Node_14,Tree_127_Node_15);
        Tree_127_Node_46 := IF ( le.p_PrevAddrAgeLastSale < 661.0,134,135);
        Tree_127_Node_47 := CHOOSE ( le.p_readmit_lift,136,137,136,136,136,136,136,136,136,136,137,136,136);
        Tree_127_Node_26 := IF ( le.p_LastNameChangeAge < 253.5,Tree_127_Node_46,Tree_127_Node_47);
        Tree_127_Node_48 := IF ( le.p_AssocSuspicousIdentitiesCount < 1.5,138,139);
        Tree_127_Node_27 := CHOOSE ( le.p_admit_diag,Tree_127_Node_48,Tree_127_Node_48,Tree_127_Node_48,109,109,Tree_127_Node_48,Tree_127_Node_48,109,Tree_127_Node_48,Tree_127_Node_48,Tree_127_Node_48,109,109);
        Tree_127_Node_16 := CHOOSE ( le.p_financial_class,Tree_127_Node_26,Tree_127_Node_26,Tree_127_Node_27,Tree_127_Node_26,Tree_127_Node_27,Tree_127_Node_27,Tree_127_Node_26,Tree_127_Node_26,Tree_127_Node_26,Tree_127_Node_26,Tree_127_Node_27,Tree_127_Node_27,Tree_127_Node_26,Tree_127_Node_26,Tree_127_Node_26,Tree_127_Node_27);
        Tree_127_Node_28 := IF ( le.p_PrevAddrCrimeIndex < 110.5,110,111);
        Tree_127_Node_17 := CHOOSE ( le.p_admit_diag,Tree_127_Node_28,107,Tree_127_Node_28,Tree_127_Node_28,107,Tree_127_Node_28,Tree_127_Node_28,107,Tree_127_Node_28,Tree_127_Node_28,107,107,107);
        Tree_127_Node_9 := IF ( le.p_age_in_years < 84.45937,Tree_127_Node_16,Tree_127_Node_17);
        Tree_127_Node_4 := IF ( le.p_PrevAddrAgeLastSale < 560.5,Tree_127_Node_8,Tree_127_Node_9);
        Tree_127_Node_56 := IF ( le.p_PrevAddrCarTheftIndex < 39.5,144,145);
        Tree_127_Node_57 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 0.5,146,147);
        Tree_127_Node_32 := CHOOSE ( le.p_readmit_lift,Tree_127_Node_56,Tree_127_Node_57,Tree_127_Node_57,Tree_127_Node_56,Tree_127_Node_57,Tree_127_Node_57,Tree_127_Node_57,Tree_127_Node_56,Tree_127_Node_56,Tree_127_Node_57,Tree_127_Node_57,Tree_127_Node_57,Tree_127_Node_57);
        Tree_127_Node_58 := IF ( le.p_BP_4 < 7.5,148,149);
        Tree_127_Node_59 := IF ( le.p_CurrAddrMedianIncome < 57407.0,150,151);
        Tree_127_Node_33 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,Tree_127_Node_58,Tree_127_Node_59);
        Tree_127_Node_19 := IF ( le.p_PropAgeNewestSale < 15.5,Tree_127_Node_32,Tree_127_Node_33);
        Tree_127_Node_52 := IF ( le.p_CurrAddrBlockIndex < 0.772,140,141);
        Tree_127_Node_53 := IF ( le.p_StatusMostRecent < 2.5,142,143);
        Tree_127_Node_30 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 2.5,Tree_127_Node_52,Tree_127_Node_53);
        Tree_127_Node_31 := CHOOSE ( le.p_admit_diag,112,112,112,112,113,113,113,113,113,113,113,112,112);
        Tree_127_Node_18 := IF ( le.p_PropAgeNewestSale < 79.5,Tree_127_Node_30,Tree_127_Node_31);
        Tree_127_Node_10 := CHOOSE ( le.p_readmit_diag,Tree_127_Node_19,Tree_127_Node_19,Tree_127_Node_19,Tree_127_Node_18,Tree_127_Node_18,Tree_127_Node_19,Tree_127_Node_18,Tree_127_Node_19,Tree_127_Node_19,Tree_127_Node_18,Tree_127_Node_18,Tree_127_Node_19,Tree_127_Node_19);
        Tree_127_Node_5 := CHOOSE ( le.p_readmit_lift,Tree_127_Node_10,Tree_127_Node_10,Tree_127_Node_10,Tree_127_Node_10,105,Tree_127_Node_10,105,Tree_127_Node_10,Tree_127_Node_10,Tree_127_Node_10,105,105,Tree_127_Node_10);
        Tree_127_Node_2 := IF ( le.p_SSNHighIssueAge < 787.5,Tree_127_Node_4,Tree_127_Node_5);
        Tree_127_Node_35 := IF ( le.p_PrevAddrAgeLastSale < 16.5,114,115);
        Tree_127_Node_20 := CHOOSE ( le.p_readmit_lift,Tree_127_Node_35,Tree_127_Node_35,108,108,Tree_127_Node_35,108,108,108,108,108,108,108,108);
        Tree_127_Node_63 := CHOOSE ( le.p_readmit_lift,152,153,152,152,152,152,152,152,152,152,152,152,152);
        Tree_127_Node_36 := IF ( le.p_RelativesCount < 6.5,116,Tree_127_Node_63);
        Tree_127_Node_65 := IF ( le.p_PropAgeNewestPurchase < 74.0,154,155);
        Tree_127_Node_37 := CHOOSE ( le.p_readmit_diag,117,Tree_127_Node_65,Tree_127_Node_65,Tree_127_Node_65,Tree_127_Node_65,117,Tree_127_Node_65,Tree_127_Node_65,Tree_127_Node_65,117,117,117,117);
        Tree_127_Node_21 := IF ( le.p_SubjectLastNameCount < 2.5,Tree_127_Node_36,Tree_127_Node_37);
        Tree_127_Node_12 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,Tree_127_Node_20,Tree_127_Node_21);
        Tree_127_Node_7 := IF ( le.p_v1_PropTimeLastSale < 169.0,Tree_127_Node_12,106);
        Tree_127_Node_3 := IF ( le.p_CurrAddrAgeOldestRecord < 9.0,104,Tree_127_Node_7);
        Tree_127_Node_1 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 379.5,Tree_127_Node_2,Tree_127_Node_3);
    SELF.Score1_Tree127_node := Tree_127_Node_1;
    SELF.Score1_Tree127_score := CASE(SELF.Score1_Tree127_node,104=>0.020309763,105=>0.01958405,106=>0.021368708,107=>0.040446233,108=>-0.03366468,109=>0.032953057,110=>0.020283448,111=>-0.032798145,112=>-0.03384521,113=>-0.025621613,114=>-0.0318589,115=>-0.0065718885,116=>0.003985024,117=>-0.02111097,118=>-0.0014863965,119=>0.03257523,120=>0.0024227747,121=>-0.0013809212,122=>-0.024574399,123=>0.0074955663,124=>0.02979915,125=>-0.01338308,126=>-1.5180145E-5,127=>-0.009058228,128=>-0.021185623,129=>0.005187459,130=>0.0014009883,131=>0.006616252,132=>0.0076755793,133=>-0.017494325,134=>-0.024238886,135=>0.0051775468,136=>-0.033883285,137=>-0.031475395,138=>-0.031756178,139=>0.008841549,140=>-0.018512428,141=>0.018501556,142=>-0.03372083,143=>-0.008564815,144=>-0.030669302,145=>-0.008397765,146=>-0.017101055,147=>0.0010877674,148=>0.022692628,149=>-0.020020857,150=>0.05531154,151=>0.008443992,152=>-0.032238554,153=>-0.03094071,154=>0.050617363,155=>-0.006980547,0);
ENDMACRO;
