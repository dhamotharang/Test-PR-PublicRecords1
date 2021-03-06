EXPORT Model1_Score1_Tree49_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_49_Node_44 := IF ( le.p_v1_HHCnt < 2.5,116,117);
        Tree_49_Node_45 := IF ( le.p_SubjectLastNameCount < 1.5,118,119);
        Tree_49_Node_26 := IF ( le.p_NonDerogCount01 < 4.5,Tree_49_Node_44,Tree_49_Node_45);
        Tree_49_Node_46 := IF ( le.p_PropAgeNewestSale < 51.5,120,121);
        Tree_49_Node_47 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 0.5,122,123);
        Tree_49_Node_27 := CHOOSE ( le.p_financial_class,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_47,Tree_49_Node_47,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_47,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_46,Tree_49_Node_46);
        Tree_49_Node_14 := CHOOSE ( le.p_readmit_lift,Tree_49_Node_26,Tree_49_Node_26,Tree_49_Node_26,Tree_49_Node_27,Tree_49_Node_26,Tree_49_Node_27,Tree_49_Node_26,Tree_49_Node_27,Tree_49_Node_26,Tree_49_Node_26,Tree_49_Node_27,Tree_49_Node_26,Tree_49_Node_26);
        Tree_49_Node_48 := IF ( le.p_PhoneEDAAgeOldestRecord < 193.5,124,125);
        Tree_49_Node_49 := IF ( le.p_CurrAddrAgeOldestRecord < 258.5,126,127);
        Tree_49_Node_28 := IF ( le.p_CurrAddrAgeOldestRecord < 223.5,Tree_49_Node_48,Tree_49_Node_49);
        Tree_49_Node_51 := IF ( le.p_LastNameChangeAge < 338.5,130,131);
        Tree_49_Node_50 := IF ( le.p_PrevAddrCrimeIndex < 170.5,128,129);
        Tree_49_Node_29 := CHOOSE ( le.p_readmit_diag,Tree_49_Node_51,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_51,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_50,Tree_49_Node_50);
        Tree_49_Node_15 := IF ( le.p_CurrAddrCrimeIndex < 119.5,Tree_49_Node_28,Tree_49_Node_29);
        Tree_49_Node_8 := IF ( le.p_age_in_years < 92.99062,Tree_49_Node_14,Tree_49_Node_15);
        Tree_49_Node_52 := CHOOSE ( le.p_readmit_diag,132,132,132,132,132,132,132,132,133,132,132,132,133);
        Tree_49_Node_53 := IF ( le.p_PrevAddrBurglaryIndex < 49.5,134,135);
        Tree_49_Node_31 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 1.5,Tree_49_Node_52,Tree_49_Node_53);
        Tree_49_Node_16 := IF ( le.p_SSNHighIssueAge < 79.5,100,Tree_49_Node_31);
        Tree_49_Node_33 := CHOOSE ( le.p_readmit_diag,106,107,107,106,107,106,107,106,106,107,106,106,106);
        Tree_49_Node_17 := IF ( le.p_NonDerogCount01 < 2.5,101,Tree_49_Node_33);
        Tree_49_Node_9 := IF ( le.p_v1_CrtRecTimeNewest < 295.5,Tree_49_Node_16,Tree_49_Node_17);
        Tree_49_Node_4 := IF ( le.p_CurrAddrCrimeIndex < 184.5,Tree_49_Node_8,Tree_49_Node_9);
        Tree_49_Node_56 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,136,137);
        Tree_49_Node_57 := IF ( le.p_SrcsConfirmIDAddrCount < 3.5,138,139);
        Tree_49_Node_34 := IF ( le.p_PhoneOtherAgeNewestRecord < 125.0,Tree_49_Node_56,Tree_49_Node_57);
        Tree_49_Node_18 := IF ( le.p_v1_HHCollegeAttendedMmbrCnt < 3.5,Tree_49_Node_34,102);
        Tree_49_Node_58 := IF ( le.p_PrevAddrAgeLastSale < 65.5,140,141);
        Tree_49_Node_36 := IF ( le.p_PrevAddrAgeLastSale < 443.5,Tree_49_Node_58,108);
        Tree_49_Node_37 := CHOOSE ( le.p_admit_diag,110,110,109,110,109,109,109,109,109,109,110,109,109);
        Tree_49_Node_19 := IF ( le.p_DerogAge < 260.5,Tree_49_Node_36,Tree_49_Node_37);
        Tree_49_Node_10 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 0.5,Tree_49_Node_18,Tree_49_Node_19);
        Tree_49_Node_39 := CHOOSE ( le.p_readmit_diag,112,111,112,112,112,112,112,112,111,112,112,111,111);
        Tree_49_Node_20 := CHOOSE ( le.p_readmit_lift,103,Tree_49_Node_39,103,103,103,103,103,Tree_49_Node_39,Tree_49_Node_39,103,103,103,103);
        Tree_49_Node_11 := IF ( le.p_PropAgeOldestPurchase < 215.5,Tree_49_Node_20,97);
        Tree_49_Node_5 := IF ( le.p_SubjectSSNCount < 4.5,Tree_49_Node_10,Tree_49_Node_11);
        Tree_49_Node_2 := IF ( le.p_CurrAddrAVMValue60 < 74510.5,Tree_49_Node_4,Tree_49_Node_5);
        Tree_49_Node_40 := CHOOSE ( le.p_admit_diag,114,113,114,114,114,114,114,114,113,114,114,114,114);
        Tree_49_Node_23 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 184121.5,Tree_49_Node_40,104);
        Tree_49_Node_12 := CHOOSE ( le.p_readmit_lift,98,Tree_49_Node_23,98,Tree_49_Node_23,98,98,98,98,98,98,Tree_49_Node_23,98,98);
        Tree_49_Node_66 := IF ( le.p_v1_HHPPCurrOwnedCnt < 2.5,142,143);
        Tree_49_Node_42 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 5.5,Tree_49_Node_66,115);
        Tree_49_Node_24 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 2.5,Tree_49_Node_42,105);
        Tree_49_Node_13 := IF ( le.p_v1_HHPropCurrOwnedCnt < 10.5,Tree_49_Node_24,99);
        Tree_49_Node_6 := CHOOSE ( le.p_financial_class,Tree_49_Node_12,Tree_49_Node_13,Tree_49_Node_13,Tree_49_Node_12,Tree_49_Node_13,Tree_49_Node_12,Tree_49_Node_13,Tree_49_Node_13,Tree_49_Node_13,Tree_49_Node_12,Tree_49_Node_12,Tree_49_Node_13,Tree_49_Node_13,Tree_49_Node_13,Tree_49_Node_13,Tree_49_Node_13);
        Tree_49_Node_3 := IF ( le.p_CurrAddrLenOfRes < 698.5,Tree_49_Node_6,96);
        Tree_49_Node_1 := IF ( le.p_NonDerogCount06 < 5.5,Tree_49_Node_2,Tree_49_Node_3);
    SELF.Score1_Tree49_node := Tree_49_Node_1;
    SELF.Score1_Tree49_score := CASE(SELF.Score1_Tree49_node,128=>-0.070185766,129=>-0.030440498,130=>-0.0518774,131=>0.048583783,132=>-0.015162677,133=>0.04534903,134=>0.041843396,135=>0.0058239885,136=>0.007578346,137=>9.515181E-4,138=>0.07553614,139=>0.0142527865,140=>-0.0056553977,141=>-0.036515027,142=>-0.0066074887,143=>-0.026590748,96=>0.07908121,97=>0.0016546346,98=>-0.07173875,99=>0.05195464,100=>0.09546106,101=>0.123499215,102=>0.091096245,103=>-0.07283403,104=>-0.0072043194,105=>0.07362705,106=>-0.028768577,107=>0.06728505,108=>0.087056406,109=>-0.016629891,110=>0.15832116,111=>-0.06908144,112=>-0.03618915,113=>-0.06863172,114=>-0.067395695,115=>0.08243768,116=>-0.0036569813,117=>0.0021010241,118=>0.0112614855,119=>-0.020710194,120=>0.0011994274,121=>0.029279154,122=>0.03189116,123=>0.106783345,124=>-0.036649782,125=>0.033611253,126=>0.114327654,127=>-0.0070721344,0);
ENDMACRO;
