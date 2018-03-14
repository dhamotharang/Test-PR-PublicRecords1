﻿EXPORT Model1_Score1_Tree106_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_106_Node_46 := IF ( le.p_NonDerogCount < 9.5,137,138);
        Tree_106_Node_47 := IF ( le.p_SSNHighIssueAge < 473.5,139,140);
        Tree_106_Node_26 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 9.5,Tree_106_Node_46,Tree_106_Node_47);
        Tree_106_Node_48 := IF ( le.p_LastNameChangeAge < 315.5,141,142);
        Tree_106_Node_49 := IF ( le.p_RecentActivityIndex < 2.5,143,144);
        Tree_106_Node_27 := IF ( le.p_SrcsConfirmIDAddrCount < 2.5,Tree_106_Node_48,Tree_106_Node_49);
        Tree_106_Node_14 := IF ( le.p_RelativesCount < 35.5,Tree_106_Node_26,Tree_106_Node_27);
        Tree_106_Node_50 := IF ( le.p_PrevAddrAgeOldestRecord < 75.5,145,146);
        Tree_106_Node_51 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 4.5,147,148);
        Tree_106_Node_28 := IF ( le.p_NonDerogCount24 < 4.5,Tree_106_Node_50,Tree_106_Node_51);
        Tree_106_Node_52 := IF ( le.p_PhoneOtherAgeNewestRecord < 133.5,149,150);
        Tree_106_Node_53 := IF ( le.p_v1_HHCrtRecFelonyMmbrCnt < 1.5,151,152);
        Tree_106_Node_29 := IF ( le.p_CurrAddrCountyIndex < 0.9875,Tree_106_Node_52,Tree_106_Node_53);
        Tree_106_Node_15 := IF ( le.p_LastNameChangeAge < 48.5,Tree_106_Node_28,Tree_106_Node_29);
        Tree_106_Node_8 := IF ( le.p_CurrAddrTractIndex < 1.0390625,Tree_106_Node_14,Tree_106_Node_15);
        Tree_106_Node_54 := IF ( le.p_NonDerogCount < 6.5,153,154);
        Tree_106_Node_55 := IF ( le.p_CurrAddrCrimeIndex < 170.5,155,156);
        Tree_106_Node_30 := IF ( le.p_SearchSSNSearchCount < 7.5,Tree_106_Node_54,Tree_106_Node_55);
        Tree_106_Node_56 := IF ( le.p_PrevAddrAgeNewestRecord < 100.0,157,158);
        Tree_106_Node_57 := IF ( le.p_v1_RaAPropOwnerAVMMed < 136663.5,159,160);
        Tree_106_Node_31 := IF ( le.p_SearchVelocityRiskLevel < 4.5,Tree_106_Node_56,Tree_106_Node_57);
        Tree_106_Node_16 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 208.0,Tree_106_Node_30,Tree_106_Node_31);
        Tree_106_Node_59 := IF ( le.p_EstimatedAnnualIncome < 48000.5,161,162);
        Tree_106_Node_32 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 1.5,125,Tree_106_Node_59);
        Tree_106_Node_33 := IF ( le.p_EstimatedAnnualIncome < 42750.5,126,127);
        Tree_106_Node_17 := IF ( le.p_age_in_years < 68.56594,Tree_106_Node_32,Tree_106_Node_33);
        Tree_106_Node_9 := IF ( le.p_CurrAddrTractIndex < 1.6054688,Tree_106_Node_16,Tree_106_Node_17);
        Tree_106_Node_4 := IF ( le.p_NonDerogCount01 < 4.5,Tree_106_Node_8,Tree_106_Node_9);
        Tree_106_Node_34 := IF ( le.p_BPV_4 < -1.9013531,128,129);
        Tree_106_Node_64 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.375,163,164);
        Tree_106_Node_65 := IF ( le.p_CurrAddrMedianIncome < 72995.5,165,166);
        Tree_106_Node_35 := IF ( le.p_BPV_4 < -2.037164,Tree_106_Node_64,Tree_106_Node_65);
        Tree_106_Node_18 := IF ( le.p_CurrAddrAgeLastSale < 15.5,Tree_106_Node_34,Tree_106_Node_35);
        Tree_106_Node_66 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 3.5,167,168);
        Tree_106_Node_67 := IF ( le.p_PropAgeOldestPurchase < 287.5,169,170);
        Tree_106_Node_36 := IF ( le.p_age_in_years < 62.949062,Tree_106_Node_66,Tree_106_Node_67);
        Tree_106_Node_37 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 15.5,130,131);
        Tree_106_Node_19 := IF ( le.p_PrevAddrMedianIncome < 119026.5,Tree_106_Node_36,Tree_106_Node_37);
        Tree_106_Node_10 := IF ( le.p_PrevAddrAgeOldestRecord < 25.5,Tree_106_Node_18,Tree_106_Node_19);
        Tree_106_Node_71 := IF ( le.p_CurrAddrTaxMarketValue < 295500.5,171,172);
        Tree_106_Node_38 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,132,Tree_106_Node_71);
        Tree_106_Node_39 := IF ( le.p_PrevAddrDwellType < 6.5,133,134);
        Tree_106_Node_21 := IF ( le.p_PropAgeNewestPurchase < 206.5,Tree_106_Node_38,Tree_106_Node_39);
        Tree_106_Node_11 := IF ( le.p_SSNLowIssueAge < 480.0,119,Tree_106_Node_21);
        Tree_106_Node_5 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 178.5,Tree_106_Node_10,Tree_106_Node_11);
        Tree_106_Node_2 := IF ( le.p_CurrAddrTractIndex < 1.9008398,Tree_106_Node_4,Tree_106_Node_5);
        Tree_106_Node_40 := IF ( le.p_PropAgeOldestPurchase < 20.5,135,136);
        Tree_106_Node_22 := IF ( le.p_v1_HHEstimatedIncomeRange < 6.5,Tree_106_Node_40,121);
        Tree_106_Node_12 := IF ( le.p_PrevAddrAgeLastSale < 137.5,Tree_106_Node_22,120);
        Tree_106_Node_24 := IF ( le.p_PropAgeNewestPurchase < 186.5,122,123);
        Tree_106_Node_76 := IF ( le.p_v1_PropCurrOwnedCnt < 0.5,173,174);
        Tree_106_Node_77 := IF ( le.p_PrevAddrMedianIncome < 54908.5,175,176);
        Tree_106_Node_44 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,Tree_106_Node_76,Tree_106_Node_77);
        Tree_106_Node_25 := IF ( le.p_PhoneOtherAgeOldestRecord < 147.5,Tree_106_Node_44,124);
        Tree_106_Node_13 := IF ( le.p_PrevAddrMedianIncome < 34500.5,Tree_106_Node_24,Tree_106_Node_25);
        Tree_106_Node_7 := IF ( le.p_CurrAddrBurglaryIndex < 95.5,Tree_106_Node_12,Tree_106_Node_13);
        Tree_106_Node_3 := IF ( le.p_CurrAddrLenOfRes < 7.5,118,Tree_106_Node_7);
        Tree_106_Node_1 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 378.5,Tree_106_Node_2,Tree_106_Node_3);
    SELF.Score1_Tree106_node := Tree_106_Node_1;
    SELF.Score1_Tree106_score := CASE(SELF.Score1_Tree106_node,118=>0.023406925,119=>0.010469378,120=>-7.6365686E-4,121=>-0.024363179,122=>-0.03966317,123=>-0.0048811617,124=>-0.0312393,125=>0.013349533,126=>-0.03921291,127=>-0.038319994,128=>-0.025698137,129=>0.023243068,130=>-0.04008546,131=>-0.0070590735,132=>-0.040497445,133=>-0.039219026,134=>0.009781729,135=>-0.039810702,136=>-0.03871962,137=>-3.1078426E-4,138=>0.0033075241,139=>-0.016469654,140=>-0.040816627,141=>-0.02743444,142=>0.0060589886,143=>-0.01092316,144=>0.01084413,145=>-0.011275881,146=>-0.023574812,147=>-0.0034878212,148=>0.04033825,149=>0.0059703193,150=>0.043287124,151=>0.0014625201,152=>0.05504498,153=>0.03903656,154=>-7.626928E-4,155=>-0.030189482,156=>0.007278271,157=>-0.023963382,158=>0.010258548,159=>-0.017465394,160=>0.053297184,161=>-0.0383864,162=>-0.037467048,163=>0.006075326,164=>-0.03869913,165=>-0.040041104,166=>-0.0093851,167=>-0.0027440158,168=>-0.02515341,169=>0.008241816,170=>-0.007771398,171=>-0.038987428,172=>-0.023852384,173=>0.02267096,174=>-0.024554722,175=>0.05658286,176=>-0.0014943245,0);
ENDMACRO;
