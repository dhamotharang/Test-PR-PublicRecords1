EXPORT Model1_Score1_Tree110(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_110_Node_44 := IF ( le.p_SubjectLastNameCount < 8.5,134,135);
        Tree_110_Node_45 := IF ( le.p_v1_ProspectAge < 32.5,136,137);
        Tree_110_Node_26 := IF ( le.p_EvictionAge < 88.5,Tree_110_Node_44,Tree_110_Node_45);
        Tree_110_Node_47 := IF ( le.p_SearchVelocityRiskLevel < 1.5,138,139);
        Tree_110_Node_27 := IF ( le.p_age_in_years < 44.3625,127,Tree_110_Node_47);
        Tree_110_Node_14 := IF ( le.p_VariationDOBCount < 5.5,Tree_110_Node_26,Tree_110_Node_27);
        Tree_110_Node_48 := IF ( le.p_LastNameChangeAge < 278.5,140,141);
        Tree_110_Node_49 := IF ( le.p_CurrAddrMedianIncome < 65449.5,142,143);
        Tree_110_Node_28 := IF ( le.p_SSNIssueState < 32.5,Tree_110_Node_48,Tree_110_Node_49);
        Tree_110_Node_15 := IF ( le.p_DerogAge < 195.0,Tree_110_Node_28,124);
        Tree_110_Node_8 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 312499.5,Tree_110_Node_14,Tree_110_Node_15);
        Tree_110_Node_50 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 336305.5,144,145);
        Tree_110_Node_51 := IF ( le.p_SSNLowIssueAge < 672.5,146,147);
        Tree_110_Node_30 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 83563.5,Tree_110_Node_50,Tree_110_Node_51);
        Tree_110_Node_52 := IF ( le.p_PRSearchOtherCount < 7.5,148,149);
        Tree_110_Node_31 := IF ( le.p_v1_HHCrtRecMmbrCnt < 3.5,Tree_110_Node_52,128);
        Tree_110_Node_16 := IF ( le.p_LienFiledCount < 9.5,Tree_110_Node_30,Tree_110_Node_31);
        Tree_110_Node_54 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 0.5,150,151);
        Tree_110_Node_55 := IF ( le.p_CurrAddrBurglaryIndex < 19.5,152,153);
        Tree_110_Node_32 := IF ( le.p_CurrAddrCarTheftIndex < 9.5,Tree_110_Node_54,Tree_110_Node_55);
        Tree_110_Node_17 := IF ( le.p_AccidentAge < 359.5,Tree_110_Node_32,125);
        Tree_110_Node_9 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 2.5,Tree_110_Node_16,Tree_110_Node_17);
        Tree_110_Node_4 := IF ( le.p_v1_HHCnt < 2.5,Tree_110_Node_8,Tree_110_Node_9);
        Tree_110_Node_56 := IF ( le.p_SearchVelocityRiskLevel < 1.5,154,155);
        Tree_110_Node_57 := IF ( le.p_SubjectPhoneCount < 0.5,156,157);
        Tree_110_Node_34 := IF ( le.p_CurrAddrCountyIndex < 0.73125,Tree_110_Node_56,Tree_110_Node_57);
        Tree_110_Node_58 := IF ( le.p_v1_HHCrtRecMmbrCnt < 5.5,158,159);
        Tree_110_Node_59 := IF ( le.p_PrevAddrMurderIndex < 59.5,160,161);
        Tree_110_Node_35 := IF ( le.p_EstimatedAnnualIncome < 29062.5,Tree_110_Node_58,Tree_110_Node_59);
        Tree_110_Node_18 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt12Mo < 1.5,Tree_110_Node_34,Tree_110_Node_35);
        Tree_110_Node_60 := IF ( le.p_SSNHighIssueAge < 533.5,162,163);
        Tree_110_Node_61 := IF ( le.p_CurrAddrAVMValue12 < 79644.5,164,165);
        Tree_110_Node_36 := IF ( le.p_SSNHighIssueAge < 592.5,Tree_110_Node_60,Tree_110_Node_61);
        Tree_110_Node_62 := IF ( le.p_CurrAddrMedianValue < 122435.5,166,167);
        Tree_110_Node_63 := IF ( le.p_LienFiledAge < 88.5,168,169);
        Tree_110_Node_37 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,Tree_110_Node_62,Tree_110_Node_63);
        Tree_110_Node_19 := IF ( le.p_SearchVelocityRiskLevel < 3.5,Tree_110_Node_36,Tree_110_Node_37);
        Tree_110_Node_10 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 5.5,Tree_110_Node_18,Tree_110_Node_19);
        Tree_110_Node_11 := IF ( le.p_SSNHighIssueAge < 564.0,121,122);
        Tree_110_Node_5 := IF ( le.p_VariationDOBCount < 4.5,Tree_110_Node_10,Tree_110_Node_11);
        Tree_110_Node_2 := IF ( le.p_v1_HHCrtRecMmbrCnt < 4.5,Tree_110_Node_4,Tree_110_Node_5);
        Tree_110_Node_64 := IF ( le.p_DivSSNAddrMSourceCount < 5.5,170,171);
        Tree_110_Node_38 := IF ( le.p_PrevAddrMedianIncome < 140030.5,Tree_110_Node_64,129);
        Tree_110_Node_66 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 0.5,172,173);
        Tree_110_Node_39 := IF ( le.p_CurrAddrMedianIncome < 70014.5,Tree_110_Node_66,130);
        Tree_110_Node_22 := IF ( le.p_CurrAddrAgeOldestRecord < 577.5,Tree_110_Node_38,Tree_110_Node_39);
        Tree_110_Node_12 := IF ( le.p_SrcsConfirmIDAddrCount < 12.5,Tree_110_Node_22,123);
        Tree_110_Node_40 := IF ( le.p_CurrAddrBlockIndex < 0.868125,131,132);
        Tree_110_Node_70 := IF ( le.p_CurrAddrTaxMarketValue < 28194.5,174,175);
        Tree_110_Node_71 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 1.5,176,177);
        Tree_110_Node_41 := IF ( le.p_v1_ProspectTimeOnRecord < 268.5,Tree_110_Node_70,Tree_110_Node_71);
        Tree_110_Node_24 := IF ( le.p_PrevAddrMedianIncome < 31813.5,Tree_110_Node_40,Tree_110_Node_41);
        Tree_110_Node_72 := IF ( le.p_PRSearchOtherCount < 5.5,178,179);
        Tree_110_Node_42 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 3.5,Tree_110_Node_72,133);
        Tree_110_Node_25 := IF ( le.p_CurrAddrAgeOldestRecord < 542.5,Tree_110_Node_42,126);
        Tree_110_Node_13 := IF ( le.p_EstimatedAnnualIncome < 33242.5,Tree_110_Node_24,Tree_110_Node_25);
        Tree_110_Node_6 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,Tree_110_Node_12,Tree_110_Node_13);
        Tree_110_Node_3 := IF ( le.p_SSNIssueState < 50.5,Tree_110_Node_6,120);
        Tree_110_Node_1 := IF ( le.p_PrevAddrAgeNewestRecord < 163.5,Tree_110_Node_2,Tree_110_Node_3);
    UNSIGNED2 Score1_Tree110_node := Tree_110_Node_1;
    REAL8 Score1_Tree110_score := CASE(Score1_Tree110_node,120=>0.034275673,121=>-0.015056992,122=>0.054279283,123=>0.028453965,124=>0.04563893,125=>0.041379567,126=>0.033865843,127=>0.032319758,128=>0.018082328,129=>0.027880348,130=>0.03614191,131=>-0.0021324581,132=>-0.038513117,133=>0.05042816,134=>-3.686022E-4,135=>0.009594569,136=>-0.026035188,137=>-0.0029385628,138=>0.0018704387,139=>-0.036048867,140=>-0.01825018,141=>0.014566897,142=>0.04560186,143=>-0.006253297,144=>0.004101959,145=>0.016471079,146=>-0.038640823,147=>-0.006609654,148=>-0.033181008,149=>-0.008739946,150=>-0.0065688863,151=>0.010620508,152=>0.008840908,153=>2.0705382E-4,154=>-0.038211707,155=>0.0013860215,156=>-0.033679105,157=>-0.0038384653,158=>0.060518283,159=>0.003782416,160=>0.025888871,161=>-0.013702244,162=>-0.038353387,163=>0.0045507606,164=>-0.04229732,165=>-0.03852322,166=>-0.038166214,167=>-0.012769693,168=>-0.019178227,169=>0.0343535,170=>-0.009145616,171=>-0.02948076,172=>0.014353549,173=>-0.026897931,174=>0.063852206,175=>0.009464723,176=>-0.013073793,177=>0.022440359,178=>-0.010946042,179=>0.033753525,0);
ENDMACRO;
