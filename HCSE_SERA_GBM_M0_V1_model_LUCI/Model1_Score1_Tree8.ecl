EXPORT Model1_Score1_Tree8(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_8_Node_58 := IF ( le.p_age_in_years < 0.015234375,166,167);
        Tree_8_Node_59 := IF ( le.p_age_in_years < 0.27773437,168,169);
        Tree_8_Node_32 := IF ( le.p_age_in_years < 0.0234375,Tree_8_Node_58,Tree_8_Node_59);
        Tree_8_Node_16 := IF ( le.p_SSNLowIssueAge < 53.5,Tree_8_Node_32,151);
        Tree_8_Node_17 := IF ( le.p_age_in_years < 0.87461877,152,153);
        Tree_8_Node_8 := IF ( le.p_age_in_years < 0.75518674,Tree_8_Node_16,Tree_8_Node_17);
        Tree_8_Node_18 := CHOOSE ( le.p_gender,155,154);
        Tree_8_Node_9 := IF ( le.p_age_in_years < 1.4043074,Tree_8_Node_18,148);
        Tree_8_Node_4 := IF ( le.p_age_in_years < 0.9914246,Tree_8_Node_8,Tree_8_Node_9);
        Tree_8_Node_60 := IF ( le.p_RelativesPropOwnedCount < 3.5,170,171);
        Tree_8_Node_38 := IF ( le.p_AddrChangeCount60 < 2.5,Tree_8_Node_60,160);
        Tree_8_Node_62 := IF ( le.p_PhoneEDAAgeOldestRecord < 122.0,172,173);
        Tree_8_Node_63 := IF ( le.p_RelativesPropOwnedTaxTotal < 129834.5,174,175);
        Tree_8_Node_39 := IF ( le.p_SSNAddrCount < 12.5,Tree_8_Node_62,Tree_8_Node_63);
        Tree_8_Node_20 := IF ( le.p_PrevAddrMurderIndex < 69.5,Tree_8_Node_38,Tree_8_Node_39);
        Tree_8_Node_10 := IF ( le.p_SubjectLastNameCount < 7.5,Tree_8_Node_20,149);
        Tree_8_Node_64 := IF ( le.p_NonDerogCount01 < 2.5,176,177);
        Tree_8_Node_40 := IF ( le.p_CurrAddrCrimeIndex < 180.5,Tree_8_Node_64,161);
        Tree_8_Node_66 := IF ( le.p_PhoneEDAAgeOldestRecord < 132.5,178,179);
        Tree_8_Node_67 := IF ( le.p_CurrAddrTaxMarketValue < 210820.5,180,181);
        Tree_8_Node_41 := IF ( le.p_AgeOldestRecord < 354.0,Tree_8_Node_66,Tree_8_Node_67);
        Tree_8_Node_22 := IF ( le.p_CurrAddrBlockIndex < 0.850625,Tree_8_Node_40,Tree_8_Node_41);
        Tree_8_Node_11 := IF ( le.p_PrevAddrLenOfRes < 340.5,Tree_8_Node_22,150);
        Tree_8_Node_5 := IF ( le.p_RelativesBankruptcyCount < 0.5,Tree_8_Node_10,Tree_8_Node_11);
        Tree_8_Node_2 := IF ( le.p_age_in_years < 1.4929688,Tree_8_Node_4,Tree_8_Node_5);
        Tree_8_Node_68 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 0.5,182,183);
        Tree_8_Node_69 := IF ( le.p_SSNHighIssueAge < 101.5,184,185);
        Tree_8_Node_42 := IF ( le.p_v1_ProspectAge < 59.0,Tree_8_Node_68,Tree_8_Node_69);
        Tree_8_Node_24 := IF ( le.p_v1_HHPPCurrOwnedCnt < 6.5,Tree_8_Node_42,156);
        Tree_8_Node_70 := IF ( le.p_v1_HHPropCurrAVMHighest < 71677.5,186,187);
        Tree_8_Node_71 := IF ( le.p_EstimatedAnnualIncome < 24500.5,188,189);
        Tree_8_Node_44 := IF ( le.p_SSNAddrCount < 4.5,Tree_8_Node_70,Tree_8_Node_71);
        Tree_8_Node_72 := IF ( le.p_PrevAddrCrimeIndex < 139.5,190,191);
        Tree_8_Node_73 := IF ( le.p_LienFiledAge < 15.5,192,193);
        Tree_8_Node_45 := IF ( le.p_EstimatedAnnualIncome < 33907.5,Tree_8_Node_72,Tree_8_Node_73);
        Tree_8_Node_25 := IF ( le.p_BPV_3 < 2.1759093,Tree_8_Node_44,Tree_8_Node_45);
        Tree_8_Node_12 := IF ( le.p_SSNLowIssueAge < 383.5,Tree_8_Node_24,Tree_8_Node_25);
        Tree_8_Node_74 := IF ( le.p_PrevAddrMedianValue < 199999.5,194,195);
        Tree_8_Node_46 := IF ( le.p_BP_1 < 5.5,Tree_8_Node_74,162);
        Tree_8_Node_76 := IF ( le.p_NonDerogCount01 < 3.5,196,197);
        Tree_8_Node_77 := IF ( le.p_CurrAddrMurderIndex < 39.5,198,199);
        Tree_8_Node_47 := IF ( le.p_PRSearchOtherCount < 38.5,Tree_8_Node_76,Tree_8_Node_77);
        Tree_8_Node_26 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_8_Node_46,Tree_8_Node_47);
        Tree_8_Node_78 := IF ( le.p_RelativesPropOwnedTaxTotal < 312919.5,200,201);
        Tree_8_Node_79 := IF ( le.p_DivSSNAddrMSourceCount < 6.5,202,203);
        Tree_8_Node_48 := IF ( le.p_PropAgeOldestPurchase < 512.5,Tree_8_Node_78,Tree_8_Node_79);
        Tree_8_Node_80 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 2.5,204,205);
        Tree_8_Node_49 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 3.5,Tree_8_Node_80,163);
        Tree_8_Node_27 := IF ( le.p_EstimatedAnnualIncome < 42515.5,Tree_8_Node_48,Tree_8_Node_49);
        Tree_8_Node_13 := IF ( le.p_age_in_years < 69.10313,Tree_8_Node_26,Tree_8_Node_27);
        Tree_8_Node_6 := IF ( le.p_EstimatedAnnualIncome < 35607.5,Tree_8_Node_12,Tree_8_Node_13);
        Tree_8_Node_82 := IF ( le.p_CurrAddrMurderIndex < 180.5,206,207);
        Tree_8_Node_83 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 223.5,208,209);
        Tree_8_Node_50 := IF ( le.p_SearchVelocityRiskLevel < 2.5,Tree_8_Node_82,Tree_8_Node_83);
        Tree_8_Node_28 := IF ( le.p_BPV_2 < 4.456708,Tree_8_Node_50,157);
        Tree_8_Node_84 := IF ( le.p_PrevAddrLenOfRes < 17.5,210,211);
        Tree_8_Node_85 := IF ( le.p_SSNLowIssueAge < 335.5,212,213);
        Tree_8_Node_52 := IF ( le.p_PrevAddrLenOfRes < 20.5,Tree_8_Node_84,Tree_8_Node_85);
        Tree_8_Node_86 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 1.5,214,215);
        Tree_8_Node_87 := IF ( le.p_PrevAddrLenOfRes < 123.5,216,217);
        Tree_8_Node_53 := IF ( le.p_v1_LifeEvEverResidedCnt < 3.5,Tree_8_Node_86,Tree_8_Node_87);
        Tree_8_Node_29 := IF ( le.p_NonDerogCount60 < 5.5,Tree_8_Node_52,Tree_8_Node_53);
        Tree_8_Node_14 := IF ( le.p_PhoneOtherAgeNewestRecord < 15.5,Tree_8_Node_28,Tree_8_Node_29);
        Tree_8_Node_88 := IF ( le.p_FelonyCount < 0.5,218,219);
        Tree_8_Node_54 := IF ( le.p_v1_CrtRecLienJudgCnt < 2.5,Tree_8_Node_88,164);
        Tree_8_Node_90 := IF ( le.p_v1_CrtRecCnt < 39.5,220,221);
        Tree_8_Node_55 := IF ( le.p_BP_3 < 10.5,Tree_8_Node_90,165);
        Tree_8_Node_30 := IF ( le.p_PrevAddrMedianValue < 74600.5,Tree_8_Node_54,Tree_8_Node_55);
        Tree_8_Node_31 := IF ( le.p_CurrAddrAgeLastSale < 15.5,158,159);
        Tree_8_Node_15 := IF ( le.p_BPV_2 < 2.9375598,Tree_8_Node_30,Tree_8_Node_31);
        Tree_8_Node_7 := IF ( le.p_BPV_1 < 2.8324845,Tree_8_Node_14,Tree_8_Node_15);
        Tree_8_Node_3 := IF ( le.p_BPV_2 < 1.0100651,Tree_8_Node_6,Tree_8_Node_7);
        Tree_8_Node_1 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.0546875,Tree_8_Node_2,Tree_8_Node_3);
    UNSIGNED2 Score1_Tree8_node := Tree_8_Node_1;
    REAL8 Score1_Tree8_score := CASE(Score1_Tree8_node,148=>-0.06390516,149=>0.08991987,150=>0.058985393,151=>0.007222652,152=>0.09456393,153=>0.0033899092,154=>-0.10234634,155=>-0.10198192,156=>0.13346677,157=>0.109156705,158=>0.1655942,159=>0.090894334,160=>0.11536897,161=>-0.0021135414,162=>0.19585076,163=>0.15179975,164=>0.21244088,165=>0.1170013,166=>-0.07884863,167=>-0.060566153,168=>-0.05778171,169=>-0.031762306,170=>-0.015738672,171=>0.09777436,172=>-0.095460966,173=>-0.040928476,174=>0.06680575,175=>-0.10078769,176=>-0.07585028,177=>-0.10098586,178=>-0.055129837,179=>0.16360961,180=>-0.10084554,181=>-0.101639755,182=>0.008493073,183=>-0.020323122,184=>-0.10381693,185=>0.16367362,186=>-0.0023420316,187=>0.023143487,188=>0.051463436,189=>0.021206276,190=>0.044396635,191=>0.10567818,192=>0.023707727,193=>-0.10654287,194=>0.014058891,195=>-0.0170751,196=>-0.005534059,197=>-0.021660736,198=>0.3045782,199=>-0.016461972,200=>0.011354637,201=>0.042122778,202=>-0.049431857,203=>0.051862095,204=>-0.0022461894,205=>0.15834233,206=>0.022977516,207=>0.12081087,208=>-0.017593248,209=>0.10661399,210=>-0.011512682,211=>0.19404046,212=>0.19094458,213=>0.0812621,214=>0.021596972,215=>0.2031184,216=>-0.1082416,217=>-0.009772231,218=>0.14859293,219=>-0.017491251,220=>0.07614126,221=>-0.0076744216,0);
ENDMACRO;
