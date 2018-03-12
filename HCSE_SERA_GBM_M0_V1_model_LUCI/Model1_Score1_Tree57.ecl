﻿EXPORT Model1_Score1_Tree57(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_57_Node_28 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 229.5,71,72);
        Tree_57_Node_29 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 16.5,73,74);
        Tree_57_Node_20 := IF ( le.p_SubjectAddrCount < 10.5,Tree_57_Node_28,Tree_57_Node_29);
        Tree_57_Node_30 := IF ( le.p_PrevAddrAgeLastSale < 431.5,75,76);
        Tree_57_Node_21 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 265.5,Tree_57_Node_30,65);
        Tree_57_Node_12 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_57_Node_20,Tree_57_Node_21);
        Tree_57_Node_23 := IF ( le.p_RecentActivityIndex < 1.5,66,67);
        Tree_57_Node_13 := IF ( le.p_AgeOldestRecord < 335.5,64,Tree_57_Node_23);
        Tree_57_Node_8 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 8.5,Tree_57_Node_12,Tree_57_Node_13);
        Tree_57_Node_34 := IF ( le.p_PrevAddrBurglaryIndex < 89.5,77,78);
        Tree_57_Node_35 := IF ( le.p_v1_RaAMedIncomeRange < 4.5,79,80);
        Tree_57_Node_24 := IF ( le.p_PrevAddrCarTheftIndex < 109.0,Tree_57_Node_34,Tree_57_Node_35);
        Tree_57_Node_25 := IF ( le.p_SubjectLastNameCount < 2.5,68,69);
        Tree_57_Node_15 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 34.5,Tree_57_Node_24,Tree_57_Node_25);
        Tree_57_Node_9 := IF ( le.p_LienFiledAge < 31.5,60,Tree_57_Node_15);
        Tree_57_Node_4 := IF ( le.p_EvictionAge < 139.5,Tree_57_Node_8,Tree_57_Node_9);
        Tree_57_Node_38 := IF ( le.p_PhoneOtherAgeNewestRecord < 58.5,81,82);
        Tree_57_Node_39 := IF ( le.p_v1_ProspectTimeOnRecord < 110.5,83,84);
        Tree_57_Node_26 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 280706.0,Tree_57_Node_38,Tree_57_Node_39);
        Tree_57_Node_41 := IF ( le.p_v1_RaASeniorMmbrCnt < 0.5,85,86);
        Tree_57_Node_27 := IF ( le.p_BPV_4 < -1.8108125,70,Tree_57_Node_41);
        Tree_57_Node_17 := IF ( le.p_PrevAddrMedianValue < 142076.5,Tree_57_Node_26,Tree_57_Node_27);
        Tree_57_Node_10 := IF ( le.p_EstimatedAnnualIncome < 20484.5,61,Tree_57_Node_17);
        Tree_57_Node_11 := IF ( le.p_v1_HHCnt < 2.5,62,63);
        Tree_57_Node_5 := IF ( le.p_BPV_3 < 2.088171,Tree_57_Node_10,Tree_57_Node_11);
        Tree_57_Node_2 := IF ( le.p_PrevAddrCrimeIndex < 199.0,Tree_57_Node_4,Tree_57_Node_5);
        Tree_57_Node_3 := IF ( le.p_CurrAddrBurglaryIndex < 115.0,58,59);
        Tree_57_Node_1 := IF ( le.p_PrevAddrMurderIndex < 199.5,Tree_57_Node_2,Tree_57_Node_3);
    UNSIGNED2 Score1_Tree57_node := Tree_57_Node_1;
    REAL8 Score1_Tree57_score := CASE(Score1_Tree57_node,58=>-0.0065882723,59=>-0.066734016,60=>0.06826895,61=>0.07778548,62=>0.008117686,63=>0.07507534,64=>-0.016994832,65=>0.067407995,66=>-0.044515416,67=>-0.064545386,68=>0.11313658,69=>-0.03695806,70=>-0.04376849,71=>-5.861644E-4,72=>-0.018936643,73=>0.0035622588,74=>-0.0030948224,75=>-0.008255239,76=>0.04329426,77=>-0.026108481,78=>0.01522072,79=>-0.0061719017,80=>-0.05301552,81=>-0.012643602,82=>-0.06627981,83=>0.07978238,84=>-0.009008867,85=>0.0059133307,86=>0.08771382,0);
ENDMACRO;
