﻿EXPORT Model1_Score1_Tree183(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_183_Node_46 := IF ( le.p_EvictionAge < 55.0,116,117);
        Tree_183_Node_47 := IF ( le.p_PropOwnedHistoricalCount < 5.5,118,119);
        Tree_183_Node_28 := IF ( le.p_AccidentAge < 68.0,Tree_183_Node_46,Tree_183_Node_47);
        Tree_183_Node_48 := IF ( le.p_SubjectAddrCount < 18.5,120,121);
        Tree_183_Node_49 := IF ( le.p_CurrAddrAVMValue60 < 109568.5,122,123);
        Tree_183_Node_29 := IF ( le.p_PhoneOtherAgeNewestRecord < 31.5,Tree_183_Node_48,Tree_183_Node_49);
        Tree_183_Node_16 := IF ( le.p_AccidentAge < 113.5,Tree_183_Node_28,Tree_183_Node_29);
        Tree_183_Node_51 := IF ( le.p_RelativesCount < 8.5,124,125);
        Tree_183_Node_30 := IF ( le.p_RelativesPropOwnedCount < 0.5,103,Tree_183_Node_51);
        Tree_183_Node_17 := IF ( le.p_CurrAddrCarTheftIndex < 180.5,Tree_183_Node_30,97);
        Tree_183_Node_8 := IF ( le.p_BPV_2 < 3.0349374,Tree_183_Node_16,Tree_183_Node_17);
        Tree_183_Node_33 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,104,105);
        Tree_183_Node_18 := IF ( le.p_v1_ProspectTimeOnRecord < 118.5,98,Tree_183_Node_33);
        Tree_183_Node_35 := IF ( le.p_PhoneEDAAgeNewestRecord < 26.0,106,107);
        Tree_183_Node_19 := IF ( le.p_LienFiledAge < 69.5,99,Tree_183_Node_35);
        Tree_183_Node_9 := IF ( le.p_SSNAddrCount < 16.0,Tree_183_Node_18,Tree_183_Node_19);
        Tree_183_Node_4 := IF ( le.p_LienReleasedAge < 76.5,Tree_183_Node_8,Tree_183_Node_9);
        Tree_183_Node_56 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 1.5,126,127);
        Tree_183_Node_36 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 3.5,Tree_183_Node_56,108);
        Tree_183_Node_58 := IF ( le.p_PropAgeNewestPurchase < 98.5,128,129);
        Tree_183_Node_37 := IF ( le.p_SSNLowIssueAge < 736.5,Tree_183_Node_58,109);
        Tree_183_Node_20 := IF ( le.p_CurrAddrAgeOldestRecord < 202.5,Tree_183_Node_36,Tree_183_Node_37);
        Tree_183_Node_21 := IF ( le.p_CurrAddrBurglaryIndex < 110.5,100,101);
        Tree_183_Node_10 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 162.5,Tree_183_Node_20,Tree_183_Node_21);
        Tree_183_Node_60 := IF ( le.p_CurrAddrAgeLastSale < 335.5,130,131);
        Tree_183_Node_61 := IF ( le.p_CurrAddrCrimeIndex < 109.5,132,133);
        Tree_183_Node_40 := IF ( le.p_BPV_3 < 2.0889094,Tree_183_Node_60,Tree_183_Node_61);
        Tree_183_Node_41 := IF ( le.p_LienFiledCount < 2.5,110,111);
        Tree_183_Node_22 := IF ( le.p_CurrAddrBurglaryIndex < 179.5,Tree_183_Node_40,Tree_183_Node_41);
        Tree_183_Node_11 := IF ( le.p_DerogAge < 197.5,Tree_183_Node_22,94);
        Tree_183_Node_5 := IF ( le.p_PropAgeNewestPurchase < 151.5,Tree_183_Node_10,Tree_183_Node_11);
        Tree_183_Node_2 := IF ( le.p_LienReleasedAge < 81.5,Tree_183_Node_4,Tree_183_Node_5);
        Tree_183_Node_42 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,112,113);
        Tree_183_Node_24 := IF ( le.p_SearchVelocityRiskLevel < 5.5,Tree_183_Node_42,102);
        Tree_183_Node_66 := IF ( le.p_SubjectLastNameCount < 2.5,134,135);
        Tree_183_Node_67 := IF ( le.p_SourceRiskLevel < 4.5,136,137);
        Tree_183_Node_44 := IF ( le.p_PrevAddrBurglaryIndex < 100.0,Tree_183_Node_66,Tree_183_Node_67);
        Tree_183_Node_45 := IF ( le.p_LienFiledCount < 6.5,114,115);
        Tree_183_Node_25 := IF ( le.p_DerogSeverityIndex < 3.5,Tree_183_Node_44,Tree_183_Node_45);
        Tree_183_Node_12 := IF ( le.p_CurrAddrMedianIncome < 33256.5,Tree_183_Node_24,Tree_183_Node_25);
        Tree_183_Node_6 := IF ( le.p_SourceRiskLevel < 6.5,Tree_183_Node_12,92);
        Tree_183_Node_15 := IF ( le.p_LienReleasedAge < 270.5,95,96);
        Tree_183_Node_7 := IF ( le.p_AgeOldestRecord < 390.5,93,Tree_183_Node_15);
        Tree_183_Node_3 := IF ( le.p_CurrAddrTractIndex < 1.2901367,Tree_183_Node_6,Tree_183_Node_7);
        Tree_183_Node_1 := IF ( le.p_LienReleasedAge < 222.5,Tree_183_Node_2,Tree_183_Node_3);
    UNSIGNED2 Score1_Tree183_node := Tree_183_Node_1;
    REAL8 Score1_Tree183_score := CASE(Score1_Tree183_node,128=>-0.009330607,129=>0.0052014617,130=>-0.009246046,131=>0.0069300546,132=>0.0070873005,133=>-0.011946683,134=>0.010563302,135=>-0.003956255,136=>-0.0045517753,137=>-0.018149585,92=>0.007853084,93=>0.020012014,94=>0.011560478,95=>0.008421935,96=>-0.015129968,97=>-0.013852199,98=>-0.012097747,99=>0.012324166,100=>0.00290598,101=>0.026975803,102=>-0.0051697944,103=>-0.007706764,104=>-0.019155312,105=>-0.018340532,106=>-0.006890317,107=>-0.018200463,108=>0.019282306,109=>0.008127855,110=>-0.0053647133,111=>0.019311987,112=>-0.01822912,113=>-0.017780062,114=>-0.018195732,115=>-0.010973023,116=>2.2229073E-5,117=>-0.001653067,118=>0.001918147,119=>0.022942862,120=>-0.0027955144,121=>0.006589342,122=>-0.013543875,123=>-8.914135E-4,124=>0.010491609,125=>0.0028904814,126=>0.0043077166,127=>-5.0135015E-4,0);
ENDMACRO;
