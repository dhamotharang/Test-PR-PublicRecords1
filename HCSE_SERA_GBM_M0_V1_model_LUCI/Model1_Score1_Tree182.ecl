EXPORT Model1_Score1_Tree182(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_182_Node_28 := IF ( le.p_AddrChangeCount60 < 6.5,72,73);
        Tree_182_Node_29 := IF ( le.p_NonDerogCount60 < 4.5,74,75);
        Tree_182_Node_20 := IF ( le.p_AddrChangeCount24 < 4.5,Tree_182_Node_28,Tree_182_Node_29);
        Tree_182_Node_30 := IF ( le.p_PrevAddrCrimeIndex < 110.5,76,77);
        Tree_182_Node_31 := IF ( le.p_PrevAddrCarTheftIndex < 110.5,78,79);
        Tree_182_Node_21 := IF ( le.p_PrevAddrLenOfRes < 191.5,Tree_182_Node_30,Tree_182_Node_31);
        Tree_182_Node_14 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_182_Node_20,Tree_182_Node_21);
        Tree_182_Node_33 := IF ( le.p_CurrAddrMurderIndex < 99.5,80,81);
        Tree_182_Node_22 := IF ( le.p_CurrAddrCrimeIndex < 69.5,67,Tree_182_Node_33);
        Tree_182_Node_34 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 24.5,82,83);
        Tree_182_Node_23 := IF ( le.p_PrevAddrCrimeIndex < 150.5,Tree_182_Node_34,68);
        Tree_182_Node_15 := IF ( le.p_v1_ProspectTimeLastUpdate < 15.5,Tree_182_Node_22,Tree_182_Node_23);
        Tree_182_Node_8 := IF ( le.p_SSNAddrRecentCount < 1.5,Tree_182_Node_14,Tree_182_Node_15);
        Tree_182_Node_37 := IF ( le.p_CurrAddrCarTheftIndex < 149.5,84,85);
        Tree_182_Node_24 := IF ( le.p_PrevAddrMedianIncome < 31754.5,69,Tree_182_Node_37);
        Tree_182_Node_39 := IF ( le.p_v1_ProspectTimeLastUpdate < 28.5,86,87);
        Tree_182_Node_25 := IF ( le.p_SSNIssueState < 12.0,70,Tree_182_Node_39);
        Tree_182_Node_16 := IF ( le.p_AssocRiskLevel < 1.5,Tree_182_Node_24,Tree_182_Node_25);
        Tree_182_Node_40 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 7.5,88,89);
        Tree_182_Node_26 := IF ( le.p_v1_RaAPropOwnerAVMMed < 160387.0,Tree_182_Node_40,71);
        Tree_182_Node_17 := IF ( le.p_PrevAddrMedianValue < 171874.5,Tree_182_Node_26,66);
        Tree_182_Node_9 := IF ( le.p_SSNHighIssueAge < 475.5,Tree_182_Node_16,Tree_182_Node_17);
        Tree_182_Node_4 := IF ( le.p_AddrChangeCount60 < 7.5,Tree_182_Node_8,Tree_182_Node_9);
        Tree_182_Node_5 := IF ( le.p_BP_3 < 9.5,61,62);
        Tree_182_Node_2 := IF ( le.p_BP_1 < 10.5,Tree_182_Node_4,Tree_182_Node_5);
        Tree_182_Node_12 := IF ( le.p_v1_ProspectAge < 43.0,64,65);
        Tree_182_Node_7 := IF ( le.p_v1_RaACrtRecMmbrCnt < 13.5,Tree_182_Node_12,63);
        Tree_182_Node_3 := IF ( le.p_NonDerogCount12 < 2.5,60,Tree_182_Node_7);
        Tree_182_Node_1 := IF ( le.p_v1_CrtRecCnt < 98.5,Tree_182_Node_2,Tree_182_Node_3);
    UNSIGNED2 Score1_Tree182_node := Tree_182_Node_1;
    REAL8 Score1_Tree182_score := CASE(Score1_Tree182_node,60=>0.0014010605,61=>-8.106933E-5,62=>0.012294425,63=>-0.002407132,64=>-0.017642537,65=>-0.020993989,66=>0.012819368,67=>-0.017815296,68=>-6.2199467E-4,69=>0.015482724,70=>0.0021573238,71=>-0.0144206965,72=>-5.1651914E-5,73=>0.0045572864,74=>-0.018761653,75=>-0.0069452594,76=>0.002433611,77=>-0.002561273,78=>0.0014480291,79=>0.009209887,80=>0.02057141,81=>-0.0064844494,82=>-0.018580128,83=>-0.013643269,84=>-0.017882463,85=>0.0021087732,86=>-0.014748784,87=>-0.0024935114,88=>-0.0021831612,89=>0.011461143,0);
ENDMACRO;
