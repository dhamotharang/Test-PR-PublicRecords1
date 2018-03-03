﻿EXPORT Model1_Score1_Tree70_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_70_Node_50 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 141.0,138,139);
        Tree_70_Node_51 := IF ( le.p_SSNLowIssueAge < 864.5,140,141);
        Tree_70_Node_30 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_70_Node_50,Tree_70_Node_51);
        Tree_70_Node_52 := IF ( le.p_PrevAddrCarTheftIndex < 140.5,142,143);
        Tree_70_Node_53 := IF ( le.p_RecentActivityIndex < 2.5,144,145);
        Tree_70_Node_31 := IF ( le.p_AgeOldestRecord < 223.5,Tree_70_Node_52,Tree_70_Node_53);
        Tree_70_Node_16 := IF ( le.p_RelativesPropOwnedTaxTotal < 1418569.5,Tree_70_Node_30,Tree_70_Node_31);
        Tree_70_Node_17 := IF ( le.p_PrevAddrMurderIndex < 100.0,125,126);
        Tree_70_Node_8 := IF ( le.p_PropAgeNewestPurchase < 490.5,Tree_70_Node_16,Tree_70_Node_17);
        Tree_70_Node_54 := IF ( le.p_CurrAddrMurderIndex < 49.5,146,147);
        Tree_70_Node_55 := IF ( le.p_NonDerogCount01 < 3.5,148,149);
        Tree_70_Node_34 := IF ( le.p_EstimatedAnnualIncome < 34375.5,Tree_70_Node_54,Tree_70_Node_55);
        Tree_70_Node_18 := IF ( le.p_CurrAddrAgeLastSale < 376.5,Tree_70_Node_34,127);
        Tree_70_Node_9 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 191.5,Tree_70_Node_18,121);
        Tree_70_Node_4 := IF ( le.p_PrevAddrAgeOldestRecord < 568.5,Tree_70_Node_8,Tree_70_Node_9);
        Tree_70_Node_36 := IF ( le.p_RelativesBankruptcyCount < 0.5,131,132);
        Tree_70_Node_20 := IF ( le.p_DivSSNIdentityMSourceCount < 1.5,Tree_70_Node_36,128);
        Tree_70_Node_58 := IF ( le.p_v1_ProspectAge < 56.5,150,151);
        Tree_70_Node_59 := IF ( le.p_RelativesPropOwnedTaxTotal < 268430.5,152,153);
        Tree_70_Node_38 := IF ( le.p_AddrChangeCount24 < 0.5,Tree_70_Node_58,Tree_70_Node_59);
        Tree_70_Node_60 := IF ( le.p_CurrAddrMedianValue < 179062.5,154,155);
        Tree_70_Node_61 := IF ( le.p_age_in_years < 88.407,156,157);
        Tree_70_Node_39 := IF ( le.p_RecentActivityIndex < 1.5,Tree_70_Node_60,Tree_70_Node_61);
        Tree_70_Node_21 := IF ( le.p_age_in_years < 86.63062,Tree_70_Node_38,Tree_70_Node_39);
        Tree_70_Node_10 := IF ( le.p_v1_HHEstimatedIncomeRange < 1.5,Tree_70_Node_20,Tree_70_Node_21);
        Tree_70_Node_11 := IF ( le.p_v1_HHCrtRecMmbrCnt < 1.5,122,123);
        Tree_70_Node_5 := IF ( le.p_CurrAddrMedianValue < 398437.5,Tree_70_Node_10,Tree_70_Node_11);
        Tree_70_Node_2 := IF ( le.p_PropAgeOldestPurchase < 494.5,Tree_70_Node_4,Tree_70_Node_5);
        Tree_70_Node_62 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 7.5,158,159);
        Tree_70_Node_63 := IF ( le.p_PrevAddrAgeNewestRecord < 134.5,160,161);
        Tree_70_Node_41 := IF ( le.p_v1_ProspectTimeOnRecord < 576.5,Tree_70_Node_62,Tree_70_Node_63);
        Tree_70_Node_24 := IF ( le.p_BP_4 < 2.5,129,Tree_70_Node_41);
        Tree_70_Node_42 := IF ( le.p_RelativesCount < 1.5,133,134);
        Tree_70_Node_43 := IF ( le.p_PhoneEDAAgeOldestRecord < 199.5,135,136);
        Tree_70_Node_25 := IF ( le.p_v1_HHPPCurrOwnedCnt < 1.5,Tree_70_Node_42,Tree_70_Node_43);
        Tree_70_Node_12 := IF ( le.p_PhoneEDAAgeOldestRecord < 195.5,Tree_70_Node_24,Tree_70_Node_25);
        Tree_70_Node_6 := IF ( le.p_v1_RaAPropOwnerAVMMed < 73547.5,Tree_70_Node_12,120);
        Tree_70_Node_68 := IF ( le.p_PrevAddrMedianIncome < 100495.0,162,163);
        Tree_70_Node_69 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,164,165);
        Tree_70_Node_45 := IF ( le.p_age_in_years < 81.9175,Tree_70_Node_68,Tree_70_Node_69);
        Tree_70_Node_26 := IF ( le.p_v1_RaAPropOwnerAVMMed < 94432.5,130,Tree_70_Node_45);
        Tree_70_Node_14 := IF ( le.p_PropAgeNewestPurchase < 737.5,Tree_70_Node_26,124);
        Tree_70_Node_70 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 0.5,166,167);
        Tree_70_Node_71 := IF ( le.p_v1_RaAElderlyMmbrCnt < 0.5,168,169);
        Tree_70_Node_46 := IF ( le.p_PrevAddrAgeLastSale < 63.5,Tree_70_Node_70,Tree_70_Node_71);
        Tree_70_Node_72 := IF ( le.p_RelativesCount < 7.5,170,171);
        Tree_70_Node_73 := IF ( le.p_SSNHighIssueAge < 722.5,172,173);
        Tree_70_Node_47 := IF ( le.p_PropAgeOldestPurchase < 557.5,Tree_70_Node_72,Tree_70_Node_73);
        Tree_70_Node_28 := IF ( le.p_SearchVelocityRiskLevel < 2.5,Tree_70_Node_46,Tree_70_Node_47);
        Tree_70_Node_74 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 294063.5,174,175);
        Tree_70_Node_75 := IF ( le.p_SubjectLastNameCount < 2.5,176,177);
        Tree_70_Node_48 := IF ( le.p_age_in_years < 83.5275,Tree_70_Node_74,Tree_70_Node_75);
        Tree_70_Node_76 := IF ( le.p_PrevAddrBurglaryIndex < 88.5,178,179);
        Tree_70_Node_49 := IF ( le.p_CurrAddrAgeOldestRecord < 589.5,Tree_70_Node_76,137);
        Tree_70_Node_29 := IF ( le.p_CurrAddrMedianIncome < 71247.5,Tree_70_Node_48,Tree_70_Node_49);
        Tree_70_Node_15 := IF ( le.p_PhoneOtherAgeOldestRecord < 102.5,Tree_70_Node_28,Tree_70_Node_29);
        Tree_70_Node_7 := IF ( le.p_CurrAddrCarTheftIndex < 51.5,Tree_70_Node_14,Tree_70_Node_15);
        Tree_70_Node_3 := IF ( le.p_v1_RaAPropOwnerAVMMed < 78124.5,Tree_70_Node_6,Tree_70_Node_7);
        Tree_70_Node_1 := IF ( le.p_PropAgeOldestPurchase < 508.5,Tree_70_Node_2,Tree_70_Node_3);
    SELF.Score1_Tree70_node := Tree_70_Node_1;
    SELF.Score1_Tree70_score := CASE(SELF.Score1_Tree70_node,120=>0.09405848,121=>0.022349756,122=>0.035818316,123=>0.120569624,124=>0.03591775,125=>-0.057959042,126=>-0.005899792,127=>0.029678881,128=>-0.001069009,129=>0.054278094,130=>0.021692447,131=>-0.057130687,132=>-0.059690196,133=>0.10631406,134=>0.03222461,135=>-0.032450568,136=>0.03598291,137=>0.10412543,138=>1.3603529E-4,139=>-0.0060405354,140=>0.0018675319,141=>0.015799684,142=>-0.054948762,143=>-0.029663539,144=>-0.010581031,145=>0.023573559,146=>-0.009213836,147=>-0.056732614,148=>0.0091625005,149=>-0.055426996,150=>0.06562321,151=>-0.008808878,152=>0.0031677664,153=>0.08738104,154=>0.02771266,155=>0.10620275,156=>0.060206607,157=>-0.005630983,158=>-0.022502558,159=>0.024778754,160=>-0.0044247946,161=>0.056469597,162=>-0.053623933,163=>-0.006221829,164=>-0.031650573,165=>0.032597747,166=>0.016314862,167=>-0.041332223,168=>0.044555508,169=>-0.020729605,170=>-0.0440442,171=>0.004417617,172=>-0.02017175,173=>-0.05773479,174=>0.002142591,175=>0.07553582,176=>-0.05193763,177=>-0.0081653185,178=>-0.029982254,179=>0.07521406,0);
ENDMACRO;
