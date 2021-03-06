EXPORT Model1_Score1_Tree119(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_119_Node_36 := IF ( le.p_RelativesPropOwnedCount < 2.5,99,100);
        Tree_119_Node_37 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 6.5,101,102);
        Tree_119_Node_20 := CHOOSE ( le.p_readmit_diag,Tree_119_Node_36,Tree_119_Node_36,Tree_119_Node_37,Tree_119_Node_36,Tree_119_Node_36,Tree_119_Node_37,Tree_119_Node_37,Tree_119_Node_37,Tree_119_Node_37,Tree_119_Node_37,Tree_119_Node_37,Tree_119_Node_36,Tree_119_Node_37);
        Tree_119_Node_38 := CHOOSE ( le.p_readmit_diag,103,103,103,103,104,104,103,104,103,103,104,104,104);
        Tree_119_Node_39 := IF ( le.p_PropAgeNewestPurchase < 143.5,105,106);
        Tree_119_Node_21 := IF ( le.p_CurrAddrMurderIndex < 39.5,Tree_119_Node_38,Tree_119_Node_39);
        Tree_119_Node_12 := IF ( le.p_LastNameChangeAge < 512.5,Tree_119_Node_20,Tree_119_Node_21);
        Tree_119_Node_40 := IF ( le.p_BPV_2 < 3.641925,107,108);
        Tree_119_Node_41 := CHOOSE ( le.p_admit_diag,110,110,110,110,109,109,109,110,110,109,109,109,109);
        Tree_119_Node_22 := IF ( le.p_NonDerogCount60 < 5.5,Tree_119_Node_40,Tree_119_Node_41);
        Tree_119_Node_42 := CHOOSE ( le.p_financial_class,111,111,111,111,111,111,112,111,111,112,111,111,112,111,112,111);
        Tree_119_Node_23 := CHOOSE ( le.p_readmit_diag,Tree_119_Node_42,Tree_119_Node_42,Tree_119_Node_42,Tree_119_Node_42,Tree_119_Node_42,Tree_119_Node_42,Tree_119_Node_42,89,Tree_119_Node_42,Tree_119_Node_42,Tree_119_Node_42,89,Tree_119_Node_42);
        Tree_119_Node_13 := IF ( le.p_PRSearchLocateCount < 6.5,Tree_119_Node_22,Tree_119_Node_23);
        Tree_119_Node_8 := IF ( le.p_CurrAddrAgeOldestRecord < 239.5,Tree_119_Node_12,Tree_119_Node_13);
        Tree_119_Node_44 := IF ( le.p_CurrAddrMurderIndex < 9.5,113,114);
        Tree_119_Node_45 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 8.5,115,116);
        Tree_119_Node_24 := IF ( le.p_v1_RaAMedIncomeRange < 4.5,Tree_119_Node_44,Tree_119_Node_45);
        Tree_119_Node_25 := CHOOSE ( le.p_admit_diag,90,90,91,91,91,90,90,90,91,90,91,90,91);
        Tree_119_Node_14 := IF ( le.p_PRSearchOtherCount24 < 18.5,Tree_119_Node_24,Tree_119_Node_25);
        Tree_119_Node_48 := CHOOSE ( le.p_financial_class,117,118,118,118,118,118,118,118,117,117,118,118,118,117,117,117);
        Tree_119_Node_26 := IF ( le.p_v1_ProspectAge < 76.5,Tree_119_Node_48,92);
        Tree_119_Node_15 := IF ( le.p_v1_CrtRecTimeNewest < 81.5,Tree_119_Node_26,84);
        Tree_119_Node_9 := IF ( le.p_CurrAddrMedianValue < 625000.5,Tree_119_Node_14,Tree_119_Node_15);
        Tree_119_Node_4 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,Tree_119_Node_8,Tree_119_Node_9);
        Tree_119_Node_32 := IF ( le.p_SubjectPhoneCount < 0.5,95,96);
        Tree_119_Node_33 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 1.5,97,98);
        Tree_119_Node_18 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 0.5,Tree_119_Node_32,Tree_119_Node_33);
        Tree_119_Node_19 := IF ( le.p_StatusMostRecent < 2.5,87,88);
        Tree_119_Node_11 := IF ( le.p_SubjectSSNCount < 1.5,Tree_119_Node_18,Tree_119_Node_19);
        Tree_119_Node_50 := IF ( le.p_SrcsConfirmIDAddrCount < 6.5,119,120);
        Tree_119_Node_28 := IF ( le.p_AgeOldestRecord < 411.5,Tree_119_Node_50,93);
        Tree_119_Node_52 := IF ( le.p_LastNameChangeAge < 267.0,121,122);
        Tree_119_Node_29 := IF ( le.p_PropAgeNewestPurchase < 95.5,Tree_119_Node_52,94);
        Tree_119_Node_16 := IF ( le.p_CurrAddrMedianValue < 145361.5,Tree_119_Node_28,Tree_119_Node_29);
        Tree_119_Node_17 := IF ( le.p_CurrAddrAgeOldestRecord < 63.5,85,86);
        Tree_119_Node_10 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 2.5,Tree_119_Node_16,Tree_119_Node_17);
        Tree_119_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_119_Node_11,Tree_119_Node_10,Tree_119_Node_10,Tree_119_Node_11,Tree_119_Node_10,Tree_119_Node_10,Tree_119_Node_10,Tree_119_Node_11,Tree_119_Node_10,Tree_119_Node_10,Tree_119_Node_10,Tree_119_Node_10,Tree_119_Node_11);
        Tree_119_Node_2 := IF ( le.p_PrevAddrCrimeIndex < 199.0,Tree_119_Node_4,Tree_119_Node_5);
        Tree_119_Node_3 := IF ( le.p_CurrAddrBurglaryIndex < 115.0,82,83);
        Tree_119_Node_1 := IF ( le.p_PrevAddrMurderIndex < 199.5,Tree_119_Node_2,Tree_119_Node_3);
    UNSIGNED2 Score1_Tree119_node := Tree_119_Node_1;
    REAL8 Score1_Tree119_score := CASE(Score1_Tree119_node,82=>7.4561144E-4,83=>-0.035247568,84=>0.053916477,85=>0.0032635913,86=>0.042738724,87=>0.011543389,88=>0.04462502,89=>0.058811992,90=>0.007156208,91=>0.07350092,92=>0.037204597,93=>-0.036227517,94=>-0.025319021,95=>-0.0280533,96=>0.0063822484,97=>0.042554807,98=>-0.0044127977,99=>-3.7379927E-4,100=>-0.0030545464,101=>0.0014281115,102=>0.021130316,103=>-0.0039549484,104=>0.052635137,105=>-0.029254282,106=>-0.01311432,107=>-0.0012304335,108=>0.028214801,109=>-0.004940494,110=>0.0059922743,111=>0.010753299,112=>0.050664313,113=>0.015644727,114=>-0.008794852,115=>-2.633704E-4,116=>-0.0074291658,117=>-0.033406522,118=>-0.032618344,119=>-0.01433432,120=>0.007043665,121=>9.269528E-4,122=>0.051485304,0);
ENDMACRO;
