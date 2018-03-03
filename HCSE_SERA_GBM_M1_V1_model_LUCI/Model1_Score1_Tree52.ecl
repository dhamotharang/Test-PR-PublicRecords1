﻿EXPORT Model1_Score1_Tree52(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_52_Node_38 := IF ( le.p_v1_RaASeniorMmbrCnt < 2.5,111,112);
        Tree_52_Node_39 := CHOOSE ( le.p_readmit_diag,113,114,114,114,114,113,114,114,113,114,113,114,113);
        Tree_52_Node_24 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 2.5,Tree_52_Node_38,Tree_52_Node_39);
        Tree_52_Node_16 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 207.5,Tree_52_Node_24,99);
        Tree_52_Node_42 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 5.5,117,118);
        Tree_52_Node_27 := IF ( le.p_PrevAddrCrimeIndex < 170.5,Tree_52_Node_42,101);
        Tree_52_Node_40 := CHOOSE ( le.p_readmit_lift,115,116,115,115,115,115,115,116,115,115,115,115,115);
        Tree_52_Node_26 := IF ( le.p_RecentActivityIndex < 2.5,Tree_52_Node_40,100);
        Tree_52_Node_17 := CHOOSE ( le.p_admit_diag,Tree_52_Node_27,Tree_52_Node_26,Tree_52_Node_26,Tree_52_Node_26,Tree_52_Node_27,Tree_52_Node_26,Tree_52_Node_26,Tree_52_Node_27,Tree_52_Node_26,Tree_52_Node_26,Tree_52_Node_26,Tree_52_Node_27,Tree_52_Node_27);
        Tree_52_Node_8 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 201.5,Tree_52_Node_16,Tree_52_Node_17);
        Tree_52_Node_44 := IF ( le.p_SubjectAddrCount < 38.5,119,120);
        Tree_52_Node_45 := CHOOSE ( le.p_admit_diag,122,122,121,122,122,121,122,121,122,121,121,122,121);
        Tree_52_Node_28 := IF ( le.p_WealthIndex < 3.5,Tree_52_Node_44,Tree_52_Node_45);
        Tree_52_Node_46 := IF ( le.p_SSNIssueState < 28.5,123,124);
        Tree_52_Node_47 := IF ( le.p_PrevAddrBurglaryIndex < 190.5,125,126);
        Tree_52_Node_29 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_52_Node_46,Tree_52_Node_47);
        Tree_52_Node_18 := IF ( le.p_EstimatedAnnualIncome < 38718.5,Tree_52_Node_28,Tree_52_Node_29);
        Tree_52_Node_50 := IF ( le.p_AddrStability < 1.5,129,130);
        Tree_52_Node_51 := CHOOSE ( le.p_admit_diag,131,132,132,132,131,132,132,131,132,131,131,131,131);
        Tree_52_Node_31 := IF ( le.p_SrcsConfirmIDAddrCount < 4.5,Tree_52_Node_50,Tree_52_Node_51);
        Tree_52_Node_49 := IF ( le.p_age_in_years < 60.654,127,128);
        Tree_52_Node_30 := IF ( le.p_LastNameChangeAge < 64.5,102,Tree_52_Node_49);
        Tree_52_Node_19 := CHOOSE ( le.p_readmit_lift,Tree_52_Node_31,Tree_52_Node_31,Tree_52_Node_30,Tree_52_Node_30,Tree_52_Node_30,Tree_52_Node_31,Tree_52_Node_30,Tree_52_Node_31,Tree_52_Node_30,Tree_52_Node_30,Tree_52_Node_30,Tree_52_Node_30,Tree_52_Node_30);
        Tree_52_Node_9 := IF ( le.p_IdentityRiskLevel < 6.5,Tree_52_Node_18,Tree_52_Node_19);
        Tree_52_Node_4 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.328125,Tree_52_Node_8,Tree_52_Node_9);
        Tree_52_Node_5 := CHOOSE ( le.p_readmit_diag,95,94,94,94,94,94,94,95,94,95,95,95,95);
        Tree_52_Node_2 := IF ( le.p_v1_ProspectAge < 93.0,Tree_52_Node_4,Tree_52_Node_5);
        Tree_52_Node_54 := IF ( le.p_PrevAddrBurglaryIndex < 39.0,133,134);
        Tree_52_Node_33 := IF ( le.p_v1_ProspectMaritalStatus < 0.5,Tree_52_Node_54,105);
        Tree_52_Node_32 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 1.5,103,104);
        Tree_52_Node_20 := CHOOSE ( le.p_readmit_lift,Tree_52_Node_33,Tree_52_Node_33,Tree_52_Node_32,Tree_52_Node_32,Tree_52_Node_32,Tree_52_Node_32,Tree_52_Node_32,Tree_52_Node_32,Tree_52_Node_32,Tree_52_Node_32,Tree_52_Node_33,Tree_52_Node_32,Tree_52_Node_32);
        Tree_52_Node_56 := CHOOSE ( le.p_readmit_diag,136,136,135,136,135,135,136,136,136,135,136,136,135);
        Tree_52_Node_57 := CHOOSE ( le.p_readmit_diag,137,138,137,137,137,137,138,137,138,138,137,137,137);
        Tree_52_Node_34 := IF ( le.p_PrevAddrAgeLastSale < 191.5,Tree_52_Node_56,Tree_52_Node_57);
        Tree_52_Node_58 := IF ( le.p_CurrAddrCountyIndex < 1.053,139,140);
        Tree_52_Node_35 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 0.5,Tree_52_Node_58,106);
        Tree_52_Node_21 := IF ( le.p_CurrAddrMedianIncome < 84018.5,Tree_52_Node_34,Tree_52_Node_35);
        Tree_52_Node_12 := IF ( le.p_CurrAddrAgeOldestRecord < 95.5,Tree_52_Node_20,Tree_52_Node_21);
        Tree_52_Node_36 := CHOOSE ( le.p_readmit_diag,108,107,107,108,108,107,108,107,107,107,107,107,107);
        Tree_52_Node_37 := CHOOSE ( le.p_readmit_diag,109,110,109,110,110,109,109,110,109,109,109,109,109);
        Tree_52_Node_23 := IF ( le.p_PrevAddrAgeOldestRecord < 190.5,Tree_52_Node_36,Tree_52_Node_37);
        Tree_52_Node_13 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 0.5,98,Tree_52_Node_23);
        Tree_52_Node_6 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 3.5,Tree_52_Node_12,Tree_52_Node_13);
        Tree_52_Node_7 := IF ( le.p_SubjectPhoneCount < 0.5,96,97);
        Tree_52_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_52_Node_6,Tree_52_Node_6,Tree_52_Node_6,Tree_52_Node_7,Tree_52_Node_6,Tree_52_Node_6,Tree_52_Node_7,Tree_52_Node_7,Tree_52_Node_7,Tree_52_Node_7,Tree_52_Node_6,Tree_52_Node_6,Tree_52_Node_6);
        Tree_52_Node_1 := IF ( le.p_age_in_years < 93.09727,Tree_52_Node_2,Tree_52_Node_3);
    UNSIGNED2 Score1_Tree52_node := Tree_52_Node_1;
    REAL8 Score1_Tree52_score := CASE(Score1_Tree52_node,128=>-0.073667064,129=>0.03080445,130=>-0.051349383,131=>-0.05685895,132=>0.04006524,133=>-0.013929542,134=>-0.055956565,135=>-0.06330667,136=>-0.018791227,137=>-0.024176583,138=>0.1080189,139=>0.03314112,140=>-0.067803405,94=>0.0029638743,95=>0.11450017,96=>-0.01763376,97=>0.07619918,98=>0.10706508,99=>0.05447818,100=>-0.00446722,101=>0.04375587,102=>-0.0346564,103=>-0.06729342,104=>-0.06876428,105=>0.015616125,106=>0.08382056,107=>-0.022986405,108=>0.092132255,109=>-0.0688336,110=>-0.009542985,111=>-0.00844678,112=>0.01572877,113=>-0.04907091,114=>0.08200017,115=>-0.07442717,116=>-0.059243005,117=>-0.055275116,118=>0.04337506,119=>0.001671909,120=>0.07583659,121=>-0.004708878,122=>0.020342024,123=>5.1672887E-5,124=>-0.0065412656,125=>0.009509132,126=>0.09409506,127=>-0.070744865,0);
ENDMACRO;
