﻿EXPORT Model1_Score1_Tree197(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_197_Node_34 := IF ( le.p_PhoneOtherAgeNewestRecord < 44.5,105,106);
        Tree_197_Node_35 := IF ( le.p_PhoneEDAAgeNewestRecord < 132.5,107,108);
        Tree_197_Node_20 := IF ( le.p_PhoneOtherAgeNewestRecord < 63.5,Tree_197_Node_34,Tree_197_Node_35);
        Tree_197_Node_21 := IF ( le.p_PhoneEDAAgeNewestRecord < 19.5,94,95);
        Tree_197_Node_12 := IF ( le.p_BP_2 < 6.5,Tree_197_Node_20,Tree_197_Node_21);
        Tree_197_Node_38 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,109,110);
        Tree_197_Node_39 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 9.5,111,112);
        Tree_197_Node_22 := IF ( le.p_AddrChangeCount60 < 2.5,Tree_197_Node_38,Tree_197_Node_39);
        Tree_197_Node_40 := IF ( le.p_PhoneOtherAgeNewestRecord < 87.5,113,114);
        Tree_197_Node_41 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 4.5,115,116);
        Tree_197_Node_23 := IF ( le.p_CurrAddrBlockIndex < 1.1278125,Tree_197_Node_40,Tree_197_Node_41);
        Tree_197_Node_13 := IF ( le.p_PrevAddrAgeOldestRecord < 31.5,Tree_197_Node_22,Tree_197_Node_23);
        Tree_197_Node_8 := IF ( le.p_RelativesBankruptcyCount < 7.5,Tree_197_Node_12,Tree_197_Node_13);
        Tree_197_Node_24 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 1.5,96,97);
        Tree_197_Node_44 := IF ( le.p_v1_RaAPropOwnerAVMMed < 720140.5,117,118);
        Tree_197_Node_25 := IF ( le.p_age_in_years < 70.44281,Tree_197_Node_44,98);
        Tree_197_Node_14 := IF ( le.p_CurrAddrMedianValue < 187499.5,Tree_197_Node_24,Tree_197_Node_25);
        Tree_197_Node_9 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 2683105.5,Tree_197_Node_14,92);
        Tree_197_Node_4 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 1562499.5,Tree_197_Node_8,Tree_197_Node_9);
        Tree_197_Node_46 := IF ( le.p_RelativesCount < 15.5,119,120);
        Tree_197_Node_47 := IF ( le.p_NonDerogCount12 < 3.5,121,122);
        Tree_197_Node_26 := IF ( le.p_SearchVelocityRiskLevel < 5.5,Tree_197_Node_46,Tree_197_Node_47);
        Tree_197_Node_27 := IF ( le.p_NonDerogCount06 < 3.5,99,100);
        Tree_197_Node_16 := IF ( le.p_PrevAddrMedianIncome < 122567.5,Tree_197_Node_26,Tree_197_Node_27);
        Tree_197_Node_29 := IF ( le.p_v1_CrtRecCnt < 31.5,101,102);
        Tree_197_Node_17 := IF ( le.p_CurrAddrMedianValue < 109374.5,93,Tree_197_Node_29);
        Tree_197_Node_10 := IF ( le.p_LienFiledCount < 9.5,Tree_197_Node_16,Tree_197_Node_17);
        Tree_197_Node_52 := IF ( le.p_PrevAddrBurglaryIndex < 139.5,123,124);
        Tree_197_Node_53 := IF ( le.p_CurrAddrCarTheftIndex < 19.5,125,126);
        Tree_197_Node_30 := IF ( le.p_CurrAddrMedianValue < 120441.5,Tree_197_Node_52,Tree_197_Node_53);
        Tree_197_Node_54 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 148.5,127,128);
        Tree_197_Node_55 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 5.0,129,130);
        Tree_197_Node_31 := IF ( le.p_DivSSNIdentityMSourceUrelCount < 1.5,Tree_197_Node_54,Tree_197_Node_55);
        Tree_197_Node_18 := IF ( le.p_CurrAddrAVMValue60 < 137091.5,Tree_197_Node_30,Tree_197_Node_31);
        Tree_197_Node_57 := IF ( le.p_PrevAddrCarTheftIndex < 97.0,131,132);
        Tree_197_Node_32 := IF ( le.p_SSNIssueState < 16.5,103,Tree_197_Node_57);
        Tree_197_Node_58 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 2.5,133,134);
        Tree_197_Node_33 := IF ( le.p_PhoneOtherAgeNewestRecord < 73.5,Tree_197_Node_58,104);
        Tree_197_Node_19 := IF ( le.p_AssocSuspicousIdentitiesCount < 1.5,Tree_197_Node_32,Tree_197_Node_33);
        Tree_197_Node_11 := IF ( le.p_v1_PropTimeLastSale < 1.5,Tree_197_Node_18,Tree_197_Node_19);
        Tree_197_Node_5 := IF ( le.p_CurrAddrTractIndex < 0.8321094,Tree_197_Node_10,Tree_197_Node_11);
        Tree_197_Node_2 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 5.5,Tree_197_Node_4,Tree_197_Node_5);
        Tree_197_Node_3 := IF ( le.p_LastNameChangeAge < 220.5,90,91);
        Tree_197_Node_1 := IF ( le.p_PrevAddrMurderIndex < 199.5,Tree_197_Node_2,Tree_197_Node_3);
    UNSIGNED2 Score1_Tree197_node := Tree_197_Node_1;
    REAL8 Score1_Tree197_score := CASE(Score1_Tree197_node,128=>0.022736974,129=>0.008358461,130=>0.026757048,131=>-0.0152965775,132=>0.009453415,133=>-0.014567146,134=>-0.0042843805,90=>-0.0020266199,91=>-0.015924307,92=>0.0022659635,93=>0.015653696,94=>0.005576064,95=>0.003468594,96=>0.0061954656,97=>-0.012160475,98=>-0.0153450165,99=>0.013536508,100=>-0.0020163725,101=>-0.015728783,102=>0.0099313315,103=>0.023868987,104=>6.9907826E-4,105=>5.9763108E-5,106=>0.0013145478,107=>-8.1469433E-4,108=>0.0033152683,109=>0.009628476,110=>0.021139983,111=>-0.015761979,112=>0.012160337,113=>-0.004798581,114=>0.007897089,115=>0.0014796582,116=>0.019347802,117=>-0.01504756,118=>-0.014876345,119=>7.695905E-4,120=>-0.007232851,121=>0.0038223902,122=>-0.004018532,123=>0.008625296,124=>-0.0044065393,125=>0.017727846,126=>-0.008901324,127=>0.002714944,0);
ENDMACRO;
