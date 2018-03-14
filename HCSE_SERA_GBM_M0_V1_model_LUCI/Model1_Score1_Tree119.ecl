﻿EXPORT Model1_Score1_Tree119(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_119_Node_28 := IF ( le.p_AddrChangeCount60 < 6.5,73,74);
        Tree_119_Node_29 := IF ( le.p_NonDerogCount60 < 4.5,75,76);
        Tree_119_Node_20 := IF ( le.p_AddrChangeCount24 < 4.5,Tree_119_Node_28,Tree_119_Node_29);
        Tree_119_Node_30 := IF ( le.p_PrevAddrCrimeIndex < 110.5,77,78);
        Tree_119_Node_31 := IF ( le.p_VariationDOBCount < 2.5,79,80);
        Tree_119_Node_21 := IF ( le.p_PrevAddrLenOfRes < 191.5,Tree_119_Node_30,Tree_119_Node_31);
        Tree_119_Node_14 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_119_Node_20,Tree_119_Node_21);
        Tree_119_Node_32 := IF ( le.p_SSNLowIssueAge < 239.5,81,82);
        Tree_119_Node_22 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 5.5,Tree_119_Node_32,69);
        Tree_119_Node_34 := IF ( le.p_AddrChangeCount24 < 0.5,83,84);
        Tree_119_Node_35 := IF ( le.p_NonDerogCount06 < 4.5,85,86);
        Tree_119_Node_23 := IF ( le.p_PrevAddrAgeOldestRecord < 58.5,Tree_119_Node_34,Tree_119_Node_35);
        Tree_119_Node_15 := IF ( le.p_v1_LifeEvEverResidedCnt < 0.5,Tree_119_Node_22,Tree_119_Node_23);
        Tree_119_Node_8 := IF ( le.p_SSNAddrRecentCount < 1.5,Tree_119_Node_14,Tree_119_Node_15);
        Tree_119_Node_37 := IF ( le.p_CurrAddrCarTheftIndex < 149.5,87,88);
        Tree_119_Node_24 := IF ( le.p_PrevAddrMedianIncome < 31754.5,70,Tree_119_Node_37);
        Tree_119_Node_39 := IF ( le.p_v1_ProspectTimeLastUpdate < 28.5,89,90);
        Tree_119_Node_25 := IF ( le.p_SSNIssueState < 12.0,71,Tree_119_Node_39);
        Tree_119_Node_16 := IF ( le.p_AssocRiskLevel < 1.5,Tree_119_Node_24,Tree_119_Node_25);
        Tree_119_Node_40 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 7.5,91,92);
        Tree_119_Node_26 := IF ( le.p_v1_RaAPropOwnerAVMMed < 160387.0,Tree_119_Node_40,72);
        Tree_119_Node_17 := IF ( le.p_PrevAddrMedianValue < 171874.5,Tree_119_Node_26,68);
        Tree_119_Node_9 := IF ( le.p_SSNHighIssueAge < 475.5,Tree_119_Node_16,Tree_119_Node_17);
        Tree_119_Node_4 := IF ( le.p_AddrChangeCount60 < 7.5,Tree_119_Node_8,Tree_119_Node_9);
        Tree_119_Node_5 := IF ( le.p_BP_3 < 9.5,63,64);
        Tree_119_Node_2 := IF ( le.p_BP_1 < 10.5,Tree_119_Node_4,Tree_119_Node_5);
        Tree_119_Node_12 := IF ( le.p_v1_ProspectAge < 43.0,66,67);
        Tree_119_Node_7 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 2.5,Tree_119_Node_12,65);
        Tree_119_Node_3 := IF ( le.p_NonDerogCount12 < 2.5,62,Tree_119_Node_7);
        Tree_119_Node_1 := IF ( le.p_v1_CrtRecCnt < 98.5,Tree_119_Node_2,Tree_119_Node_3);
    UNSIGNED2 Score1_Tree119_node := Tree_119_Node_1;
    REAL8 Score1_Tree119_score := CASE(Score1_Tree119_node,62=>0.002253021,63=>1.0715824E-4,64=>0.025653187,65=>8.1994815E-4,66=>-0.03332646,67=>-0.039430335,68=>0.02880662,69=>0.029805554,70=>0.032294106,71=>0.0031982986,72=>-0.02783708,73=>-1.1403361E-4,74=>0.009407287,75=>-0.035685457,76=>-0.0136234695,77=>0.0051250993,78=>-0.005177808,79=>-0.0034638236,80=>0.0147237,81=>0.014960997,82=>-0.026927408,83=>0.02125735,84=>-0.0248873,85=>-0.034849014,86=>-0.015326297,87=>-0.033923592,88=>0.0054952228,89=>-0.028575838,90=>-0.0058832606,91=>-0.004589814,92=>0.02405116,0);
ENDMACRO;
