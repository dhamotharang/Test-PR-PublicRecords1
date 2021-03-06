EXPORT Model1_Score1_Tree107(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_107_Node_40 := IF ( le.p_age_in_years < 92.82,97,98);
        Tree_107_Node_41 := CHOOSE ( le.p_admit_diag,99,99,99,99,99,100,100,99,100,100,99,100,99);
        Tree_107_Node_26 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 10.5,Tree_107_Node_40,Tree_107_Node_41);
        Tree_107_Node_43 := IF ( le.p_CurrAddrCarTheftIndex < 29.5,103,104);
        Tree_107_Node_42 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 1.5,101,102);
        Tree_107_Node_27 := CHOOSE ( le.p_financial_class,Tree_107_Node_43,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_43,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42,Tree_107_Node_42);
        Tree_107_Node_16 := IF ( le.p_RelativesBankruptcyCount < 7.5,Tree_107_Node_26,Tree_107_Node_27);
        Tree_107_Node_17 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 4.5,88,89);
        Tree_107_Node_8 := IF ( le.p_BP_1 < 10.5,Tree_107_Node_16,Tree_107_Node_17);
        Tree_107_Node_19 := IF ( le.p_SubjectAddrCount < 22.5,90,91);
        Tree_107_Node_9 := IF ( le.p_NonDerogCount12 < 2.5,85,Tree_107_Node_19);
        Tree_107_Node_4 := IF ( le.p_v1_CrtRecCnt < 99.5,Tree_107_Node_8,Tree_107_Node_9);
        Tree_107_Node_45 := CHOOSE ( le.p_admit_diag,106,105,106,105,105,105,106,106,106,105,106,106,106);
        Tree_107_Node_32 := CHOOSE ( le.p_readmit_lift,94,Tree_107_Node_45,94,94,94,94,94,94,94,94,Tree_107_Node_45,Tree_107_Node_45,94);
        Tree_107_Node_20 := IF ( le.p_CurrAddrBlockIndex < 1.31,Tree_107_Node_32,92);
        Tree_107_Node_10 := CHOOSE ( le.p_financial_class,Tree_107_Node_20,86,86,Tree_107_Node_20,86,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20,Tree_107_Node_20);
        Tree_107_Node_5 := IF ( le.p_AccidentAge < 10.5,Tree_107_Node_10,82);
        Tree_107_Node_2 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 1542967.5,Tree_107_Node_4,Tree_107_Node_5);
        Tree_107_Node_48 := IF ( le.p_v1_CrtRecTimeNewest < 40.0,111,112);
        Tree_107_Node_49 := IF ( le.p_v1_HHCnt < 8.5,113,114);
        Tree_107_Node_35 := IF ( le.p_BPV_4 < -1.5391906,Tree_107_Node_48,Tree_107_Node_49);
        Tree_107_Node_46 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 2.5,107,108);
        Tree_107_Node_47 := IF ( le.p_AgeOldestRecord < 267.5,109,110);
        Tree_107_Node_34 := IF ( le.p_CurrAddrAgeLastSale < 31.5,Tree_107_Node_46,Tree_107_Node_47);
        Tree_107_Node_22 := CHOOSE ( le.p_readmit_diag,Tree_107_Node_35,Tree_107_Node_35,Tree_107_Node_35,Tree_107_Node_34,Tree_107_Node_35,Tree_107_Node_35,Tree_107_Node_35,Tree_107_Node_34,Tree_107_Node_35,Tree_107_Node_35,Tree_107_Node_34,Tree_107_Node_34,Tree_107_Node_34);
        Tree_107_Node_14 := IF ( le.p_v1_RaAPropOwnerAVMMed < 559962.5,Tree_107_Node_22,87);
        Tree_107_Node_50 := CHOOSE ( le.p_admit_diag,116,116,116,116,115,116,116,115,115,115,115,115,116);
        Tree_107_Node_51 := IF ( le.p_SSNAddrCount < 7.5,117,118);
        Tree_107_Node_36 := IF ( le.p_PhoneEDAAgeOldestRecord < 147.5,Tree_107_Node_50,Tree_107_Node_51);
        Tree_107_Node_52 := IF ( le.p_PrevAddrMedianValue < 185714.0,119,120);
        Tree_107_Node_37 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 11.5,Tree_107_Node_52,95);
        Tree_107_Node_24 := CHOOSE ( le.p_financial_class,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_37,Tree_107_Node_37,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_36,Tree_107_Node_37,Tree_107_Node_37);
        Tree_107_Node_54 := CHOOSE ( le.p_admit_diag,121,121,122,121,122,121,121,121,122,121,121,121,121);
        Tree_107_Node_38 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 15.5,Tree_107_Node_54,96);
        Tree_107_Node_25 := IF ( le.p_CurrAddrLenOfRes < 225.5,Tree_107_Node_38,93);
        Tree_107_Node_15 := IF ( le.p_PrevAddrAgeLastSale < 87.5,Tree_107_Node_24,Tree_107_Node_25);
        Tree_107_Node_7 := IF ( le.p_PhoneEDAAgeNewestRecord < 75.5,Tree_107_Node_14,Tree_107_Node_15);
        Tree_107_Node_6 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 7.5,83,84);
        Tree_107_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_107_Node_7,Tree_107_Node_7,Tree_107_Node_7,Tree_107_Node_7,Tree_107_Node_6,Tree_107_Node_6,Tree_107_Node_6,Tree_107_Node_7,Tree_107_Node_6,Tree_107_Node_7,Tree_107_Node_7,Tree_107_Node_7,Tree_107_Node_7);
        Tree_107_Node_1 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 5.5,Tree_107_Node_2,Tree_107_Node_3);
    UNSIGNED2 Score1_Tree107_node := Tree_107_Node_1;
    REAL8 Score1_Tree107_score := CASE(Score1_Tree107_node,82=>0.009167516,83=>-0.021466255,84=>-0.042867374,85=>0.004761344,86=>-4.2959585E-4,87=>0.04064919,88=>0.024264442,89=>0.0071397843,90=>-0.032130316,91=>-0.045609005,92=>-0.0165291,93=>0.031263597,94=>-0.040028512,95=>-0.015134061,96=>0.011337283,97=>2.4071538E-4,98=>-0.0051065534,99=>-0.023470826,100=>0.03930473,101=>-0.0013498889,102=>0.04909223,103=>0.044180915,104=>-0.008775364,105=>-0.038792036,106=>-0.037274413,107=>-0.016890066,108=>0.015637813,109=>0.0038100132,110=>-0.034085646,111=>-0.0014018011,112=>-0.019102715,113=>-3.4038935E-4,114=>0.066948995,115=>-0.02850171,116=>0.0405702,117=>0.026585395,118=>-0.007789033,119=>0.029794816,120=>0.08332476,121=>-0.039565265,122=>0.0024110235,0);
ENDMACRO;
