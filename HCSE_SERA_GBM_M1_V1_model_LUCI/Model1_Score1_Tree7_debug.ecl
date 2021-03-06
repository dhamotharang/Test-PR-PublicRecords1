EXPORT Model1_Score1_Tree7_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_7_Node_68 := CHOOSE ( le.p_readmit_lift,181,182,182,181,181,181,181,181,181,182,181,181,181);
        Tree_7_Node_69 := CHOOSE ( le.p_readmit_lift,184,183,184,183,183,183,183,183,183,183,183,183,183);
        Tree_7_Node_41 := CHOOSE ( le.p_financial_class,Tree_7_Node_68,Tree_7_Node_68,Tree_7_Node_69,Tree_7_Node_68,Tree_7_Node_69,Tree_7_Node_68,Tree_7_Node_68,Tree_7_Node_68,Tree_7_Node_68,Tree_7_Node_68,Tree_7_Node_69,Tree_7_Node_68,Tree_7_Node_68,Tree_7_Node_69,Tree_7_Node_69,Tree_7_Node_68);
        Tree_7_Node_66 := IF ( le.p_age_in_years < 1.4625,177,178);
        Tree_7_Node_67 := CHOOSE ( le.p_financial_class,179,179,179,179,179,179,179,179,179,179,180,179,179,179,179,179);
        Tree_7_Node_40 := IF ( le.p_age_in_years < 5.73,Tree_7_Node_66,Tree_7_Node_67);
        Tree_7_Node_20 := CHOOSE ( le.p_readmit_diag,Tree_7_Node_41,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_41,Tree_7_Node_40,Tree_7_Node_40,Tree_7_Node_41);
        Tree_7_Node_10 := IF ( le.p_PrevAddrMedianIncome < 28883.5,Tree_7_Node_20,150);
        Tree_7_Node_23 := CHOOSE ( le.p_readmit_diag,158,158,158,158,157,158,158,158,158,158,157,158,158);
        Tree_7_Node_11 := CHOOSE ( le.p_financial_class,151,151,151,151,151,151,151,151,151,151,Tree_7_Node_23,Tree_7_Node_23,151,151,151,151);
        Tree_7_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_7_Node_10,Tree_7_Node_10,Tree_7_Node_10,Tree_7_Node_11,Tree_7_Node_11,Tree_7_Node_10,Tree_7_Node_11,Tree_7_Node_11,Tree_7_Node_11,Tree_7_Node_10,Tree_7_Node_11,Tree_7_Node_10,Tree_7_Node_10);
        Tree_7_Node_19 := IF ( le.p_age_in_years < 20.475,155,156);
        Tree_7_Node_64 := IF ( le.p_age_in_years < 0.6279785,173,174);
        Tree_7_Node_65 := CHOOSE ( le.p_admit_diag,175,176,175,175,175,175,175,175,175,175,176,175,175);
        Tree_7_Node_36 := IF ( le.p_age_in_years < 11.6095705,Tree_7_Node_64,Tree_7_Node_65);
        Tree_7_Node_18 := IF ( le.p_age_in_years < 52.89375,Tree_7_Node_36,154);
        Tree_7_Node_9 := CHOOSE ( le.p_readmit_lift,Tree_7_Node_19,Tree_7_Node_18,Tree_7_Node_18,Tree_7_Node_18,Tree_7_Node_18,Tree_7_Node_19,Tree_7_Node_18,Tree_7_Node_18,Tree_7_Node_18,Tree_7_Node_18,Tree_7_Node_18,Tree_7_Node_19,Tree_7_Node_19);
        Tree_7_Node_60 := IF ( le.p_CurrAddrMedianValue < 88689.5,171,172);
        Tree_7_Node_32 := IF ( le.p_age_in_years < 71.3625,Tree_7_Node_60,162);
        Tree_7_Node_16 := IF ( le.p_CurrAddrBlockIndex < 0.9875,Tree_7_Node_32,152);
        Tree_7_Node_35 := IF ( le.p_age_in_years < 49.395,163,164);
        Tree_7_Node_17 := IF ( le.p_v1_HHMiddleAgemmbrCnt < -0.5,153,Tree_7_Node_35);
        Tree_7_Node_8 := IF ( le.p_AddrStability < 3.5,Tree_7_Node_16,Tree_7_Node_17);
        Tree_7_Node_4 := CHOOSE ( le.p_readmit_diag,Tree_7_Node_9,Tree_7_Node_8,Tree_7_Node_9,Tree_7_Node_8,Tree_7_Node_8,Tree_7_Node_9,Tree_7_Node_8,Tree_7_Node_9,Tree_7_Node_9,Tree_7_Node_8,Tree_7_Node_8,Tree_7_Node_9,Tree_7_Node_8);
        Tree_7_Node_2 := CHOOSE ( le.p_admit_diag,Tree_7_Node_5,Tree_7_Node_4,Tree_7_Node_4,Tree_7_Node_4,Tree_7_Node_5,Tree_7_Node_5,Tree_7_Node_4,Tree_7_Node_4,Tree_7_Node_4,Tree_7_Node_5,Tree_7_Node_4,Tree_7_Node_4,Tree_7_Node_5);
        Tree_7_Node_82 := CHOOSE ( le.p_readmit_lift,203,203,203,204,203,203,203,204,203,203,203,203,203);
        Tree_7_Node_83 := CHOOSE ( le.p_readmit_diag,205,205,205,206,205,205,206,205,205,206,205,205,205);
        Tree_7_Node_52 := CHOOSE ( le.p_financial_class,Tree_7_Node_82,Tree_7_Node_83,Tree_7_Node_82,Tree_7_Node_82,Tree_7_Node_83,Tree_7_Node_82,Tree_7_Node_82,Tree_7_Node_83,Tree_7_Node_83,Tree_7_Node_83,Tree_7_Node_83,Tree_7_Node_82,Tree_7_Node_82,Tree_7_Node_83,Tree_7_Node_83,Tree_7_Node_83);
        Tree_7_Node_28 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 176.5,Tree_7_Node_52,161);
        Tree_7_Node_84 := IF ( le.p_BP_1 < 0.5,207,208);
        Tree_7_Node_85 := IF ( le.p_SearchUnverifiedSSNCountYear < 0.5,209,210);
        Tree_7_Node_54 := CHOOSE ( le.p_readmit_lift,Tree_7_Node_84,Tree_7_Node_84,Tree_7_Node_84,Tree_7_Node_85,Tree_7_Node_84,Tree_7_Node_85,Tree_7_Node_85,Tree_7_Node_84,Tree_7_Node_84,Tree_7_Node_84,Tree_7_Node_84,Tree_7_Node_84,Tree_7_Node_84);
        Tree_7_Node_55 := IF ( le.p_NonDerogCount60 < 5.5,168,169);
        Tree_7_Node_29 := IF ( le.p_BP_3 < 2.5,Tree_7_Node_54,Tree_7_Node_55);
        Tree_7_Node_14 := IF ( le.p_age_in_years < 41.375,Tree_7_Node_28,Tree_7_Node_29);
        Tree_7_Node_88 := CHOOSE ( le.p_readmit_diag,212,212,211,211,211,212,211,212,211,211,211,212,211);
        Tree_7_Node_89 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,213,214);
        Tree_7_Node_56 := IF ( le.p_BPV_4 < -2.8067594,Tree_7_Node_88,Tree_7_Node_89);
        Tree_7_Node_91 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,215,216);
        Tree_7_Node_57 := IF ( le.p_PrevAddrDwellType < 4.0,170,Tree_7_Node_91);
        Tree_7_Node_30 := IF ( le.p_v1_ProspectAge < 67.5,Tree_7_Node_56,Tree_7_Node_57);
        Tree_7_Node_92 := IF ( le.p_CurrAddrCrimeIndex < 140.5,217,218);
        Tree_7_Node_93 := IF ( le.p_CurrAddrCarTheftIndex < 69.5,219,220);
        Tree_7_Node_58 := CHOOSE ( le.p_readmit_diag,Tree_7_Node_92,Tree_7_Node_93,Tree_7_Node_93,Tree_7_Node_92,Tree_7_Node_92,Tree_7_Node_92,Tree_7_Node_93,Tree_7_Node_92,Tree_7_Node_92,Tree_7_Node_92,Tree_7_Node_93,Tree_7_Node_93,Tree_7_Node_92);
        Tree_7_Node_95 := IF ( le.p_v1_HHCnt < 1.5,223,224);
        Tree_7_Node_94 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,221,222);
        Tree_7_Node_59 := CHOOSE ( le.p_admit_diag,Tree_7_Node_95,Tree_7_Node_94,Tree_7_Node_94,Tree_7_Node_94,Tree_7_Node_95,Tree_7_Node_95,Tree_7_Node_94,Tree_7_Node_94,Tree_7_Node_94,Tree_7_Node_95,Tree_7_Node_94,Tree_7_Node_94,Tree_7_Node_94);
        Tree_7_Node_31 := IF ( le.p_PhoneOtherAgeNewestRecord < 40.5,Tree_7_Node_58,Tree_7_Node_59);
        Tree_7_Node_15 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 4.5,Tree_7_Node_30,Tree_7_Node_31);
        Tree_7_Node_7 := IF ( le.p_BPV_2 < 1.0148072,Tree_7_Node_14,Tree_7_Node_15);
        Tree_7_Node_74 := CHOOSE ( le.p_readmit_diag,193,193,193,194,193,194,194,194,194,194,194,194,194);
        Tree_7_Node_75 := CHOOSE ( le.p_readmit_diag,195,195,196,195,195,195,195,195,195,195,195,195,195);
        Tree_7_Node_48 := CHOOSE ( le.p_admit_diag,Tree_7_Node_74,Tree_7_Node_75,Tree_7_Node_74,Tree_7_Node_75,Tree_7_Node_74,Tree_7_Node_74,Tree_7_Node_74,Tree_7_Node_74,Tree_7_Node_74,Tree_7_Node_75,Tree_7_Node_74,Tree_7_Node_75,Tree_7_Node_74);
        Tree_7_Node_76 := IF ( le.p_age_in_years < 90.885,197,198);
        Tree_7_Node_77 := IF ( le.p_v1_CrtRecCnt < 14.5,199,200);
        Tree_7_Node_49 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,Tree_7_Node_76,Tree_7_Node_77);
        Tree_7_Node_26 := CHOOSE ( le.p_readmit_lift,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_49,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48,Tree_7_Node_48);
        Tree_7_Node_78 := IF ( le.p_BPV_3 < 2.640675,201,202);
        Tree_7_Node_50 := IF ( le.p_BP_1 < 10.5,Tree_7_Node_78,165);
        Tree_7_Node_51 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.0,166,167);
        Tree_7_Node_27 := IF ( le.p_BPV_2 < 3.6039882,Tree_7_Node_50,Tree_7_Node_51);
        Tree_7_Node_13 := IF ( le.p_BPV_3 < 2.0004327,Tree_7_Node_26,Tree_7_Node_27);
        Tree_7_Node_72 := IF ( le.p_CurrAddrAgeOldestRecord < 437.5,189,190);
        Tree_7_Node_73 := IF ( le.p_LienFiledAge < 67.0,191,192);
        Tree_7_Node_45 := CHOOSE ( le.p_readmit_diag,Tree_7_Node_72,Tree_7_Node_72,Tree_7_Node_72,Tree_7_Node_72,Tree_7_Node_72,Tree_7_Node_72,Tree_7_Node_73,Tree_7_Node_73,Tree_7_Node_72,Tree_7_Node_72,Tree_7_Node_73,Tree_7_Node_73,Tree_7_Node_72);
        Tree_7_Node_70 := CHOOSE ( le.p_readmit_diag,185,186,185,185,186,186,185,186,186,186,185,186,185);
        Tree_7_Node_71 := IF ( le.p_PrevAddrMedianIncome < 78416.5,187,188);
        Tree_7_Node_44 := IF ( le.p_BPV_3 < 0.91247815,Tree_7_Node_70,Tree_7_Node_71);
        Tree_7_Node_24 := CHOOSE ( le.p_admit_diag,Tree_7_Node_45,Tree_7_Node_45,Tree_7_Node_44,Tree_7_Node_44,Tree_7_Node_45,Tree_7_Node_44,Tree_7_Node_44,Tree_7_Node_45,Tree_7_Node_44,Tree_7_Node_45,Tree_7_Node_44,Tree_7_Node_45,Tree_7_Node_45);
        Tree_7_Node_25 := IF ( le.p_PhoneEDAAgeOldestRecord < 153.5,159,160);
        Tree_7_Node_12 := IF ( le.p_BP_1 < 6.5,Tree_7_Node_24,Tree_7_Node_25);
        Tree_7_Node_6 := CHOOSE ( le.p_financial_class,Tree_7_Node_13,Tree_7_Node_12,Tree_7_Node_12,Tree_7_Node_12,Tree_7_Node_12,Tree_7_Node_12,Tree_7_Node_12,Tree_7_Node_13,Tree_7_Node_13,Tree_7_Node_13,Tree_7_Node_13,Tree_7_Node_12,Tree_7_Node_12,Tree_7_Node_13,Tree_7_Node_13,Tree_7_Node_12);
        Tree_7_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_7_Node_7,Tree_7_Node_6,Tree_7_Node_6,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7,Tree_7_Node_7);
        Tree_7_Node_1 := IF ( le.p_SSNLowIssueAge < 52.5,Tree_7_Node_2,Tree_7_Node_3);
    SELF.Score1_Tree7_node := Tree_7_Node_1;
    SELF.Score1_Tree7_score := CASE(SELF.Score1_Tree7_node,150=>-0.10425641,151=>-0.014539538,152=>0.021732965,153=>-0.10260651,154=>0.07247353,155=>0.02543522,156=>0.054243483,157=>0.111557946,158=>0.23831917,159=>0.007377837,160=>0.3020076,161=>0.2146999,162=>0.010029221,163=>-0.1038387,164=>-0.10672335,165=>0.19174409,166=>0.08575915,167=>0.23718704,168=>0.09948541,169=>0.24060997,170=>0.12603533,171=>-0.08073855,172=>-0.103072874,173=>-0.058284547,174=>0.014638625,175=>-0.09490227,176=>-0.014230767,177=>-0.077896334,178=>-0.0148293795,179=>-0.02543971,180=>0.083884425,181=>-0.064914614,182=>0.0036497219,183=>0.019842524,184=>0.09376581,185=>-0.051916618,186=>-0.023385402,187=>-5.661557E-4,188=>0.13214347,189=>-0.01543214,190=>0.05585217,191=>0.007904716,192=>0.073428676,193=>-0.015105441,194=>0.01668203,195=>0.0076329443,196=>0.097512916,197=>0.013777011,198=>-0.02913631,199=>0.040082134,200=>0.0025246018,201=>0.034329228,202=>0.09343908,203=>-0.0445257,204=>0.04761144,205=>0.0068427855,206=>0.07747199,207=>0.03480915,208=>0.16978069,209=>0.068869285,210=>0.2803407,211=>-0.06425762,212=>0.10827325,213=>0.16634607,214=>0.08093647,215=>0.024816548,216=>-0.06655915,217=>-0.062645756,218=>0.03279573,219=>0.019443147,220=>0.18636237,221=>-0.06512947,222=>0.009422526,223=>0.21597755,224=>0.07682584,0);
ENDMACRO;
