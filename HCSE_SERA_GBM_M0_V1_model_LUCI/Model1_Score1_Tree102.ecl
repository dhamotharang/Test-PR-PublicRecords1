﻿EXPORT Model1_Score1_Tree102(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_102_Node_48 := IF ( le.p_v1_HHCrtRecFelonyMmbrCnt < 2.5,106,107);
        Tree_102_Node_49 := IF ( le.p_DivSSNAddrMSourceCount < 18.5,108,109);
        Tree_102_Node_30 := IF ( le.p_SubjectSSNCount < 5.5,Tree_102_Node_48,Tree_102_Node_49);
        Tree_102_Node_50 := IF ( le.p_PrevAddrCarTheftIndex < 59.5,110,111);
        Tree_102_Node_31 := IF ( le.p_DivSSNIdentityMSourceUrelCount < 2.5,Tree_102_Node_50,100);
        Tree_102_Node_16 := IF ( le.p_AddrChangeCount60 < 6.5,Tree_102_Node_30,Tree_102_Node_31);
        Tree_102_Node_17 := IF ( le.p_NonDerogCount60 < 4.5,90,91);
        Tree_102_Node_8 := IF ( le.p_AddrChangeCount24 < 4.5,Tree_102_Node_16,Tree_102_Node_17);
        Tree_102_Node_52 := IF ( le.p_v1_ProspectTimeLastUpdate < 191.5,112,113);
        Tree_102_Node_53 := IF ( le.p_PrevAddrBurglaryIndex < 180.5,114,115);
        Tree_102_Node_34 := IF ( le.p_PrevAddrCrimeIndex < 110.5,Tree_102_Node_52,Tree_102_Node_53);
        Tree_102_Node_54 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 0.5,116,117);
        Tree_102_Node_55 := IF ( le.p_v1_RaAPropOwnerAVMMed < 197115.5,118,119);
        Tree_102_Node_35 := IF ( le.p_PrevAddrCarTheftIndex < 110.5,Tree_102_Node_54,Tree_102_Node_55);
        Tree_102_Node_19 := IF ( le.p_PrevAddrLenOfRes < 182.5,Tree_102_Node_34,Tree_102_Node_35);
        Tree_102_Node_9 := IF ( le.p_age_in_years < 17.915625,85,Tree_102_Node_19);
        Tree_102_Node_4 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_102_Node_8,Tree_102_Node_9);
        Tree_102_Node_37 := IF ( le.p_NonDerogCount24 < 3.5,101,102);
        Tree_102_Node_20 := IF ( le.p_CurrAddrCarTheftIndex < 89.5,92,Tree_102_Node_37);
        Tree_102_Node_10 := IF ( le.p_EstimatedAnnualIncome < 38929.5,Tree_102_Node_20,86);
        Tree_102_Node_39 := IF ( le.p_v1_RaASeniorMmbrCnt < 0.5,103,104);
        Tree_102_Node_22 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,93,Tree_102_Node_39);
        Tree_102_Node_11 := IF ( le.p_CurrAddrTractIndex < 1.015625,Tree_102_Node_22,87);
        Tree_102_Node_5 := IF ( le.p_v1_ProspectTimeLastUpdate < 7.5,Tree_102_Node_10,Tree_102_Node_11);
        Tree_102_Node_2 := IF ( le.p_SSNAddrRecentCount < 1.5,Tree_102_Node_4,Tree_102_Node_5);
        Tree_102_Node_25 := IF ( le.p_CurrAddrCarTheftIndex < 159.5,94,95);
        Tree_102_Node_12 := IF ( le.p_PrevAddrMedianIncome < 33342.5,88,Tree_102_Node_25);
        Tree_102_Node_60 := IF ( le.p_LastNameChangeAge < 115.5,120,121);
        Tree_102_Node_42 := IF ( le.p_BPV_2 < 2.1692,Tree_102_Node_60,105);
        Tree_102_Node_62 := IF ( le.p_DerogAge < 42.5,122,123);
        Tree_102_Node_63 := IF ( le.p_PrevAddrLenOfRes < 25.5,124,125);
        Tree_102_Node_43 := IF ( le.p_CurrAddrBurglaryIndex < 109.5,Tree_102_Node_62,Tree_102_Node_63);
        Tree_102_Node_26 := IF ( le.p_CurrAddrAgeOldestRecord < 7.5,Tree_102_Node_42,Tree_102_Node_43);
        Tree_102_Node_13 := IF ( le.p_v1_HHCnt < 5.5,Tree_102_Node_26,89);
        Tree_102_Node_6 := IF ( le.p_AssocRiskLevel < 1.5,Tree_102_Node_12,Tree_102_Node_13);
        Tree_102_Node_28 := IF ( le.p_PhoneOtherAgeOldestRecord < 109.5,96,97);
        Tree_102_Node_29 := IF ( le.p_PRSearchLocateCount < 1.5,98,99);
        Tree_102_Node_15 := IF ( le.p_v1_ProspectTimeLastUpdate < 24.5,Tree_102_Node_28,Tree_102_Node_29);
        Tree_102_Node_7 := IF ( le.p_v1_CrtRecTimeNewest < 10.5,84,Tree_102_Node_15);
        Tree_102_Node_3 := IF ( le.p_SSNHighIssueAge < 485.5,Tree_102_Node_6,Tree_102_Node_7);
        Tree_102_Node_1 := IF ( le.p_AddrChangeCount60 < 7.5,Tree_102_Node_2,Tree_102_Node_3);
    UNSIGNED2 Score1_Tree102_node := Tree_102_Node_1;
    REAL8 Score1_Tree102_score := CASE(Score1_Tree102_node,84=>-0.02312342,85=>0.07820749,86=>0.04183015,87=>-0.0096918065,88=>0.037722886,89=>0.013633932,90=>-0.042533267,91=>-0.016836809,92=>-0.040699482,93=>-0.04240647,94=>-0.04067737,95=>0.011163101,96=>0.005833069,97=>0.074297056,98=>0.017056312,99=>-0.041320294,100=>0.058298137,101=>0.050302528,102=>-0.030294528,103=>-0.041037064,104=>-0.027437698,105=>-0.042967632,106=>-9.179937E-5,107=>-0.030441469,108=>-0.026412921,109=>0.004572725,110=>0.027325239,111=>-0.00845885,112=>0.0035329782,113=>0.04679961,114=>-0.011413868,115=>0.008706334,116=>-0.0060533555,117=>0.017401354,118=>0.009103052,119=>0.050091557,120=>-0.030059185,121=>-0.040340986,122=>-0.030133896,123=>0.026845327,124=>-0.03644691,125=>-0.015949596,0);
ENDMACRO;
