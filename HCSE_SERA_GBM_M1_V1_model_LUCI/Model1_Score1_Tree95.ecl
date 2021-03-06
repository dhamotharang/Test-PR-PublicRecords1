EXPORT Model1_Score1_Tree95(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_95_Node_34 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 386.5,97,98);
        Tree_95_Node_35 := IF ( le.p_NonDerogCount < 3.5,99,100);
        Tree_95_Node_20 := IF ( le.p_PrevAddrCrimeIndex < 189.0,Tree_95_Node_34,Tree_95_Node_35);
        Tree_95_Node_36 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 29.5,101,102);
        Tree_95_Node_37 := IF ( le.p_AccidentAge < 87.5,103,104);
        Tree_95_Node_21 := IF ( le.p_AccidentAge < 55.5,Tree_95_Node_36,Tree_95_Node_37);
        Tree_95_Node_12 := IF ( le.p_v1_HHCnt < 7.5,Tree_95_Node_20,Tree_95_Node_21);
        Tree_95_Node_38 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,105,106);
        Tree_95_Node_39 := CHOOSE ( le.p_admit_diag,108,108,108,108,108,107,108,107,107,107,107,108,108);
        Tree_95_Node_22 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 6.0,Tree_95_Node_38,Tree_95_Node_39);
        Tree_95_Node_23 := CHOOSE ( le.p_admit_diag,89,88,88,89,89,88,88,88,89,88,88,89,89);
        Tree_95_Node_13 := IF ( le.p_VariationDOBCount < 4.5,Tree_95_Node_22,Tree_95_Node_23);
        Tree_95_Node_8 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 3.5,Tree_95_Node_12,Tree_95_Node_13);
        Tree_95_Node_42 := IF ( le.p_AddrChangeCount24 < 2.5,109,110);
        Tree_95_Node_43 := CHOOSE ( le.p_readmit_lift,111,111,111,112,111,112,112,112,111,111,111,112,112);
        Tree_95_Node_24 := IF ( le.p_LienReleasedAge < 87.5,Tree_95_Node_42,Tree_95_Node_43);
        Tree_95_Node_44 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 7.5,113,114);
        Tree_95_Node_25 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 2.5,Tree_95_Node_44,90);
        Tree_95_Node_14 := CHOOSE ( le.p_financial_class,Tree_95_Node_24,Tree_95_Node_24,Tree_95_Node_25,Tree_95_Node_24,Tree_95_Node_25,Tree_95_Node_24,Tree_95_Node_24,Tree_95_Node_24,Tree_95_Node_24,Tree_95_Node_25,Tree_95_Node_24,Tree_95_Node_24,Tree_95_Node_24,Tree_95_Node_25,Tree_95_Node_25,Tree_95_Node_24);
        Tree_95_Node_26 := IF ( le.p_v1_HHCrtRecMmbrCnt < 2.5,91,92);
        Tree_95_Node_49 := IF ( le.p_SubjectLastNameCount < 2.5,115,116);
        Tree_95_Node_27 := CHOOSE ( le.p_readmit_diag,93,Tree_95_Node_49,Tree_95_Node_49,Tree_95_Node_49,Tree_95_Node_49,93,Tree_95_Node_49,93,93,93,93,Tree_95_Node_49,Tree_95_Node_49);
        Tree_95_Node_15 := CHOOSE ( le.p_financial_class,Tree_95_Node_26,Tree_95_Node_26,Tree_95_Node_26,Tree_95_Node_26,Tree_95_Node_27,Tree_95_Node_27,Tree_95_Node_26,Tree_95_Node_26,Tree_95_Node_26,Tree_95_Node_26,Tree_95_Node_27,Tree_95_Node_27,Tree_95_Node_26,Tree_95_Node_27,Tree_95_Node_26,Tree_95_Node_26);
        Tree_95_Node_9 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 4.5,Tree_95_Node_14,Tree_95_Node_15);
        Tree_95_Node_4 := IF ( le.p_EvictionAge < 55.5,Tree_95_Node_8,Tree_95_Node_9);
        Tree_95_Node_54 := IF ( le.p_CurrAddrBurglaryIndex < 135.5,121,122);
        Tree_95_Node_33 := IF ( le.p_SSNIssueState < 29.0,Tree_95_Node_54,96);
        Tree_95_Node_19 := IF ( le.p_CurrAddrLenOfRes < 25.5,87,Tree_95_Node_33);
        Tree_95_Node_11 := IF ( le.p_CurrAddrBurglaryIndex < 112.5,84,Tree_95_Node_19);
        Tree_95_Node_50 := IF ( le.p_SrcsConfirmIDAddrCount < 6.5,117,118);
        Tree_95_Node_28 := IF ( le.p_AgeOldestRecord < 411.5,Tree_95_Node_50,94);
        Tree_95_Node_52 := IF ( le.p_PRSearchOtherCount24 < 0.5,119,120);
        Tree_95_Node_29 := IF ( le.p_PropAgeNewestPurchase < 95.5,Tree_95_Node_52,95);
        Tree_95_Node_16 := IF ( le.p_CurrAddrMedianValue < 145361.5,Tree_95_Node_28,Tree_95_Node_29);
        Tree_95_Node_17 := IF ( le.p_CurrAddrAgeOldestRecord < 63.5,85,86);
        Tree_95_Node_10 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 2.5,Tree_95_Node_16,Tree_95_Node_17);
        Tree_95_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_95_Node_11,Tree_95_Node_10,Tree_95_Node_10,Tree_95_Node_11,Tree_95_Node_10,Tree_95_Node_10,Tree_95_Node_10,Tree_95_Node_11,Tree_95_Node_10,Tree_95_Node_10,Tree_95_Node_10,Tree_95_Node_10,Tree_95_Node_11);
        Tree_95_Node_2 := IF ( le.p_PrevAddrCrimeIndex < 199.0,Tree_95_Node_4,Tree_95_Node_5);
        Tree_95_Node_3 := IF ( le.p_CurrAddrBurglaryIndex < 115.0,82,83);
        Tree_95_Node_1 := IF ( le.p_PrevAddrMurderIndex < 199.5,Tree_95_Node_2,Tree_95_Node_3);
    UNSIGNED2 Score1_Tree95_node := Tree_95_Node_1;
    REAL8 Score1_Tree95_score := CASE(Score1_Tree95_node,82=>-3.5334926E-4,83=>-0.045212064,84=>-0.01824908,85=>0.00454887,86=>0.06045132,87=>-0.027176578,88=>-0.020724889,89=>0.09244173,90=>0.053617027,91=>-0.043956235,92=>0.009950228,93=>-0.008349352,94=>-0.04637163,95=>-0.03285114,96=>0.06817889,97=>3.8656293E-4,98=>-0.0230902,99=>0.040569004,100=>-0.0062737786,101=>0.008029308,102=>-0.020856805,103=>0.067640394,104=>-0.010133281,105=>-0.017203895,106=>0.0030191604,107=>-0.04370952,108=>-0.014037331,109=>-0.014323008,110=>0.01178508,111=>-4.1982174E-4,112=>0.034727257,113=>-0.0011455904,114=>0.036028825,115=>0.09858303,116=>0.038162686,117=>-0.01858332,118=>0.009727518,119=>0.061355848,120=>-0.010620121,121=>0.06495853,122=>0.01588334,0);
ENDMACRO;
