﻿EXPORT Model1_Score1_Tree82(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_82_Node_58 := IF ( le.p_age_in_years < 0.99975586,146,147);
        Tree_82_Node_59 := CHOOSE ( le.p_gender,148,149);
        Tree_82_Node_32 := IF ( le.p_age_in_years < 1.3330078,Tree_82_Node_58,Tree_82_Node_59);
        Tree_82_Node_60 := IF ( le.p_PrevAddrMedianValue < 201041.0,150,151);
        Tree_82_Node_61 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 2.5,152,153);
        Tree_82_Node_33 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 1.5,Tree_82_Node_60,Tree_82_Node_61);
        Tree_82_Node_16 := IF ( le.p_age_in_years < 1.70625,Tree_82_Node_32,Tree_82_Node_33);
        Tree_82_Node_34 := IF ( le.p_age_in_years < 67.905,135,136);
        Tree_82_Node_65 := IF ( le.p_NonDerogCount12 < 4.5,154,155);
        Tree_82_Node_35 := IF ( le.p_PrevAddrAgeOldestRecord < 79.5,137,Tree_82_Node_65);
        Tree_82_Node_17 := IF ( le.p_RelativesCount < 5.5,Tree_82_Node_34,Tree_82_Node_35);
        Tree_82_Node_8 := IF ( le.p_CurrAddrMedianValue < 773438.5,Tree_82_Node_16,Tree_82_Node_17);
        Tree_82_Node_67 := IF ( le.p_v1_LifeEvEverResidedCnt < 3.5,156,157);
        Tree_82_Node_37 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.3705357,138,Tree_82_Node_67);
        Tree_82_Node_18 := IF ( le.p_NonDerogCount24 < 3.5,123,Tree_82_Node_37);
        Tree_82_Node_9 := IF ( le.p_PrevAddrMedianValue < 714640.5,Tree_82_Node_18,120);
        Tree_82_Node_4 := IF ( le.p_v1_RaAPropOwnerAVMMed < 781249.5,Tree_82_Node_8,Tree_82_Node_9);
        Tree_82_Node_10 := IF ( le.p_SSNHighIssueAge < 598.5,121,122);
        Tree_82_Node_69 := IF ( le.p_SrcsConfirmIDAddrCount < 3.5,158,159);
        Tree_82_Node_39 := IF ( le.p_EstimatedAnnualIncome < 30780.5,139,Tree_82_Node_69);
        Tree_82_Node_22 := IF ( le.p_v1_ProspectTimeOnRecord < 74.5,124,Tree_82_Node_39);
        Tree_82_Node_23 := IF ( le.p_PrevAddrDwellType < 4.0,125,126);
        Tree_82_Node_11 := IF ( le.p_v1_RaAPropOwnerAVMMed < 161328.5,Tree_82_Node_22,Tree_82_Node_23);
        Tree_82_Node_5 := IF ( le.p_v1_RaACrtRecMmbrCnt < 3.0,Tree_82_Node_10,Tree_82_Node_11);
        Tree_82_Node_2 := IF ( le.p_PhoneOtherAgeOldestRecord < 249.5,Tree_82_Node_4,Tree_82_Node_5);
        Tree_82_Node_24 := IF ( le.p_CurrAddrMedianIncome < 58343.5,127,128);
        Tree_82_Node_44 := IF ( le.p_PrevAddrCarTheftIndex < 132.0,140,141);
        Tree_82_Node_25 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 230.5,Tree_82_Node_44,129);
        Tree_82_Node_12 := IF ( le.p_PrevAddrCarTheftIndex < 63.5,Tree_82_Node_24,Tree_82_Node_25);
        Tree_82_Node_72 := IF ( le.p_v1_CrtRecLienJudgCnt < 3.5,160,161);
        Tree_82_Node_73 := IF ( le.p_DivSSNAddrMSourceCount < 1.5,162,163);
        Tree_82_Node_46 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 199.5,Tree_82_Node_72,Tree_82_Node_73);
        Tree_82_Node_74 := IF ( le.p_CurrAddrCarTheftIndex < 29.5,164,165);
        Tree_82_Node_75 := IF ( le.p_age_in_years < 51.5,166,167);
        Tree_82_Node_47 := IF ( le.p_EvictionAge < 11.5,Tree_82_Node_74,Tree_82_Node_75);
        Tree_82_Node_26 := IF ( le.p_SSNAddrCount < 24.5,Tree_82_Node_46,Tree_82_Node_47);
        Tree_82_Node_76 := IF ( le.p_v1_ProspectAge < 50.5,168,169);
        Tree_82_Node_77 := IF ( le.p_v1_CrtRecLienJudgCnt < 2.5,170,171);
        Tree_82_Node_48 := IF ( le.p_EstimatedAnnualIncome < 36062.5,Tree_82_Node_76,Tree_82_Node_77);
        Tree_82_Node_27 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 4.5,Tree_82_Node_48,130);
        Tree_82_Node_13 := IF ( le.p_SearchSSNSearchCount < 8.5,Tree_82_Node_26,Tree_82_Node_27);
        Tree_82_Node_6 := IF ( le.p_EstimatedAnnualIncome < 24445.5,Tree_82_Node_12,Tree_82_Node_13);
        Tree_82_Node_78 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 1.5,172,173);
        Tree_82_Node_79 := IF ( le.p_BPV_4 < -1.73778,174,175);
        Tree_82_Node_50 := IF ( le.p_P_EstimatedHHIncomePerCapita < 3.2011719,Tree_82_Node_78,Tree_82_Node_79);
        Tree_82_Node_81 := IF ( le.p_CurrAddrMedianIncome < 52259.5,176,177);
        Tree_82_Node_51 := IF ( le.p_age_in_years < 64.12125,142,Tree_82_Node_81);
        Tree_82_Node_28 := IF ( le.p_PropAgeNewestPurchase < 143.5,Tree_82_Node_50,Tree_82_Node_51);
        Tree_82_Node_82 := IF ( le.p_v1_ProspectTimeOnRecord < 245.5,178,179);
        Tree_82_Node_52 := IF ( le.p_CurrAddrLenOfRes < 175.5,Tree_82_Node_82,143);
        Tree_82_Node_29 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 6.5,Tree_82_Node_52,131);
        Tree_82_Node_14 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 1.5,Tree_82_Node_28,Tree_82_Node_29);
        Tree_82_Node_54 := IF ( le.p_RelativesPropOwnedTaxTotal < 338600.5,144,145);
        Tree_82_Node_30 := IF ( le.p_PrevAddrMedianValue < 167853.5,Tree_82_Node_54,132);
        Tree_82_Node_31 := IF ( le.p_DerogAge < 155.5,133,134);
        Tree_82_Node_15 := IF ( le.p_PhoneEDAAgeNewestRecord < 15.5,Tree_82_Node_30,Tree_82_Node_31);
        Tree_82_Node_7 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_82_Node_14,Tree_82_Node_15);
        Tree_82_Node_3 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_82_Node_6,Tree_82_Node_7);
        Tree_82_Node_1 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 142.5,Tree_82_Node_2,Tree_82_Node_3);
    UNSIGNED2 Score1_Tree82_node := Tree_82_Node_1;
    REAL8 Score1_Tree82_score := CASE(Score1_Tree82_node,120=>0.03605197,121=>0.058703393,122=>-0.014579398,123=>0.0057813963,124=>-0.01290594,125=>0.03843133,126=>-0.031008346,127=>0.014227776,128=>0.08098323,129=>0.027515113,130=>0.01050068,131=>0.08963624,132=>-0.0036888763,133=>-0.05096291,134=>0.022826297,135=>-0.04854206,136=>-0.050164197,137=>0.013499738,138=>-0.0028416335,139=>-0.051221795,140=>-5.4029527E-4,141=>-0.053116247,142=>-0.03245294,143=>0.052889194,144=>0.045602605,145=>0.10223325,146=>-0.010201234,147=>-0.046447314,148=>-0.04688034,149=>0.08739746,150=>0.0026274798,151=>-0.0014814843,152=>-0.0010839778,153=>0.02105407,154=>-0.049249098,155=>-0.008942874,156=>-0.049044978,157=>-0.024292676,158=>-0.050315183,159=>-0.049362093,160=>-0.015128885,161=>0.011549462,162=>0.06719065,163=>-0.002451603,164=>0.08788535,165=>0.012706104,166=>0.010386334,167=>-0.050809752,168=>-0.049974147,169=>-0.051710725,170=>-0.0447152,171=>0.012669646,172=>-0.007878594,173=>-0.0425314,174=>0.06712082,175=>-0.011654835,176=>-0.05112646,177=>-0.05008082,178=>-5.6327006E-4,179=>-0.049387522,0);
ENDMACRO;
