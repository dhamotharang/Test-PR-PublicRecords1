﻿EXPORT Model1_Score1_Tree3_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_3_Node_58 := CHOOSE ( le.p_gender,181,180);
        Tree_3_Node_59 := CHOOSE ( le.p_gender,182,183);
        Tree_3_Node_33 := IF ( le.p_age_in_years < 0.14476402,Tree_3_Node_58,Tree_3_Node_59);
        Tree_3_Node_16 := IF ( le.p_age_in_years < 0.035241395,163,Tree_3_Node_33);
        Tree_3_Node_35 := IF ( le.p_age_in_years < 0.50535494,168,169);
        Tree_3_Node_17 := IF ( le.p_age_in_years < 0.43543214,164,Tree_3_Node_35);
        Tree_3_Node_8 := IF ( le.p_age_in_years < 0.3469922,Tree_3_Node_16,Tree_3_Node_17);
        Tree_3_Node_9 := CHOOSE ( le.p_gender,160,161);
        Tree_3_Node_4 := IF ( le.p_SSNLowIssueAge < 27.5,Tree_3_Node_8,Tree_3_Node_9);
        Tree_3_Node_62 := CHOOSE ( le.p_gender,184,185);
        Tree_3_Node_36 := IF ( le.p_PrevAddrMedianValue < 124999.5,Tree_3_Node_62,170);
        Tree_3_Node_37 := IF ( le.p_PrevAddrLenOfRes < 73.0,171,172);
        Tree_3_Node_20 := IF ( le.p_PrevAddrMedianIncome < 47848.5,Tree_3_Node_36,Tree_3_Node_37);
        Tree_3_Node_10 := IF ( le.p_SSNHighIssueAge < 773.5,Tree_3_Node_20,162);
        Tree_3_Node_66 := IF ( le.p_DerogAge < 115.5,186,187);
        Tree_3_Node_38 := IF ( le.p_PrevAddrBurglaryIndex < 179.5,Tree_3_Node_66,173);
        Tree_3_Node_22 := IF ( le.p_CurrAddrCountyIndex < 3.099375,Tree_3_Node_38,165);
        Tree_3_Node_68 := IF ( le.p_AddrChangeCount60 < 1.5,188,189);
        Tree_3_Node_40 := IF ( le.p_PhoneEDAAgeOldestRecord < 142.5,Tree_3_Node_68,174);
        Tree_3_Node_71 := IF ( le.p_DerogSeverityIndex < 0.5,190,191);
        Tree_3_Node_41 := IF ( le.p_PrevAddrMedianValue < 124999.5,175,Tree_3_Node_71);
        Tree_3_Node_23 := IF ( le.p_VariationDOBCount < 1.5,Tree_3_Node_40,Tree_3_Node_41);
        Tree_3_Node_11 := IF ( le.p_PrevAddrAgeLastSale < 79.5,Tree_3_Node_22,Tree_3_Node_23);
        Tree_3_Node_5 := IF ( le.p_CurrAddrMedianIncome < 38191.5,Tree_3_Node_10,Tree_3_Node_11);
        Tree_3_Node_2 := IF ( le.p_age_in_years < 0.63984376,Tree_3_Node_4,Tree_3_Node_5);
        Tree_3_Node_72 := IF ( le.p_ArrestCount24 < 0.5,192,193);
        Tree_3_Node_73 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 2.5,194,195);
        Tree_3_Node_42 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt12Mo < 0.5,Tree_3_Node_72,Tree_3_Node_73);
        Tree_3_Node_24 := IF ( le.p_BPV_3 < 3.0532923,Tree_3_Node_42,166);
        Tree_3_Node_74 := IF ( le.p_NonDerogCount < 8.5,196,197);
        Tree_3_Node_75 := IF ( le.p_EstimatedAnnualIncome < 34200.5,198,199);
        Tree_3_Node_44 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,Tree_3_Node_74,Tree_3_Node_75);
        Tree_3_Node_76 := IF ( le.p_CurrAddrBlockIndex < 1.352,200,201);
        Tree_3_Node_77 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 239.5,202,203);
        Tree_3_Node_45 := IF ( le.p_EstimatedAnnualIncome < 30875.5,Tree_3_Node_76,Tree_3_Node_77);
        Tree_3_Node_25 := IF ( le.p_BPV_3 < 2.1759093,Tree_3_Node_44,Tree_3_Node_45);
        Tree_3_Node_12 := IF ( le.p_age_in_years < 44.3625,Tree_3_Node_24,Tree_3_Node_25);
        Tree_3_Node_79 := IF ( le.p_PropAgeNewestSale < 104.5,204,205);
        Tree_3_Node_46 := IF ( le.p_SSNHighIssueAge < 97.5,176,Tree_3_Node_79);
        Tree_3_Node_80 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,206,207);
        Tree_3_Node_81 := IF ( le.p_NonDerogCount < 8.5,208,209);
        Tree_3_Node_47 := IF ( le.p_BPV_3 < 1.9653375,Tree_3_Node_80,Tree_3_Node_81);
        Tree_3_Node_26 := IF ( le.p_age_in_years < 41.749805,Tree_3_Node_46,Tree_3_Node_47);
        Tree_3_Node_82 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 0.5,210,211);
        Tree_3_Node_83 := IF ( le.p_PhoneEDAAgeNewestRecord < 19.5,212,213);
        Tree_3_Node_48 := IF ( le.p_NonDerogCount01 < 4.5,Tree_3_Node_82,Tree_3_Node_83);
        Tree_3_Node_84 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 1.5,214,215);
        Tree_3_Node_85 := IF ( le.p_CurrAddrAVMValue60 < 182614.5,216,217);
        Tree_3_Node_49 := IF ( le.p_v1_RaAPropOwnerAVMMed < 307562.5,Tree_3_Node_84,Tree_3_Node_85);
        Tree_3_Node_27 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_3_Node_48,Tree_3_Node_49);
        Tree_3_Node_13 := IF ( le.p_age_in_years < 74.22188,Tree_3_Node_26,Tree_3_Node_27);
        Tree_3_Node_6 := IF ( le.p_EstimatedAnnualIncome < 38373.0,Tree_3_Node_12,Tree_3_Node_13);
        Tree_3_Node_86 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,218,219);
        Tree_3_Node_87 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 6.5,220,221);
        Tree_3_Node_50 := IF ( le.p_PRSearchOtherCount < 10.5,Tree_3_Node_86,Tree_3_Node_87);
        Tree_3_Node_88 := IF ( le.p_PrevAddrAgeLastSale < 149.5,222,223);
        Tree_3_Node_89 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 1.5,224,225);
        Tree_3_Node_51 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_3_Node_88,Tree_3_Node_89);
        Tree_3_Node_28 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,Tree_3_Node_50,Tree_3_Node_51);
        Tree_3_Node_90 := IF ( le.p_CurrAddrCrimeIndex < 77.0,226,227);
        Tree_3_Node_91 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 62.5,228,229);
        Tree_3_Node_52 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 4.5,Tree_3_Node_90,Tree_3_Node_91);
        Tree_3_Node_92 := IF ( le.p_BPV_3 < 1.984835,230,231);
        Tree_3_Node_53 := IF ( le.p_LastNameChangeAge < 357.5,Tree_3_Node_92,177);
        Tree_3_Node_29 := IF ( le.p_PrevAddrMedianValue < 109374.5,Tree_3_Node_52,Tree_3_Node_53);
        Tree_3_Node_14 := IF ( le.p_BPV_2 < 3.0484464,Tree_3_Node_28,Tree_3_Node_29);
        Tree_3_Node_94 := IF ( le.p_PRSearchLocateCount < 2.5,232,233);
        Tree_3_Node_95 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,234,235);
        Tree_3_Node_54 := IF ( le.p_v1_ProspectAge < 41.5,Tree_3_Node_94,Tree_3_Node_95);
        Tree_3_Node_55 := IF ( le.p_SSNIdentitiesCount < 2.5,178,179);
        Tree_3_Node_30 := IF ( le.p_PrevAddrAgeOldestRecord < 161.5,Tree_3_Node_54,Tree_3_Node_55);
        Tree_3_Node_98 := IF ( le.p_BPV_4 < -0.7853725,236,237);
        Tree_3_Node_99 := IF ( le.p_PhoneEDAAgeOldestRecord < 90.5,238,239);
        Tree_3_Node_57 := IF ( le.p_v1_CrtRecCnt < 18.0,Tree_3_Node_98,Tree_3_Node_99);
        Tree_3_Node_31 := IF ( le.p_PhoneOtherAgeOldestRecord < 3.5,167,Tree_3_Node_57);
        Tree_3_Node_15 := IF ( le.p_BP_2 < 1.5,Tree_3_Node_30,Tree_3_Node_31);
        Tree_3_Node_7 := IF ( le.p_BPV_3 < 2.395255,Tree_3_Node_14,Tree_3_Node_15);
        Tree_3_Node_3 := IF ( le.p_BPV_2 < 1.0100651,Tree_3_Node_6,Tree_3_Node_7);
        Tree_3_Node_1 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.0546875,Tree_3_Node_2,Tree_3_Node_3);
    SELF.Score1_Tree3_node := Tree_3_Node_1;
    SELF.Score1_Tree3_score := CASE(SELF.Score1_Tree3_node,160=>-0.07731571,161=>0.038503792,162=>0.081706904,163=>-0.092659116,164=>0.053426377,165=>0.046873078,166=>0.19429499,167=>0.11604518,168=>-0.108480506,169=>-0.07086577,170=>0.15210499,171=>-0.10880711,172=>-0.07274909,173=>-0.012338425,174=>0.18932395,175=>0.02844679,176=>0.09101941,177=>0.19930871,178=>0.121550165,179=>0.3205283,180=>-0.08420634,181=>-0.037964135,182=>-0.10805103,183=>-0.079178065,184=>-0.03761399,185=>-0.013239931,186=>-0.08880117,187=>-0.0383411,188=>-0.1084946,189=>0.037248075,190=>-0.108331904,191=>-0.06800073,192=>0.0010448599,193=>0.1159149,194=>-0.032051727,195=>0.028362546,196=>0.034661543,197=>0.056330267,198=>0.024189819,199=>4.1965907E-4,200=>0.1404636,201=>0.38099065,202=>0.03507413,203=>0.2763007,204=>-0.053300094,205=>0.019716928,206=>0.011438991,207=>-0.014819359,208=>0.091476016,209=>0.01546545,210=>0.019704998,211=>-0.043109905,212=>-0.034512967,213=>0.05931483,214=>0.054648492,215=>0.1778016,216=>-0.0879148,217=>0.03368696,218=>0.12299666,219=>0.038739823,220=>-0.03206708,221=>0.122829996,222=>0.03509188,223=>0.18775846,224=>0.023234842,225=>-0.05256945,226=>0.31164235,227=>0.14747027,228=>-0.006088623,229=>0.22298251,230=>-0.011121016,231=>0.16857997,232=>0.0014516283,233=>-0.112890385,234=>0.07250067,235=>0.24618675,236=>0.27913556,237=>0.32047614,238=>0.27206707,239=>0.16236085,0);
ENDMACRO;
