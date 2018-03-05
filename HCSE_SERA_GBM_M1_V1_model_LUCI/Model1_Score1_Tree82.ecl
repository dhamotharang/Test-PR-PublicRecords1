﻿EXPORT Model1_Score1_Tree82(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_82_Node_46 := IF ( le.p_v1_CrtRecCnt < 19.5,101,102);
        Tree_82_Node_47 := IF ( le.p_SrcsConfirmIDAddrCount < 4.5,103,104);
        Tree_82_Node_28 := IF ( le.p_CurrAddrCarTheftIndex < 89.5,Tree_82_Node_46,Tree_82_Node_47);
        Tree_82_Node_48 := CHOOSE ( le.p_financial_class,105,106,106,105,106,106,105,105,106,105,105,105,105,105,106,105);
        Tree_82_Node_49 := IF ( le.p_VariationDOBCount < 3.5,107,108);
        Tree_82_Node_29 := CHOOSE ( le.p_readmit_diag,Tree_82_Node_48,Tree_82_Node_48,Tree_82_Node_48,Tree_82_Node_48,Tree_82_Node_48,Tree_82_Node_49,Tree_82_Node_48,Tree_82_Node_48,Tree_82_Node_49,Tree_82_Node_48,Tree_82_Node_48,Tree_82_Node_48,Tree_82_Node_48);
        Tree_82_Node_16 := IF ( le.p_AddrChangeCount60 < 4.5,Tree_82_Node_28,Tree_82_Node_29);
        Tree_82_Node_30 := CHOOSE ( le.p_readmit_lift,93,94,93,93,93,93,93,93,93,93,93,93,93);
        Tree_82_Node_17 := CHOOSE ( le.p_admit_diag,Tree_82_Node_30,83,Tree_82_Node_30,83,Tree_82_Node_30,Tree_82_Node_30,Tree_82_Node_30,Tree_82_Node_30,Tree_82_Node_30,Tree_82_Node_30,Tree_82_Node_30,Tree_82_Node_30,Tree_82_Node_30);
        Tree_82_Node_8 := IF ( le.p_CurrAddrMedianValue < 843750.5,Tree_82_Node_16,Tree_82_Node_17);
        Tree_82_Node_32 := CHOOSE ( le.p_financial_class,95,96,96,96,96,96,96,96,95,96,95,96,96,95,95,95);
        Tree_82_Node_18 := IF ( le.p_PrevAddrMedianIncome < 59759.5,Tree_82_Node_32,84);
        Tree_82_Node_9 := CHOOSE ( le.p_admit_diag,Tree_82_Node_18,Tree_82_Node_18,80,Tree_82_Node_18,Tree_82_Node_18,Tree_82_Node_18,80,80,Tree_82_Node_18,Tree_82_Node_18,Tree_82_Node_18,Tree_82_Node_18,Tree_82_Node_18);
        Tree_82_Node_4 := IF ( le.p_PhoneEDAAgeNewestRecord < 191.5,Tree_82_Node_8,Tree_82_Node_9);
        Tree_82_Node_5 := IF ( le.p_PrevAddrAgeOldestRecord < 123.5,78,79);
        Tree_82_Node_2 := IF ( le.p_v1_ProspectAge < 93.0,Tree_82_Node_4,Tree_82_Node_5);
        Tree_82_Node_54 := IF ( le.p_CurrAddrCountyIndex < 1.605,109,110);
        Tree_82_Node_55 := IF ( le.p_PhoneEDAAgeNewestRecord < 17.5,111,112);
        Tree_82_Node_34 := CHOOSE ( le.p_readmit_diag,Tree_82_Node_54,Tree_82_Node_54,Tree_82_Node_55,Tree_82_Node_55,Tree_82_Node_54,Tree_82_Node_55,Tree_82_Node_54,Tree_82_Node_54,Tree_82_Node_55,Tree_82_Node_54,Tree_82_Node_54,Tree_82_Node_54,Tree_82_Node_54);
        Tree_82_Node_20 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 151.5,Tree_82_Node_34,85);
        Tree_82_Node_12 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 6.5,Tree_82_Node_20,81);
        Tree_82_Node_22 := CHOOSE ( le.p_admit_diag,86,87,86,87,87,87,86,86,86,86,86,87,86);
        Tree_82_Node_56 := IF ( le.p_LastNameChangeAge < 97.0,113,114);
        Tree_82_Node_38 := CHOOSE ( le.p_admit_diag,Tree_82_Node_56,Tree_82_Node_56,Tree_82_Node_56,Tree_82_Node_56,Tree_82_Node_56,Tree_82_Node_56,97,Tree_82_Node_56,97,Tree_82_Node_56,Tree_82_Node_56,97,Tree_82_Node_56);
        Tree_82_Node_58 := CHOOSE ( le.p_readmit_diag,116,116,115,115,115,116,116,115,115,116,115,115,115);
        Tree_82_Node_39 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 23.5,Tree_82_Node_58,98);
        Tree_82_Node_23 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_82_Node_38,Tree_82_Node_39);
        Tree_82_Node_13 := IF ( le.p_CurrAddrAgeOldestRecord < 260.5,Tree_82_Node_22,Tree_82_Node_23);
        Tree_82_Node_6 := IF ( le.p_CurrAddrAgeOldestRecord < 223.5,Tree_82_Node_12,Tree_82_Node_13);
        Tree_82_Node_24 := IF ( le.p_WealthIndex < 3.5,88,89);
        Tree_82_Node_25 := IF ( le.p_PhoneOtherAgeOldestRecord < 130.5,90,91);
        Tree_82_Node_14 := IF ( le.p_CurrAddrCrimeIndex < 50.5,Tree_82_Node_24,Tree_82_Node_25);
        Tree_82_Node_45 := IF ( le.p_PhoneOtherAgeOldestRecord < 123.5,99,100);
        Tree_82_Node_27 := IF ( le.p_AgeOldestRecord < 405.5,92,Tree_82_Node_45);
        Tree_82_Node_15 := CHOOSE ( le.p_readmit_diag,Tree_82_Node_27,Tree_82_Node_27,82,Tree_82_Node_27,Tree_82_Node_27,82,82,Tree_82_Node_27,Tree_82_Node_27,82,82,82,82);
        Tree_82_Node_7 := IF ( le.p_PrevAddrMedianIncome < 61262.5,Tree_82_Node_14,Tree_82_Node_15);
        Tree_82_Node_3 := IF ( le.p_CurrAddrMedianIncome < 82113.5,Tree_82_Node_6,Tree_82_Node_7);
        Tree_82_Node_1 := IF ( le.p_age_in_years < 93.09727,Tree_82_Node_2,Tree_82_Node_3);
    UNSIGNED2 Score1_Tree82_node := Tree_82_Node_1;
    REAL8 Score1_Tree82_score := CASE(Score1_Tree82_node,78=>0.0651665,79=>-0.003188231,80=>0.012374098,81=>0.023173412,82=>-0.050264586,83=>-0.0068517174,84=>-0.021317923,85=>0.020598326,86=>-0.0019243162,87=>0.08976736,88=>0.023584183,89=>0.106996536,90=>-0.031465217,91=>0.033800468,92=>0.042078033,93=>-0.050773457,94=>-0.04743839,95=>-0.048187688,96=>-0.04917816,97=>0.024220945,98=>0.043945238,99=>-0.050498534,100=>-0.0023185331,101=>-5.9700567E-5,102=>-0.007993118,103=>0.0042860294,104=>-3.124783E-4,105=>-0.012224424,106=>-0.0018920635,107=>0.023654222,108=>-0.025805233,109=>-0.044465195,110=>-0.004111491,111=>-0.030083124,112=>0.023206513,113=>0.005220449,114=>-0.032746494,115=>-0.03674547,116=>0.012562016,0);
ENDMACRO;
