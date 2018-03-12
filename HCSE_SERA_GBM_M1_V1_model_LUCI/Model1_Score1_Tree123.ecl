﻿EXPORT Model1_Score1_Tree123(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_123_Node_30 := IF ( le.p_BP_1 < 6.5,58,59);
        Tree_123_Node_31 := CHOOSE ( le.p_readmit_diag,60,61,60,60,60,60,60,61,60,60,61,61,61);
        Tree_123_Node_22 := IF ( le.p_BP_3 < 2.5,Tree_123_Node_30,Tree_123_Node_31);
        Tree_123_Node_33 := CHOOSE ( le.p_admit_diag,62,62,62,62,63,62,62,62,63,63,62,62,62);
        Tree_123_Node_23 := IF ( le.p_PrevAddrMurderIndex < 19.5,56,Tree_123_Node_33);
        Tree_123_Node_16 := IF ( le.p_v1_CrtRecMsdmeanCnt < 69.5,Tree_123_Node_22,Tree_123_Node_23);
        Tree_123_Node_17 := CHOOSE ( le.p_admit_diag,52,51,51,52,51,51,51,51,51,52,52,52,51);
        Tree_123_Node_8 := IF ( le.p_BP_1 < 10.5,Tree_123_Node_16,Tree_123_Node_17);
        Tree_123_Node_18 := IF ( le.p_PhoneOtherAgeOldestRecord < 78.5,53,54);
        Tree_123_Node_34 := IF ( le.p_PhoneEDAAgeOldestRecord < 194.5,64,65);
        Tree_123_Node_29 := CHOOSE ( le.p_readmit_lift,57,Tree_123_Node_34,Tree_123_Node_34,Tree_123_Node_34,57,Tree_123_Node_34,Tree_123_Node_34,Tree_123_Node_34,Tree_123_Node_34,Tree_123_Node_34,Tree_123_Node_34,Tree_123_Node_34,Tree_123_Node_34);
        Tree_123_Node_19 := CHOOSE ( le.p_readmit_diag,Tree_123_Node_29,Tree_123_Node_29,Tree_123_Node_29,Tree_123_Node_29,55,Tree_123_Node_29,55,55,Tree_123_Node_29,55,Tree_123_Node_29,55,55);
        Tree_123_Node_9 := IF ( le.p_PrevAddrAgeOldestRecord < 39.5,Tree_123_Node_18,Tree_123_Node_19);
        Tree_123_Node_4 := IF ( le.p_AccidentAge < 263.5,Tree_123_Node_8,Tree_123_Node_9);
        Tree_123_Node_5 := CHOOSE ( le.p_financial_class,44,44,45,44,44,44,44,44,44,44,44,44,44,45,44,44);
        Tree_123_Node_2 := IF ( le.p_AccidentAge < 359.5,Tree_123_Node_4,Tree_123_Node_5);
        Tree_123_Node_6 := IF ( le.p_RelativesPropOwnedCount < 1.5,46,47);
        Tree_123_Node_14 := CHOOSE ( le.p_admit_diag,49,50,50,50,50,50,50,49,50,49,50,49,50);
        Tree_123_Node_7 := CHOOSE ( le.p_financial_class,Tree_123_Node_14,Tree_123_Node_14,48,48,48,48,48,48,Tree_123_Node_14,48,Tree_123_Node_14,Tree_123_Node_14,48,48,48,Tree_123_Node_14);
        Tree_123_Node_3 := IF ( le.p_PhoneEDAAgeOldestRecord < 37.0,Tree_123_Node_6,Tree_123_Node_7);
        Tree_123_Node_1 := IF ( le.p_PhoneOtherAgeNewestRecord < 153.5,Tree_123_Node_2,Tree_123_Node_3);
    UNSIGNED2 Score1_Tree123_node := Tree_123_Node_1;
    REAL8 Score1_Tree123_score := CASE(Score1_Tree123_node,64=>-0.028995387,65=>4.0969328E-4,44=>-0.009483,45=>0.042257234,46=>0.02569103,47=>-0.026398767,48=>-0.021516753,49=>-0.03560664,50=>-0.03235303,51=>-0.0016370559,52=>0.029818531,53=>0.04590705,54=>-0.012698932,55=>-0.034186058,56=>0.011860117,57=>0.0070755295,58=>8.43574E-6,59=>0.015253256,60=>-3.49571E-4,61=>0.015708137,62=>-0.019148836,63=>0.01471143,0);
ENDMACRO;
