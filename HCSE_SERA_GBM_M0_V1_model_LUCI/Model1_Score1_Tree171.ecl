﻿EXPORT Model1_Score1_Tree171(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_171_Node_44 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 1.5,117,118);
        Tree_171_Node_45 := IF ( le.p_v1_HHCollegeAttendedMmbrCnt < 3.5,119,120);
        Tree_171_Node_28 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.25,Tree_171_Node_44,Tree_171_Node_45);
        Tree_171_Node_46 := IF ( le.p_PrevAddrAgeLastSale < 47.5,121,122);
        Tree_171_Node_47 := IF ( le.p_RelativesBankruptcyCount < 1.5,123,124);
        Tree_171_Node_29 := IF ( le.p_DerogAge < 260.5,Tree_171_Node_46,Tree_171_Node_47);
        Tree_171_Node_16 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_171_Node_28,Tree_171_Node_29);
        Tree_171_Node_17 := IF ( le.p_EstimatedAnnualIncome < 38718.5,104,105);
        Tree_171_Node_8 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 292.5,Tree_171_Node_16,Tree_171_Node_17);
        Tree_171_Node_9 := IF ( le.p_NonDerogCount01 < 3.5,100,101);
        Tree_171_Node_4 := IF ( le.p_LienFiledAge < 307.5,Tree_171_Node_8,Tree_171_Node_9);
        Tree_171_Node_20 := IF ( le.p_AddrChangeCount60 < 1.5,106,107);
        Tree_171_Node_49 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,125,126);
        Tree_171_Node_34 := IF ( le.p_age_in_years < 46.879375,108,Tree_171_Node_49);
        Tree_171_Node_51 := IF ( le.p_PhoneOtherAgeOldestRecord < 13.5,127,128);
        Tree_171_Node_35 := IF ( le.p_NonDerogCount01 < 2.5,109,Tree_171_Node_51);
        Tree_171_Node_21 := IF ( le.p_SubjectSSNCount < 1.5,Tree_171_Node_34,Tree_171_Node_35);
        Tree_171_Node_10 := IF ( le.p_SSNLowIssueAge < 391.5,Tree_171_Node_20,Tree_171_Node_21);
        Tree_171_Node_11 := IF ( le.p_v1_ProspectTimeLastUpdate < 161.5,102,103);
        Tree_171_Node_5 := IF ( le.p_v1_ProspectTimeLastUpdate < 115.5,Tree_171_Node_10,Tree_171_Node_11);
        Tree_171_Node_2 := IF ( le.p_PhoneEDAAgeNewestRecord < 177.5,Tree_171_Node_4,Tree_171_Node_5);
        Tree_171_Node_52 := IF ( le.p_NonDerogCount < 10.5,129,130);
        Tree_171_Node_53 := IF ( le.p_AssocSuspicousIdentitiesCount < 3.5,131,132);
        Tree_171_Node_36 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 6.5,Tree_171_Node_52,Tree_171_Node_53);
        Tree_171_Node_54 := IF ( le.p_SSNLowIssueAge < 455.5,133,134);
        Tree_171_Node_37 := IF ( le.p_NonDerogCount06 < 4.5,Tree_171_Node_54,110);
        Tree_171_Node_24 := IF ( le.p_SearchSSNSearchCount < 12.5,Tree_171_Node_36,Tree_171_Node_37);
        Tree_171_Node_56 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,135,136);
        Tree_171_Node_38 := IF ( le.p_NonDerogCount60 < 6.5,Tree_171_Node_56,111);
        Tree_171_Node_58 := IF ( le.p_CurrAddrBurglaryIndex < 181.5,137,138);
        Tree_171_Node_39 := IF ( le.p_CurrAddrTaxMarketValue < 821187.5,Tree_171_Node_58,112);
        Tree_171_Node_25 := IF ( le.p_v1_HHPropCurrOwnedCnt < 0.5,Tree_171_Node_38,Tree_171_Node_39);
        Tree_171_Node_12 := IF ( le.p_CurrAddrBurglaryIndex < 152.5,Tree_171_Node_24,Tree_171_Node_25);
        Tree_171_Node_6 := IF ( le.p_v1_PropSoldRatio < 16.96875,Tree_171_Node_12,98);
        Tree_171_Node_60 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 1.5,139,140);
        Tree_171_Node_40 := IF ( le.p_PropAgeNewestPurchase < 243.5,Tree_171_Node_60,113);
        Tree_171_Node_63 := IF ( le.p_PRSearchOtherCount < 3.5,141,142);
        Tree_171_Node_41 := IF ( le.p_RelativesCount < 8.5,114,Tree_171_Node_63);
        Tree_171_Node_26 := IF ( le.p_PrevAddrMedianValue < 175423.5,Tree_171_Node_40,Tree_171_Node_41);
        Tree_171_Node_42 := IF ( le.p_v1_RaASeniorMmbrCnt < 1.5,115,116);
        Tree_171_Node_66 := IF ( le.p_LienFiledAge < 82.5,143,144);
        Tree_171_Node_67 := IF ( le.p_PrevAddrMedianValue < 144703.5,145,146);
        Tree_171_Node_43 := IF ( le.p_CurrAddrMedianIncome < 50851.5,Tree_171_Node_66,Tree_171_Node_67);
        Tree_171_Node_27 := IF ( le.p_PrevAddrCarTheftIndex < 49.5,Tree_171_Node_42,Tree_171_Node_43);
        Tree_171_Node_14 := IF ( le.p_SSNIdentitiesCount < 2.5,Tree_171_Node_26,Tree_171_Node_27);
        Tree_171_Node_7 := IF ( le.p_LienFiledAge < 223.0,Tree_171_Node_14,99);
        Tree_171_Node_3 := IF ( le.p_PhoneEDAAgeNewestRecord < 133.5,Tree_171_Node_6,Tree_171_Node_7);
        Tree_171_Node_1 := IF ( le.p_PhoneOtherAgeNewestRecord < 62.5,Tree_171_Node_2,Tree_171_Node_3);
    UNSIGNED2 Score1_Tree171_node := Tree_171_Node_1;
    REAL8 Score1_Tree171_score := CASE(Score1_Tree171_node,98=>0.023325067,99=>0.023427146,100=>-0.0064183134,101=>0.028389318,102=>0.026961133,103=>-0.014841837,104=>-0.020929202,105=>-2.9920918E-4,106=>0.014770946,107=>-0.01992331,108=>-0.015176967,109=>0.0075354297,110=>0.004080467,111=>0.021602903,112=>0.02616317,113=>0.00951239,114=>-0.012961225,115=>-0.017006202,116=>0.012697259,117=>-0.0012884156,118=>0.0086096795,119=>4.185289E-4,120=>0.015708948,121=>-4.4755198E-4,122=>-0.005728113,123=>0.0032018172,124=>0.023636678,125=>-0.020546092,126=>-0.020137371,127=>-0.0164367,128=>0.0020642518,129=>-7.058154E-4,130=>0.007634857,131=>0.023458907,132=>-0.0034035544,133=>-0.014822008,134=>-0.020626293,135=>0.001157878,136=>-0.009394991,137=>-0.008185356,138=>-0.0014551374,139=>-0.0128847435,140=>-0.0022174884,141=>0.03060649,142=>0.0013519728,143=>-0.0035611934,144=>0.015970951,145=>0.03875549,146=>0.0117750075,0);
ENDMACRO;
