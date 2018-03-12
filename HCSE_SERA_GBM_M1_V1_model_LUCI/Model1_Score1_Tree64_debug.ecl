﻿EXPORT Model1_Score1_Tree64_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_64_Node_26 := CHOOSE ( le.p_financial_class,64,65,65,64,64,64,64,65,65,65,65,65,64,65,65,64);
        Tree_64_Node_27 := CHOOSE ( le.p_admit_diag,66,66,67,67,67,66,66,66,67,66,66,66,66);
        Tree_64_Node_18 := IF ( le.p_AddrChangeCount60 < 7.5,Tree_64_Node_26,Tree_64_Node_27);
        Tree_64_Node_28 := IF ( le.p_DerogAge < 159.5,68,69);
        Tree_64_Node_29 := CHOOSE ( le.p_readmit_lift,70,70,71,70,70,70,70,70,70,71,71,70,71);
        Tree_64_Node_19 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 218.0,Tree_64_Node_28,Tree_64_Node_29);
        Tree_64_Node_10 := IF ( le.p_BPV_1 < 2.3000624,Tree_64_Node_18,Tree_64_Node_19);
        Tree_64_Node_20 := IF ( le.p_CurrAddrLenOfRes < 50.5,59,60);
        Tree_64_Node_11 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 2.5,Tree_64_Node_20,57);
        Tree_64_Node_6 := IF ( le.p_v1_CrtRecMsdmeanCnt < 62.5,Tree_64_Node_10,Tree_64_Node_11);
        Tree_64_Node_32 := CHOOSE ( le.p_readmit_diag,73,73,73,73,72,73,73,73,72,72,73,73,72);
        Tree_64_Node_22 := IF ( le.p_PhoneEDAAgeNewestRecord < 82.5,Tree_64_Node_32,61);
        Tree_64_Node_23 := CHOOSE ( le.p_readmit_diag,62,63,62,63,63,63,62,63,62,63,63,63,63);
        Tree_64_Node_12 := CHOOSE ( le.p_financial_class,Tree_64_Node_22,Tree_64_Node_22,Tree_64_Node_22,Tree_64_Node_22,Tree_64_Node_23,Tree_64_Node_22,Tree_64_Node_23,Tree_64_Node_22,Tree_64_Node_22,Tree_64_Node_23,Tree_64_Node_22,Tree_64_Node_22,Tree_64_Node_22,Tree_64_Node_23,Tree_64_Node_22,Tree_64_Node_22);
        Tree_64_Node_7 := IF ( le.p_age_in_years < 82.75313,Tree_64_Node_12,53);
        Tree_64_Node_4 := IF ( le.p_BP_3 < 2.5,Tree_64_Node_6,Tree_64_Node_7);
        Tree_64_Node_8 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 1.5,54,55);
        Tree_64_Node_36 := IF ( le.p_BPV_1 < 3.8164,74,75);
        Tree_64_Node_37 := CHOOSE ( le.p_admit_diag,77,76,76,77,77,76,77,77,76,77,77,77,77);
        Tree_64_Node_24 := IF ( le.p_PRSearchOtherCount < 7.5,Tree_64_Node_36,Tree_64_Node_37);
        Tree_64_Node_16 := CHOOSE ( le.p_readmit_diag,Tree_64_Node_24,Tree_64_Node_24,Tree_64_Node_24,Tree_64_Node_24,Tree_64_Node_24,Tree_64_Node_24,58,58,58,58,Tree_64_Node_24,Tree_64_Node_24,58);
        Tree_64_Node_9 := IF ( le.p_v1_ProspectTimeOnRecord < 259.5,Tree_64_Node_16,56);
        Tree_64_Node_5 := IF ( le.p_PrevAddrCrimeIndex < 23.5,Tree_64_Node_8,Tree_64_Node_9);
        Tree_64_Node_2 := IF ( le.p_v1_CrtRecCnt < 75.5,Tree_64_Node_4,Tree_64_Node_5);
        Tree_64_Node_1 := IF ( le.p_BP_1 < 11.5,Tree_64_Node_2,52);
    SELF.Score1_Tree64_node := Tree_64_Node_1;
    SELF.Score1_Tree64_score := CASE(SELF.Score1_Tree64_node,52=>0.03152309,53=>0.056378294,54=>-0.031342316,55=>0.048183464,56=>0.0120181935,57=>-0.05982694,58=>0.011852268,59=>0.09640835,60=>-0.0010285946,61=>-0.054491635,62=>0.00128028,63=>0.07544301,64=>-0.008643136,65=>9.7565666E-5,66=>-0.034048717,67=>0.012870663,68=>0.0064672083,69=>0.036774207,70=>-0.058955174,71=>0.020344501,72=>-0.03162317,73=>0.013668221,74=>-0.044940032,75=>0.0026058492,76=>-0.06763392,77=>-0.043686323,0);
ENDMACRO;
