﻿EXPORT Model1_Score1_Tree114(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_114_Node_36 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 85349.5,85,86);
        Tree_114_Node_37 := CHOOSE ( le.p_readmit_lift,88,88,88,87,88,87,87,88,88,87,87,87,87);
        Tree_114_Node_24 := IF ( le.p_CurrAddrAgeLastSale < 351.5,Tree_114_Node_36,Tree_114_Node_37);
        Tree_114_Node_38 := IF ( le.p_PrevAddrBurglaryIndex < 190.5,89,90);
        Tree_114_Node_39 := IF ( le.p_SSNIssueState < 11.5,91,92);
        Tree_114_Node_25 := IF ( le.p_AccidentAge < 112.5,Tree_114_Node_38,Tree_114_Node_39);
        Tree_114_Node_16 := IF ( le.p_v1_HHEstimatedIncomeRange < 2.5,Tree_114_Node_24,Tree_114_Node_25);
        Tree_114_Node_40 := IF ( le.p_PrevAddrLenOfRes < 302.5,93,94);
        Tree_114_Node_41 := IF ( le.p_PrevAddrAgeLastSale < 455.0,95,96);
        Tree_114_Node_26 := IF ( le.p_PrevAddrMedianIncome < 21447.5,Tree_114_Node_40,Tree_114_Node_41);
        Tree_114_Node_27 := IF ( le.p_PrevAddrMedianValue < 124999.5,81,82);
        Tree_114_Node_17 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 241.5,Tree_114_Node_26,Tree_114_Node_27);
        Tree_114_Node_8 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_114_Node_16,Tree_114_Node_17);
        Tree_114_Node_18 := IF ( le.p_RelativesPropOwnedCount < 1.5,76,77);
        Tree_114_Node_19 := CHOOSE ( le.p_readmit_lift,78,79,78,78,78,78,78,78,78,78,78,78,78);
        Tree_114_Node_9 := IF ( le.p_LastNameChangeAge < 280.5,Tree_114_Node_18,Tree_114_Node_19);
        Tree_114_Node_4 := IF ( le.p_PrevAddrAgeLastSale < 628.5,Tree_114_Node_8,Tree_114_Node_9);
        Tree_114_Node_45 := IF ( le.p_SubjectLastNameCount < 3.5,99,100);
        Tree_114_Node_44 := IF ( le.p_PrevAddrMedianIncome < 56011.5,97,98);
        Tree_114_Node_32 := CHOOSE ( le.p_admit_diag,Tree_114_Node_45,Tree_114_Node_44,Tree_114_Node_44,Tree_114_Node_45,Tree_114_Node_45,Tree_114_Node_45,Tree_114_Node_44,Tree_114_Node_44,Tree_114_Node_44,Tree_114_Node_44,Tree_114_Node_44,Tree_114_Node_45,Tree_114_Node_44);
        Tree_114_Node_33 := IF ( le.p_PropAgeNewestPurchase < 159.5,83,84);
        Tree_114_Node_20 := IF ( le.p_PrevAddrBurglaryIndex < 170.5,Tree_114_Node_32,Tree_114_Node_33);
        Tree_114_Node_48 := IF ( le.p_v1_HHCnt < 6.5,101,102);
        Tree_114_Node_49 := IF ( le.p_v1_HHCnt < 2.5,103,104);
        Tree_114_Node_34 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 6.5,Tree_114_Node_48,Tree_114_Node_49);
        Tree_114_Node_21 := IF ( le.p_PropAgeNewestPurchase < 672.5,Tree_114_Node_34,80);
        Tree_114_Node_10 := CHOOSE ( le.p_readmit_lift,Tree_114_Node_20,Tree_114_Node_21,Tree_114_Node_20,Tree_114_Node_20,Tree_114_Node_20,Tree_114_Node_21,Tree_114_Node_20,Tree_114_Node_21,Tree_114_Node_21,Tree_114_Node_20,Tree_114_Node_20,Tree_114_Node_21,Tree_114_Node_20);
        Tree_114_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10,70,Tree_114_Node_10,Tree_114_Node_10,Tree_114_Node_10);
        Tree_114_Node_2 := IF ( le.p_PrevAddrAgeOldestRecord < 507.0,Tree_114_Node_4,Tree_114_Node_5);
        Tree_114_Node_6 := IF ( le.p_PRSearchOtherCount < 0.5,71,72);
        Tree_114_Node_14 := CHOOSE ( le.p_admit_diag,74,75,75,75,75,75,75,74,75,74,75,74,75);
        Tree_114_Node_7 := CHOOSE ( le.p_financial_class,Tree_114_Node_14,Tree_114_Node_14,73,73,73,73,73,73,Tree_114_Node_14,73,Tree_114_Node_14,Tree_114_Node_14,73,73,73,Tree_114_Node_14);
        Tree_114_Node_3 := IF ( le.p_PhoneEDAAgeOldestRecord < 37.0,Tree_114_Node_6,Tree_114_Node_7);
        Tree_114_Node_1 := IF ( le.p_PhoneOtherAgeNewestRecord < 153.5,Tree_114_Node_2,Tree_114_Node_3);
    UNSIGNED2 Score1_Tree114_node := Tree_114_Node_1;
    REAL8 Score1_Tree114_score := CASE(Score1_Tree114_node,70=>0.025186755,71=>0.030371595,72=>-0.028987609,73=>-0.024022145,74=>-0.039146185,75=>-0.03552688,76=>0.024495034,77=>-0.029858753,78=>-0.03817811,79=>-0.03565334,80=>0.04086571,81=>0.046739228,82=>0.0035271219,83=>0.027230801,84=>-0.007668433,85=>-9.0533466E-4,86=>0.007313418,87=>-0.039253652,88=>-0.006033676,89=>8.641201E-4,90=>0.00686089,91=>0.009443079,92=>-0.012309575,93=>0.0013718769,94=>0.025740156,95=>-0.0058999183,96=>0.025286717,97=>-0.03711709,98=>-0.022430291,99=>-0.016977478,100=>0.011335973,101=>-0.011450487,102=>0.030528318,103=>0.06008286,104=>0.00460704,0);
ENDMACRO;
