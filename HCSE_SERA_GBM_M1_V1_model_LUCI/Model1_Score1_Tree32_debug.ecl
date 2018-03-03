﻿EXPORT Model1_Score1_Tree32_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_32_Node_60 := IF ( le.p_SrcsConfirmIDAddrCount < 9.5,198,199);
        Tree_32_Node_61 := IF ( le.p_CurrAddrMedianIncome < 85073.5,200,201);
        Tree_32_Node_32 := IF ( le.p_CurrAddrMedianValue < 249999.5,Tree_32_Node_60,Tree_32_Node_61);
        Tree_32_Node_63 := IF ( le.p_BP_4 < 11.5,202,203);
        Tree_32_Node_33 := IF ( le.p_PhoneEDAAgeOldestRecord < 107.5,181,Tree_32_Node_63);
        Tree_32_Node_16 := IF ( le.p_BPV_2 < 3.0349374,Tree_32_Node_32,Tree_32_Node_33);
        Tree_32_Node_64 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 3.5,204,205);
        Tree_32_Node_65 := CHOOSE ( le.p_patient_type,206,207);
        Tree_32_Node_34 := IF ( le.p_PrevAddrMedianValue < 314127.5,Tree_32_Node_64,Tree_32_Node_65);
        Tree_32_Node_66 := IF ( le.p_PhoneOtherAgeNewestRecord < 70.5,208,209);
        Tree_32_Node_67 := IF ( le.p_DerogAge < 289.5,210,211);
        Tree_32_Node_35 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 2.5,Tree_32_Node_66,Tree_32_Node_67);
        Tree_32_Node_17 := CHOOSE ( le.p_financial_class,Tree_32_Node_34,Tree_32_Node_34,Tree_32_Node_34,Tree_32_Node_35,Tree_32_Node_34,Tree_32_Node_35,Tree_32_Node_34,Tree_32_Node_35,Tree_32_Node_35,Tree_32_Node_35,Tree_32_Node_34,Tree_32_Node_35,Tree_32_Node_35,Tree_32_Node_35,Tree_32_Node_35,Tree_32_Node_34);
        Tree_32_Node_8 := CHOOSE ( le.p_admit_diag,Tree_32_Node_16,Tree_32_Node_17,Tree_32_Node_17,Tree_32_Node_16,Tree_32_Node_17,Tree_32_Node_16,Tree_32_Node_16,Tree_32_Node_16,Tree_32_Node_16,Tree_32_Node_16,Tree_32_Node_16,Tree_32_Node_17,Tree_32_Node_16);
        Tree_32_Node_70 := IF ( le.p_v1_CrtRecTimeNewest < 80.5,214,215);
        Tree_32_Node_71 := CHOOSE ( le.p_admit_diag,216,217,217,216,216,216,217,216,216,217,216,216,216);
        Tree_32_Node_38 := CHOOSE ( le.p_financial_class,Tree_32_Node_70,Tree_32_Node_70,Tree_32_Node_71,Tree_32_Node_70,Tree_32_Node_71,Tree_32_Node_70,Tree_32_Node_71,Tree_32_Node_70,Tree_32_Node_70,Tree_32_Node_70,Tree_32_Node_70,Tree_32_Node_71,Tree_32_Node_70,Tree_32_Node_70,Tree_32_Node_70,Tree_32_Node_70);
        Tree_32_Node_72 := CHOOSE ( le.p_readmit_lift,218,218,218,218,218,219,218,219,218,219,218,218,218);
        Tree_32_Node_73 := IF ( le.p_RelativesCount < 14.5,220,221);
        Tree_32_Node_39 := IF ( le.p_EstimatedAnnualIncome < 37843.5,Tree_32_Node_72,Tree_32_Node_73);
        Tree_32_Node_19 := IF ( le.p_CurrAddrMedianIncome < 45830.5,Tree_32_Node_38,Tree_32_Node_39);
        Tree_32_Node_68 := CHOOSE ( le.p_readmit_diag,213,213,213,213,213,213,213,212,213,213,213,212,212);
        Tree_32_Node_37 := IF ( le.p_v1_ProspectMaritalStatus < 0.5,Tree_32_Node_68,182);
        Tree_32_Node_18 := IF ( le.p_age_in_years < 61.235,178,Tree_32_Node_37);
        Tree_32_Node_9 := CHOOSE ( le.p_admit_diag,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_18,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_19,Tree_32_Node_18,Tree_32_Node_19);
        Tree_32_Node_4 := IF ( le.p_NonDerogCount01 < 4.5,Tree_32_Node_8,Tree_32_Node_9);
        Tree_32_Node_74 := IF ( le.p_SubjectLastNameCount < 9.5,222,223);
        Tree_32_Node_75 := IF ( le.p_AssocRiskLevel < 1.5,224,225);
        Tree_32_Node_40 := IF ( le.p_CurrAddrMedianIncome < 37925.5,Tree_32_Node_74,Tree_32_Node_75);
        Tree_32_Node_76 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 5.5,226,227);
        Tree_32_Node_41 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 6.5,Tree_32_Node_76,183);
        Tree_32_Node_20 := IF ( le.p_BPV_3 < 2.1057189,Tree_32_Node_40,Tree_32_Node_41);
        Tree_32_Node_78 := CHOOSE ( le.p_admit_diag,228,228,229,229,228,228,229,228,228,229,228,228,228);
        Tree_32_Node_42 := IF ( le.p_BPV_1 < 2.896375,Tree_32_Node_78,184);
        Tree_32_Node_80 := CHOOSE ( le.p_financial_class,230,230,230,230,231,230,230,230,230,230,231,230,230,230,230,230);
        Tree_32_Node_43 := CHOOSE ( le.p_admit_diag,Tree_32_Node_80,Tree_32_Node_80,Tree_32_Node_80,Tree_32_Node_80,Tree_32_Node_80,Tree_32_Node_80,185,Tree_32_Node_80,Tree_32_Node_80,185,185,Tree_32_Node_80,185);
        Tree_32_Node_21 := IF ( le.p_LastNameChangeAge < 120.5,Tree_32_Node_42,Tree_32_Node_43);
        Tree_32_Node_10 := IF ( le.p_AddrChangeCount60 < 3.5,Tree_32_Node_20,Tree_32_Node_21);
        Tree_32_Node_44 := IF ( le.p_PhoneOtherAgeOldestRecord < 88.5,186,187);
        Tree_32_Node_45 := CHOOSE ( le.p_admit_diag,188,188,188,189,188,189,188,188,188,188,188,188,188);
        Tree_32_Node_22 := CHOOSE ( le.p_admit_diag,Tree_32_Node_44,Tree_32_Node_44,Tree_32_Node_44,Tree_32_Node_45,Tree_32_Node_44,Tree_32_Node_45,Tree_32_Node_44,Tree_32_Node_44,Tree_32_Node_44,Tree_32_Node_44,Tree_32_Node_44,Tree_32_Node_45,Tree_32_Node_45);
        Tree_32_Node_86 := IF ( le.p_PropOwnedHistoricalCount < 2.5,232,233);
        Tree_32_Node_87 := IF ( le.p_PrevAddrBurglaryIndex < 119.5,234,235);
        Tree_32_Node_46 := CHOOSE ( le.p_readmit_lift,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_87,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86,Tree_32_Node_86);
        Tree_32_Node_47 := CHOOSE ( le.p_admit_diag,190,190,190,191,190,191,190,190,190,191,190,191,190);
        Tree_32_Node_23 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 1.5,Tree_32_Node_46,Tree_32_Node_47);
        Tree_32_Node_11 := IF ( le.p_CurrAddrAgeOldestRecord < 7.5,Tree_32_Node_22,Tree_32_Node_23);
        Tree_32_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_32_Node_10,Tree_32_Node_10,Tree_32_Node_10,Tree_32_Node_10,Tree_32_Node_10,Tree_32_Node_11,Tree_32_Node_10,Tree_32_Node_11,Tree_32_Node_11,Tree_32_Node_11,Tree_32_Node_10,Tree_32_Node_10,Tree_32_Node_10);
        Tree_32_Node_2 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_32_Node_4,Tree_32_Node_5);
        Tree_32_Node_90 := IF ( le.p_v1_PropTimeLastSale < 144.5,236,237);
        Tree_32_Node_91 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 5.0,238,239);
        Tree_32_Node_48 := IF ( le.p_v1_CrtRecTimeNewest < 170.0,Tree_32_Node_90,Tree_32_Node_91);
        Tree_32_Node_92 := IF ( le.p_PrevAddrBurglaryIndex < 120.5,240,241);
        Tree_32_Node_93 := IF ( le.p_NonDerogCount < 10.5,242,243);
        Tree_32_Node_49 := IF ( le.p_CurrAddrMedianValue < 406250.5,Tree_32_Node_92,Tree_32_Node_93);
        Tree_32_Node_24 := CHOOSE ( le.p_financial_class,Tree_32_Node_48,Tree_32_Node_49,Tree_32_Node_49,Tree_32_Node_49,Tree_32_Node_48,Tree_32_Node_48,Tree_32_Node_48,Tree_32_Node_49,Tree_32_Node_49,Tree_32_Node_48,Tree_32_Node_49,Tree_32_Node_49,Tree_32_Node_49,Tree_32_Node_49,Tree_32_Node_48,Tree_32_Node_48);
        Tree_32_Node_94 := CHOOSE ( le.p_financial_class,244,244,245,244,245,245,244,244,245,245,244,244,244,244,244,244);
        Tree_32_Node_95 := CHOOSE ( le.p_admit_diag,247,246,246,246,247,247,246,247,246,246,246,246,246);
        Tree_32_Node_50 := IF ( le.p_NonDerogCount12 < 4.5,Tree_32_Node_94,Tree_32_Node_95);
        Tree_32_Node_25 := IF ( le.p_FelonyCount < 12.5,Tree_32_Node_50,179);
        Tree_32_Node_12 := IF ( le.p_BPV_1 < 2.3000624,Tree_32_Node_24,Tree_32_Node_25);
        Tree_32_Node_96 := CHOOSE ( le.p_readmit_lift,248,249,248,248,248,248,248,248,248,248,248,248,249);
        Tree_32_Node_52 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 205544.5,Tree_32_Node_96,192);
        Tree_32_Node_26 := CHOOSE ( le.p_admit_diag,Tree_32_Node_52,Tree_32_Node_52,Tree_32_Node_52,180,Tree_32_Node_52,Tree_32_Node_52,Tree_32_Node_52,180,180,180,Tree_32_Node_52,Tree_32_Node_52,Tree_32_Node_52);
        Tree_32_Node_13 := IF ( le.p_CurrAddrCountyIndex < 0.6063281,Tree_32_Node_26,176);
        Tree_32_Node_6 := IF ( le.p_v1_CrtRecCnt < 79.5,Tree_32_Node_12,Tree_32_Node_13);
        Tree_32_Node_98 := IF ( le.p_PrevAddrBurglaryIndex < 180.5,250,251);
        Tree_32_Node_99 := CHOOSE ( le.p_readmit_diag,253,252,252,253,253,253,253,252,253,252,253,253,252);
        Tree_32_Node_54 := IF ( le.p_PrevAddrAgeNewestRecord < 156.5,Tree_32_Node_98,Tree_32_Node_99);
        Tree_32_Node_101 := IF ( le.p_CurrAddrAVMValue60 < 116886.5,254,255);
        Tree_32_Node_55 := IF ( le.p_PrevAddrMedianIncome < 42896.5,193,Tree_32_Node_101);
        Tree_32_Node_28 := CHOOSE ( le.p_readmit_lift,Tree_32_Node_54,Tree_32_Node_54,Tree_32_Node_54,Tree_32_Node_54,Tree_32_Node_55,Tree_32_Node_55,Tree_32_Node_55,Tree_32_Node_55,Tree_32_Node_55,Tree_32_Node_54,Tree_32_Node_54,Tree_32_Node_55,Tree_32_Node_54);
        Tree_32_Node_14 := IF ( le.p_LastNameChangeAge < 633.0,Tree_32_Node_28,177);
        Tree_32_Node_103 := CHOOSE ( le.p_readmit_lift,259,259,259,258,259,258,259,259,258,259,258,258,259);
        Tree_32_Node_102 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 299500.5,256,257);
        Tree_32_Node_56 := CHOOSE ( le.p_admit_diag,Tree_32_Node_103,Tree_32_Node_103,Tree_32_Node_103,Tree_32_Node_103,Tree_32_Node_102,Tree_32_Node_102,Tree_32_Node_102,Tree_32_Node_103,Tree_32_Node_102,Tree_32_Node_103,Tree_32_Node_103,Tree_32_Node_103,Tree_32_Node_103);
        Tree_32_Node_57 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 610956.5,194,195);
        Tree_32_Node_30 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 493248.5,Tree_32_Node_56,Tree_32_Node_57);
        Tree_32_Node_106 := IF ( le.p_PhoneOtherAgeOldestRecord < 153.5,260,261);
        Tree_32_Node_58 := CHOOSE ( le.p_readmit_diag,Tree_32_Node_106,Tree_32_Node_106,Tree_32_Node_106,Tree_32_Node_106,Tree_32_Node_106,196,196,Tree_32_Node_106,Tree_32_Node_106,196,Tree_32_Node_106,Tree_32_Node_106,Tree_32_Node_106);
        Tree_32_Node_108 := CHOOSE ( le.p_financial_class,262,262,263,262,262,262,262,262,262,262,262,263,262,263,262,262);
        Tree_32_Node_59 := CHOOSE ( le.p_readmit_diag,Tree_32_Node_108,Tree_32_Node_108,Tree_32_Node_108,197,197,Tree_32_Node_108,Tree_32_Node_108,197,Tree_32_Node_108,Tree_32_Node_108,197,197,197);
        Tree_32_Node_31 := IF ( le.p_SubjectSSNCount < 1.5,Tree_32_Node_58,Tree_32_Node_59);
        Tree_32_Node_15 := IF ( le.p_PhoneEDAAgeOldestRecord < 195.5,Tree_32_Node_30,Tree_32_Node_31);
        Tree_32_Node_7 := IF ( le.p_CurrAddrCrimeIndex < 135.5,Tree_32_Node_14,Tree_32_Node_15);
        Tree_32_Node_3 := IF ( le.p_v1_ProspectMaritalStatus < 0.5,Tree_32_Node_6,Tree_32_Node_7);
        Tree_32_Node_1 := IF ( le.p_CurrAddrCarTheftIndex < 91.0,Tree_32_Node_2,Tree_32_Node_3);
    SELF.Score1_Tree32_node := Tree_32_Node_1;
    SELF.Score1_Tree32_score := CASE(SELF.Score1_Tree32_node,256=>-0.06514385,257=>-0.0073105237,258=>-0.0720302,259=>-0.018189855,260=>-0.029082954,261=>0.035412975,262=>-0.08382567,263=>0.08373522,176=>0.029383104,177=>0.13045771,178=>-0.025183005,179=>0.1072715,180=>-0.015106642,181=>-0.009674738,182=>-0.045052838,183=>0.10085998,184=>0.09823323,185=>0.06588427,186=>0.06993699,187=>-0.04438398,188=>0.1336225,189=>0.18053448,190=>-0.08679735,191=>-0.024272876,192=>-0.027717708,193=>-0.02073041,194=>0.11890272,195=>-0.02545839,196=>0.08512521,197=>0.20147593,198=>-0.008197371,199=>0.011963273,200=>-0.03220381,201=>-0.011680399,202=>0.039983258,203=>0.10601102,204=>-4.2584477E-4,205=>-0.05066435,206=>-0.056281243,207=>0.09272117,208=>0.0039820275,209=>-0.02673001,210=>0.013455899,211=>0.11008562,212=>-0.08884666,213=>-0.08351927,214=>-0.032580286,215=>-0.08014683,216=>-0.055846322,217=>0.04437386,218=>0.0070572756,219=>0.08888682,220=>-0.01420884,221=>-0.059998874,222=>0.020450689,223=>0.14772223,224=>0.018233838,225=>-0.008466371,226=>0.039381295,227=>-0.0788356,228=>-0.025985884,229=>0.05953145,230=>-0.05814977,231=>-0.0068947338,232=>0.011804609,233=>0.085934326,234=>0.028545877,235=>0.1364385,236=>-0.026282119,237=>0.06581039,238=>0.0050148685,239=>0.18949707,240=>0.012597788,241=>0.0029170467,242=>-0.028035687,243=>0.068179436,244=>-0.0042888597,245=>0.038823277,246=>0.017662758,247=>0.10460497,248=>-0.09052118,249=>-0.07520793,250=>-0.008993069,251=>0.045110308,252=>-0.010736141,253=>0.10287339,254=>0.062328532,255=>0.16906899,0);
ENDMACRO;
