EXPORT Model1_Score1_Tree128_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_128_Node_32 := CHOOSE ( le.p_readmit_diag,93,92,93,93,93,93,93,93,93,93,93,93,93);
        Tree_128_Node_33 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 5.5,94,95);
        Tree_128_Node_20 := CHOOSE ( le.p_admit_diag,Tree_128_Node_32,Tree_128_Node_33,Tree_128_Node_33,Tree_128_Node_32,Tree_128_Node_32,Tree_128_Node_32,Tree_128_Node_32,Tree_128_Node_32,Tree_128_Node_32,Tree_128_Node_32,Tree_128_Node_32,Tree_128_Node_33,Tree_128_Node_32);
        Tree_128_Node_34 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 4.5,96,97);
        Tree_128_Node_35 := IF ( le.p_DerogAge < 138.5,98,99);
        Tree_128_Node_21 := IF ( le.p_v1_ProspectMaritalStatus < 0.5,Tree_128_Node_34,Tree_128_Node_35);
        Tree_128_Node_12 := IF ( le.p_PRSearchOtherCount < 12.5,Tree_128_Node_20,Tree_128_Node_21);
        Tree_128_Node_36 := CHOOSE ( le.p_readmit_lift,100,101,100,100,100,100,100,100,100,100,100,101,100);
        Tree_128_Node_22 := CHOOSE ( le.p_admit_diag,Tree_128_Node_36,Tree_128_Node_36,86,Tree_128_Node_36,Tree_128_Node_36,Tree_128_Node_36,Tree_128_Node_36,Tree_128_Node_36,86,Tree_128_Node_36,Tree_128_Node_36,Tree_128_Node_36,86);
        Tree_128_Node_23 := IF ( le.p_v1_HHCnt < 2.5,87,88);
        Tree_128_Node_13 := CHOOSE ( le.p_readmit_diag,Tree_128_Node_22,Tree_128_Node_22,Tree_128_Node_23,Tree_128_Node_23,Tree_128_Node_23,Tree_128_Node_22,Tree_128_Node_22,Tree_128_Node_23,Tree_128_Node_23,Tree_128_Node_22,Tree_128_Node_22,Tree_128_Node_22,Tree_128_Node_22);
        Tree_128_Node_8 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 386.5,Tree_128_Node_12,Tree_128_Node_13);
        Tree_128_Node_40 := CHOOSE ( le.p_readmit_lift,103,102,103,103,103,103,103,103,103,103,102,102,102);
        Tree_128_Node_25 := IF ( le.p_PrevAddrMedianIncome < 28436.5,Tree_128_Node_40,89);
        Tree_128_Node_14 := CHOOSE ( le.p_financial_class,84,84,Tree_128_Node_25,84,84,84,84,84,Tree_128_Node_25,84,Tree_128_Node_25,Tree_128_Node_25,84,84,84,84);
        Tree_128_Node_42 := IF ( le.p_BP_4 < 16.5,104,105);
        Tree_128_Node_43 := CHOOSE ( le.p_readmit_diag,106,106,106,106,107,106,106,107,107,107,106,106,106);
        Tree_128_Node_26 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,Tree_128_Node_42,Tree_128_Node_43);
        Tree_128_Node_44 := CHOOSE ( le.p_readmit_lift,108,109,109,108,109,108,108,108,108,108,109,108,108);
        Tree_128_Node_45 := IF ( le.p_PropOwnedHistoricalCount < 2.5,110,111);
        Tree_128_Node_27 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 2.5,Tree_128_Node_44,Tree_128_Node_45);
        Tree_128_Node_15 := IF ( le.p_NonDerogCount24 < 4.5,Tree_128_Node_26,Tree_128_Node_27);
        Tree_128_Node_9 := IF ( le.p_NonDerogCount < 3.5,Tree_128_Node_14,Tree_128_Node_15);
        Tree_128_Node_4 := IF ( le.p_PrevAddrCrimeIndex < 183.0,Tree_128_Node_8,Tree_128_Node_9);
        Tree_128_Node_50 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,116,117);
        Tree_128_Node_51 := IF ( le.p_DivSSNAddrMSourceCount < 11.5,118,119);
        Tree_128_Node_30 := IF ( le.p_v1_CrtRecMsdmeanCnt < 3.5,Tree_128_Node_50,Tree_128_Node_51);
        Tree_128_Node_17 := IF ( le.p_BPV_3 < 1.9580687,Tree_128_Node_30,85);
        Tree_128_Node_46 := CHOOSE ( le.p_admit_diag,113,113,113,112,112,112,113,112,112,113,112,113,113);
        Tree_128_Node_28 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 2.5,Tree_128_Node_46,90);
        Tree_128_Node_48 := IF ( le.p_CurrAddrCarTheftIndex < 100.0,114,115);
        Tree_128_Node_29 := IF ( le.p_CurrAddrMedianValue < 145362.5,Tree_128_Node_48,91);
        Tree_128_Node_16 := IF ( le.p_NonDerogCount24 < 4.5,Tree_128_Node_28,Tree_128_Node_29);
        Tree_128_Node_10 := CHOOSE ( le.p_readmit_diag,Tree_128_Node_17,Tree_128_Node_16,Tree_128_Node_17,Tree_128_Node_17,Tree_128_Node_16,Tree_128_Node_16,Tree_128_Node_16,Tree_128_Node_17,Tree_128_Node_16,Tree_128_Node_16,Tree_128_Node_16,Tree_128_Node_16,Tree_128_Node_17);
        Tree_128_Node_11 := CHOOSE ( le.p_admit_diag,82,83,82,82,82,82,83,83,83,82,82,82,82);
        Tree_128_Node_5 := IF ( le.p_AccidentAge < 11.5,Tree_128_Node_10,Tree_128_Node_11);
        Tree_128_Node_2 := IF ( le.p_PrevAddrCrimeIndex < 199.0,Tree_128_Node_4,Tree_128_Node_5);
        Tree_128_Node_3 := CHOOSE ( le.p_admit_diag,81,80,81,80,80,80,80,80,80,80,81,80,80);
        Tree_128_Node_1 := IF ( le.p_PrevAddrMurderIndex < 199.5,Tree_128_Node_2,Tree_128_Node_3);
    SELF.Score1_Tree128_node := Tree_128_Node_1;
    SELF.Score1_Tree128_score := CASE(SELF.Score1_Tree128_node,80=>-0.032163564,81=>4.0508472E-4,82=>-0.032985665,83=>-0.006271688,84=>-0.011211778,85=>0.03618545,86=>-0.0041583967,87=>0.023848284,88=>-0.0016703883,89=>0.0011963109,90=>0.03673763,91=>0.008342152,92=>-0.01028214,93=>-3.6835103E-5,94=>0.001127838,95=>0.021179404,96=>-0.0064778,97=>0.0051659145,98=>-0.0032567275,99=>0.03664945,100=>-0.031638175,101=>-0.02682876,102=>0.036636934,103=>0.053391393,104=>0.00466136,105=>-0.008691047,106=>-0.012154887,107=>0.009575255,108=>-0.012853019,109=>-0.006933649,110=>-0.0049872873,111=>0.027088083,112=>-0.022087174,113=>0.008301765,114=>-0.005060419,115=>-0.030212209,116=>0.040771797,117=>0.0026790597,118=>-0.016359212,119=>0.015688816,0);
ENDMACRO;
