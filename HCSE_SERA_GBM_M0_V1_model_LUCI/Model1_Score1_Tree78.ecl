﻿EXPORT Model1_Score1_Tree78(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_78_Node_54 := IF ( le.p_NonDerogCount06 < 4.5,148,149);
        Tree_78_Node_55 := IF ( le.p_AccidentAge < 17.5,150,151);
        Tree_78_Node_30 := IF ( le.p_BP_4 < 13.5,Tree_78_Node_54,Tree_78_Node_55);
        Tree_78_Node_56 := IF ( le.p_v1_RaAElderlyMmbrCnt < 0.5,152,153);
        Tree_78_Node_57 := IF ( le.p_v1_CrtRecMsdmeanCnt < 4.5,154,155);
        Tree_78_Node_31 := IF ( le.p_v1_ProspectTimeOnRecord < 255.5,Tree_78_Node_56,Tree_78_Node_57);
        Tree_78_Node_16 := IF ( le.p_BPV_2 < 3.110811,Tree_78_Node_30,Tree_78_Node_31);
        Tree_78_Node_58 := IF ( le.p_PrevAddrAgeNewestRecord < 39.5,156,157);
        Tree_78_Node_59 := IF ( le.p_PrevAddrLenOfRes < 479.5,158,159);
        Tree_78_Node_32 := IF ( le.p_PrevAddrBurglaryIndex < 9.5,Tree_78_Node_58,Tree_78_Node_59);
        Tree_78_Node_33 := IF ( le.p_PropOwnedHistoricalCount < 1.5,130,131);
        Tree_78_Node_17 := IF ( le.p_VariationDOBCount < 4.5,Tree_78_Node_32,Tree_78_Node_33);
        Tree_78_Node_8 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 3.5,Tree_78_Node_16,Tree_78_Node_17);
        Tree_78_Node_62 := IF ( le.p_RelativesBankruptcyCount < 7.5,160,161);
        Tree_78_Node_63 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.6,162,163);
        Tree_78_Node_34 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 4.5,Tree_78_Node_62,Tree_78_Node_63);
        Tree_78_Node_64 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 307029.5,164,165);
        Tree_78_Node_35 := IF ( le.p_SrcsConfirmIDAddrCount < 6.5,Tree_78_Node_64,132);
        Tree_78_Node_18 := IF ( le.p_PrevAddrCrimeIndex < 190.5,Tree_78_Node_34,Tree_78_Node_35);
        Tree_78_Node_19 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,123,124);
        Tree_78_Node_9 := IF ( le.p_v1_HHPPCurrOwnedCnt < 6.5,Tree_78_Node_18,Tree_78_Node_19);
        Tree_78_Node_4 := IF ( le.p_EvictionAge < 49.5,Tree_78_Node_8,Tree_78_Node_9);
        Tree_78_Node_66 := IF ( le.p_RelativesBankruptcyCount < 3.5,166,167);
        Tree_78_Node_38 := IF ( le.p_v1_CrtRecLienJudgCnt < 6.5,Tree_78_Node_66,133);
        Tree_78_Node_39 := IF ( le.p_PrevAddrCrimeIndex < 120.5,134,135);
        Tree_78_Node_20 := IF ( le.p_PrevAddrAgeNewestRecord < 36.5,Tree_78_Node_38,Tree_78_Node_39);
        Tree_78_Node_10 := IF ( le.p_SubjectLastNameCount < 7.5,Tree_78_Node_20,121);
        Tree_78_Node_70 := IF ( le.p_PropOwnedHistoricalCount < 5.5,168,169);
        Tree_78_Node_71 := IF ( le.p_RelativesPropOwnedCount < 1.5,170,171);
        Tree_78_Node_40 := IF ( le.p_PropAgeOldestPurchase < 223.5,Tree_78_Node_70,Tree_78_Node_71);
        Tree_78_Node_41 := IF ( le.p_PhoneOtherAgeOldestRecord < 112.0,136,137);
        Tree_78_Node_22 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 254.5,Tree_78_Node_40,Tree_78_Node_41);
        Tree_78_Node_42 := IF ( le.p_v1_ProspectTimeLastUpdate < 59.5,138,139);
        Tree_78_Node_76 := IF ( le.p_CurrAddrMedianIncome < 101996.5,172,173);
        Tree_78_Node_77 := IF ( le.p_VariationMSourcesSSNCount < 1.5,174,175);
        Tree_78_Node_43 := IF ( le.p_v1_ProspectAge < 74.5,Tree_78_Node_76,Tree_78_Node_77);
        Tree_78_Node_23 := IF ( le.p_v1_HHEstimatedIncomeRange < 1.5,Tree_78_Node_42,Tree_78_Node_43);
        Tree_78_Node_11 := IF ( le.p_PrevAddrAgeOldestRecord < 293.0,Tree_78_Node_22,Tree_78_Node_23);
        Tree_78_Node_5 := IF ( le.p_EstimatedAnnualIncome < 30422.5,Tree_78_Node_10,Tree_78_Node_11);
        Tree_78_Node_2 := IF ( le.p_LienReleasedAge < 81.5,Tree_78_Node_4,Tree_78_Node_5);
        Tree_78_Node_24 := IF ( le.p_age_in_years < 50.535,125,126);
        Tree_78_Node_46 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,140,141);
        Tree_78_Node_47 := IF ( le.p_SubjectLastNameCount < 3.5,142,143);
        Tree_78_Node_25 := IF ( le.p_EstimatedAnnualIncome < 39812.5,Tree_78_Node_46,Tree_78_Node_47);
        Tree_78_Node_12 := IF ( le.p_SSNHighIssueAge < 491.5,Tree_78_Node_24,Tree_78_Node_25);
        Tree_78_Node_48 := IF ( le.p_PrevAddrCrimeIndex < 130.5,144,145);
        Tree_78_Node_26 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 22.5,Tree_78_Node_48,127);
        Tree_78_Node_27 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 5.5,128,129);
        Tree_78_Node_13 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 270647.5,Tree_78_Node_26,Tree_78_Node_27);
        Tree_78_Node_6 := IF ( le.p_PrevAddrAgeLastSale < 23.5,Tree_78_Node_12,Tree_78_Node_13);
        Tree_78_Node_84 := IF ( le.p_CurrAddrTractIndex < 0.096,176,177);
        Tree_78_Node_85 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 0.5,178,179);
        Tree_78_Node_52 := IF ( le.p_SubjectLastNameCount < 3.5,Tree_78_Node_84,Tree_78_Node_85);
        Tree_78_Node_53 := IF ( le.p_v1_RaAPropOwnerAVMMed < 216456.5,146,147);
        Tree_78_Node_29 := IF ( le.p_P_EstimatedHHIncomePerCapita < 4.5625,Tree_78_Node_52,Tree_78_Node_53);
        Tree_78_Node_14 := IF ( le.p_RelativesCount < 3.5,122,Tree_78_Node_29);
        Tree_78_Node_7 := IF ( le.p_CurrAddrTractIndex < 1.748164,Tree_78_Node_14,120);
        Tree_78_Node_3 := CHOOSE ( le.p_gender,Tree_78_Node_6,Tree_78_Node_7);
        Tree_78_Node_1 := IF ( le.p_LienReleasedAge < 220.5,Tree_78_Node_2,Tree_78_Node_3);
    UNSIGNED2 Score1_Tree78_node := Tree_78_Node_1;
    REAL8 Score1_Tree78_score := CASE(Score1_Tree78_node,120=>0.05191012,121=>0.06834356,122=>0.03618866,123=>6.592642E-4,124=>0.06972359,125=>-0.050668772,126=>0.021329671,127=>0.05987705,128=>-0.0520531,129=>-0.026051102,130=>0.058737136,131=>-0.025915995,132=>0.061070465,133=>-0.031654216,134=>-0.006847939,135=>-0.053977557,136=>-0.013975325,137=>0.10604403,138=>-0.02664536,139=>0.06146528,140=>-0.05374961,141=>-0.052242875,142=>-0.036268566,143=>-0.051795498,144=>0.0077239154,145=>-0.05303885,146=>0.05593329,147=>-0.004708783,148=>0.0022953977,149=>-0.0022301497,150=>-8.053336E-4,151=>-0.0151497815,152=>0.03438718,153=>0.001338096,154=>-0.02971272,155=>0.020466179,156=>-0.004484398,157=>0.045109086,158=>-0.015415191,159=>0.023700815,160=>-0.015140098,161=>0.034827027,162=>-0.0068699927,163=>0.06234785,164=>-0.0047081113,165=>0.036125865,166=>0.016244905,167=>0.04900698,168=>0.0038603803,169=>0.05883478,170=>0.0064885607,171=>-0.032006476,172=>-0.04476395,173=>8.703164E-4,174=>-0.025824256,175=>0.059108566,176=>0.019708565,177=>-0.022055628,178=>-0.009286119,179=>-0.052673087,0);
ENDMACRO;
