﻿EXPORT Model1_Score1_Tree137(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_137_Node_60 := IF ( le.p_v1_HHEstimatedIncomeRange < 2.5,179,180);
        Tree_137_Node_61 := IF ( le.p_SSNLowIssueAge < 768.5,181,182);
        Tree_137_Node_32 := IF ( le.p_EstimatedAnnualIncome < 38718.5,Tree_137_Node_60,Tree_137_Node_61);
        Tree_137_Node_62 := IF ( le.p_NonDerogCount06 < 3.5,183,184);
        Tree_137_Node_63 := IF ( le.p_StatusMostRecent < 2.5,185,186);
        Tree_137_Node_33 := IF ( le.p_v1_CrtRecCnt12Mo < 0.5,Tree_137_Node_62,Tree_137_Node_63);
        Tree_137_Node_16 := IF ( le.p_SearchVelocityRiskLevel < 7.5,Tree_137_Node_32,Tree_137_Node_33);
        Tree_137_Node_64 := IF ( le.p_v1_HHCnt < 1.5,187,188);
        Tree_137_Node_65 := IF ( le.p_SubjectAddrCount < 27.5,189,190);
        Tree_137_Node_34 := IF ( le.p_PropOwnedHistoricalCount < 1.5,Tree_137_Node_64,Tree_137_Node_65);
        Tree_137_Node_66 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,191,192);
        Tree_137_Node_35 := IF ( le.p_RelativesCount < 23.5,Tree_137_Node_66,168);
        Tree_137_Node_17 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 1.5,Tree_137_Node_34,Tree_137_Node_35);
        Tree_137_Node_8 := IF ( le.p_AddrChangeCount60 < 4.5,Tree_137_Node_16,Tree_137_Node_17);
        Tree_137_Node_68 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,193,194);
        Tree_137_Node_69 := IF ( le.p_LastNameChangeAge < 382.5,195,196);
        Tree_137_Node_36 := IF ( le.p_PrevAddrLenOfRes < 97.5,Tree_137_Node_68,Tree_137_Node_69);
        Tree_137_Node_37 := IF ( le.p_EstimatedAnnualIncome < 34061.5,169,170);
        Tree_137_Node_18 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_137_Node_36,Tree_137_Node_37);
        Tree_137_Node_73 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 2.5,197,198);
        Tree_137_Node_38 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,171,Tree_137_Node_73);
        Tree_137_Node_19 := IF ( le.p_PrevAddrBurglaryIndex < 170.5,Tree_137_Node_38,160);
        Tree_137_Node_9 := IF ( le.p_PhoneEDAAgeNewestRecord < 7.5,Tree_137_Node_18,Tree_137_Node_19);
        Tree_137_Node_4 := IF ( le.p_LienFiledAge < 279.0,Tree_137_Node_8,Tree_137_Node_9);
        Tree_137_Node_74 := IF ( le.p_AccidentAge < 34.5,199,200);
        Tree_137_Node_75 := IF ( le.p_SrcsConfirmIDAddrCount < 8.5,201,202);
        Tree_137_Node_40 := IF ( le.p_v1_ProspectTimeOnRecord < 280.5,Tree_137_Node_74,Tree_137_Node_75);
        Tree_137_Node_76 := IF ( le.p_RelativesFelonyCount < 0.5,203,204);
        Tree_137_Node_77 := IF ( le.p_LienReleasedAge < 157.5,205,206);
        Tree_137_Node_41 := IF ( le.p_PhoneEDAAgeOldestRecord < 111.5,Tree_137_Node_76,Tree_137_Node_77);
        Tree_137_Node_20 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.71875,Tree_137_Node_40,Tree_137_Node_41);
        Tree_137_Node_78 := IF ( le.p_SubjectSSNCount < 1.5,207,208);
        Tree_137_Node_79 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 0.5,209,210);
        Tree_137_Node_43 := IF ( le.p_AddrChangeCount60 < 1.5,Tree_137_Node_78,Tree_137_Node_79);
        Tree_137_Node_21 := IF ( le.p_BPV_4 < -2.4898672,161,Tree_137_Node_43);
        Tree_137_Node_10 := IF ( le.p_LastNameChangeAge < 392.5,Tree_137_Node_20,Tree_137_Node_21);
        Tree_137_Node_80 := IF ( le.p_RelativesBankruptcyCount < 2.5,211,212);
        Tree_137_Node_81 := IF ( le.p_NonDerogCount12 < 5.5,213,214);
        Tree_137_Node_44 := IF ( le.p_NonDerogCount06 < 3.5,Tree_137_Node_80,Tree_137_Node_81);
        Tree_137_Node_82 := IF ( le.p_CurrAddrTractIndex < 0.965,215,216);
        Tree_137_Node_83 := IF ( le.p_v1_HHEstimatedIncomeRange < 4.5,217,218);
        Tree_137_Node_45 := IF ( le.p_PrevAddrMurderIndex < 99.5,Tree_137_Node_82,Tree_137_Node_83);
        Tree_137_Node_22 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 194.5,Tree_137_Node_44,Tree_137_Node_45);
        Tree_137_Node_23 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,162,163);
        Tree_137_Node_11 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 277.5,Tree_137_Node_22,Tree_137_Node_23);
        Tree_137_Node_5 := IF ( le.p_CurrAddrAgeLastSale < 87.5,Tree_137_Node_10,Tree_137_Node_11);
        Tree_137_Node_2 := IF ( le.p_PRSearchLocateCount < 4.5,Tree_137_Node_4,Tree_137_Node_5);
        Tree_137_Node_84 := IF ( le.p_PrevAddrAgeNewestRecord < 34.5,219,220);
        Tree_137_Node_85 := IF ( le.p_LienFiledCount < 1.5,221,222);
        Tree_137_Node_48 := IF ( le.p_v1_RaASeniorMmbrCnt < 5.5,Tree_137_Node_84,Tree_137_Node_85);
        Tree_137_Node_87 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 5.5,223,224);
        Tree_137_Node_49 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,172,Tree_137_Node_87);
        Tree_137_Node_24 := IF ( le.p_BPV_3 < 2.807625,Tree_137_Node_48,Tree_137_Node_49);
        Tree_137_Node_12 := IF ( le.p_CurrAddrTractIndex < 2.049375,Tree_137_Node_24,158);
        Tree_137_Node_88 := IF ( le.p_CurrAddrAVMValue12 < 215677.5,225,226);
        Tree_137_Node_89 := IF ( le.p_SSNLowIssueAge < 651.5,227,228);
        Tree_137_Node_50 := IF ( le.p_CurrAddrAgeOldestRecord < 153.5,Tree_137_Node_88,Tree_137_Node_89);
        Tree_137_Node_90 := IF ( le.p_CurrAddrLenOfRes < 164.5,229,230);
        Tree_137_Node_51 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 4.5,Tree_137_Node_90,173);
        Tree_137_Node_26 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 1.5,Tree_137_Node_50,Tree_137_Node_51);
        Tree_137_Node_93 := IF ( le.p_EstimatedAnnualIncome < 49700.5,231,232);
        Tree_137_Node_52 := IF ( le.p_RelativesPropOwnedTaxTotal < 290228.5,174,Tree_137_Node_93);
        Tree_137_Node_53 := IF ( le.p_PropAgeNewestSale < 77.5,175,176);
        Tree_137_Node_27 := IF ( le.p_PrevAddrMedianValue < 167853.5,Tree_137_Node_52,Tree_137_Node_53);
        Tree_137_Node_13 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_137_Node_26,Tree_137_Node_27);
        Tree_137_Node_6 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_137_Node_12,Tree_137_Node_13);
        Tree_137_Node_96 := IF ( le.p_AssocSuspicousIdentitiesCount < 1.5,233,234);
        Tree_137_Node_55 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 1.5,Tree_137_Node_96,177);
        Tree_137_Node_28 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 0.5,164,Tree_137_Node_55);
        Tree_137_Node_98 := IF ( le.p_PrevAddrAgeLastSale < 382.5,235,236);
        Tree_137_Node_57 := IF ( le.p_v1_HHPPCurrOwnedCnt < 3.5,Tree_137_Node_98,178);
        Tree_137_Node_29 := IF ( le.p_SrcsConfirmIDAddrCount < 1.5,165,Tree_137_Node_57);
        Tree_137_Node_14 := IF ( le.p_PrevAddrCarTheftIndex < 39.5,Tree_137_Node_28,Tree_137_Node_29);
        Tree_137_Node_30 := IF ( le.p_EstimatedAnnualIncome < 30109.5,166,167);
        Tree_137_Node_15 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,Tree_137_Node_30,159);
        Tree_137_Node_7 := IF ( le.p_PrevAddrLenOfRes < 274.5,Tree_137_Node_14,Tree_137_Node_15);
        Tree_137_Node_3 := IF ( le.p_PrevAddrAgeLastSale < 135.0,Tree_137_Node_6,Tree_137_Node_7);
        Tree_137_Node_1 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 142.5,Tree_137_Node_2,Tree_137_Node_3);
    UNSIGNED2 Score1_Tree137_node := Tree_137_Node_1;
    REAL8 Score1_Tree137_score := CASE(Score1_Tree137_node,158=>-0.029302811,159=>0.02294442,160=>-0.0049283127,161=>0.058741465,162=>-0.029356565,163=>-0.0077965404,164=>0.014882091,165=>0.0121191,166=>0.0070154713,167=>-0.022874082,168=>-0.012546752,169=>-0.01847942,170=>0.039835945,171=>-0.029806525,172=>-0.0033191494,173=>0.04057132,174=>-4.1946894E-4,175=>-0.028624397,176=>0.014108907,177=>-0.029080663,178=>-0.0051849806,179=>-7.040218E-4,180=>0.0014638349,181=>-0.0018265524,182=>0.0015819009,183=>0.03051595,184=>0.005574024,185=>-9.17318E-4,186=>-0.028291099,187=>-0.0036903557,188=>-0.013352142,189=>0.0014134692,190=>0.037725285,191=>0.011037012,192=>0.05032314,193=>0.028624078,194=>-0.009452031,195=>-0.023825794,196=>0.0049305004,197=>-0.028796604,198=>-0.01445846,199=>-6.146159E-4,200=>0.017481811,201=>0.012532479,202=>0.0526721,203=>0.008313698,204=>-0.0058548995,205=>-0.0069015473,206=>0.011691443,207=>0.0050376174,208=>-0.025062433,209=>0.036063287,210=>0.0022395665,211=>0.004519212,212=>0.0186413,213=>-0.0020736158,214=>0.011749274,215=>0.01892649,216=>0.06776483,217=>-0.012953291,218=>0.021029167,219=>-0.0041190106,220=>0.00301932,221=>0.02991712,222=>-0.020060457,223=>0.0059910663,224=>0.027630823,225=>-0.0076654903,226=>0.023625132,227=>-0.01865478,228=>-0.028894521,229=>-0.01680789,230=>0.020425925,231=>0.045833103,232=>0.015818158,233=>-0.015001589,234=>0.011513141,235=>-0.026176563,236=>-0.0051705595,0);
ENDMACRO;
