﻿EXPORT Model1_Score1_Tree13_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_13_Node_67 := CHOOSE ( le.p_readmit_diag,191,191,191,191,191,191,192,191,191,191,191,192,191);
        Tree_13_Node_66 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.6,189,190);
        Tree_13_Node_38 := CHOOSE ( le.p_admit_diag,Tree_13_Node_67,Tree_13_Node_66,Tree_13_Node_67,Tree_13_Node_66,Tree_13_Node_67,Tree_13_Node_66,Tree_13_Node_66,Tree_13_Node_66,Tree_13_Node_66,Tree_13_Node_66,Tree_13_Node_66,Tree_13_Node_66,Tree_13_Node_66);
        Tree_13_Node_68 := IF ( le.p_PrevAddrCarTheftIndex < 49.5,193,194);
        Tree_13_Node_69 := IF ( le.p_PrevAddrMurderIndex < 89.5,195,196);
        Tree_13_Node_39 := CHOOSE ( le.p_readmit_lift,Tree_13_Node_68,Tree_13_Node_68,Tree_13_Node_68,Tree_13_Node_69,Tree_13_Node_68,Tree_13_Node_68,Tree_13_Node_69,Tree_13_Node_69,Tree_13_Node_68,Tree_13_Node_69,Tree_13_Node_68,Tree_13_Node_68,Tree_13_Node_68);
        Tree_13_Node_20 := IF ( le.p_CurrAddrMedianValue < 78124.5,Tree_13_Node_38,Tree_13_Node_39);
        Tree_13_Node_40 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 0.5,169,170);
        Tree_13_Node_21 := IF ( le.p_v1_RaASeniorMmbrCnt < 0.5,Tree_13_Node_40,163);
        Tree_13_Node_10 := CHOOSE ( le.p_admit_diag,Tree_13_Node_20,Tree_13_Node_21,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20,Tree_13_Node_20);
        Tree_13_Node_42 := IF ( le.p_v1_HHEstimatedIncomeRange < 2.5,171,172);
        Tree_13_Node_22 := IF ( le.p_LastNameChangeAge < 127.5,Tree_13_Node_42,164);
        Tree_13_Node_11 := IF ( le.p_PrevAddrMedianValue < 140624.5,Tree_13_Node_22,159);
        Tree_13_Node_5 := IF ( le.p_BPV_2 < 2.4469182,Tree_13_Node_10,Tree_13_Node_11);
        Tree_13_Node_60 := IF ( le.p_CurrAddrBurglaryIndex < 150.5,179,180);
        Tree_13_Node_32 := CHOOSE ( le.p_financial_class,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,168,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60,Tree_13_Node_60);
        Tree_13_Node_62 := IF ( le.p_DerogAge < 13.5,181,182);
        Tree_13_Node_63 := IF ( le.p_CurrAddrMedianValue < 99999.5,183,184);
        Tree_13_Node_33 := CHOOSE ( le.p_financial_class,Tree_13_Node_62,Tree_13_Node_63,Tree_13_Node_63,Tree_13_Node_63,Tree_13_Node_62,Tree_13_Node_62,Tree_13_Node_62,Tree_13_Node_62,Tree_13_Node_62,Tree_13_Node_62,Tree_13_Node_63,Tree_13_Node_62,Tree_13_Node_63,Tree_13_Node_62,Tree_13_Node_63,Tree_13_Node_62);
        Tree_13_Node_16 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,Tree_13_Node_32,Tree_13_Node_33);
        Tree_13_Node_64 := IF ( le.p_AgeOldestRecord < 165.5,185,186);
        Tree_13_Node_65 := IF ( le.p_age_in_years < 20.594,187,188);
        Tree_13_Node_34 := IF ( le.p_CurrAddrAVMValue12 < 88610.5,Tree_13_Node_64,Tree_13_Node_65);
        Tree_13_Node_17 := IF ( le.p_PrevAddrAgeLastSale < 319.5,Tree_13_Node_34,160);
        Tree_13_Node_8 := IF ( le.p_AssocRiskLevel < 1.5,Tree_13_Node_16,Tree_13_Node_17);
        Tree_13_Node_18 := IF ( le.p_v1_RaAPropOwnerAVMMed < 185928.5,161,162);
        Tree_13_Node_9 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 9.5,Tree_13_Node_18,158);
        Tree_13_Node_4 := IF ( le.p_RelativesBankruptcyCount < 4.5,Tree_13_Node_8,Tree_13_Node_9);
        Tree_13_Node_2 := CHOOSE ( le.p_readmit_diag,Tree_13_Node_5,Tree_13_Node_4,Tree_13_Node_5,Tree_13_Node_4,Tree_13_Node_4,Tree_13_Node_5,Tree_13_Node_5,Tree_13_Node_5,Tree_13_Node_5,Tree_13_Node_4,Tree_13_Node_4,Tree_13_Node_5,Tree_13_Node_5);
        Tree_13_Node_86 := CHOOSE ( le.p_readmit_lift,217,218,217,218,218,218,218,218,217,217,218,217,218);
        Tree_13_Node_87 := IF ( le.p_CurrAddrAgeOldestRecord < 287.5,219,220);
        Tree_13_Node_52 := IF ( le.p_age_in_years < 84.41,Tree_13_Node_86,Tree_13_Node_87);
        Tree_13_Node_28 := IF ( le.p_BPV_3 < 3.7551985,Tree_13_Node_52,167);
        Tree_13_Node_88 := IF ( le.p_NonDerogCount < 5.5,221,222);
        Tree_13_Node_89 := IF ( le.p_PRSearchLocateCount < 5.5,223,224);
        Tree_13_Node_54 := IF ( le.p_age_in_years < 43.565,Tree_13_Node_88,Tree_13_Node_89);
        Tree_13_Node_91 := IF ( le.p_PhoneOtherAgeNewestRecord < 21.5,225,226);
        Tree_13_Node_55 := IF ( le.p_age_in_years < 50.6225,175,Tree_13_Node_91);
        Tree_13_Node_29 := IF ( le.p_BPV_3 < 2.3864813,Tree_13_Node_54,Tree_13_Node_55);
        Tree_13_Node_14 := IF ( le.p_EstimatedAnnualIncome < 38906.5,Tree_13_Node_28,Tree_13_Node_29);
        Tree_13_Node_92 := IF ( le.p_v1_RaAPropOwnerAVMMed < 112549.5,227,228);
        Tree_13_Node_93 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 3.5,229,230);
        Tree_13_Node_56 := IF ( le.p_DerogAge < 32.5,Tree_13_Node_92,Tree_13_Node_93);
        Tree_13_Node_95 := CHOOSE ( le.p_readmit_diag,231,232,232,232,231,231,231,231,232,231,231,231,231);
        Tree_13_Node_57 := IF ( le.p_BP_4 < 3.0,176,Tree_13_Node_95);
        Tree_13_Node_30 := IF ( le.p_DerogAge < 131.5,Tree_13_Node_56,Tree_13_Node_57);
        Tree_13_Node_96 := CHOOSE ( le.p_readmit_diag,233,233,233,234,233,233,234,233,234,233,233,233,234);
        Tree_13_Node_58 := IF ( le.p_PropOwnedHistoricalCount < 1.5,Tree_13_Node_96,177);
        Tree_13_Node_99 := IF ( le.p_PhoneEDAAgeOldestRecord < 131.5,235,236);
        Tree_13_Node_59 := CHOOSE ( le.p_readmit_diag,178,Tree_13_Node_99,Tree_13_Node_99,178,Tree_13_Node_99,Tree_13_Node_99,Tree_13_Node_99,Tree_13_Node_99,178,178,Tree_13_Node_99,178,178);
        Tree_13_Node_31 := IF ( le.p_BP_2 < 0.5,Tree_13_Node_58,Tree_13_Node_59);
        Tree_13_Node_15 := IF ( le.p_v1_RaASeniorMmbrCnt < 1.5,Tree_13_Node_30,Tree_13_Node_31);
        Tree_13_Node_7 := IF ( le.p_BPV_1 < 2.917672,Tree_13_Node_14,Tree_13_Node_15);
        Tree_13_Node_80 := IF ( le.p_BPV_2 < 2.91354,207,208);
        Tree_13_Node_81 := IF ( le.p_v1_HHPropCurrOwnedCnt < 5.5,209,210);
        Tree_13_Node_48 := IF ( le.p_PropAgeNewestSale < 18.5,Tree_13_Node_80,Tree_13_Node_81);
        Tree_13_Node_26 := IF ( le.p_BPV_3 < 3.0532923,Tree_13_Node_48,166);
        Tree_13_Node_82 := IF ( le.p_PrevAddrMedianValue < 452343.5,211,212);
        Tree_13_Node_83 := IF ( le.p_SSNHighIssueAge < 117.5,213,214);
        Tree_13_Node_50 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,Tree_13_Node_82,Tree_13_Node_83);
        Tree_13_Node_85 := IF ( le.p_NonDerogCount12 < 3.5,215,216);
        Tree_13_Node_51 := IF ( le.p_RelativesCount < 10.5,174,Tree_13_Node_85);
        Tree_13_Node_27 := IF ( le.p_BPV_2 < 3.110811,Tree_13_Node_50,Tree_13_Node_51);
        Tree_13_Node_13 := IF ( le.p_EstimatedAnnualIncome < 34570.5,Tree_13_Node_26,Tree_13_Node_27);
        Tree_13_Node_74 := IF ( le.p_EstimatedAnnualIncome < 26550.5,197,198);
        Tree_13_Node_75 := IF ( le.p_StatusMostRecent < 2.5,199,200);
        Tree_13_Node_44 := CHOOSE ( le.p_admit_diag,Tree_13_Node_74,Tree_13_Node_74,Tree_13_Node_74,Tree_13_Node_74,Tree_13_Node_75,Tree_13_Node_74,Tree_13_Node_74,Tree_13_Node_75,Tree_13_Node_74,Tree_13_Node_74,Tree_13_Node_74,Tree_13_Node_74,Tree_13_Node_75);
        Tree_13_Node_77 := IF ( le.p_v1_HHEstimatedIncomeRange < 5.5,201,202);
        Tree_13_Node_45 := CHOOSE ( le.p_financial_class,173,Tree_13_Node_77,Tree_13_Node_77,173,173,173,173,173,Tree_13_Node_77,173,Tree_13_Node_77,Tree_13_Node_77,173,173,173,173);
        Tree_13_Node_24 := CHOOSE ( le.p_admit_diag,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_45,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44,Tree_13_Node_44);
        Tree_13_Node_79 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,205,206);
        Tree_13_Node_78 := IF ( le.p_v1_ProspectTimeOnRecord < 480.0,203,204);
        Tree_13_Node_46 := CHOOSE ( le.p_financial_class,Tree_13_Node_79,Tree_13_Node_78,Tree_13_Node_78,Tree_13_Node_78,Tree_13_Node_78,Tree_13_Node_79,Tree_13_Node_78,Tree_13_Node_78,Tree_13_Node_79,Tree_13_Node_78,Tree_13_Node_78,Tree_13_Node_78,Tree_13_Node_78,Tree_13_Node_79,Tree_13_Node_78,Tree_13_Node_78);
        Tree_13_Node_25 := IF ( le.p_BP_3 < 2.5,Tree_13_Node_46,165);
        Tree_13_Node_12 := CHOOSE ( le.p_readmit_diag,Tree_13_Node_24,Tree_13_Node_25,Tree_13_Node_24,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25,Tree_13_Node_25);
        Tree_13_Node_6 := CHOOSE ( le.p_admit_diag,Tree_13_Node_13,Tree_13_Node_13,Tree_13_Node_12,Tree_13_Node_13,Tree_13_Node_12,Tree_13_Node_12,Tree_13_Node_12,Tree_13_Node_12,Tree_13_Node_13,Tree_13_Node_13,Tree_13_Node_12,Tree_13_Node_13,Tree_13_Node_12);
        Tree_13_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_13_Node_7,Tree_13_Node_6,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7,Tree_13_Node_7);
        Tree_13_Node_1 := IF ( le.p_age_in_years < 29.432812,Tree_13_Node_2,Tree_13_Node_3);
    SELF.Score1_Tree13_node := Tree_13_Node_1;
    SELF.Score1_Tree13_score := CASE(SELF.Score1_Tree13_node,158=>0.16935825,159=>-0.079855785,160=>0.08439235,161=>-0.073279776,162=>0.07311064,163=>-0.037773088,164=>0.16381668,165=>0.09541694,166=>0.14465939,167=>0.15078577,168=>0.088186584,169=>0.053928025,170=>0.16229029,171=>-0.029552657,172=>0.093877316,173=>-0.076683916,174=>0.14077406,175=>0.13922508,176=>0.1773946,177=>0.06485414,178=>0.009120563,179=>-0.062159345,180=>-0.07541603,181=>-0.053466484,182=>0.053398248,183=>0.18520205,184=>0.014122652,185=>-0.08727325,186=>-8.550382E-5,187=>0.07282701,188=>-0.0511454,189=>-0.01867823,190=>0.06715079,191=>0.025723899,192=>0.12518725,193=>-0.0054524965,194=>-0.04905678,195=>-0.020646697,196=>0.093010075,197=>0.019125395,198=>-0.06029023,199=>-0.035664927,200=>0.0026907418,201=>0.0596861,202=>0.3001161,203=>-0.028957574,204=>0.13409348,205=>0.009497894,206=>-0.024247319,207=>0.00858011,208=>0.086026385,209=>0.043661512,210=>0.23419087,211=>0.004529219,212=>-0.043896876,213=>0.15197109,214=>-0.013786917,215=>0.086017534,216=>-0.06211924,217=>0.01915603,218=>0.03921594,219=>-0.011588451,220=>0.019847851,221=>0.07296046,222=>-0.043123152,223=>0.0032717257,224=>0.032553762,225=>-0.028555432,226=>0.08401631,227=>0.122622654,228=>0.0036422496,229=>-0.020440867,230=>0.09367397,231=>0.017028509,232=>0.17761493,233=>-0.09483285,234=>-4.250772E-4,235=>0.05961304,236=>0.14308652,0);
ENDMACRO;
