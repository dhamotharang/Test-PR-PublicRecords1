﻿EXPORT Model1_Score1_Tree118(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_118_Node_48 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 6.5,165,166);
        Tree_118_Node_49 := IF ( le.p_SSNIdentitiesCount < 3.5,167,168);
        Tree_118_Node_26 := IF ( le.p_v1_ProspectAge < 81.5,Tree_118_Node_48,Tree_118_Node_49);
        Tree_118_Node_50 := IF ( le.p_PrevAddrMedianIncome < 32863.5,169,170);
        Tree_118_Node_51 := IF ( le.p_v1_LifeEvEverResidedCnt < 2.5,171,172);
        Tree_118_Node_27 := IF ( le.p_RelativesFelonyCount < 0.5,Tree_118_Node_50,Tree_118_Node_51);
        Tree_118_Node_14 := IF ( le.p_BPV_2 < 2.3520765,Tree_118_Node_26,Tree_118_Node_27);
        Tree_118_Node_52 := IF ( le.p_PhoneOtherAgeOldestRecord < 107.0,173,174);
        Tree_118_Node_53 := IF ( le.p_PhoneOtherAgeNewestRecord < 22.5,175,176);
        Tree_118_Node_28 := IF ( le.p_CurrAddrMurderIndex < 189.5,Tree_118_Node_52,Tree_118_Node_53);
        Tree_118_Node_55 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 0.5,177,178);
        Tree_118_Node_29 := IF ( le.p_SourceRiskLevel < 2.5,158,Tree_118_Node_55);
        Tree_118_Node_15 := IF ( le.p_CurrAddrBurglaryIndex < 158.5,Tree_118_Node_28,Tree_118_Node_29);
        Tree_118_Node_8 := IF ( le.p_PrevAddrMedianValue < 212035.5,Tree_118_Node_14,Tree_118_Node_15);
        Tree_118_Node_56 := IF ( le.p_CurrAddrAgeLastSale < 239.5,179,180);
        Tree_118_Node_57 := IF ( le.p_v1_PropCurrOwnedCnt < 2.5,181,182);
        Tree_118_Node_30 := IF ( le.p_CurrAddrBurglaryIndex < 177.5,Tree_118_Node_56,Tree_118_Node_57);
        Tree_118_Node_58 := CHOOSE ( le.p_gender,183,184);
        Tree_118_Node_59 := IF ( le.p_v1_ProspectTimeOnRecord < 271.0,185,186);
        Tree_118_Node_31 := IF ( le.p_v1_ProspectAge < 59.0,Tree_118_Node_58,Tree_118_Node_59);
        Tree_118_Node_16 := IF ( le.p_CurrAddrAgeLastSale < 281.5,Tree_118_Node_30,Tree_118_Node_31);
        Tree_118_Node_60 := IF ( le.p_SubjectAddrCount < 4.5,187,188);
        Tree_118_Node_32 := IF ( le.p_VariationMSourcesSSNUnrelCount < 2.5,Tree_118_Node_60,159);
        Tree_118_Node_62 := IF ( le.p_NonDerogCount01 < 4.5,189,190);
        Tree_118_Node_63 := IF ( le.p_v1_RaAHHCnt < 3.5,191,192);
        Tree_118_Node_33 := IF ( le.p_PrevAddrAgeNewestRecord < 160.5,Tree_118_Node_62,Tree_118_Node_63);
        Tree_118_Node_17 := IF ( le.p_CurrAddrCrimeIndex < 140.5,Tree_118_Node_32,Tree_118_Node_33);
        Tree_118_Node_9 := IF ( le.p_CurrAddrAgeLastSale < 295.5,Tree_118_Node_16,Tree_118_Node_17);
        Tree_118_Node_4 := IF ( le.p_LastNameChangeAge < 172.5,Tree_118_Node_8,Tree_118_Node_9);
        Tree_118_Node_64 := IF ( le.p_PrevAddrLenOfRes < 386.0,193,194);
        Tree_118_Node_65 := IF ( le.p_LastNameChangeAge < 275.5,195,196);
        Tree_118_Node_34 := IF ( le.p_SubjectAddrCount < 19.5,Tree_118_Node_64,Tree_118_Node_65);
        Tree_118_Node_66 := IF ( le.p_RelativesPropOwnedCount < 0.5,197,198);
        Tree_118_Node_67 := IF ( le.p_PrevAddrAgeLastSale < 212.5,199,200);
        Tree_118_Node_35 := IF ( le.p_CurrAddrBurglaryIndex < 191.5,Tree_118_Node_66,Tree_118_Node_67);
        Tree_118_Node_18 := IF ( le.p_CurrAddrBurglaryIndex < 189.5,Tree_118_Node_34,Tree_118_Node_35);
        Tree_118_Node_10 := IF ( le.p_PRSearchLocateCount < 15.0,Tree_118_Node_18,155);
        Tree_118_Node_68 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 4.5,201,202);
        Tree_118_Node_36 := IF ( le.p_v1_ProspectTimeLastUpdate < 191.5,Tree_118_Node_68,160);
        Tree_118_Node_70 := IF ( le.p_BP_4 < 14.5,203,204);
        Tree_118_Node_37 := IF ( le.p_PhoneOtherAgeNewestRecord < 98.5,Tree_118_Node_70,161);
        Tree_118_Node_20 := IF ( le.p_SSNIdentitiesCount < 1.5,Tree_118_Node_36,Tree_118_Node_37);
        Tree_118_Node_72 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 189.5,205,206);
        Tree_118_Node_73 := IF ( le.p_PhoneEDAAgeOldestRecord < 70.5,207,208);
        Tree_118_Node_38 := IF ( le.p_SrcsConfirmIDAddrCount < 6.5,Tree_118_Node_72,Tree_118_Node_73);
        Tree_118_Node_74 := IF ( le.p_CurrAddrCarTheftIndex < 166.5,209,210);
        Tree_118_Node_39 := IF ( le.p_v1_HHEstimatedIncomeRange < 4.5,Tree_118_Node_74,162);
        Tree_118_Node_21 := IF ( le.p_BP_4 < 12.0,Tree_118_Node_38,Tree_118_Node_39);
        Tree_118_Node_11 := IF ( le.p_SSNAddrCount < 9.5,Tree_118_Node_20,Tree_118_Node_21);
        Tree_118_Node_5 := IF ( le.p_PrevAddrMedianIncome < 41831.5,Tree_118_Node_10,Tree_118_Node_11);
        Tree_118_Node_2 := IF ( le.p_CurrAddrBurglaryIndex < 187.0,Tree_118_Node_4,Tree_118_Node_5);
        Tree_118_Node_76 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.8,211,212);
        Tree_118_Node_40 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 1.5,Tree_118_Node_76,163);
        Tree_118_Node_22 := IF ( le.p_PhoneEDAAgeOldestRecord < 36.5,Tree_118_Node_40,156);
        Tree_118_Node_79 := IF ( le.p_PrevAddrMedianIncome < 80480.5,213,214);
        Tree_118_Node_43 := IF ( le.p_PrevAddrAgeOldestRecord < 3.5,164,Tree_118_Node_79);
        Tree_118_Node_23 := IF ( le.p_CurrAddrMedianValue < 109374.5,157,Tree_118_Node_43);
        Tree_118_Node_12 := IF ( le.p_EstimatedAnnualIncome < 29492.5,Tree_118_Node_22,Tree_118_Node_23);
        Tree_118_Node_80 := IF ( le.p_PrevAddrCarTheftIndex < 39.5,215,216);
        Tree_118_Node_81 := IF ( le.p_BPV_4 < -1.73838,217,218);
        Tree_118_Node_44 := IF ( le.p_NonDerogCount06 < 3.5,Tree_118_Node_80,Tree_118_Node_81);
        Tree_118_Node_82 := IF ( le.p_SearchSSNSearchCount < 7.5,219,220);
        Tree_118_Node_83 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 1.5,221,222);
        Tree_118_Node_45 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 12534.5,Tree_118_Node_82,Tree_118_Node_83);
        Tree_118_Node_24 := IF ( le.p_CurrAddrBurglaryIndex < 79.5,Tree_118_Node_44,Tree_118_Node_45);
        Tree_118_Node_84 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 924884.5,223,224);
        Tree_118_Node_85 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 23.5,225,226);
        Tree_118_Node_46 := IF ( le.p_CurrAddrAgeLastSale < 159.5,Tree_118_Node_84,Tree_118_Node_85);
        Tree_118_Node_86 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 60.5,227,228);
        Tree_118_Node_87 := IF ( le.p_PrevAddrMurderIndex < 129.5,229,230);
        Tree_118_Node_47 := IF ( le.p_BPV_4 < -2.0817156,Tree_118_Node_86,Tree_118_Node_87);
        Tree_118_Node_25 := IF ( le.p_P_EstimatedHHIncomePerCapita < 3.21875,Tree_118_Node_46,Tree_118_Node_47);
        Tree_118_Node_13 := IF ( le.p_SubjectAddrCount < 9.0,Tree_118_Node_24,Tree_118_Node_25);
        Tree_118_Node_7 := IF ( le.p_AgeOldestRecord < 120.5,Tree_118_Node_12,Tree_118_Node_13);
        Tree_118_Node_3 := IF ( le.p_age_in_years < 17.915625,154,Tree_118_Node_7);
        Tree_118_Node_1 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_118_Node_2,Tree_118_Node_3);
    UNSIGNED2 Score1_Tree118_node := Tree_118_Node_1;
    REAL8 Score1_Tree118_score := CASE(Score1_Tree118_node,154=>0.056227062,155=>0.033273064,156=>0.020694034,157=>0.054744978,158=>0.026044147,159=>0.049706787,160=>0.012523054,161=>0.02666477,162=>-0.024572065,163=>-0.0027156437,164=>0.019385738,165=>-5.882901E-4,166=>-0.0041902084,167=>0.0025766059,168=>0.0293937,169=>-0.0108417785,170=>0.0049227527,171=>0.016494345,172=>-0.0018850982,173=>-0.007327346,174=>2.013398E-4,175=>0.0041300487,176=>0.05609445,177=>-0.029839698,178=>-0.0053800535,179=>8.2979986E-4,180=>-0.006413682,181=>0.0037085363,182=>0.034152478,183=>-0.0020160326,184=>0.08060028,185=>-0.023220707,186=>0.011298764,187=>0.004907011,188=>-0.0060028164,189=>-0.010451037,190=>0.016503578,191=>-0.03513042,192=>-0.00964001,193=>-0.014999275,194=>0.02841098,195=>0.00150907,196=>0.04408673,197=>0.034563344,198=>0.004578604,199=>-0.0015694537,200=>0.023806045,201=>-0.029721476,202=>-0.014904405,203=>-0.0038271272,204=>-0.021346545,205=>-0.010982074,206=>0.036367204,207=>0.04602421,208=>-2.9323032E-4,209=>0.06670873,210=>0.023383096,211=>-0.033166323,212=>-0.032672446,213=>-0.033924438,214=>0.0011700923,215=>-0.007824178,216=>-0.032257248,217=>-0.0014340066,218=>0.044659242,219=>0.010286503,220=>0.04201063,221=>0.07878169,222=>0.018097257,223=>-0.005885495,224=>0.032435276,225=>0.001339118,226=>0.042331975,227=>0.016115844,228=>0.06614491,229=>0.0106527805,230=>-0.015491826,0);
ENDMACRO;
