﻿EXPORT Model1_Score1_Tree18(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_18_Node_44 := IF ( le.p_age_in_years < 0.7555847,126,127);
        Tree_18_Node_45 := IF ( le.p_age_in_years < 1.3993616,128,129);
        Tree_18_Node_26 := IF ( le.p_age_in_years < 1.0074463,Tree_18_Node_44,Tree_18_Node_45);
        Tree_18_Node_46 := IF ( le.p_PhoneEDAAgeOldestRecord < 132.5,130,131);
        Tree_18_Node_47 := IF ( le.p_NonDerogCount01 < 1.5,132,133);
        Tree_18_Node_27 := IF ( le.p_BP_4 < 37.5,Tree_18_Node_46,Tree_18_Node_47);
        Tree_18_Node_14 := IF ( le.p_age_in_years < 1.5351562,Tree_18_Node_26,Tree_18_Node_27);
        Tree_18_Node_8 := IF ( le.p_v1_ProspectTimeLastUpdate < 33.5,Tree_18_Node_14,113);
        Tree_18_Node_17 := IF ( le.p_DerogAge < 70.5,116,117);
        Tree_18_Node_9 := IF ( le.p_NonDerogCount < 7.5,114,Tree_18_Node_17);
        Tree_18_Node_4 := IF ( le.p_v1_RaAMedIncomeRange < 4.5,Tree_18_Node_8,Tree_18_Node_9);
        Tree_18_Node_2 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 59330.5,Tree_18_Node_4,112);
        Tree_18_Node_48 := IF ( le.p_age_in_years < 92.82,134,135);
        Tree_18_Node_49 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 8.5,136,137);
        Tree_18_Node_30 := IF ( le.p_AddrChangeCount60 < 4.5,Tree_18_Node_48,Tree_18_Node_49);
        Tree_18_Node_18 := IF ( le.p_BPV_3 < 3.7551985,Tree_18_Node_30,118);
        Tree_18_Node_32 := IF ( le.p_v1_CrtRecLienJudgCnt < 1.5,121,122);
        Tree_18_Node_19 := IF ( le.p_FelonyCount < 6.5,Tree_18_Node_32,119);
        Tree_18_Node_10 := IF ( le.p_BP_1 < 6.5,Tree_18_Node_18,Tree_18_Node_19);
        Tree_18_Node_34 := IF ( le.p_CurrAddrAVMValue60 < 40904.5,123,124);
        Tree_18_Node_54 := IF ( le.p_CurrAddrMurderIndex < 109.5,138,139);
        Tree_18_Node_55 := CHOOSE ( le.p_gender,140,141);
        Tree_18_Node_35 := IF ( le.p_v1_ProspectTimeLastUpdate < 10.5,Tree_18_Node_54,Tree_18_Node_55);
        Tree_18_Node_20 := IF ( le.p_age_in_years < 28.55125,Tree_18_Node_34,Tree_18_Node_35);
        Tree_18_Node_56 := IF ( le.p_CurrAddrCrimeIndex < 79.5,142,143);
        Tree_18_Node_57 := IF ( le.p_CurrAddrAgeLastSale < 85.5,144,145);
        Tree_18_Node_36 := IF ( le.p_DivSSNIdentityMSourceCount < 2.5,Tree_18_Node_56,Tree_18_Node_57);
        Tree_18_Node_58 := IF ( le.p_PropOwnedHistoricalCount < 0.5,146,147);
        Tree_18_Node_59 := IF ( le.p_NonDerogCount06 < 2.5,148,149);
        Tree_18_Node_37 := IF ( le.p_SearchUnverifiedSSNCountYear < 0.5,Tree_18_Node_58,Tree_18_Node_59);
        Tree_18_Node_21 := IF ( le.p_RecentActivityIndex < 2.5,Tree_18_Node_36,Tree_18_Node_37);
        Tree_18_Node_11 := IF ( le.p_PrevAddrCarTheftIndex < 79.5,Tree_18_Node_20,Tree_18_Node_21);
        Tree_18_Node_6 := IF ( le.p_BPV_2 < 2.5607285,Tree_18_Node_10,Tree_18_Node_11);
        Tree_18_Node_60 := IF ( le.p_SubjectAddrCount < 12.0,150,151);
        Tree_18_Node_61 := IF ( le.p_BP_4 < 8.5,152,153);
        Tree_18_Node_38 := IF ( le.p_PhoneEDAAgeNewestRecord < 29.5,Tree_18_Node_60,Tree_18_Node_61);
        Tree_18_Node_62 := IF ( le.p_v1_HHEstimatedIncomeRange < 5.5,154,155);
        Tree_18_Node_63 := IF ( le.p_RelativesPropOwnedCount < 1.5,156,157);
        Tree_18_Node_39 := IF ( le.p_PrevAddrAgeNewestRecord < 126.5,Tree_18_Node_62,Tree_18_Node_63);
        Tree_18_Node_22 := IF ( le.p_NonDerogCount01 < 4.5,Tree_18_Node_38,Tree_18_Node_39);
        Tree_18_Node_12 := IF ( le.p_VariationMSourcesSSNUnrelCount < 4.5,Tree_18_Node_22,115);
        Tree_18_Node_64 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 31.5,158,159);
        Tree_18_Node_65 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,160,161);
        Tree_18_Node_41 := IF ( le.p_BPV_2 < 3.0349374,Tree_18_Node_64,Tree_18_Node_65);
        Tree_18_Node_24 := IF ( le.p_age_in_years < 20.785913,120,Tree_18_Node_41);
        Tree_18_Node_66 := IF ( le.p_PhoneEDAAgeNewestRecord < 80.5,162,163);
        Tree_18_Node_67 := IF ( le.p_v1_HHEstimatedIncomeRange < 7.5,164,165);
        Tree_18_Node_42 := CHOOSE ( le.p_gender,Tree_18_Node_66,Tree_18_Node_67);
        Tree_18_Node_68 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,166,167);
        Tree_18_Node_43 := IF ( le.p_v1_RaASeniorMmbrCnt < 2.5,Tree_18_Node_68,125);
        Tree_18_Node_25 := IF ( le.p_LienFiledAge < 179.5,Tree_18_Node_42,Tree_18_Node_43);
        Tree_18_Node_13 := IF ( le.p_age_in_years < 73.90547,Tree_18_Node_24,Tree_18_Node_25);
        Tree_18_Node_7 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.0560547,Tree_18_Node_12,Tree_18_Node_13);
        Tree_18_Node_3 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_18_Node_6,Tree_18_Node_7);
        Tree_18_Node_1 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.09375,Tree_18_Node_2,Tree_18_Node_3);
    UNSIGNED2 Score1_Tree18_node := Tree_18_Node_1;
    REAL8 Score1_Tree18_score := CASE(Score1_Tree18_node,112=>0.083784,113=>0.074260384,114=>-0.05698844,115=>0.12053881,116=>-0.09667132,117=>-0.09976554,118=>0.091777936,119=>0.012321858,120=>0.17943168,121=>0.06766793,122=>0.12238113,123=>-0.0912946,124=>-0.02171821,125=>0.18389769,126=>-0.05271276,127=>0.038797174,128=>-0.08950229,129=>-0.05305736,130=>-0.051004525,131=>-0.0049167266,132=>-6.8795186E-4,133=>0.1150486,134=>0.009019344,135=>-0.02148785,136=>-0.0171741,137=>0.12692691,138=>0.011830907,139=>0.07742794,140=>-0.056190845,141=>0.031165687,142=>-0.042438217,143=>0.05713247,144=>0.149506,145=>-0.0013783051,146=>-0.030821377,147=>0.060414657,148=>0.12433819,149=>-0.011189487,150=>0.0048313434,151=>0.025457054,152=>0.004879604,153=>-0.023711521,154=>-0.04233749,155=>0.02406019,156=>-0.037621282,157=>0.12690814,158=>-0.00926439,159=>0.1135537,160=>0.07055346,161=>-0.0188556,162=>-0.007873927,163=>0.033896647,164=>0.011457647,165=>-0.05105005,166=>-0.011923137,167=>0.12875888,0);
ENDMACRO;
