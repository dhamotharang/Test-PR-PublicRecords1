﻿EXPORT Model1_Score1_Tree177(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_177_Node_38 := IF ( le.p_LastNameChangeAge < 365.5,105,106);
        Tree_177_Node_39 := IF ( le.p_DerogAge < 285.5,107,108);
        Tree_177_Node_24 := IF ( le.p_LastNameChangeAge < 384.5,Tree_177_Node_38,Tree_177_Node_39);
        Tree_177_Node_40 := IF ( le.p_v1_HHCnt < 6.5,109,110);
        Tree_177_Node_25 := IF ( le.p_NonDerogCount01 < 5.5,Tree_177_Node_40,103);
        Tree_177_Node_14 := IF ( le.p_EstimatedAnnualIncome < 91266.5,Tree_177_Node_24,Tree_177_Node_25);
        Tree_177_Node_42 := IF ( le.p_PrevAddrLenOfRes < 209.5,111,112);
        Tree_177_Node_43 := IF ( le.p_v1_RaACrtRecMmbrCnt < 6.5,113,114);
        Tree_177_Node_26 := IF ( le.p_CurrAddrBlockIndex < 1.29,Tree_177_Node_42,Tree_177_Node_43);
        Tree_177_Node_44 := IF ( le.p_PhoneEDAAgeOldestRecord < 163.0,115,116);
        Tree_177_Node_45 := IF ( le.p_SubjectAddrCount < 2.5,117,118);
        Tree_177_Node_27 := IF ( le.p_NonDerogCount24 < 3.5,Tree_177_Node_44,Tree_177_Node_45);
        Tree_177_Node_15 := IF ( le.p_NonDerogCount60 < 5.5,Tree_177_Node_26,Tree_177_Node_27);
        Tree_177_Node_8 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 116.5,Tree_177_Node_14,Tree_177_Node_15);
        Tree_177_Node_16 := IF ( le.p_v1_CrtRecTimeNewest < 49.5,99,100);
        Tree_177_Node_46 := IF ( le.p_v1_ProspectTimeLastUpdate < 120.0,119,120);
        Tree_177_Node_47 := IF ( le.p_NonDerogCount12 < 4.5,121,122);
        Tree_177_Node_30 := IF ( le.p_SubjectSSNCount < 1.5,Tree_177_Node_46,Tree_177_Node_47);
        Tree_177_Node_49 := IF ( le.p_v1_ProspectTimeOnRecord < 197.0,123,124);
        Tree_177_Node_31 := IF ( le.p_PrevAddrMedianValue < 102833.5,104,Tree_177_Node_49);
        Tree_177_Node_17 := IF ( le.p_SourceRiskLevel < 4.5,Tree_177_Node_30,Tree_177_Node_31);
        Tree_177_Node_9 := IF ( le.p_SSNIssueState < 22.5,Tree_177_Node_16,Tree_177_Node_17);
        Tree_177_Node_4 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 186.5,Tree_177_Node_8,Tree_177_Node_9);
        Tree_177_Node_2 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 203.0,Tree_177_Node_4,94);
        Tree_177_Node_50 := IF ( le.p_v1_RaAHHCnt < 4.5,125,126);
        Tree_177_Node_51 := IF ( le.p_PrevAddrMedianValue < 138990.5,127,128);
        Tree_177_Node_32 := IF ( le.p_SSNLowIssueAge < 672.5,Tree_177_Node_50,Tree_177_Node_51);
        Tree_177_Node_52 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 207090.5,129,130);
        Tree_177_Node_53 := IF ( le.p_PrevAddrLenOfRes < 416.0,131,132);
        Tree_177_Node_33 := IF ( le.p_PrevAddrBurglaryIndex < 79.5,Tree_177_Node_52,Tree_177_Node_53);
        Tree_177_Node_18 := IF ( le.p_NonDerogCount60 < 4.5,Tree_177_Node_32,Tree_177_Node_33);
        Tree_177_Node_54 := IF ( le.p_v1_RaACrtRecMmbrCnt < 4.5,133,134);
        Tree_177_Node_55 := IF ( le.p_SSNIssueState < 49.5,135,136);
        Tree_177_Node_34 := IF ( le.p_PrevAddrAgeLastSale < 76.5,Tree_177_Node_54,Tree_177_Node_55);
        Tree_177_Node_56 := IF ( le.p_BPV_3 < 2.01474,137,138);
        Tree_177_Node_57 := IF ( le.p_CurrAddrCrimeIndex < 175.5,139,140);
        Tree_177_Node_35 := IF ( le.p_v1_PropSoldRatio < 3.09375,Tree_177_Node_56,Tree_177_Node_57);
        Tree_177_Node_19 := IF ( le.p_CurrAddrCrimeIndex < 100.0,Tree_177_Node_34,Tree_177_Node_35);
        Tree_177_Node_10 := IF ( le.p_v1_RaAPropOwnerAVMMed < 122519.5,Tree_177_Node_18,Tree_177_Node_19);
        Tree_177_Node_11 := IF ( le.p_PhoneEDAAgeNewestRecord < 7.5,96,97);
        Tree_177_Node_6 := IF ( le.p_PrevAddrMedianIncome < 173626.5,Tree_177_Node_10,Tree_177_Node_11);
        Tree_177_Node_22 := IF ( le.p_PhoneOtherAgeNewestRecord < 6.5,101,102);
        Tree_177_Node_12 := IF ( le.p_PrevAddrAgeNewestRecord < 14.5,Tree_177_Node_22,98);
        Tree_177_Node_7 := IF ( le.p_v1_CrtRecMsdmeanCnt < 6.0,Tree_177_Node_12,95);
        Tree_177_Node_3 := IF ( le.p_PrevAddrAgeLastSale < 331.0,Tree_177_Node_6,Tree_177_Node_7);
        Tree_177_Node_1 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 203.5,Tree_177_Node_2,Tree_177_Node_3);
    UNSIGNED2 Score1_Tree177_node := Tree_177_Node_1;
    REAL8 Score1_Tree177_score := CASE(Score1_Tree177_node,128=>-0.015985353,129=>0.006036567,130=>0.03631198,131=>-0.0018650764,132=>0.011753998,133=>-0.006421298,134=>4.544412E-4,135=>0.002130149,136=>0.031362962,137=>-0.008100932,138=>0.0036974037,139=>-0.0015645211,140=>0.022018524,94=>0.015148621,95=>0.03245855,96=>-8.01086E-4,97=>0.028070172,98=>0.02241059,99=>-0.0085387165,100=>0.018474113,101=>-0.0013298371,102=>-0.017448805,103=>0.011392392,104=>0.016791098,105=>4.4070457E-5,106=>0.0029047518,107=>-0.0010495421,108=>0.009111671,109=>-0.008883374,110=>0.008391009,111=>-0.0066204406,112=>0.002093329,113=>0.0031132575,114=>0.022381993,115=>0.011265779,116=>0.034928467,117=>0.023678688,118=>0.0032837968,119=>-0.018541489,120=>-0.00840881,121=>-0.019278096,122=>0.0045028515,123=>0.009825891,124=>-0.012471288,125=>0.00801571,126=>-0.013118936,127=>-0.019672476,0);
ENDMACRO;
