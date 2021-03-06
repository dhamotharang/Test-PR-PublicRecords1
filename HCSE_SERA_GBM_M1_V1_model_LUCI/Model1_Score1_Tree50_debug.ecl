EXPORT Model1_Score1_Tree50_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_50_Node_52 := CHOOSE ( le.p_readmit_diag,131,130,131,131,130,130,130,131,131,131,131,131,130);
        Tree_50_Node_53 := IF ( le.p_PropAgeNewestPurchase < 191.5,132,133);
        Tree_50_Node_30 := IF ( le.p_AssocSuspicousIdentitiesCount < 5.0,Tree_50_Node_52,Tree_50_Node_53);
        Tree_50_Node_31 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 2353515.5,102,103);
        Tree_50_Node_18 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 1562499.5,Tree_50_Node_30,Tree_50_Node_31);
        Tree_50_Node_57 := IF ( le.p_CurrAddrCarTheftIndex < 70.5,134,135);
        Tree_50_Node_32 := CHOOSE ( le.p_readmit_lift,104,Tree_50_Node_57,104,104,104,104,104,104,104,104,104,104,104);
        Tree_50_Node_19 := IF ( le.p_v1_HHCrtRecMmbrCnt < 1.5,Tree_50_Node_32,96);
        Tree_50_Node_10 := IF ( le.p_CurrAddrMedianValue < 773438.5,Tree_50_Node_18,Tree_50_Node_19);
        Tree_50_Node_58 := CHOOSE ( le.p_readmit_lift,136,137,137,136,137,136,137,136,137,136,136,136,136);
        Tree_50_Node_34 := IF ( le.p_SubjectAddrCount < 19.0,Tree_50_Node_58,105);
        Tree_50_Node_20 := CHOOSE ( le.p_readmit_diag,Tree_50_Node_34,Tree_50_Node_34,Tree_50_Node_34,Tree_50_Node_34,97,Tree_50_Node_34,Tree_50_Node_34,97,97,Tree_50_Node_34,Tree_50_Node_34,Tree_50_Node_34,Tree_50_Node_34);
        Tree_50_Node_11 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 11.5,Tree_50_Node_20,95);
        Tree_50_Node_5 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 372.5,Tree_50_Node_10,Tree_50_Node_11);
        Tree_50_Node_36 := CHOOSE ( le.p_financial_class,106,106,107,106,106,106,106,106,107,107,106,106,106,106,106,106);
        Tree_50_Node_22 := IF ( le.p_P_EstimatedHHIncomePerCapita < 3.640625,Tree_50_Node_36,98);
        Tree_50_Node_38 := CHOOSE ( le.p_financial_class,108,108,108,108,109,108,108,108,108,108,109,109,108,109,108,109);
        Tree_50_Node_39 := IF ( le.p_v1_RaASeniorMmbrCnt < 2.5,110,111);
        Tree_50_Node_23 := IF ( le.p_PrevAddrAgeOldestRecord < 62.5,Tree_50_Node_38,Tree_50_Node_39);
        Tree_50_Node_14 := IF ( le.p_AgeOldestRecord < 333.5,Tree_50_Node_22,Tree_50_Node_23);
        Tree_50_Node_40 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 23.5,112,113);
        Tree_50_Node_41 := IF ( le.p_NonDerogCount < 8.5,114,115);
        Tree_50_Node_24 := CHOOSE ( le.p_financial_class,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_41,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_41,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_40,Tree_50_Node_41,Tree_50_Node_40);
        Tree_50_Node_42 := IF ( le.p_PropAgeOldestPurchase < 151.5,116,117);
        Tree_50_Node_25 := IF ( le.p_CurrAddrMedianIncome < 82538.5,Tree_50_Node_42,99);
        Tree_50_Node_15 := IF ( le.p_v1_CrtRecLienJudgCnt < 3.5,Tree_50_Node_24,Tree_50_Node_25);
        Tree_50_Node_8 := IF ( le.p_SSNIssueState < 19.5,Tree_50_Node_14,Tree_50_Node_15);
        Tree_50_Node_44 := IF ( le.p_v1_CrtRecTimeNewest < 369.5,118,119);
        Tree_50_Node_45 := IF ( le.p_RelativesCount < 11.5,120,121);
        Tree_50_Node_26 := IF ( le.p_PrevAddrMedianValue < 593750.5,Tree_50_Node_44,Tree_50_Node_45);
        Tree_50_Node_46 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 11.5,122,123);
        Tree_50_Node_47 := IF ( le.p_DerogAge < 126.5,124,125);
        Tree_50_Node_27 := IF ( le.p_RecentActivityIndex < 2.5,Tree_50_Node_46,Tree_50_Node_47);
        Tree_50_Node_16 := IF ( le.p_CurrAddrAVMValue60 < 66429.5,Tree_50_Node_26,Tree_50_Node_27);
        Tree_50_Node_48 := CHOOSE ( le.p_readmit_diag,126,126,126,126,126,127,127,126,126,126,127,127,126);
        Tree_50_Node_49 := CHOOSE ( le.p_financial_class,128,129,128,128,128,129,128,128,128,128,128,128,128,129,128,128);
        Tree_50_Node_28 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 5.5,Tree_50_Node_48,Tree_50_Node_49);
        Tree_50_Node_29 := IF ( le.p_CurrAddrBurglaryIndex < 130.5,100,101);
        Tree_50_Node_17 := IF ( le.p_SSNIssueState < 34.5,Tree_50_Node_28,Tree_50_Node_29);
        Tree_50_Node_9 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 7.5,Tree_50_Node_16,Tree_50_Node_17);
        Tree_50_Node_4 := CHOOSE ( le.p_readmit_diag,Tree_50_Node_8,Tree_50_Node_9,Tree_50_Node_8,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9,Tree_50_Node_9);
        Tree_50_Node_2 := CHOOSE ( le.p_admit_diag,Tree_50_Node_5,Tree_50_Node_5,Tree_50_Node_5,Tree_50_Node_4,Tree_50_Node_5,Tree_50_Node_4,Tree_50_Node_4,Tree_50_Node_4,Tree_50_Node_4,Tree_50_Node_5,Tree_50_Node_4,Tree_50_Node_5,Tree_50_Node_5);
        Tree_50_Node_6 := CHOOSE ( le.p_readmit_lift,93,94,93,93,93,94,93,93,93,93,93,93,93);
        Tree_50_Node_3 := IF ( le.p_PRSearchOtherCount < 12.0,Tree_50_Node_6,92);
        Tree_50_Node_1 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 8.5,Tree_50_Node_2,Tree_50_Node_3);
    SELF.Score1_Tree50_node := Tree_50_Node_1;
    SELF.Score1_Tree50_score := CASE(SELF.Score1_Tree50_node,128=>0.002292153,129=>0.12696901,130=>-3.424688E-4,131=>0.0040463093,132=>-0.0032791935,133=>-0.032955687,134=>-0.034216773,135=>-0.06756523,136=>-0.06328022,137=>-0.03616055,92=>-0.0040696464,93=>-0.07281767,94=>-0.05488267,95=>0.033679213,96=>-0.0127545595,97=>0.038825836,98=>0.17158362,99=>0.15698697,100=>0.044683337,101=>0.13129863,102=>0.09754046,103=>0.0054717204,104=>-0.071247086,105=>0.037566625,106=>-0.022507189,107=>0.09818171,108=>-0.028089108,109=>0.11739888,110=>-0.055565704,111=>0.049597893,112=>-0.032057982,113=>0.04819785,114=>-0.06483907,115=>0.18439382,116=>-0.0468772,117=>0.08444413,118=>-0.006454458,119=>0.042416964,120=>0.08138483,121=>-0.02160932,122=>0.0088481335,123=>-0.0426164,124=>-0.0059706396,125=>-0.05918805,126=>-0.03646988,127=>0.027081953,0);
ENDMACRO;
