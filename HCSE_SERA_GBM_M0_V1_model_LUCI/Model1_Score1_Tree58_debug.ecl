﻿EXPORT Model1_Score1_Tree58_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_58_Node_40 := IF ( le.p_PrevAddrCrimeIndex < 120.5,109,110);
        Tree_58_Node_26 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 284.5,Tree_58_Node_40,103);
        Tree_58_Node_42 := IF ( le.p_SubjectAddrCount < 16.5,111,112);
        Tree_58_Node_27 := IF ( le.p_v1_RaACrtRecMmbrCnt < 19.0,Tree_58_Node_42,104);
        Tree_58_Node_16 := IF ( le.p_RelativesBankruptcyCount < 6.5,Tree_58_Node_26,Tree_58_Node_27);
        Tree_58_Node_44 := IF ( le.p_age_in_years < 42.066,113,114);
        Tree_58_Node_28 := IF ( le.p_BP_2 < 4.5,Tree_58_Node_44,105);
        Tree_58_Node_17 := IF ( le.p_AddrChangeCount60 < 6.5,Tree_58_Node_28,100);
        Tree_58_Node_8 := IF ( le.p_EvictionAge < 47.5,Tree_58_Node_16,Tree_58_Node_17);
        Tree_58_Node_46 := IF ( le.p_CurrAddrMedianIncome < 56969.5,115,116);
        Tree_58_Node_47 := IF ( le.p_PropAgeOldestPurchase < 480.0,117,118);
        Tree_58_Node_30 := IF ( le.p_CurrAddrMedianIncome < 75958.5,Tree_58_Node_46,Tree_58_Node_47);
        Tree_58_Node_48 := IF ( le.p_v1_HHPPCurrOwnedCnt < 5.5,119,120);
        Tree_58_Node_49 := IF ( le.p_age_in_years < 21.16,121,122);
        Tree_58_Node_31 := IF ( le.p_PrevAddrMedianValue < 31411.5,Tree_58_Node_48,Tree_58_Node_49);
        Tree_58_Node_18 := IF ( le.p_PrevAddrDwellType < 0.0,Tree_58_Node_30,Tree_58_Node_31);
        Tree_58_Node_50 := IF ( le.p_CurrAddrCrimeIndex < 130.5,123,124);
        Tree_58_Node_51 := IF ( le.p_v1_HHPropCurrAVMHighest < 55945.5,125,126);
        Tree_58_Node_32 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 1.5,Tree_58_Node_50,Tree_58_Node_51);
        Tree_58_Node_52 := IF ( le.p_PrevAddrBurglaryIndex < 99.5,127,128);
        Tree_58_Node_53 := IF ( le.p_v1_ProspectTimeLastUpdate < 511.5,129,130);
        Tree_58_Node_33 := IF ( le.p_v1_RaAPropOwnerAVMMed < 64809.5,Tree_58_Node_52,Tree_58_Node_53);
        Tree_58_Node_19 := IF ( le.p_PrevAddrAgeNewestRecord < 104.5,Tree_58_Node_32,Tree_58_Node_33);
        Tree_58_Node_9 := IF ( le.p_PropAgeNewestPurchase < 504.5,Tree_58_Node_18,Tree_58_Node_19);
        Tree_58_Node_4 := IF ( le.p_BPV_4 < -2.733195,Tree_58_Node_8,Tree_58_Node_9);
        Tree_58_Node_54 := IF ( le.p_DerogSeverityIndex < 1.0,131,132);
        Tree_58_Node_55 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,133,134);
        Tree_58_Node_34 := IF ( le.p_age_in_years < 56.979374,Tree_58_Node_54,Tree_58_Node_55);
        Tree_58_Node_35 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.25,106,107);
        Tree_58_Node_20 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 208599.5,Tree_58_Node_34,Tree_58_Node_35);
        Tree_58_Node_10 := IF ( le.p_SubjectLastNameCount < 4.5,Tree_58_Node_20,97);
        Tree_58_Node_5 := IF ( le.p_age_in_years < 86.37891,Tree_58_Node_10,94);
        Tree_58_Node_2 := IF ( le.p_PrevAddrAgeLastSale < 561.0,Tree_58_Node_4,Tree_58_Node_5);
        Tree_58_Node_58 := IF ( le.p_PrevAddrCrimeIndex < 9.5,135,136);
        Tree_58_Node_59 := IF ( le.p_BPV_4 < -2.172975,137,138);
        Tree_58_Node_36 := IF ( le.p_PropAgeNewestPurchase < 134.0,Tree_58_Node_58,Tree_58_Node_59);
        Tree_58_Node_22 := IF ( le.p_AddrChangeCount24 < 1.5,Tree_58_Node_36,101);
        Tree_58_Node_61 := IF ( le.p_PhoneOtherAgeOldestRecord < 122.5,139,140);
        Tree_58_Node_38 := IF ( le.p_v1_ProspectTimeOnRecord < 502.0,108,Tree_58_Node_61);
        Tree_58_Node_23 := IF ( le.p_age_in_years < 88.02563,Tree_58_Node_38,102);
        Tree_58_Node_12 := IF ( le.p_v1_ProspectTimeLastUpdate < 150.5,Tree_58_Node_22,Tree_58_Node_23);
        Tree_58_Node_13 := IF ( le.p_CurrAddrMedianValue < 242186.5,98,99);
        Tree_58_Node_6 := IF ( le.p_PrevAddrAgeNewestRecord < 125.5,Tree_58_Node_12,Tree_58_Node_13);
        Tree_58_Node_7 := IF ( le.p_v1_ProspectTimeLastUpdate < 97.5,95,96);
        Tree_58_Node_3 := IF ( le.p_PropAgeNewestPurchase < 675.0,Tree_58_Node_6,Tree_58_Node_7);
        Tree_58_Node_1 := IF ( le.p_PrevAddrAgeOldestRecord < 506.5,Tree_58_Node_2,Tree_58_Node_3);
    SELF.Score1_Tree58_node := Tree_58_Node_1;
    SELF.Score1_Tree58_score := CASE(SELF.Score1_Tree58_node,128=>0.074148774,129=>-0.022996819,130=>0.06806307,131=>-0.02082776,132=>-0.06422371,133=>-0.06629356,134=>-0.06411464,135=>0.035954397,136=>-0.033593405,137=>0.024789909,138=>-0.017713625,139=>-0.06367215,140=>-0.0091604,94=>0.037408452,95=>0.0028671166,96=>0.06738473,97=>0.0076606697,98=>-0.06414595,99=>-0.041321266,100=>0.06609412,101=>0.047113594,102=>0.08132038,103=>0.063626684,104=>-0.003410902,105=>0.014139447,106=>0.018469082,107=>-0.06415614,108=>0.04637744,109=>-0.0020200016,110=>-0.00944446,111=>0.044990547,112=>0.10030586,113=>-0.025468556,114=>-0.048823915,115=>0.003401136,116=>0.02111764,117=>-0.01081851,118=>0.050993085,119=>-0.013040196,120=>0.039186794,121=>0.056635085,122=>0.0010658428,123=>-0.050233547,124=>-0.013115113,125=>-0.029417017,126=>-9.08793E-5,127=>-0.023620585,0);
ENDMACRO;
