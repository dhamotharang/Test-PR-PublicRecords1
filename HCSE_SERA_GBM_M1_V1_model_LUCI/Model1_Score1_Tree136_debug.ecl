﻿EXPORT Model1_Score1_Tree136_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_136_Node_58 := CHOOSE ( le.p_admit_diag,182,183,182,182,182,182,182,182,182,182,182,182,183);
        Tree_136_Node_59 := CHOOSE ( le.p_readmit_lift,184,185,185,185,184,184,185,185,184,185,184,185,185);
        Tree_136_Node_33 := IF ( le.p_CurrAddrMedianIncome < 137492.5,Tree_136_Node_58,Tree_136_Node_59);
        Tree_136_Node_56 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 47.5,178,179);
        Tree_136_Node_57 := IF ( le.p_v1_CrtRecTimeNewest < 77.5,180,181);
        Tree_136_Node_32 := IF ( le.p_SubjectLastNameCount < 10.5,Tree_136_Node_56,Tree_136_Node_57);
        Tree_136_Node_16 := CHOOSE ( le.p_readmit_diag,Tree_136_Node_33,Tree_136_Node_32,Tree_136_Node_33,Tree_136_Node_32,Tree_136_Node_33,Tree_136_Node_33,Tree_136_Node_33,Tree_136_Node_33,Tree_136_Node_33,Tree_136_Node_32,Tree_136_Node_33,Tree_136_Node_33,Tree_136_Node_32);
        Tree_136_Node_60 := CHOOSE ( le.p_readmit_diag,187,186,187,186,187,186,186,186,186,186,186,186,186);
        Tree_136_Node_61 := CHOOSE ( le.p_financial_class,188,188,188,188,189,188,188,188,188,188,189,189,188,188,188,188);
        Tree_136_Node_34 := IF ( le.p_LienFiledAge < 238.5,Tree_136_Node_60,Tree_136_Node_61);
        Tree_136_Node_62 := CHOOSE ( le.p_admit_diag,190,191,190,190,190,191,190,190,190,190,190,190,191);
        Tree_136_Node_63 := IF ( le.p_PropAgeNewestSale < 149.5,192,193);
        Tree_136_Node_35 := IF ( le.p_StatusMostRecent < 1.5,Tree_136_Node_62,Tree_136_Node_63);
        Tree_136_Node_17 := IF ( le.p_CurrAddrCrimeIndex < 150.5,Tree_136_Node_34,Tree_136_Node_35);
        Tree_136_Node_8 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 1.5,Tree_136_Node_16,Tree_136_Node_17);
        Tree_136_Node_64 := IF ( le.p_SubjectAddrCount < 25.5,194,195);
        Tree_136_Node_65 := IF ( le.p_WealthIndex < 2.5,196,197);
        Tree_136_Node_36 := CHOOSE ( le.p_admit_diag,Tree_136_Node_64,Tree_136_Node_64,Tree_136_Node_65,Tree_136_Node_64,Tree_136_Node_64,Tree_136_Node_64,Tree_136_Node_65,Tree_136_Node_64,Tree_136_Node_64,Tree_136_Node_65,Tree_136_Node_65,Tree_136_Node_65,Tree_136_Node_64);
        Tree_136_Node_66 := CHOOSE ( le.p_readmit_lift,198,198,198,199,198,198,198,198,199,198,198,199,198);
        Tree_136_Node_67 := IF ( le.p_DerogAge < 275.5,200,201);
        Tree_136_Node_37 := CHOOSE ( le.p_financial_class,Tree_136_Node_66,Tree_136_Node_67,Tree_136_Node_66,Tree_136_Node_66,Tree_136_Node_66,Tree_136_Node_66,Tree_136_Node_66,Tree_136_Node_66,Tree_136_Node_66,Tree_136_Node_66,Tree_136_Node_67,Tree_136_Node_67,Tree_136_Node_67,Tree_136_Node_67,Tree_136_Node_66,Tree_136_Node_66);
        Tree_136_Node_18 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.33984375,Tree_136_Node_36,Tree_136_Node_37);
        Tree_136_Node_70 := IF ( le.p_v1_RaAMedIncomeRange < 3.5,206,207);
        Tree_136_Node_71 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 0.5,208,209);
        Tree_136_Node_39 := CHOOSE ( le.p_readmit_lift,Tree_136_Node_70,Tree_136_Node_70,Tree_136_Node_70,Tree_136_Node_71,Tree_136_Node_70,Tree_136_Node_70,Tree_136_Node_70,Tree_136_Node_70,Tree_136_Node_70,Tree_136_Node_71,Tree_136_Node_70,Tree_136_Node_70,Tree_136_Node_70);
        Tree_136_Node_68 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.135965,202,203);
        Tree_136_Node_69 := CHOOSE ( le.p_readmit_diag,204,204,204,204,205,205,205,204,205,205,205,204,204);
        Tree_136_Node_38 := IF ( le.p_AccidentAge < 36.5,Tree_136_Node_68,Tree_136_Node_69);
        Tree_136_Node_19 := CHOOSE ( le.p_financial_class,Tree_136_Node_39,Tree_136_Node_38,Tree_136_Node_39,Tree_136_Node_39,Tree_136_Node_39,Tree_136_Node_39,Tree_136_Node_39,Tree_136_Node_39,Tree_136_Node_39,Tree_136_Node_38,Tree_136_Node_38,Tree_136_Node_39,Tree_136_Node_38,Tree_136_Node_39,Tree_136_Node_38,Tree_136_Node_38);
        Tree_136_Node_9 := IF ( le.p_PhoneEDAAgeOldestRecord < 15.5,Tree_136_Node_18,Tree_136_Node_19);
        Tree_136_Node_4 := IF ( le.p_v1_HHCnt < 2.5,Tree_136_Node_8,Tree_136_Node_9);
        Tree_136_Node_73 := CHOOSE ( le.p_admit_diag,210,211,211,211,210,210,210,211,210,210,210,211,210);
        Tree_136_Node_40 := IF ( le.p_CurrAddrMedianIncome < 47858.0,167,Tree_136_Node_73);
        Tree_136_Node_74 := CHOOSE ( le.p_admit_diag,212,212,212,212,212,212,212,213,212,213,212,213,212);
        Tree_136_Node_75 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 296666.5,214,215);
        Tree_136_Node_41 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 3.5,Tree_136_Node_74,Tree_136_Node_75);
        Tree_136_Node_20 := IF ( le.p_NonDerogCount60 < 3.5,Tree_136_Node_40,Tree_136_Node_41);
        Tree_136_Node_10 := IF ( le.p_PRSearchOtherCount24 < 7.5,Tree_136_Node_20,160);
        Tree_136_Node_76 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 7.5,216,217);
        Tree_136_Node_77 := CHOOSE ( le.p_readmit_lift,218,218,218,218,219,218,219,219,219,218,219,219,218);
        Tree_136_Node_42 := IF ( le.p_CurrAddrBurglaryIndex < 99.5,Tree_136_Node_76,Tree_136_Node_77);
        Tree_136_Node_79 := IF ( le.p_PrevAddrBurglaryIndex < 130.5,220,221);
        Tree_136_Node_43 := CHOOSE ( le.p_readmit_lift,Tree_136_Node_79,Tree_136_Node_79,Tree_136_Node_79,Tree_136_Node_79,168,168,168,Tree_136_Node_79,168,Tree_136_Node_79,168,168,168);
        Tree_136_Node_22 := IF ( le.p_CurrAddrCrimeIndex < 160.5,Tree_136_Node_42,Tree_136_Node_43);
        Tree_136_Node_11 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 804814.5,Tree_136_Node_22,161);
        Tree_136_Node_5 := IF ( le.p_SrcsConfirmIDAddrCount < 2.5,Tree_136_Node_10,Tree_136_Node_11);
        Tree_136_Node_2 := IF ( le.p_v1_ProspectMaritalStatus < 0.5,Tree_136_Node_4,Tree_136_Node_5);
        Tree_136_Node_48 := IF ( le.p_v1_HHCnt < 1.5,173,174);
        Tree_136_Node_28 := CHOOSE ( le.p_admit_diag,Tree_136_Node_48,Tree_136_Node_48,165,Tree_136_Node_48,Tree_136_Node_48,Tree_136_Node_48,Tree_136_Node_48,165,Tree_136_Node_48,Tree_136_Node_48,165,165,Tree_136_Node_48);
        Tree_136_Node_50 := CHOOSE ( le.p_readmit_diag,175,175,176,176,176,176,176,175,176,175,176,176,175);
        Tree_136_Node_29 := CHOOSE ( le.p_readmit_lift,Tree_136_Node_50,166,Tree_136_Node_50,Tree_136_Node_50,166,Tree_136_Node_50,Tree_136_Node_50,Tree_136_Node_50,Tree_136_Node_50,Tree_136_Node_50,Tree_136_Node_50,Tree_136_Node_50,Tree_136_Node_50);
        Tree_136_Node_14 := IF ( le.p_AddrChangeCount60 < 0.5,Tree_136_Node_28,Tree_136_Node_29);
        Tree_136_Node_90 := IF ( le.p_v1_CrtRecMsdmeanCnt < 5.5,226,227);
        Tree_136_Node_91 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 1.5,228,229);
        Tree_136_Node_52 := IF ( le.p_SrcsConfirmIDAddrCount < 1.5,Tree_136_Node_90,Tree_136_Node_91);
        Tree_136_Node_92 := IF ( le.p_PhoneOtherAgeOldestRecord < 101.5,230,231);
        Tree_136_Node_93 := IF ( le.p_PhoneEDAAgeOldestRecord < 91.5,232,233);
        Tree_136_Node_53 := IF ( le.p_RelativesPropOwnedCount < 2.5,Tree_136_Node_92,Tree_136_Node_93);
        Tree_136_Node_30 := IF ( le.p_DerogAge < 190.5,Tree_136_Node_52,Tree_136_Node_53);
        Tree_136_Node_94 := IF ( le.p_v1_ProspectTimeLastUpdate < 111.5,234,235);
        Tree_136_Node_95 := IF ( le.p_VariationDOBCount < 2.5,236,237);
        Tree_136_Node_54 := CHOOSE ( le.p_readmit_lift,Tree_136_Node_94,Tree_136_Node_94,Tree_136_Node_95,Tree_136_Node_95,Tree_136_Node_94,Tree_136_Node_94,Tree_136_Node_95,Tree_136_Node_94,Tree_136_Node_94,Tree_136_Node_95,Tree_136_Node_95,Tree_136_Node_94,Tree_136_Node_94);
        Tree_136_Node_97 := IF ( le.p_DivSSNAddrMSourceCount < 11.5,238,239);
        Tree_136_Node_55 := CHOOSE ( le.p_financial_class,177,Tree_136_Node_97,177,177,177,177,177,177,Tree_136_Node_97,177,Tree_136_Node_97,Tree_136_Node_97,177,Tree_136_Node_97,177,177);
        Tree_136_Node_31 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_136_Node_54,Tree_136_Node_55);
        Tree_136_Node_15 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_136_Node_30,Tree_136_Node_31);
        Tree_136_Node_7 := IF ( le.p_EstimatedAnnualIncome < 25582.5,Tree_136_Node_14,Tree_136_Node_15);
        Tree_136_Node_45 := IF ( le.p_SSNLowIssueAge < 608.5,169,170);
        Tree_136_Node_24 := IF ( le.p_VariationDOBCount < 2.5,164,Tree_136_Node_45);
        Tree_136_Node_12 := CHOOSE ( le.p_readmit_diag,162,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24,Tree_136_Node_24);
        Tree_136_Node_83 := IF ( le.p_LastNameChangeAge < 231.5,224,225);
        Tree_136_Node_82 := CHOOSE ( le.p_financial_class,222,223,223,222,222,223,223,222,222,223,222,222,222,222,222,222);
        Tree_136_Node_46 := CHOOSE ( le.p_readmit_lift,Tree_136_Node_83,Tree_136_Node_82,Tree_136_Node_82,Tree_136_Node_83,Tree_136_Node_83,Tree_136_Node_83,Tree_136_Node_83,Tree_136_Node_83,Tree_136_Node_83,Tree_136_Node_83,Tree_136_Node_83,Tree_136_Node_82,Tree_136_Node_82);
        Tree_136_Node_47 := CHOOSE ( le.p_readmit_diag,172,171,171,171,172,171,172,171,171,171,171,172,172);
        Tree_136_Node_26 := IF ( le.p_SSNIssueState < 44.5,Tree_136_Node_46,Tree_136_Node_47);
        Tree_136_Node_13 := IF ( le.p_PrevAddrAgeOldestRecord < 337.5,Tree_136_Node_26,163);
        Tree_136_Node_6 := IF ( le.p_SubjectAddrCount < 10.5,Tree_136_Node_12,Tree_136_Node_13);
        Tree_136_Node_3 := CHOOSE ( le.p_admit_diag,Tree_136_Node_7,Tree_136_Node_7,Tree_136_Node_7,Tree_136_Node_7,Tree_136_Node_6,Tree_136_Node_6,Tree_136_Node_7,Tree_136_Node_7,Tree_136_Node_6,Tree_136_Node_6,Tree_136_Node_7,Tree_136_Node_7,Tree_136_Node_7);
        Tree_136_Node_1 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 142.5,Tree_136_Node_2,Tree_136_Node_3);
    SELF.Score1_Tree136_node := Tree_136_Node_1;
    SELF.Score1_Tree136_score := CASE(SELF.Score1_Tree136_node,160=>0.041772094,161=>0.02542885,162=>-0.010399496,163=>0.018579712,164=>-0.015993942,165=>0.052450217,166=>0.0136286225,167=>-0.009989221,168=>-0.023792125,169=>-0.028719604,170=>-0.03010902,171=>-0.031747714,172=>-0.020232337,173=>0.034486197,174=>-0.009120286,175=>-0.03199776,176=>-0.004493462,177=>-0.01778626,178=>-0.0019436325,179=>0.004500861,180=>-0.004691907,181=>0.036317892,182=>0.0015034208,183=>0.008852407,184=>-0.021627905,185=>-0.008438227,186=>-0.008247717,187=>-0.001747082,188=>-0.008384071,189=>0.024434803,190=>0.0023581185,191=>0.04739361,192=>-6.2698574E-4,193=>0.033495188,194=>-0.008706744,195=>0.019885058,196=>6.889231E-4,197=>0.03334518,198=>0.0014021791,199=>0.033305313,200=>0.009009523,201=>0.045459438,202=>-0.007419946,203=>0.010808697,204=>-1.9923618E-5,205=>0.040928766,206=>0.0061440426,207=>3.2086752E-4,208=>0.022156317,209=>-0.0043723197,210=>0.009256779,211=>0.06624469,212=>0.0030004147,213=>0.022178149,214=>-0.017485075,215=>0.008429085,216=>-0.0041725147,217=>0.02817854,218=>1.8998205E-4,219=>0.008199718,220=>-0.012481061,221=>-0.0018961144,222=>-0.020316316,223=>0.005127649,224=>0.01989935,225=>-0.0070836926,226=>-0.00564643,227=>0.026518682,228=>-0.009168877,229=>9.1263105E-4,230=>-0.011204666,231=>0.0028214436,232=>0.025999326,233=>-0.0014966788,234=>-0.011200055,235=>0.01678643,236=>0.04137226,237=>0.0031525213,238=>0.04201621,239=>0.0117598055,0);
ENDMACRO;
