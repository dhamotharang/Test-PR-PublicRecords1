EXPORT Model1_Score1_Tree44(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_44_Node_74 := IF ( le.p_PhoneEDAAgeOldestRecord < 184.5,195,196);
        Tree_44_Node_75 := IF ( le.p_BP_4 < 13.5,197,198);
        Tree_44_Node_42 := CHOOSE ( le.p_readmit_lift,Tree_44_Node_74,Tree_44_Node_74,Tree_44_Node_74,Tree_44_Node_74,Tree_44_Node_74,Tree_44_Node_74,Tree_44_Node_74,Tree_44_Node_74,Tree_44_Node_75,Tree_44_Node_74,Tree_44_Node_75,Tree_44_Node_74,Tree_44_Node_75);
        Tree_44_Node_76 := CHOOSE ( le.p_gender,199,200);
        Tree_44_Node_77 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 0.5,201,202);
        Tree_44_Node_43 := IF ( le.p_BP_3 < 1.5,Tree_44_Node_76,Tree_44_Node_77);
        Tree_44_Node_21 := CHOOSE ( le.p_financial_class,Tree_44_Node_42,Tree_44_Node_42,Tree_44_Node_43,Tree_44_Node_42,Tree_44_Node_42,Tree_44_Node_42,Tree_44_Node_42,Tree_44_Node_43,Tree_44_Node_43,Tree_44_Node_43,Tree_44_Node_43,Tree_44_Node_43,Tree_44_Node_43,Tree_44_Node_43,Tree_44_Node_43,Tree_44_Node_42);
        Tree_44_Node_70 := IF ( le.p_v1_HHCrtRecMmbrCnt < 3.5,189,190);
        Tree_44_Node_71 := IF ( le.p_v1_CrtRecLienJudgCnt < 2.5,191,192);
        Tree_44_Node_40 := CHOOSE ( le.p_financial_class,Tree_44_Node_70,Tree_44_Node_71,Tree_44_Node_71,Tree_44_Node_70,Tree_44_Node_71,Tree_44_Node_71,Tree_44_Node_70,Tree_44_Node_70,Tree_44_Node_70,Tree_44_Node_70,Tree_44_Node_71,Tree_44_Node_71,Tree_44_Node_70,Tree_44_Node_70,Tree_44_Node_70,Tree_44_Node_70);
        Tree_44_Node_72 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 0.5,193,194);
        Tree_44_Node_41 := IF ( le.p_PrevAddrCarTheftIndex < 180.5,Tree_44_Node_72,168);
        Tree_44_Node_20 := IF ( le.p_CurrAddrBurglaryIndex < 190.5,Tree_44_Node_40,Tree_44_Node_41);
        Tree_44_Node_10 := CHOOSE ( le.p_patient_type,Tree_44_Node_21,Tree_44_Node_20);
        Tree_44_Node_81 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 104.5,205,206);
        Tree_44_Node_46 := IF ( le.p_NonDerogCount < 6.5,170,Tree_44_Node_81);
        Tree_44_Node_82 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,207,208);
        Tree_44_Node_47 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 0.5,Tree_44_Node_82,171);
        Tree_44_Node_23 := IF ( le.p_CurrAddrAgeOldestRecord < 351.5,Tree_44_Node_46,Tree_44_Node_47);
        Tree_44_Node_78 := IF ( le.p_v1_HHEstimatedIncomeRange < 5.5,203,204);
        Tree_44_Node_44 := IF ( le.p_v1_ProspectTimeOnRecord < 370.5,Tree_44_Node_78,169);
        Tree_44_Node_22 := IF ( le.p_P_EstimatedHHIncomePerCapita < 3.6875,Tree_44_Node_44,159);
        Tree_44_Node_11 := CHOOSE ( le.p_readmit_diag,Tree_44_Node_23,Tree_44_Node_23,Tree_44_Node_23,Tree_44_Node_23,Tree_44_Node_23,Tree_44_Node_22,Tree_44_Node_22,Tree_44_Node_22,Tree_44_Node_23,Tree_44_Node_23,Tree_44_Node_22,Tree_44_Node_22,Tree_44_Node_23);
        Tree_44_Node_5 := IF ( le.p_NonDerogCount01 < 4.5,Tree_44_Node_10,Tree_44_Node_11);
        Tree_44_Node_58 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 10.5,175,176);
        Tree_44_Node_59 := IF ( le.p_BPV_3 < 0.9528075,177,178);
        Tree_44_Node_32 := IF ( le.p_PrevAddrCarTheftIndex < 69.5,Tree_44_Node_58,Tree_44_Node_59);
        Tree_44_Node_16 := CHOOSE ( le.p_financial_class,Tree_44_Node_32,Tree_44_Node_32,Tree_44_Node_32,157,Tree_44_Node_32,Tree_44_Node_32,Tree_44_Node_32,Tree_44_Node_32,Tree_44_Node_32,157,Tree_44_Node_32,Tree_44_Node_32,Tree_44_Node_32,Tree_44_Node_32,Tree_44_Node_32,157);
        Tree_44_Node_60 := IF ( le.p_v1_PropTimeLastSale < 55.5,179,180);
        Tree_44_Node_61 := IF ( le.p_CurrAddrBurglaryIndex < 179.5,181,182);
        Tree_44_Node_35 := IF ( le.p_PrevAddrAgeOldestRecord < 28.5,Tree_44_Node_60,Tree_44_Node_61);
        Tree_44_Node_17 := IF ( le.p_EstimatedAnnualIncome < 23343.5,158,Tree_44_Node_35);
        Tree_44_Node_8 := IF ( le.p_SSNHighIssueAge < 515.5,Tree_44_Node_16,Tree_44_Node_17);
        Tree_44_Node_62 := IF ( le.p_PrevAddrBurglaryIndex < 140.5,183,184);
        Tree_44_Node_63 := IF ( le.p_PhoneEDAAgeNewestRecord < 60.5,185,186);
        Tree_44_Node_36 := IF ( le.p_PrevAddrCarTheftIndex < 49.5,Tree_44_Node_62,Tree_44_Node_63);
        Tree_44_Node_64 := IF ( le.p_SSNIssueState < 25.5,187,188);
        Tree_44_Node_37 := IF ( le.p_v1_ProspectTimeLastUpdate < 455.5,Tree_44_Node_64,163);
        Tree_44_Node_18 := IF ( le.p_age_in_years < 88.725,Tree_44_Node_36,Tree_44_Node_37);
        Tree_44_Node_38 := IF ( le.p_AgeOldestRecord < 459.5,164,165);
        Tree_44_Node_39 := IF ( le.p_CurrAddrMedianValue < 144234.5,166,167);
        Tree_44_Node_19 := IF ( le.p_PropAgeNewestPurchase < 239.5,Tree_44_Node_38,Tree_44_Node_39);
        Tree_44_Node_9 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 351.5,Tree_44_Node_18,Tree_44_Node_19);
        Tree_44_Node_4 := CHOOSE ( le.p_readmit_diag,Tree_44_Node_8,Tree_44_Node_9,Tree_44_Node_8,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9,Tree_44_Node_9);
        Tree_44_Node_2 := CHOOSE ( le.p_admit_diag,Tree_44_Node_5,Tree_44_Node_5,Tree_44_Node_5,Tree_44_Node_4,Tree_44_Node_5,Tree_44_Node_4,Tree_44_Node_4,Tree_44_Node_4,Tree_44_Node_4,Tree_44_Node_4,Tree_44_Node_4,Tree_44_Node_5,Tree_44_Node_5);
        Tree_44_Node_84 := IF ( le.p_EvictionAge < 110.5,209,210);
        Tree_44_Node_85 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,211,212);
        Tree_44_Node_48 := IF ( le.p_CurrAddrAgeOldestRecord < 285.0,Tree_44_Node_84,Tree_44_Node_85);
        Tree_44_Node_86 := IF ( le.p_SSNIssueState < 31.5,213,214);
        Tree_44_Node_49 := IF ( le.p_NonDerogCount < 8.5,Tree_44_Node_86,172);
        Tree_44_Node_24 := CHOOSE ( le.p_admit_diag,Tree_44_Node_48,Tree_44_Node_48,Tree_44_Node_48,Tree_44_Node_48,Tree_44_Node_48,Tree_44_Node_48,Tree_44_Node_49,Tree_44_Node_49,Tree_44_Node_48,Tree_44_Node_48,Tree_44_Node_48,Tree_44_Node_49,Tree_44_Node_48);
        Tree_44_Node_89 := CHOOSE ( le.p_admit_diag,216,215,215,215,215,216,215,216,215,215,216,215,215);
        Tree_44_Node_50 := IF ( le.p_CurrAddrCountyIndex < 0.21037598,173,Tree_44_Node_89);
        Tree_44_Node_90 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.8,217,218);
        Tree_44_Node_91 := IF ( le.p_RelativesPropOwnedCount < 2.5,219,220);
        Tree_44_Node_51 := IF ( le.p_SSNIssueState < 44.0,Tree_44_Node_90,Tree_44_Node_91);
        Tree_44_Node_25 := IF ( le.p_CurrAddrCountyIndex < 0.46171874,Tree_44_Node_50,Tree_44_Node_51);
        Tree_44_Node_12 := IF ( le.p_CurrAddrBlockIndex < 0.6664063,Tree_44_Node_24,Tree_44_Node_25);
        Tree_44_Node_13 := CHOOSE ( le.p_readmit_diag,155,154,155,154,154,154,155,154,154,154,154,155,154);
        Tree_44_Node_6 := IF ( le.p_PrevAddrBurglaryIndex < 192.5,Tree_44_Node_12,Tree_44_Node_13);
        Tree_44_Node_92 := CHOOSE ( le.p_readmit_lift,221,222,221,221,222,221,221,221,221,222,221,221,221);
        Tree_44_Node_93 := IF ( le.p_PrevAddrMurderIndex < 190.5,223,224);
        Tree_44_Node_52 := IF ( le.p_StatusMostRecent < 2.5,Tree_44_Node_92,Tree_44_Node_93);
        Tree_44_Node_94 := IF ( le.p_v1_ProspectTimeLastUpdate < 24.5,225,226);
        Tree_44_Node_53 := IF ( le.p_v1_RaAMedIncomeRange < 7.5,Tree_44_Node_94,174);
        Tree_44_Node_28 := IF ( le.p_PropOwnedHistoricalCount < 3.5,Tree_44_Node_52,Tree_44_Node_53);
        Tree_44_Node_96 := IF ( le.p_v1_ProspectTimeOnRecord < 196.5,227,228);
        Tree_44_Node_97 := IF ( le.p_VariationDOBCount < 2.5,229,230);
        Tree_44_Node_54 := CHOOSE ( le.p_financial_class,Tree_44_Node_96,Tree_44_Node_97,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_97,Tree_44_Node_97,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96,Tree_44_Node_96);
        Tree_44_Node_29 := IF ( le.p_PropAgeNewestPurchase < 92.5,Tree_44_Node_54,160);
        Tree_44_Node_14 := CHOOSE ( le.p_readmit_diag,Tree_44_Node_28,Tree_44_Node_28,Tree_44_Node_28,Tree_44_Node_28,Tree_44_Node_28,Tree_44_Node_29,Tree_44_Node_28,Tree_44_Node_28,Tree_44_Node_28,Tree_44_Node_28,Tree_44_Node_29,Tree_44_Node_29,Tree_44_Node_29);
        Tree_44_Node_30 := CHOOSE ( le.p_admit_diag,161,162,161,162,161,161,161,161,161,162,161,162,161);
        Tree_44_Node_15 := IF ( le.p_PrevAddrAgeNewestRecord < 2.5,Tree_44_Node_30,156);
        Tree_44_Node_7 := IF ( le.p_v1_HHCnt < 6.5,Tree_44_Node_14,Tree_44_Node_15);
        Tree_44_Node_3 := IF ( le.p_SearchSSNSearchCount < 1.5,Tree_44_Node_6,Tree_44_Node_7);
        Tree_44_Node_1 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_44_Node_2,Tree_44_Node_3);
    UNSIGNED2 Score1_Tree44_node := Tree_44_Node_1;
    REAL8 Score1_Tree44_score := CASE(Score1_Tree44_node,154=>0.022380255,155=>0.17770763,156=>0.16242623,157=>0.11196408,158=>0.07630363,159=>0.010667762,160=>0.1253949,161=>-0.04535508,162=>0.061564796,163=>0.080786295,164=>-0.061177142,165=>0.030666055,166=>-0.07859938,167=>-0.07528474,168=>0.19696124,169=>-0.012155325,170=>0.0729806,171=>0.122984566,172=>0.13425887,173=>0.25158003,174=>0.15228848,175=>-0.020591225,176=>-0.063157834,177=>-0.004478187,178=>0.05917709,179=>-0.023012102,180=>0.09429384,181=>-0.04797099,182=>-0.010603186,183=>-0.0064737257,184=>-0.02033766,185=>0.007660241,186=>-0.006696932,187=>-0.058664355,188=>-0.013428588,189=>-0.03146864,190=>0.05029485,191=>-0.009381141,192=>0.03946349,193=>-0.05787261,194=>0.052638464,195=>-0.003916808,196=>-0.033920817,197=>0.0798174,198=>-0.021536427,199=>6.594352E-4,200=>0.0057825986,201=>0.022076176,202=>-0.027837036,203=>-0.076611504,204=>-0.06449493,205=>-0.007639728,206=>-0.03171938,207=>-0.016817367,208=>0.026007758,209=>-0.006730855,210=>0.075697616,211=>0.0021191551,212=>0.06952544,213=>-0.02745451,214=>0.134428,215=>-0.0348204,216=>0.07934116,217=>-0.057250645,218=>0.021945024,219=>0.14118563,220=>-0.03165699,221=>-0.050827447,222=>-0.022348527,223=>-0.013835207,224=>0.05298335,225=>-0.04953904,226=>0.065828525,227=>-0.061933566,228=>0.018731382,229=>0.099455334,230=>0.0030366476,0);
ENDMACRO;
