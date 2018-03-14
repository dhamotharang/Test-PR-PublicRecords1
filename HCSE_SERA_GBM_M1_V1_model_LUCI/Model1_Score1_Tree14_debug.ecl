﻿EXPORT Model1_Score1_Tree14_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_14_Node_64 := IF ( le.p_SSNLowIssueAge < 47.5,188,189);
        Tree_14_Node_65 := CHOOSE ( le.p_readmit_lift,190,191,191,190,190,191,191,190,190,191,190,191,191);
        Tree_14_Node_36 := IF ( le.p_age_in_years < 15.967188,Tree_14_Node_64,Tree_14_Node_65);
        Tree_14_Node_66 := IF ( le.p_age_in_years < 77.4225,192,193);
        Tree_14_Node_67 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 2.5,194,195);
        Tree_14_Node_37 := IF ( le.p_EstimatedAnnualIncome < 26562.5,Tree_14_Node_66,Tree_14_Node_67);
        Tree_14_Node_20 := IF ( le.p_CurrAddrAgeOldestRecord < 223.5,Tree_14_Node_36,Tree_14_Node_37);
        Tree_14_Node_69 := IF ( le.p_DivSSNIdentityMSourceUrelCount < -0.5,196,197);
        Tree_14_Node_38 := CHOOSE ( le.p_readmit_lift,Tree_14_Node_69,Tree_14_Node_69,170,Tree_14_Node_69,170,170,170,170,170,170,170,170,170);
        Tree_14_Node_21 := IF ( le.p_CurrAddrMedianIncome < 38806.5,Tree_14_Node_38,164);
        Tree_14_Node_10 := CHOOSE ( le.p_readmit_diag,Tree_14_Node_20,Tree_14_Node_20,Tree_14_Node_20,Tree_14_Node_21,Tree_14_Node_20,Tree_14_Node_20,Tree_14_Node_21,Tree_14_Node_20,Tree_14_Node_21,Tree_14_Node_20,Tree_14_Node_21,Tree_14_Node_20,Tree_14_Node_20);
        Tree_14_Node_22 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 2.5,165,166);
        Tree_14_Node_42 := IF ( le.p_v1_RaAPropOwnerAVMMed < 33700.5,171,172);
        Tree_14_Node_72 := IF ( le.p_PrevAddrMedianValue < 230973.5,198,199);
        Tree_14_Node_73 := CHOOSE ( le.p_readmit_lift,200,201,201,200,201,200,200,200,200,200,200,200,201);
        Tree_14_Node_43 := IF ( le.p_LastNameChangeAge < 71.5,Tree_14_Node_72,Tree_14_Node_73);
        Tree_14_Node_23 := IF ( le.p_PrevAddrMedianIncome < 7012.0,Tree_14_Node_42,Tree_14_Node_43);
        Tree_14_Node_11 := IF ( le.p_CurrAddrMedianValue < 31249.5,Tree_14_Node_22,Tree_14_Node_23);
        Tree_14_Node_5 := IF ( le.p_SubjectLastNameCount < 1.5,Tree_14_Node_10,Tree_14_Node_11);
        Tree_14_Node_60 := CHOOSE ( le.p_readmit_diag,182,182,182,182,182,182,182,182,183,182,182,182,183);
        Tree_14_Node_61 := IF ( le.p_CurrAddrMedianIncome < 23896.5,184,185);
        Tree_14_Node_32 := IF ( le.p_age_in_years < 13.65,Tree_14_Node_60,Tree_14_Node_61);
        Tree_14_Node_63 := CHOOSE ( le.p_financial_class,186,186,186,186,187,187,186,186,187,186,186,186,186,186,186,186);
        Tree_14_Node_33 := IF ( le.p_AddrStability < 1.5,169,Tree_14_Node_63);
        Tree_14_Node_16 := IF ( le.p_v1_CrtRecCnt12Mo < 0.5,Tree_14_Node_32,Tree_14_Node_33);
        Tree_14_Node_17 := IF ( le.p_SSNLowIssueAge < 399.5,162,163);
        Tree_14_Node_8 := IF ( le.p_PrevAddrCrimeIndex < 192.5,Tree_14_Node_16,Tree_14_Node_17);
        Tree_14_Node_9 := IF ( le.p_CurrAddrLenOfRes < 269.5,160,161);
        Tree_14_Node_4 := IF ( le.p_v1_CrtRecTimeNewest < 239.0,Tree_14_Node_8,Tree_14_Node_9);
        Tree_14_Node_2 := CHOOSE ( le.p_admit_diag,Tree_14_Node_5,Tree_14_Node_4,Tree_14_Node_5,Tree_14_Node_4,Tree_14_Node_5,Tree_14_Node_5,Tree_14_Node_4,Tree_14_Node_4,Tree_14_Node_4,Tree_14_Node_4,Tree_14_Node_4,Tree_14_Node_5,Tree_14_Node_5);
        Tree_14_Node_86 := IF ( le.p_v1_CrtRecTimeNewest < 185.0,224,225);
        Tree_14_Node_87 := IF ( le.p_BPV_1 < 2.1808,226,227);
        Tree_14_Node_52 := IF ( le.p_age_in_years < 42.98125,Tree_14_Node_86,Tree_14_Node_87);
        Tree_14_Node_53 := IF ( le.p_PhoneEDAAgeNewestRecord < 19.5,174,175);
        Tree_14_Node_28 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 531494.5,Tree_14_Node_52,Tree_14_Node_53);
        Tree_14_Node_92 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 27.5,232,233);
        Tree_14_Node_55 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 0.5,Tree_14_Node_92,176);
        Tree_14_Node_90 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,228,229);
        Tree_14_Node_91 := IF ( le.p_PropAgeNewestSale < 44.5,230,231);
        Tree_14_Node_54 := IF ( le.p_EstimatedAnnualIncome < 30000.5,Tree_14_Node_90,Tree_14_Node_91);
        Tree_14_Node_29 := CHOOSE ( le.p_readmit_diag,Tree_14_Node_55,Tree_14_Node_55,Tree_14_Node_54,Tree_14_Node_54,Tree_14_Node_54,Tree_14_Node_54,Tree_14_Node_54,Tree_14_Node_54,Tree_14_Node_54,Tree_14_Node_55,Tree_14_Node_55,Tree_14_Node_54,Tree_14_Node_54);
        Tree_14_Node_14 := IF ( le.p_PrevAddrAgeOldestRecord < 504.5,Tree_14_Node_28,Tree_14_Node_29);
        Tree_14_Node_94 := IF ( le.p_v1_RaASeniorMmbrCnt < 0.5,234,235);
        Tree_14_Node_56 := IF ( le.p_SSNLowIssueAge < 672.5,Tree_14_Node_94,177);
        Tree_14_Node_96 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 5.5,236,237);
        Tree_14_Node_57 := IF ( le.p_CurrAddrAVMValue60 < 10073.5,Tree_14_Node_96,178);
        Tree_14_Node_30 := IF ( le.p_RelativesCount < 15.5,Tree_14_Node_56,Tree_14_Node_57);
        Tree_14_Node_98 := IF ( le.p_CurrAddrMurderIndex < 159.5,238,239);
        Tree_14_Node_58 := IF ( le.p_PropAgeNewestSale < 55.5,Tree_14_Node_98,179);
        Tree_14_Node_59 := CHOOSE ( le.p_financial_class,180,180,180,180,180,180,180,180,181,181,180,180,180,180,180,180);
        Tree_14_Node_31 := IF ( le.p_BPV_2 < 3.004368,Tree_14_Node_58,Tree_14_Node_59);
        Tree_14_Node_15 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,Tree_14_Node_30,Tree_14_Node_31);
        Tree_14_Node_7 := IF ( le.p_BPV_2 < 2.4469182,Tree_14_Node_14,Tree_14_Node_15);
        Tree_14_Node_82 := IF ( le.p_DerogAge < 158.5,216,217);
        Tree_14_Node_83 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.0,218,219);
        Tree_14_Node_49 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_14_Node_82,Tree_14_Node_83);
        Tree_14_Node_80 := IF ( le.p_CurrAddrMedianIncome < 20965.5,214,215);
        Tree_14_Node_48 := IF ( le.p_AccidentAge < 130.5,Tree_14_Node_80,173);
        Tree_14_Node_26 := CHOOSE ( le.p_patient_type,Tree_14_Node_49,Tree_14_Node_48);
        Tree_14_Node_84 := IF ( le.p_PrevAddrCarTheftIndex < 190.5,220,221);
        Tree_14_Node_85 := IF ( le.p_AssocSuspicousIdentitiesCount < 5.0,222,223);
        Tree_14_Node_50 := IF ( le.p_RelativesBankruptcyCount < 3.5,Tree_14_Node_84,Tree_14_Node_85);
        Tree_14_Node_27 := IF ( le.p_BPV_2 < 3.7177985,Tree_14_Node_50,168);
        Tree_14_Node_13 := IF ( le.p_BPV_3 < 2.0004327,Tree_14_Node_26,Tree_14_Node_27);
        Tree_14_Node_74 := IF ( le.p_AssocSuspicousIdentitiesCount < 3.5,202,203);
        Tree_14_Node_75 := IF ( le.p_v1_CrtRecTimeNewest < 225.5,204,205);
        Tree_14_Node_44 := IF ( le.p_SubjectSSNCount < 2.5,Tree_14_Node_74,Tree_14_Node_75);
        Tree_14_Node_76 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 16.5,206,207);
        Tree_14_Node_77 := IF ( le.p_DerogAge < 81.5,208,209);
        Tree_14_Node_45 := CHOOSE ( le.p_financial_class,Tree_14_Node_76,Tree_14_Node_76,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_76,Tree_14_Node_76,Tree_14_Node_76,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_77,Tree_14_Node_76);
        Tree_14_Node_24 := CHOOSE ( le.p_admit_diag,Tree_14_Node_44,Tree_14_Node_45,Tree_14_Node_44,Tree_14_Node_44,Tree_14_Node_45,Tree_14_Node_44,Tree_14_Node_44,Tree_14_Node_45,Tree_14_Node_44,Tree_14_Node_45,Tree_14_Node_44,Tree_14_Node_45,Tree_14_Node_45);
        Tree_14_Node_78 := CHOOSE ( le.p_readmit_diag,210,210,210,211,210,210,211,210,210,210,211,211,210);
        Tree_14_Node_79 := IF ( le.p_LastNameChangeAge < 236.0,212,213);
        Tree_14_Node_46 := IF ( le.p_PhoneEDAAgeNewestRecord < 88.5,Tree_14_Node_78,Tree_14_Node_79);
        Tree_14_Node_25 := IF ( le.p_CurrAddrAgeLastSale < 271.5,Tree_14_Node_46,167);
        Tree_14_Node_12 := IF ( le.p_BPV_1 < 2.9389687,Tree_14_Node_24,Tree_14_Node_25);
        Tree_14_Node_6 := CHOOSE ( le.p_financial_class,Tree_14_Node_13,Tree_14_Node_12,Tree_14_Node_12,Tree_14_Node_12,Tree_14_Node_12,Tree_14_Node_12,Tree_14_Node_12,Tree_14_Node_13,Tree_14_Node_13,Tree_14_Node_12,Tree_14_Node_13,Tree_14_Node_12,Tree_14_Node_12,Tree_14_Node_13,Tree_14_Node_12,Tree_14_Node_12);
        Tree_14_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_14_Node_7,Tree_14_Node_6,Tree_14_Node_6,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7,Tree_14_Node_7);
        Tree_14_Node_1 := IF ( le.p_BPV_4 < -2.8944707,Tree_14_Node_2,Tree_14_Node_3);
    SELF.Score1_Tree14_node := Tree_14_Node_1;
    SELF.Score1_Tree14_score := CASE(SELF.Score1_Tree14_node,160=>-0.038871653,161=>0.2128792,162=>-0.09788777,163=>-0.101741806,164=>-0.019830585,165=>0.14699079,166=>-0.019183138,167=>0.2025736,168=>0.0963394,169=>-0.0013447131,170=>0.03560433,171=>-0.040340144,172=>0.118267804,173=>0.11664568,174=>0.025356682,175=>0.19165224,176=>-0.07890285,177=>-0.022924835,178=>-0.072751805,179=>-0.08032268,180=>0.0105780875,181=>0.11844564,182=>-0.06343591,183=>0.041046016,184=>0.007829778,185=>-0.03103864,186=>-0.097114146,187=>-0.024822714,188=>0.0018658612,189=>0.07563356,190=>-0.049616963,191=>-0.0019580259,192=>0.21618956,193=>0.056654207,194=>-0.06395427,195=>0.06797009,196=>0.077406876,197=>0.17520504,198=>-0.039375234,199=>0.08241102,200=>-0.0958665,201=>-0.056603346,202=>-0.018647484,203=>-0.045036405,204=>0.0062898877,205=>0.26685527,206=>-0.033504333,207=>0.0034878307,208=>-0.0031348146,209=>0.028504044,210=>-0.044030637,211=>0.102983,212=>0.014096224,213=>0.16366065,214=>0.017430939,215=>-0.03634917,216=>0.0113009,217=>0.039214402,218=>0.013752694,219=>-0.0048891674,220=>0.006936028,221=>0.07125635,222=>0.09680425,223=>-0.0124092745,224=>-0.0020074763,225=>0.12415453,226=>0.019078143,227=>0.07086126,228=>0.038805366,229=>-0.07084433,230=>-0.09662412,231=>-0.02422415,232=>0.008849151,233=>0.11397254,234=>0.07519594,235=>0.1373703,236=>0.10923675,237=>0.0019259957,238=>-0.016710352,239=>0.07724387,0);
ENDMACRO;
