﻿EXPORT Model1_Score1_Tree54_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_54_Node_48 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 2.5,143,144);
        Tree_54_Node_49 := IF ( le.p_LienReleasedAge < 55.5,145,146);
        Tree_54_Node_26 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 3.5,Tree_54_Node_48,Tree_54_Node_49);
        Tree_54_Node_50 := IF ( le.p_SubjectLastNameCount < 9.5,147,148);
        Tree_54_Node_51 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 3.5,149,150);
        Tree_54_Node_27 := IF ( le.p_SubjectAddrCount < 14.5,Tree_54_Node_50,Tree_54_Node_51);
        Tree_54_Node_14 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_54_Node_26,Tree_54_Node_27);
        Tree_54_Node_52 := IF ( le.p_LienFiledAge < 81.0,151,152);
        Tree_54_Node_53 := IF ( le.p_PhoneEDAAgeOldestRecord < 163.0,153,154);
        Tree_54_Node_28 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 4.5,Tree_54_Node_52,Tree_54_Node_53);
        Tree_54_Node_15 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 480.0,Tree_54_Node_28,132);
        Tree_54_Node_8 := IF ( le.p_CurrAddrCarTheftIndex < 80.5,Tree_54_Node_14,Tree_54_Node_15);
        Tree_54_Node_54 := IF ( le.p_PrevAddrBurglaryIndex < 89.5,155,156);
        Tree_54_Node_55 := IF ( le.p_NonDerogCount60 < 6.5,157,158);
        Tree_54_Node_30 := IF ( le.p_CurrAddrAgeLastSale < 194.0,Tree_54_Node_54,Tree_54_Node_55);
        Tree_54_Node_56 := IF ( le.p_v1_CrtRecCnt12Mo < 1.5,159,160);
        Tree_54_Node_57 := IF ( le.p_v1_RaAPropOwnerAVMMed < 378151.5,161,162);
        Tree_54_Node_31 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_54_Node_56,Tree_54_Node_57);
        Tree_54_Node_16 := IF ( le.p_CurrAddrAgeLastSale < 223.5,Tree_54_Node_30,Tree_54_Node_31);
        Tree_54_Node_58 := IF ( le.p_age_in_years < 73.17,163,164);
        Tree_54_Node_59 := IF ( le.p_v1_LifeEvEverResidedCnt < 4.5,165,166);
        Tree_54_Node_33 := IF ( le.p_PrevAddrMedianValue < 31249.5,Tree_54_Node_58,Tree_54_Node_59);
        Tree_54_Node_17 := IF ( le.p_CurrAddrMedianIncome < 21448.5,133,Tree_54_Node_33);
        Tree_54_Node_9 := IF ( le.p_v1_HHPPCurrOwnedCnt < 5.5,Tree_54_Node_16,Tree_54_Node_17);
        Tree_54_Node_4 := IF ( le.p_CurrAddrCarTheftIndex < 91.5,Tree_54_Node_8,Tree_54_Node_9);
        Tree_54_Node_2 := IF ( le.p_BPV_3 < 4.3605924,Tree_54_Node_4,130);
        Tree_54_Node_18 := IF ( le.p_PrevAddrCarTheftIndex < 19.5,134,135);
        Tree_54_Node_60 := IF ( le.p_SSNLowIssueAge < 383.5,167,168);
        Tree_54_Node_61 := IF ( le.p_CurrAddrCarTheftIndex < 100.0,169,170);
        Tree_54_Node_36 := IF ( le.p_AccidentAge < 52.5,Tree_54_Node_60,Tree_54_Node_61);
        Tree_54_Node_62 := IF ( le.p_PropAgeNewestSale < 78.5,171,172);
        Tree_54_Node_37 := IF ( le.p_CurrAddrCarTheftIndex < 110.0,Tree_54_Node_62,139);
        Tree_54_Node_19 := IF ( le.p_PropAgeNewestSale < 29.5,Tree_54_Node_36,Tree_54_Node_37);
        Tree_54_Node_10 := IF ( le.p_CurrAddrMurderIndex < 7.5,Tree_54_Node_18,Tree_54_Node_19);
        Tree_54_Node_64 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,173,174);
        Tree_54_Node_65 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 4.0,175,176);
        Tree_54_Node_38 := IF ( le.p_v1_PropCurrOwnedCnt < 2.5,Tree_54_Node_64,Tree_54_Node_65);
        Tree_54_Node_66 := IF ( le.p_CurrAddrMurderIndex < 79.5,177,178);
        Tree_54_Node_67 := IF ( le.p_SSNLowIssueAge < 653.5,179,180);
        Tree_54_Node_39 := IF ( le.p_v1_RaAElderlyMmbrCnt < 0.5,Tree_54_Node_66,Tree_54_Node_67);
        Tree_54_Node_20 := IF ( le.p_CurrAddrMedianValue < 265624.5,Tree_54_Node_38,Tree_54_Node_39);
        Tree_54_Node_68 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 0.5,181,182);
        Tree_54_Node_40 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 6.5,Tree_54_Node_68,140);
        Tree_54_Node_21 := IF ( le.p_CurrAddrBurglaryIndex < 150.5,Tree_54_Node_40,136);
        Tree_54_Node_11 := IF ( le.p_BP_2 < 1.5,Tree_54_Node_20,Tree_54_Node_21);
        Tree_54_Node_6 := IF ( le.p_SSNIssueState < 19.5,Tree_54_Node_10,Tree_54_Node_11);
        Tree_54_Node_22 := IF ( le.p_v1_CrtRecTimeNewest < 70.5,137,138);
        Tree_54_Node_12 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.7265625,Tree_54_Node_22,131);
        Tree_54_Node_70 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 13.5,183,184);
        Tree_54_Node_71 := IF ( le.p_PrevAddrMedianValue < 135141.0,185,186);
        Tree_54_Node_44 := IF ( le.p_CurrAddrAVMValue12 < 31344.5,Tree_54_Node_70,Tree_54_Node_71);
        Tree_54_Node_72 := IF ( le.p_v1_RaAHHCnt < 1.5,187,188);
        Tree_54_Node_73 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 2.5,189,190);
        Tree_54_Node_45 := IF ( le.p_PrevAddrCarTheftIndex < 59.5,Tree_54_Node_72,Tree_54_Node_73);
        Tree_54_Node_24 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 78561.5,Tree_54_Node_44,Tree_54_Node_45);
        Tree_54_Node_74 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,191,192);
        Tree_54_Node_46 := IF ( le.p_PrevAddrMedianIncome < 67067.0,Tree_54_Node_74,141);
        Tree_54_Node_77 := IF ( le.p_v1_HHPropCurrAVMHighest < 23355.5,193,194);
        Tree_54_Node_47 := IF ( le.p_SSNHighIssueAge < 600.5,142,Tree_54_Node_77);
        Tree_54_Node_25 := IF ( le.p_PropAgeNewestPurchase < 223.5,Tree_54_Node_46,Tree_54_Node_47);
        Tree_54_Node_13 := IF ( le.p_CurrAddrBurglaryIndex < 143.5,Tree_54_Node_24,Tree_54_Node_25);
        Tree_54_Node_7 := IF ( le.p_EstimatedAnnualIncome < 28388.5,Tree_54_Node_12,Tree_54_Node_13);
        Tree_54_Node_3 := IF ( le.p_PrevAddrAgeOldestRecord < 279.0,Tree_54_Node_6,Tree_54_Node_7);
        Tree_54_Node_1 := IF ( le.p_PRSearchLocateCount24 < 0.5,Tree_54_Node_2,Tree_54_Node_3);
    SELF.Score1_Tree54_node := Tree_54_Node_1;
    SELF.Score1_Tree54_score := CASE(SELF.Score1_Tree54_node,130=>0.049598176,131=>0.10855693,132=>0.10810672,133=>0.067427665,134=>-0.018126177,135=>0.10612921,136=>-0.032124855,137=>-0.016504206,138=>0.08272761,139=>0.061608445,140=>0.0107774325,141=>-0.028084593,142=>-0.030744104,143=>-0.0014858417,144=>-0.0103214085,145=>-0.029552821,146=>0.023153387,147=>0.010200766,148=>0.11323254,149=>-0.003793233,150=>0.07149592,151=>-0.021923192,152=>0.004850219,153=>-0.037270304,154=>0.07148376,155=>0.0076758307,156=>4.9435144E-4,157=>0.012899574,158=>0.10156465,159=>-0.0071681268,160=>-0.05264788,161=>0.004999228,162=>0.13020967,163=>-0.030011691,164=>0.08343252,165=>-0.029937783,166=>0.030356782,167=>-0.036826618,168=>-0.06125799,169=>-0.043845147,170=>0.05428713,171=>0.036547303,172=>-0.047103193,173=>-0.006131115,174=>0.012740686,175=>0.02152946,176=>0.1069371,177=>-0.05363846,178=>-0.004495639,179=>0.020107111,180=>-0.057170667,181=>0.021522203,182=>0.07975651,183=>-0.06071427,184=>-0.01564197,185=>0.08701777,186=>-0.015045281,187=>0.16494328,188=>0.05395983,189=>-0.014139232,190=>0.055943493,191=>-0.06845563,192=>-0.0657015,193=>0.06762638,194=>0.019827435,0);
ENDMACRO;
