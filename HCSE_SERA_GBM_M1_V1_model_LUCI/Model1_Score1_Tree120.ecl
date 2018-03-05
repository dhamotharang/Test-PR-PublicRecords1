﻿EXPORT Model1_Score1_Tree120(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_120_Node_60 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 1.5,157,158);
        Tree_120_Node_61 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,159,160);
        Tree_120_Node_32 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_120_Node_60,Tree_120_Node_61);
        Tree_120_Node_62 := IF ( le.p_NonDerogCount60 < 3.5,161,162);
        Tree_120_Node_63 := IF ( le.p_v1_CrtRecTimeNewest < 185.0,163,164);
        Tree_120_Node_33 := CHOOSE ( le.p_readmit_diag,Tree_120_Node_62,Tree_120_Node_62,Tree_120_Node_62,Tree_120_Node_63,Tree_120_Node_63,Tree_120_Node_62,Tree_120_Node_62,Tree_120_Node_62,Tree_120_Node_63,Tree_120_Node_63,Tree_120_Node_62,Tree_120_Node_62,Tree_120_Node_63);
        Tree_120_Node_16 := IF ( le.p_AssocSuspicousIdentitiesCount < 5.5,Tree_120_Node_32,Tree_120_Node_33);
        Tree_120_Node_64 := CHOOSE ( le.p_readmit_diag,166,166,165,165,166,166,165,165,166,165,165,165,165);
        Tree_120_Node_34 := IF ( le.p_PhoneOtherAgeOldestRecord < 190.5,Tree_120_Node_64,144);
        Tree_120_Node_67 := IF ( le.p_BP_4 < 11.5,167,168);
        Tree_120_Node_35 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.5,145,Tree_120_Node_67);
        Tree_120_Node_17 := CHOOSE ( le.p_admit_diag,Tree_120_Node_34,Tree_120_Node_35,Tree_120_Node_34,Tree_120_Node_34,Tree_120_Node_34,Tree_120_Node_34,Tree_120_Node_34,Tree_120_Node_34,Tree_120_Node_35,Tree_120_Node_34,Tree_120_Node_35,Tree_120_Node_35,Tree_120_Node_34);
        Tree_120_Node_8 := IF ( le.p_PhoneOtherAgeOldestRecord < 175.5,Tree_120_Node_16,Tree_120_Node_17);
        Tree_120_Node_68 := CHOOSE ( le.p_readmit_lift,169,170,169,169,169,169,169,169,169,169,169,169,169);
        Tree_120_Node_36 := IF ( le.p_AssocRiskLevel < 3.5,Tree_120_Node_68,146);
        Tree_120_Node_70 := CHOOSE ( le.p_admit_diag,171,171,172,172,172,172,171,172,172,172,172,172,171);
        Tree_120_Node_37 := IF ( le.p_PropAgeNewestPurchase < 127.5,Tree_120_Node_70,147);
        Tree_120_Node_18 := CHOOSE ( le.p_admit_diag,Tree_120_Node_36,Tree_120_Node_37,Tree_120_Node_37,Tree_120_Node_36,Tree_120_Node_36,Tree_120_Node_36,Tree_120_Node_37,Tree_120_Node_37,Tree_120_Node_36,Tree_120_Node_36,Tree_120_Node_36,Tree_120_Node_37,Tree_120_Node_36);
        Tree_120_Node_73 := IF ( le.p_DivSSNAddrMSourceCount < 6.5,175,176);
        Tree_120_Node_72 := IF ( le.p_PrevAddrBurglaryIndex < 96.5,173,174);
        Tree_120_Node_38 := CHOOSE ( le.p_readmit_diag,Tree_120_Node_73,Tree_120_Node_73,Tree_120_Node_72,Tree_120_Node_72,Tree_120_Node_72,Tree_120_Node_72,Tree_120_Node_73,Tree_120_Node_72,Tree_120_Node_73,Tree_120_Node_72,Tree_120_Node_73,Tree_120_Node_72,Tree_120_Node_73);
        Tree_120_Node_19 := IF ( le.p_PropAgeOldestPurchase < 175.5,Tree_120_Node_38,132);
        Tree_120_Node_9 := CHOOSE ( le.p_financial_class,Tree_120_Node_18,Tree_120_Node_18,Tree_120_Node_18,Tree_120_Node_18,Tree_120_Node_19,Tree_120_Node_18,Tree_120_Node_18,Tree_120_Node_18,Tree_120_Node_19,Tree_120_Node_18,Tree_120_Node_19,Tree_120_Node_18,Tree_120_Node_19,Tree_120_Node_18,Tree_120_Node_18,Tree_120_Node_18);
        Tree_120_Node_4 := IF ( le.p_PhoneOtherAgeOldestRecord < 195.5,Tree_120_Node_8,Tree_120_Node_9);
        Tree_120_Node_20 := CHOOSE ( le.p_readmit_lift,133,134,133,133,133,133,133,133,133,133,133,133,133);
        Tree_120_Node_42 := IF ( le.p_PrevAddrCrimeIndex < 100.0,148,149);
        Tree_120_Node_76 := CHOOSE ( le.p_readmit_lift,177,178,177,177,177,177,177,177,177,178,177,177,177);
        Tree_120_Node_43 := IF ( le.p_PhoneOtherAgeNewestRecord < 240.5,Tree_120_Node_76,150);
        Tree_120_Node_21 := IF ( le.p_PrevAddrMedianIncome < 34429.5,Tree_120_Node_42,Tree_120_Node_43);
        Tree_120_Node_10 := IF ( le.p_WealthIndex < 1.5,Tree_120_Node_20,Tree_120_Node_21);
        Tree_120_Node_11 := IF ( le.p_PhoneOtherAgeOldestRecord < 325.5,130,131);
        Tree_120_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_120_Node_10,Tree_120_Node_10,Tree_120_Node_11,Tree_120_Node_10,Tree_120_Node_11,Tree_120_Node_10,Tree_120_Node_10,Tree_120_Node_11,Tree_120_Node_10,Tree_120_Node_10,Tree_120_Node_10,Tree_120_Node_10,Tree_120_Node_10);
        Tree_120_Node_2 := IF ( le.p_PhoneOtherAgeOldestRecord < 249.5,Tree_120_Node_4,Tree_120_Node_5);
        Tree_120_Node_28 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 6.0,139,140);
        Tree_120_Node_29 := CHOOSE ( le.p_readmit_lift,141,142,141,141,141,141,141,141,141,141,141,141,141);
        Tree_120_Node_14 := IF ( le.p_AddrChangeCount60 < 0.5,Tree_120_Node_28,Tree_120_Node_29);
        Tree_120_Node_86 := IF ( le.p_LienFiledAge < 32.5,183,184);
        Tree_120_Node_87 := CHOOSE ( le.p_financial_class,185,185,185,185,185,186,186,185,185,185,185,186,186,185,186,186);
        Tree_120_Node_56 := IF ( le.p_SrcsConfirmIDAddrCount < 1.5,Tree_120_Node_86,Tree_120_Node_87);
        Tree_120_Node_88 := IF ( le.p_CurrAddrMedianValue < 118712.5,187,188);
        Tree_120_Node_89 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 3.5,189,190);
        Tree_120_Node_57 := IF ( le.p_SSNAddrCount < 4.5,Tree_120_Node_88,Tree_120_Node_89);
        Tree_120_Node_30 := IF ( le.p_DerogAge < 190.5,Tree_120_Node_56,Tree_120_Node_57);
        Tree_120_Node_90 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,191,192);
        Tree_120_Node_91 := IF ( le.p_CurrAddrCrimeIndex < 99.5,193,194);
        Tree_120_Node_58 := CHOOSE ( le.p_readmit_lift,Tree_120_Node_90,Tree_120_Node_90,Tree_120_Node_91,Tree_120_Node_91,Tree_120_Node_90,Tree_120_Node_90,Tree_120_Node_91,Tree_120_Node_90,Tree_120_Node_90,Tree_120_Node_90,Tree_120_Node_91,Tree_120_Node_90,Tree_120_Node_90);
        Tree_120_Node_31 := IF ( le.p_PRSearchOtherCount < 23.5,Tree_120_Node_58,143);
        Tree_120_Node_15 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_120_Node_30,Tree_120_Node_31);
        Tree_120_Node_7 := IF ( le.p_EstimatedAnnualIncome < 24545.0,Tree_120_Node_14,Tree_120_Node_15);
        Tree_120_Node_80 := IF ( le.p_v1_ProspectTimeLastUpdate < 15.5,181,182);
        Tree_120_Node_46 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 2.5,Tree_120_Node_80,152);
        Tree_120_Node_25 := IF ( le.p_SSNLowIssueAge < 736.5,Tree_120_Node_46,136);
        Tree_120_Node_78 := IF ( le.p_DivSSNAddrMSourceCount < 12.5,179,180);
        Tree_120_Node_44 := IF ( le.p_BPV_2 < 1.0348313,Tree_120_Node_78,151);
        Tree_120_Node_24 := IF ( le.p_CurrAddrCarTheftIndex < 159.5,Tree_120_Node_44,135);
        Tree_120_Node_12 := CHOOSE ( le.p_readmit_diag,Tree_120_Node_25,Tree_120_Node_24,Tree_120_Node_24,Tree_120_Node_25,Tree_120_Node_24,Tree_120_Node_25,Tree_120_Node_24,Tree_120_Node_24,Tree_120_Node_24,Tree_120_Node_24,Tree_120_Node_25,Tree_120_Node_25,Tree_120_Node_24);
        Tree_120_Node_50 := IF ( le.p_PrevAddrBurglaryIndex < 120.5,155,156);
        Tree_120_Node_27 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 104.5,Tree_120_Node_50,138);
        Tree_120_Node_49 := IF ( le.p_CurrAddrCarTheftIndex < 49.5,153,154);
        Tree_120_Node_26 := CHOOSE ( le.p_readmit_diag,Tree_120_Node_49,Tree_120_Node_49,Tree_120_Node_49,137,Tree_120_Node_49,137,Tree_120_Node_49,Tree_120_Node_49,137,137,Tree_120_Node_49,Tree_120_Node_49,137);
        Tree_120_Node_13 := CHOOSE ( le.p_financial_class,Tree_120_Node_27,Tree_120_Node_26,Tree_120_Node_26,Tree_120_Node_26,Tree_120_Node_26,Tree_120_Node_26,Tree_120_Node_27,Tree_120_Node_26,Tree_120_Node_26,Tree_120_Node_27,Tree_120_Node_26,Tree_120_Node_27,Tree_120_Node_26,Tree_120_Node_27,Tree_120_Node_26,Tree_120_Node_26);
        Tree_120_Node_6 := IF ( le.p_LienFiledAge < 99.0,Tree_120_Node_12,Tree_120_Node_13);
        Tree_120_Node_3 := CHOOSE ( le.p_admit_diag,Tree_120_Node_7,Tree_120_Node_7,Tree_120_Node_7,Tree_120_Node_7,Tree_120_Node_6,Tree_120_Node_6,Tree_120_Node_7,Tree_120_Node_7,Tree_120_Node_6,Tree_120_Node_6,Tree_120_Node_7,Tree_120_Node_6,Tree_120_Node_6);
        Tree_120_Node_1 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 142.5,Tree_120_Node_2,Tree_120_Node_3);
    UNSIGNED2 Score1_Tree120_node := Tree_120_Node_1;
    REAL8 Score1_Tree120_score := CASE(Score1_Tree120_node,130=>-0.016399894,131=>0.041343335,132=>-0.034021042,133=>-0.036075756,134=>-0.033128344,135=>0.00719175,136=>0.017140163,137=>-0.029384997,138=>-0.021098856,139=>0.01209528,140=>0.05537363,141=>-0.028680187,142=>0.028970039,143=>0.044432968,144=>0.0046960926,145=>0.030317627,146=>-0.00639025,147=>0.0442451,148=>-0.0014123614,149=>0.026131798,150=>0.010136954,151=>-0.038860913,152=>0.013004502,153=>0.017275136,154=>-0.022375468,155=>0.061727248,156=>0.01730019,157=>-4.6592898E-4,158=>0.0018349991,159=>0.0089664105,160=>8.5395837E-4,161=>0.0056215646,162=>-0.008462661,163=>0.0025564793,164=>0.040555403,165=>-0.03272962,166=>-0.022563906,167=>-0.023213701,168=>0.020398818,169=>-0.034851734,170=>-0.032819293,171=>-0.033549495,172=>0.0139482925,173=>-0.027276041,174=>0.02750467,175=>0.035378903,176=>0.08013494,177=>-0.034909762,178=>-0.027686078,179=>-0.03497185,180=>-0.010599591,181=>0.0021156871,182=>-0.024818564,183=>-0.0136511745,184=>0.022611309,185=>-0.009309583,186=>0.0047419085,187=>0.050543014,188=>-0.015194411,189=>-0.0041788127,190=>0.015734896,191=>-0.008579736,192=>0.023241108,193=>0.044457965,194=>-0.005316055,0);
ENDMACRO;
