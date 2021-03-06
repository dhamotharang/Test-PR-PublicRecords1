EXPORT Model1_Score1_Tree26_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_26_Node_54 := IF ( le.p_IdentityRiskLevel < 8.5,160,161);
        Tree_26_Node_55 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,162,163);
        Tree_26_Node_30 := IF ( le.p_LienFiledAge < 258.5,Tree_26_Node_54,Tree_26_Node_55);
        Tree_26_Node_56 := CHOOSE ( le.p_readmit_diag,165,164,165,164,164,165,164,164,165,164,164,164,165);
        Tree_26_Node_57 := CHOOSE ( le.p_readmit_lift,166,167,166,166,166,167,166,166,166,166,166,166,166);
        Tree_26_Node_31 := IF ( le.p_CurrAddrCrimeIndex < 49.5,Tree_26_Node_56,Tree_26_Node_57);
        Tree_26_Node_16 := IF ( le.p_AddrChangeCount24 < 3.5,Tree_26_Node_30,Tree_26_Node_31);
        Tree_26_Node_32 := CHOOSE ( le.p_admit_diag,149,150,150,149,149,149,149,150,149,149,149,149,149);
        Tree_26_Node_60 := CHOOSE ( le.p_admit_diag,168,168,169,168,169,169,169,168,169,168,168,168,168);
        Tree_26_Node_33 := IF ( le.p_RecentActivityIndex < 2.5,Tree_26_Node_60,151);
        Tree_26_Node_17 := IF ( le.p_CurrAddrMurderIndex < 89.5,Tree_26_Node_32,Tree_26_Node_33);
        Tree_26_Node_8 := IF ( le.p_BPV_3 < 2.3864813,Tree_26_Node_16,Tree_26_Node_17);
        Tree_26_Node_4 := IF ( le.p_PropAgeNewestPurchase < 680.5,Tree_26_Node_8,140);
        Tree_26_Node_62 := IF ( le.p_SearchSSNSearchCount < 2.0,170,171);
        Tree_26_Node_63 := CHOOSE ( le.p_admit_diag,173,172,172,172,172,172,172,172,173,173,172,173,173);
        Tree_26_Node_34 := IF ( le.p_LastNameChangeAge < 54.5,Tree_26_Node_62,Tree_26_Node_63);
        Tree_26_Node_64 := IF ( le.p_PrevAddrCarTheftIndex < 149.5,174,175);
        Tree_26_Node_65 := IF ( le.p_BPV_4 < -2.462705,176,177);
        Tree_26_Node_35 := CHOOSE ( le.p_financial_class,Tree_26_Node_64,Tree_26_Node_65,Tree_26_Node_64,Tree_26_Node_64,Tree_26_Node_65,Tree_26_Node_65,Tree_26_Node_64,Tree_26_Node_64,Tree_26_Node_64,Tree_26_Node_65,Tree_26_Node_64,Tree_26_Node_65,Tree_26_Node_64,Tree_26_Node_64,Tree_26_Node_64,Tree_26_Node_64);
        Tree_26_Node_18 := IF ( le.p_PrevAddrMurderIndex < 69.5,Tree_26_Node_34,Tree_26_Node_35);
        Tree_26_Node_66 := CHOOSE ( le.p_readmit_diag,179,179,178,178,179,178,179,178,178,178,178,178,178);
        Tree_26_Node_67 := IF ( le.p_NonDerogCount01 < 2.5,180,181);
        Tree_26_Node_36 := IF ( le.p_NonDerogCount60 < 3.5,Tree_26_Node_66,Tree_26_Node_67);
        Tree_26_Node_19 := IF ( le.p_BPV_1 < 1.2352188,Tree_26_Node_36,143);
        Tree_26_Node_10 := IF ( le.p_CurrAddrBurglaryIndex < 87.5,Tree_26_Node_18,Tree_26_Node_19);
        Tree_26_Node_38 := IF ( le.p_VariationDOBCount < 3.5,152,153);
        Tree_26_Node_20 := IF ( le.p_NonDerogCount12 < 4.5,Tree_26_Node_38,144);
        Tree_26_Node_11 := IF ( le.p_PrevAddrAgeLastSale < 39.5,Tree_26_Node_20,141);
        Tree_26_Node_5 := IF ( le.p_SubjectLastNameCount < 9.5,Tree_26_Node_10,Tree_26_Node_11);
        Tree_26_Node_2 := IF ( le.p_v1_CrtRecTimeNewest < 61.0,Tree_26_Node_4,Tree_26_Node_5);
        Tree_26_Node_70 := IF ( le.p_PhoneEDAAgeNewestRecord < 50.0,182,183);
        Tree_26_Node_71 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.25,184,185);
        Tree_26_Node_40 := CHOOSE ( le.p_readmit_lift,Tree_26_Node_70,Tree_26_Node_70,Tree_26_Node_70,Tree_26_Node_71,Tree_26_Node_70,Tree_26_Node_71,Tree_26_Node_71,Tree_26_Node_71,Tree_26_Node_71,Tree_26_Node_70,Tree_26_Node_71,Tree_26_Node_70,Tree_26_Node_71);
        Tree_26_Node_72 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 210.5,186,187);
        Tree_26_Node_73 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 219.5,188,189);
        Tree_26_Node_41 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 0.5,Tree_26_Node_72,Tree_26_Node_73);
        Tree_26_Node_22 := IF ( le.p_CurrAddrAVMValue60 < 42577.5,Tree_26_Node_40,Tree_26_Node_41);
        Tree_26_Node_74 := IF ( le.p_PropOwnedHistoricalCount < 7.5,190,191);
        Tree_26_Node_75 := IF ( le.p_DivSSNAddrMSourceCount < 11.5,192,193);
        Tree_26_Node_42 := IF ( le.p_SSNIssueState < 33.5,Tree_26_Node_74,Tree_26_Node_75);
        Tree_26_Node_23 := IF ( le.p_DerogAge < 339.5,Tree_26_Node_42,145);
        Tree_26_Node_12 := IF ( le.p_LastNameChangeAge < 385.5,Tree_26_Node_22,Tree_26_Node_23);
        Tree_26_Node_76 := IF ( le.p_RelativesCount < 15.0,194,195);
        Tree_26_Node_44 := IF ( le.p_BP_2 < 1.5,Tree_26_Node_76,154);
        Tree_26_Node_24 := IF ( le.p_CurrAddrAgeLastSale < 165.5,Tree_26_Node_44,146);
        Tree_26_Node_25 := IF ( le.p_PrevAddrLenOfRes < 47.0,147,148);
        Tree_26_Node_13 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,Tree_26_Node_24,Tree_26_Node_25);
        Tree_26_Node_6 := IF ( le.p_BPV_3 < 2.7198868,Tree_26_Node_12,Tree_26_Node_13);
        Tree_26_Node_78 := IF ( le.p_BPV_3 < 2.02149,196,197);
        Tree_26_Node_79 := CHOOSE ( le.p_readmit_lift,198,198,198,199,198,199,199,198,199,198,198,198,198);
        Tree_26_Node_48 := IF ( le.p_v1_ProspectTimeLastUpdate < 101.5,Tree_26_Node_78,Tree_26_Node_79);
        Tree_26_Node_80 := IF ( le.p_PRSearchOtherCount24 < 1.5,200,201);
        Tree_26_Node_49 := IF ( le.p_P_EstimatedHHIncomePerCapita < 5.5029764,Tree_26_Node_80,155);
        Tree_26_Node_26 := IF ( le.p_PrevAddrAgeNewestRecord < 145.5,Tree_26_Node_48,Tree_26_Node_49);
        Tree_26_Node_82 := IF ( le.p_FelonyCount < 2.5,202,203);
        Tree_26_Node_83 := IF ( le.p_EstimatedAnnualIncome < 25950.5,204,205);
        Tree_26_Node_50 := CHOOSE ( le.p_financial_class,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_83,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_82,Tree_26_Node_83);
        Tree_26_Node_84 := IF ( le.p_v1_RaAPropOwnerAVMMed < 38213.5,206,207);
        Tree_26_Node_85 := IF ( le.p_PrevAddrCarTheftIndex < 109.5,208,209);
        Tree_26_Node_51 := IF ( le.p_DerogAge < 158.5,Tree_26_Node_84,Tree_26_Node_85);
        Tree_26_Node_27 := IF ( le.p_PropAgeNewestPurchase < 207.5,Tree_26_Node_50,Tree_26_Node_51);
        Tree_26_Node_14 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_26_Node_26,Tree_26_Node_27);
        Tree_26_Node_53 := IF ( le.p_SubjectLastNameCount < 3.5,158,159);
        Tree_26_Node_52 := IF ( le.p_PhoneOtherAgeOldestRecord < 117.5,156,157);
        Tree_26_Node_29 := CHOOSE ( le.p_admit_diag,Tree_26_Node_53,Tree_26_Node_52,Tree_26_Node_52,Tree_26_Node_53,Tree_26_Node_52,Tree_26_Node_53,Tree_26_Node_52,Tree_26_Node_53,Tree_26_Node_52,Tree_26_Node_52,Tree_26_Node_52,Tree_26_Node_52,Tree_26_Node_52);
        Tree_26_Node_15 := CHOOSE ( le.p_financial_class,142,142,142,142,142,142,142,142,Tree_26_Node_29,142,142,Tree_26_Node_29,142,Tree_26_Node_29,142,142);
        Tree_26_Node_7 := IF ( le.p_BPV_2 < 3.0444217,Tree_26_Node_14,Tree_26_Node_15);
        Tree_26_Node_3 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,Tree_26_Node_6,Tree_26_Node_7);
        Tree_26_Node_1 := IF ( le.p_LastNameChangeAge < 63.5,Tree_26_Node_2,Tree_26_Node_3);
    SELF.Score1_Tree26_node := Tree_26_Node_1;
    SELF.Score1_Tree26_score := CASE(SELF.Score1_Tree26_node,140=>0.12145022,141=>-0.06475371,142=>-0.05684098,143=>0.1274749,144=>0.014721712,145=>0.09539119,146=>0.08980341,147=>0.03387754,148=>0.13066266,149=>-0.07587002,150=>0.019354999,151=>-0.010752354,152=>0.118344165,153=>0.2696732,154=>0.041443866,155=>0.089765206,156=>-0.03798986,157=>0.048739236,158=>0.12774718,159=>0.01154855,160=>-0.017295957,161=>0.08239004,162=>0.14416455,163=>-0.05841517,164=>-0.09082763,165=>0.04633667,166=>-0.092076585,167=>-0.08148926,168=>0.054005157,169=>0.14571093,170=>0.018069448,171=>-0.07365689,172=>0.0065605678,173=>0.1289819,174=>-0.045988034,175=>-0.089862876,176=>0.15787147,177=>-0.029208414,178=>0.0020882592,179=>0.15938818,180=>-0.043416608,181=>0.013535285,182=>0.0060866326,183=>-0.007010307,184=>-0.0071912375,185=>0.03870027,186=>0.01437845,187=>0.04607939,188=>-0.022732435,189=>0.16740586,190=>-7.95098E-5,191=>0.1243854,192=>-0.024032673,193=>0.07365441,194=>0.021583358,195=>-0.07965766,196=>-0.007898171,197=>0.01954014,198=>0.005973614,199=>0.076406166,200=>-0.03475505,201=>0.032515634,202=>0.013760435,203=>-0.07302141,204=>0.2173692,205=>0.030746782,206=>0.0060917716,207=>-0.048532594,208=>-0.02156374,209=>0.14491294,0);
ENDMACRO;
