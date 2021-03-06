EXPORT Model1_Score1_Tree4(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_4_Node_54 := CHOOSE ( le.p_gender,156,155);
        Tree_4_Node_55 := IF ( le.p_age_in_years < 0.275715,157,158);
        Tree_4_Node_33 := IF ( le.p_age_in_years < 0.1971444,Tree_4_Node_54,Tree_4_Node_55);
        Tree_4_Node_16 := IF ( le.p_age_in_years < 0.035241395,140,Tree_4_Node_33);
        Tree_4_Node_35 := IF ( le.p_age_in_years < 0.50535494,145,146);
        Tree_4_Node_17 := IF ( le.p_age_in_years < 0.43543214,141,Tree_4_Node_35);
        Tree_4_Node_8 := IF ( le.p_age_in_years < 0.3469922,Tree_4_Node_16,Tree_4_Node_17);
        Tree_4_Node_9 := CHOOSE ( le.p_gender,135,136);
        Tree_4_Node_4 := IF ( le.p_SSNLowIssueAge < 27.5,Tree_4_Node_8,Tree_4_Node_9);
        Tree_4_Node_57 := IF ( le.p_CurrAddrCrimeIndex < 180.5,159,160);
        Tree_4_Node_36 := IF ( le.p_PhoneEDAAgeNewestRecord < 79.5,Tree_4_Node_57,147);
        Tree_4_Node_59 := IF ( le.p_BPV_4 < -2.7980676,161,162);
        Tree_4_Node_37 := IF ( le.p_CurrAddrBlockIndex < 1.596875,Tree_4_Node_59,148);
        Tree_4_Node_20 := IF ( le.p_VariationDOBCount < 2.5,Tree_4_Node_36,Tree_4_Node_37);
        Tree_4_Node_10 := IF ( le.p_SubjectLastNameCount < 7.5,Tree_4_Node_20,137);
        Tree_4_Node_61 := IF ( le.p_PRSearchLocateCount < 8.5,163,164);
        Tree_4_Node_38 := IF ( le.p_CurrAddrCrimeIndex < 180.5,Tree_4_Node_61,149);
        Tree_4_Node_63 := IF ( le.p_age_in_years < 41.267,165,166);
        Tree_4_Node_39 := IF ( le.p_AccidentAge < 33.5,Tree_4_Node_63,150);
        Tree_4_Node_22 := IF ( le.p_CurrAddrBlockIndex < 0.850625,Tree_4_Node_38,Tree_4_Node_39);
        Tree_4_Node_11 := IF ( le.p_PrevAddrLenOfRes < 340.5,Tree_4_Node_22,138);
        Tree_4_Node_5 := IF ( le.p_RelativesBankruptcyCount < 0.5,Tree_4_Node_10,Tree_4_Node_11);
        Tree_4_Node_2 := IF ( le.p_age_in_years < 0.63984376,Tree_4_Node_4,Tree_4_Node_5);
        Tree_4_Node_65 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt12Mo < 0.5,167,168);
        Tree_4_Node_66 := IF ( le.p_PropOwnedHistoricalCount < 3.5,169,170);
        Tree_4_Node_40 := IF ( le.p_NonDerogCount24 < 3.5,Tree_4_Node_65,Tree_4_Node_66);
        Tree_4_Node_41 := IF ( le.p_PrevAddrDwellType < 4.0,151,152);
        Tree_4_Node_24 := IF ( le.p_BPV_3 < 2.597053,Tree_4_Node_40,Tree_4_Node_41);
        Tree_4_Node_69 := IF ( le.p_CurrAddrCrimeIndex < 79.5,171,172);
        Tree_4_Node_70 := IF ( le.p_EstimatedAnnualIncome < 26650.5,173,174);
        Tree_4_Node_42 := IF ( le.p_DivSSNAddrMSourceCount < 1.5,Tree_4_Node_69,Tree_4_Node_70);
        Tree_4_Node_71 := IF ( le.p_v1_RaACrtRecMmbrCnt < 7.5,175,176);
        Tree_4_Node_72 := IF ( le.p_DerogSeverityIndex < 2.5,177,178);
        Tree_4_Node_43 := IF ( le.p_BP_3 < 2.5,Tree_4_Node_71,Tree_4_Node_72);
        Tree_4_Node_25 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_4_Node_42,Tree_4_Node_43);
        Tree_4_Node_12 := IF ( le.p_SSNHighIssueAge < 451.0,Tree_4_Node_24,Tree_4_Node_25);
        Tree_4_Node_73 := IF ( le.p_SSNHighIssueAge < 631.5,179,180);
        Tree_4_Node_74 := IF ( le.p_v1_RaASeniorMmbrCnt < 6.5,181,182);
        Tree_4_Node_44 := IF ( le.p_CurrAddrCarTheftIndex < 89.5,Tree_4_Node_73,Tree_4_Node_74);
        Tree_4_Node_75 := IF ( le.p_CurrAddrBurglaryIndex < 160.5,183,184);
        Tree_4_Node_76 := IF ( le.p_DerogAge < 262.5,185,186);
        Tree_4_Node_45 := IF ( le.p_PrevAddrMedianIncome < 23903.5,Tree_4_Node_75,Tree_4_Node_76);
        Tree_4_Node_26 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_4_Node_44,Tree_4_Node_45);
        Tree_4_Node_78 := IF ( le.p_CurrAddrCountyIndex < 0.761,187,188);
        Tree_4_Node_46 := IF ( le.p_VariationMSourcesSSNUnrelCount < 0.5,153,Tree_4_Node_78);
        Tree_4_Node_27 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt12Mo < 1.5,Tree_4_Node_46,142);
        Tree_4_Node_13 := IF ( le.p_BPV_3 < 2.0706234,Tree_4_Node_26,Tree_4_Node_27);
        Tree_4_Node_6 := IF ( le.p_EstimatedAnnualIncome < 41484.5,Tree_4_Node_12,Tree_4_Node_13);
        Tree_4_Node_79 := IF ( le.p_SearchVelocityRiskLevel < 2.5,189,190);
        Tree_4_Node_80 := IF ( le.p_CurrAddrBurglaryIndex < 180.5,191,192);
        Tree_4_Node_48 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,Tree_4_Node_79,Tree_4_Node_80);
        Tree_4_Node_81 := IF ( le.p_RelativesPropOwnedCount < 0.5,193,194);
        Tree_4_Node_82 := IF ( le.p_v1_HHPPCurrOwnedCnt < 1.5,195,196);
        Tree_4_Node_49 := IF ( le.p_RelativesCount < 10.5,Tree_4_Node_81,Tree_4_Node_82);
        Tree_4_Node_28 := IF ( le.p_BPV_2 < 3.10389,Tree_4_Node_48,Tree_4_Node_49);
        Tree_4_Node_14 := IF ( le.p_BP_2 < 6.5,Tree_4_Node_28,139);
        Tree_4_Node_83 := IF ( le.p_NonDerogCount < 9.5,197,198);
        Tree_4_Node_50 := IF ( le.p_BPV_3 < 3.0386844,Tree_4_Node_83,154);
        Tree_4_Node_30 := IF ( le.p_PrevAddrMedianValue < 263385.5,Tree_4_Node_50,143);
        Tree_4_Node_85 := IF ( le.p_BPV_4 < -0.7853725,199,200);
        Tree_4_Node_86 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 9.5,201,202);
        Tree_4_Node_53 := IF ( le.p_v1_CrtRecCnt < 18.0,Tree_4_Node_85,Tree_4_Node_86);
        Tree_4_Node_31 := IF ( le.p_PhoneOtherAgeOldestRecord < 3.5,144,Tree_4_Node_53);
        Tree_4_Node_15 := IF ( le.p_BP_2 < 1.5,Tree_4_Node_30,Tree_4_Node_31);
        Tree_4_Node_7 := IF ( le.p_BPV_3 < 2.395255,Tree_4_Node_14,Tree_4_Node_15);
        Tree_4_Node_3 := IF ( le.p_BP_2 < 0.5,Tree_4_Node_6,Tree_4_Node_7);
        Tree_4_Node_1 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.0546875,Tree_4_Node_2,Tree_4_Node_3);
    UNSIGNED2 Score1_Tree4_node := Tree_4_Node_1;
    REAL8 Score1_Tree4_score := CASE(Score1_Tree4_node,135=>-0.0738569,136=>0.03326123,137=>0.13111748,138=>0.075396754,139=>0.2244344,140=>-0.08980908,141=>0.045499217,142=>0.23804088,143=>0.24936195,144=>0.094583765,145=>-0.10643081,146=>-0.067256875,147=>0.11322607,148=>0.055099405,149=>-0.008684042,150=>0.09243658,151=>-0.0058732387,152=>0.22371244,153=>0.24443625,154=>0.1734945,155=>-0.076683074,156=>-0.04404591,157=>-0.1063973,158=>-0.074297406,159=>-0.025889965,160=>0.058873963,161=>-0.049495954,162=>-0.106375545,163=>-0.103142396,164=>-0.064540215,165=>-0.017885545,166=>-0.09611669,167=>0.017574266,168=>-0.02098819,169=>-0.014775989,170=>0.1290956,171=>0.044328585,172=>-0.005590657,173=>0.06939426,174=>0.038258266,175=>0.010112467,176=>0.032209177,177=>0.28692055,178=>0.020057792,179=>-0.020098966,180=>0.0040591843,181=>0.007888177,182=>0.17593026,183=>-0.014467282,184=>0.27882448,185=>-0.045684837,186=>0.080420114,187=>-0.009944214,188=>0.08207195,189=>0.10123104,190=>0.044611167,191=>0.013407855,192=>0.10529128,193=>-0.0149707,194=>0.20944943,195=>0.12288132,196=>-0.02476462,197=>0.0054758643,198=>0.1981603,199=>0.21208608,200=>0.24718808,201=>0.20376162,202=>0.104418054,0);
ENDMACRO;
