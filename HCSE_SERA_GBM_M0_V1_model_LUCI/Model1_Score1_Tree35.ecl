﻿EXPORT Model1_Score1_Tree35(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_35_Node_48 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 5.5,157,158);
        Tree_35_Node_49 := IF ( le.p_StatusMostRecent < 1.5,159,160);
        Tree_35_Node_26 := IF ( le.p_BPV_3 < 2.3864813,Tree_35_Node_48,Tree_35_Node_49);
        Tree_35_Node_50 := IF ( le.p_RelativesCount < 3.5,161,162);
        Tree_35_Node_27 := IF ( le.p_LienReleasedAge < 88.5,Tree_35_Node_50,147);
        Tree_35_Node_14 := IF ( le.p_AddrChangeCount24 < 2.5,Tree_35_Node_26,Tree_35_Node_27);
        Tree_35_Node_52 := IF ( le.p_PRSearchLocateCount < 5.5,163,164);
        Tree_35_Node_53 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 5.0,165,166);
        Tree_35_Node_28 := IF ( le.p_SubjectLastNameCount < 9.5,Tree_35_Node_52,Tree_35_Node_53);
        Tree_35_Node_54 := IF ( le.p_SearchVelocityRiskLevel < 2.5,167,168);
        Tree_35_Node_29 := IF ( le.p_SSNIssueState < 47.5,Tree_35_Node_54,148);
        Tree_35_Node_15 := IF ( le.p_NonDerogCount60 < 5.5,Tree_35_Node_28,Tree_35_Node_29);
        Tree_35_Node_8 := IF ( le.p_v1_CrtRecTimeNewest < 72.0,Tree_35_Node_14,Tree_35_Node_15);
        Tree_35_Node_31 := IF ( le.p_age_in_years < 79.52031,149,150);
        Tree_35_Node_16 := IF ( le.p_CurrAddrAgeLastSale < 108.5,144,Tree_35_Node_31);
        Tree_35_Node_59 := IF ( le.p_EstimatedAnnualIncome < 41850.5,169,170);
        Tree_35_Node_32 := IF ( le.p_v1_RaAMedIncomeRange < 4.5,151,Tree_35_Node_59);
        Tree_35_Node_60 := IF ( le.p_PhoneEDAAgeOldestRecord < 132.5,171,172);
        Tree_35_Node_61 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 190325.5,173,174);
        Tree_35_Node_33 := IF ( le.p_v1_HHCrtRecMmbrCnt < 0.5,Tree_35_Node_60,Tree_35_Node_61);
        Tree_35_Node_17 := IF ( le.p_CurrAddrCrimeIndex < 89.5,Tree_35_Node_32,Tree_35_Node_33);
        Tree_35_Node_9 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.640625,Tree_35_Node_16,Tree_35_Node_17);
        Tree_35_Node_4 := IF ( le.p_v1_ProspectTimeLastUpdate < 173.5,Tree_35_Node_8,Tree_35_Node_9);
        Tree_35_Node_2 := IF ( le.p_PropAgeNewestPurchase < 675.0,Tree_35_Node_4,142);
        Tree_35_Node_62 := IF ( le.p_PrevAddrBurglaryIndex < 190.5,175,176);
        Tree_35_Node_63 := IF ( le.p_CurrAddrMedianValue < 299999.5,177,178);
        Tree_35_Node_34 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt12Mo < 1.5,Tree_35_Node_62,Tree_35_Node_63);
        Tree_35_Node_64 := IF ( le.p_RelativesBankruptcyCount < 6.5,179,180);
        Tree_35_Node_65 := IF ( le.p_SSNLowIssueAge < 624.5,181,182);
        Tree_35_Node_35 := IF ( le.p_BP_2 < 2.5,Tree_35_Node_64,Tree_35_Node_65);
        Tree_35_Node_18 := IF ( le.p_PhoneEDAAgeNewestRecord < 50.0,Tree_35_Node_34,Tree_35_Node_35);
        Tree_35_Node_66 := IF ( le.p_v1_RaAMedIncomeRange < 0.0,183,184);
        Tree_35_Node_67 := IF ( le.p_CurrAddrBurglaryIndex < 9.5,185,186);
        Tree_35_Node_36 := IF ( le.p_CurrAddrCarTheftIndex < 9.5,Tree_35_Node_66,Tree_35_Node_67);
        Tree_35_Node_19 := IF ( le.p_PrevAddrMedianIncome < 191231.5,Tree_35_Node_36,145);
        Tree_35_Node_10 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 6.5,Tree_35_Node_18,Tree_35_Node_19);
        Tree_35_Node_68 := IF ( le.p_PropOwnedHistoricalCount < 1.5,187,188);
        Tree_35_Node_38 := IF ( le.p_age_in_years < 70.0125,Tree_35_Node_68,152);
        Tree_35_Node_70 := IF ( le.p_v1_RaAPropOwnerAVMMed < 169804.5,189,190);
        Tree_35_Node_39 := IF ( le.p_SSNIdentitiesCount < 1.5,Tree_35_Node_70,153);
        Tree_35_Node_20 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.15,Tree_35_Node_38,Tree_35_Node_39);
        Tree_35_Node_11 := IF ( le.p_LienFiledAge < 200.5,Tree_35_Node_20,143);
        Tree_35_Node_6 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 429686.5,Tree_35_Node_10,Tree_35_Node_11);
        Tree_35_Node_72 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 3.5,191,192);
        Tree_35_Node_40 := IF ( le.p_v1_HHCrtRecMmbrCnt < 2.5,Tree_35_Node_72,154);
        Tree_35_Node_74 := IF ( le.p_PhoneOtherAgeOldestRecord < 135.0,193,194);
        Tree_35_Node_41 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 246222.5,Tree_35_Node_74,155);
        Tree_35_Node_22 := IF ( le.p_PrevAddrMedianIncome < 63013.5,Tree_35_Node_40,Tree_35_Node_41);
        Tree_35_Node_76 := IF ( le.p_PropAgeOldestPurchase < 239.5,195,196);
        Tree_35_Node_77 := IF ( le.p_NonDerogCount03 < 3.5,197,198);
        Tree_35_Node_42 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 179.5,Tree_35_Node_76,Tree_35_Node_77);
        Tree_35_Node_78 := IF ( le.p_RelativesBankruptcyCount < 1.5,199,200);
        Tree_35_Node_43 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 0.5,Tree_35_Node_78,156);
        Tree_35_Node_23 := IF ( le.p_CurrAddrMedianIncome < 57421.5,Tree_35_Node_42,Tree_35_Node_43);
        Tree_35_Node_12 := IF ( le.p_BPV_4 < -1.6976367,Tree_35_Node_22,Tree_35_Node_23);
        Tree_35_Node_80 := IF ( le.p_LienFiledCount < 6.5,201,202);
        Tree_35_Node_81 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 174.5,203,204);
        Tree_35_Node_44 := IF ( le.p_PrevAddrAgeNewestRecord < 29.5,Tree_35_Node_80,Tree_35_Node_81);
        Tree_35_Node_24 := IF ( le.p_PrevAddrAgeLastSale < 319.5,Tree_35_Node_44,146);
        Tree_35_Node_82 := IF ( le.p_AddrChangeCount60 < 1.5,205,206);
        Tree_35_Node_83 := IF ( le.p_PRSearchLocateCount24 < 1.5,207,208);
        Tree_35_Node_46 := IF ( le.p_v1_PropTimeLastSale < 19.5,Tree_35_Node_82,Tree_35_Node_83);
        Tree_35_Node_84 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 229.5,209,210);
        Tree_35_Node_85 := IF ( le.p_v1_ProspectTimeLastUpdate < 49.5,211,212);
        Tree_35_Node_47 := IF ( le.p_PropAgeOldestPurchase < 287.5,Tree_35_Node_84,Tree_35_Node_85);
        Tree_35_Node_25 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_35_Node_46,Tree_35_Node_47);
        Tree_35_Node_13 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,Tree_35_Node_24,Tree_35_Node_25);
        Tree_35_Node_7 := IF ( le.p_EstimatedAnnualIncome < 33533.5,Tree_35_Node_12,Tree_35_Node_13);
        Tree_35_Node_3 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 97.0,Tree_35_Node_6,Tree_35_Node_7);
        Tree_35_Node_1 := IF ( le.p_LastNameChangeAge < 63.5,Tree_35_Node_2,Tree_35_Node_3);
    UNSIGNED2 Score1_Tree35_node := Tree_35_Node_1;
    REAL8 Score1_Tree35_score := CASE(Score1_Tree35_node,142=>0.06623399,143=>0.17001864,144=>-0.08280847,145=>0.090647556,146=>0.09978502,147=>0.038239647,148=>0.10934778,149=>0.017443879,150=>0.12804669,151=>-0.040927775,152=>0.06271782,153=>-0.0048682163,154=>-0.070088185,155=>0.006245095,156=>0.03570674,157=>-0.009305199,158=>0.084740825,159=>-0.02441974,160=>0.035938952,161=>0.030222308,162=>-0.049918063,163=>0.027019598,164=>-0.05408663,165=>0.13959531,166=>0.04356394,167=>0.003649755,168=>-0.03268591,169=>-0.08202078,170=>-0.07895797,171=>-0.03410557,172=>0.048449595,173=>-0.074612424,174=>-0.015054299,175=>0.0016935092,176=>0.01899882,177=>0.020609783,178=>0.11669763,179=>-0.005221832,180=>0.026935065,181=>0.0067520607,182=>0.07226981,183=>0.08486545,184=>-0.041945584,185=>0.072019845,186=>-0.009383522,187=>-0.08159783,188=>-0.029327188,189=>0.14027299,190=>0.053761948,191=>0.05089271,192=>-0.014716614,193=>-0.08275196,194=>-0.043311004,195=>0.030418858,196=>0.12592216,197=>0.01967085,198=>-0.08443988,199=>0.12240614,200=>0.20730154,201=>-0.038402565,202=>0.04093703,203=>0.033454545,204=>-0.06247755,205=>0.04293187,206=>-0.025954274,207=>0.003070276,208=>0.123214915,209=>-0.023198448,210=>0.09254596,211=>0.08952012,212=>-0.0034828607,0);
ENDMACRO;
