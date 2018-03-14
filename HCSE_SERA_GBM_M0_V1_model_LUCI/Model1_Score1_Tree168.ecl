﻿EXPORT Model1_Score1_Tree168(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_168_Node_46 := IF ( le.p_v1_CrtRecCnt < 19.5,115,116);
        Tree_168_Node_47 := IF ( le.p_PropOwnedHistoricalCount < 5.5,117,118);
        Tree_168_Node_28 := IF ( le.p_AccidentAge < 68.0,Tree_168_Node_46,Tree_168_Node_47);
        Tree_168_Node_48 := IF ( le.p_v1_RaAMedIncomeRange < 1.5,119,120);
        Tree_168_Node_49 := IF ( le.p_CurrAddrAVMValue60 < 109568.5,121,122);
        Tree_168_Node_29 := IF ( le.p_PhoneOtherAgeNewestRecord < 31.5,Tree_168_Node_48,Tree_168_Node_49);
        Tree_168_Node_16 := IF ( le.p_AccidentAge < 113.5,Tree_168_Node_28,Tree_168_Node_29);
        Tree_168_Node_51 := IF ( le.p_RelativesCount < 8.5,123,124);
        Tree_168_Node_30 := IF ( le.p_RelativesPropOwnedCount < 0.5,106,Tree_168_Node_51);
        Tree_168_Node_17 := IF ( le.p_CurrAddrCarTheftIndex < 180.5,Tree_168_Node_30,99);
        Tree_168_Node_8 := IF ( le.p_BPV_2 < 3.0349374,Tree_168_Node_16,Tree_168_Node_17);
        Tree_168_Node_33 := IF ( le.p_CurrAddrCrimeIndex < 109.5,107,108);
        Tree_168_Node_18 := IF ( le.p_age_in_years < 49.49297,100,Tree_168_Node_33);
        Tree_168_Node_35 := IF ( le.p_PhoneEDAAgeNewestRecord < 26.0,109,110);
        Tree_168_Node_19 := IF ( le.p_LienFiledAge < 69.5,101,Tree_168_Node_35);
        Tree_168_Node_9 := IF ( le.p_SSNAddrCount < 16.0,Tree_168_Node_18,Tree_168_Node_19);
        Tree_168_Node_4 := IF ( le.p_LienReleasedAge < 76.5,Tree_168_Node_8,Tree_168_Node_9);
        Tree_168_Node_56 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 1.5,125,126);
        Tree_168_Node_57 := IF ( le.p_PropAgeNewestPurchase < 90.5,127,128);
        Tree_168_Node_36 := IF ( le.p_CurrAddrAgeOldestRecord < 202.5,Tree_168_Node_56,Tree_168_Node_57);
        Tree_168_Node_59 := IF ( le.p_CurrAddrLenOfRes < 76.5,129,130);
        Tree_168_Node_37 := IF ( le.p_PhoneEDAAgeOldestRecord < 101.5,111,Tree_168_Node_59);
        Tree_168_Node_20 := IF ( le.p_SSNHighIssueAge < 725.5,Tree_168_Node_36,Tree_168_Node_37);
        Tree_168_Node_21 := IF ( le.p_CurrAddrBurglaryIndex < 110.5,102,103);
        Tree_168_Node_10 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 162.5,Tree_168_Node_20,Tree_168_Node_21);
        Tree_168_Node_60 := IF ( le.p_v1_ProspectAge < 57.5,131,132);
        Tree_168_Node_61 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,133,134);
        Tree_168_Node_40 := IF ( le.p_age_in_years < 71.295,Tree_168_Node_60,Tree_168_Node_61);
        Tree_168_Node_41 := IF ( le.p_LienFiledCount < 2.5,112,113);
        Tree_168_Node_22 := IF ( le.p_CurrAddrBurglaryIndex < 179.5,Tree_168_Node_40,Tree_168_Node_41);
        Tree_168_Node_11 := IF ( le.p_DerogAge < 197.5,Tree_168_Node_22,96);
        Tree_168_Node_5 := IF ( le.p_PropAgeNewestPurchase < 151.5,Tree_168_Node_10,Tree_168_Node_11);
        Tree_168_Node_2 := IF ( le.p_LienReleasedAge < 81.5,Tree_168_Node_4,Tree_168_Node_5);
        Tree_168_Node_65 := IF ( le.p_CurrAddrMurderIndex < 149.5,135,136);
        Tree_168_Node_42 := IF ( le.p_DerogAge < 162.0,114,Tree_168_Node_65);
        Tree_168_Node_24 := IF ( le.p_SearchVelocityRiskLevel < 5.5,Tree_168_Node_42,104);
        Tree_168_Node_66 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 5.5,137,138);
        Tree_168_Node_67 := IF ( le.p_PrevAddrBurglaryIndex < 100.0,139,140);
        Tree_168_Node_44 := IF ( le.p_LienReleasedAge < 238.5,Tree_168_Node_66,Tree_168_Node_67);
        Tree_168_Node_25 := IF ( le.p_v1_ProspectTimeLastUpdate < 215.5,Tree_168_Node_44,105);
        Tree_168_Node_12 := IF ( le.p_CurrAddrMedianIncome < 33256.5,Tree_168_Node_24,Tree_168_Node_25);
        Tree_168_Node_6 := IF ( le.p_SourceRiskLevel < 6.5,Tree_168_Node_12,94);
        Tree_168_Node_15 := IF ( le.p_PropAgeOldestPurchase < 215.5,97,98);
        Tree_168_Node_7 := IF ( le.p_PropAgeOldestPurchase < 135.5,95,Tree_168_Node_15);
        Tree_168_Node_3 := IF ( le.p_CurrAddrTractIndex < 1.2901367,Tree_168_Node_6,Tree_168_Node_7);
        Tree_168_Node_1 := IF ( le.p_LienReleasedAge < 222.5,Tree_168_Node_2,Tree_168_Node_3);
    UNSIGNED2 Score1_Tree168_node := Tree_168_Node_1;
    REAL8 Score1_Tree168_score := CASE(Score1_Tree168_node,128=>0.005180421,129=>-0.016695837,130=>0.009670198,131=>-0.00450919,132=>-0.015465379,133=>-0.006743503,134=>0.016231034,135=>-0.020495977,136=>-0.021009363,137=>-0.020891193,138=>-0.005747182,139=>0.001919997,140=>-0.009282522,94=>0.009538786,95=>-0.012392094,96=>0.013779477,97=>0.026481047,98=>0.0018914926,99=>-0.016329788,100=>-0.016081572,101=>0.0146649815,102=>0.0034988509,103=>0.032777876,104=>-0.0060671982,105=>0.012916402,106=>-0.009080645,107=>-0.021189405,108=>-0.022102887,109=>-0.00806056,110=>-0.021212304,111=>0.027249124,112=>-0.0063453172,113=>0.023260297,114=>-0.021258032,115=>5.5015164E-5,116=>-0.0012880861,117=>0.0022814944,118=>0.027968176,119=>0.018101426,120=>-0.0016008753,121=>-0.015864972,122=>-0.0010605775,123=>0.012513261,124=>0.0034092928,125=>0.0051214383,126=>-6.99259E-4,127=>-0.010800067,0);
ENDMACRO;
