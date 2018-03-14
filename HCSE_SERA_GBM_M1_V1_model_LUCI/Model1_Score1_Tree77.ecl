﻿EXPORT Model1_Score1_Tree77(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_77_Node_44 := IF ( le.p_PrevAddrCrimeIndex < 170.5,143,144);
        Tree_77_Node_45 := CHOOSE ( le.p_financial_class,145,146,145,145,145,145,145,145,145,145,145,145,145,146,146,145);
        Tree_77_Node_26 := IF ( le.p_VariationMSourcesSSNUnrelCount < 3.5,Tree_77_Node_44,Tree_77_Node_45);
        Tree_77_Node_47 := CHOOSE ( le.p_readmit_diag,147,147,147,148,147,148,148,148,147,148,148,148,147);
        Tree_77_Node_27 := CHOOSE ( le.p_admit_diag,Tree_77_Node_47,Tree_77_Node_47,135,Tree_77_Node_47,135,Tree_77_Node_47,Tree_77_Node_47,Tree_77_Node_47,135,Tree_77_Node_47,135,135,135);
        Tree_77_Node_16 := IF ( le.p_BPV_2 < 3.110811,Tree_77_Node_26,Tree_77_Node_27);
        Tree_77_Node_48 := IF ( le.p_PrevAddrMedianIncome < 78275.5,149,150);
        Tree_77_Node_49 := CHOOSE ( le.p_admit_diag,151,151,152,152,152,151,152,152,152,152,151,152,152);
        Tree_77_Node_28 := IF ( le.p_v1_ProspectTimeLastUpdate < 5.5,Tree_77_Node_48,Tree_77_Node_49);
        Tree_77_Node_51 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 2.5,153,154);
        Tree_77_Node_29 := CHOOSE ( le.p_readmit_lift,Tree_77_Node_51,Tree_77_Node_51,136,136,136,136,Tree_77_Node_51,136,136,136,136,Tree_77_Node_51,136);
        Tree_77_Node_17 := IF ( le.p_CurrAddrBurglaryIndex < 160.5,Tree_77_Node_28,Tree_77_Node_29);
        Tree_77_Node_8 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 2.5,Tree_77_Node_16,Tree_77_Node_17);
        Tree_77_Node_52 := IF ( le.p_v1_CrtRecTimeNewest < 179.5,155,156);
        Tree_77_Node_53 := CHOOSE ( le.p_admit_diag,157,158,157,158,157,157,158,158,157,158,157,157,158);
        Tree_77_Node_30 := CHOOSE ( le.p_financial_class,Tree_77_Node_52,Tree_77_Node_52,Tree_77_Node_52,Tree_77_Node_53,Tree_77_Node_52,Tree_77_Node_53,Tree_77_Node_52,Tree_77_Node_53,Tree_77_Node_53,Tree_77_Node_53,Tree_77_Node_53,Tree_77_Node_52,Tree_77_Node_53,Tree_77_Node_53,Tree_77_Node_53,Tree_77_Node_52);
        Tree_77_Node_54 := CHOOSE ( le.p_readmit_diag,160,160,160,160,160,159,160,159,160,159,159,159,159);
        Tree_77_Node_55 := IF ( le.p_NonDerogCount60 < 4.5,161,162);
        Tree_77_Node_31 := IF ( le.p_CurrAddrMedianIncome < 43599.5,Tree_77_Node_54,Tree_77_Node_55);
        Tree_77_Node_18 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 0.5,Tree_77_Node_30,Tree_77_Node_31);
        Tree_77_Node_9 := IF ( le.p_v1_HHCollegeAttendedMmbrCnt < 3.5,Tree_77_Node_18,133);
        Tree_77_Node_4 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 1.5,Tree_77_Node_8,Tree_77_Node_9);
        Tree_77_Node_56 := CHOOSE ( le.p_financial_class,164,163,164,163,163,163,164,164,164,164,164,163,163,164,163,164);
        Tree_77_Node_32 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 3.5,Tree_77_Node_56,137);
        Tree_77_Node_59 := IF ( le.p_v1_HHCollegeAttendedMmbrCnt < 2.5,165,166);
        Tree_77_Node_33 := IF ( le.p_PrevAddrBurglaryIndex < 9.5,138,Tree_77_Node_59);
        Tree_77_Node_20 := IF ( le.p_v1_HHCrtRecMmbrCnt < 4.5,Tree_77_Node_32,Tree_77_Node_33);
        Tree_77_Node_60 := CHOOSE ( le.p_financial_class,167,168,168,168,167,168,168,167,168,168,167,167,168,168,167,167);
        Tree_77_Node_34 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 208.5,Tree_77_Node_60,139);
        Tree_77_Node_62 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 5.5,169,170);
        Tree_77_Node_63 := CHOOSE ( le.p_financial_class,171,172,172,171,171,171,171,171,171,171,171,171,171,172,171,171);
        Tree_77_Node_35 := IF ( le.p_CurrAddrBurglaryIndex < 59.5,Tree_77_Node_62,Tree_77_Node_63);
        Tree_77_Node_21 := IF ( le.p_PhoneEDAAgeOldestRecord < 143.5,Tree_77_Node_34,Tree_77_Node_35);
        Tree_77_Node_10 := CHOOSE ( le.p_readmit_diag,Tree_77_Node_20,Tree_77_Node_20,Tree_77_Node_20,Tree_77_Node_20,Tree_77_Node_20,Tree_77_Node_20,Tree_77_Node_20,Tree_77_Node_21,Tree_77_Node_21,Tree_77_Node_21,Tree_77_Node_20,Tree_77_Node_20,Tree_77_Node_20);
        Tree_77_Node_5 := IF ( le.p_NonDerogCount06 < 6.5,Tree_77_Node_10,130);
        Tree_77_Node_2 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_77_Node_4,Tree_77_Node_5);
        Tree_77_Node_64 := IF ( le.p_NonDerogCount06 < 2.5,173,174);
        Tree_77_Node_65 := CHOOSE ( le.p_financial_class,175,176,176,175,175,176,175,175,175,175,175,176,176,175,175,175);
        Tree_77_Node_36 := IF ( le.p_NonDerogCount24 < 5.5,Tree_77_Node_64,Tree_77_Node_65);
        Tree_77_Node_67 := IF ( le.p_SearchSSNSearchCount < 6.5,179,180);
        Tree_77_Node_66 := CHOOSE ( le.p_admit_diag,177,178,177,177,178,177,177,177,177,177,177,177,178);
        Tree_77_Node_37 := CHOOSE ( le.p_readmit_lift,Tree_77_Node_67,Tree_77_Node_66,Tree_77_Node_67,Tree_77_Node_66,Tree_77_Node_67,Tree_77_Node_67,Tree_77_Node_67,Tree_77_Node_67,Tree_77_Node_67,Tree_77_Node_67,Tree_77_Node_67,Tree_77_Node_67,Tree_77_Node_66);
        Tree_77_Node_22 := IF ( le.p_SubjectAddrCount < 36.5,Tree_77_Node_36,Tree_77_Node_37);
        Tree_77_Node_68 := CHOOSE ( le.p_readmit_lift,181,182,181,181,181,181,181,181,181,181,181,181,181);
        Tree_77_Node_38 := CHOOSE ( le.p_admit_diag,Tree_77_Node_68,Tree_77_Node_68,140,Tree_77_Node_68,Tree_77_Node_68,Tree_77_Node_68,Tree_77_Node_68,140,Tree_77_Node_68,Tree_77_Node_68,Tree_77_Node_68,140,Tree_77_Node_68);
        Tree_77_Node_70 := IF ( le.p_AddrChangeCount24 < 1.5,183,184);
        Tree_77_Node_71 := IF ( le.p_EstimatedAnnualIncome < 39900.5,185,186);
        Tree_77_Node_39 := IF ( le.p_CurrAddrCountyIndex < 0.07625,Tree_77_Node_70,Tree_77_Node_71);
        Tree_77_Node_23 := IF ( le.p_CurrAddrMedianValue < 109374.5,Tree_77_Node_38,Tree_77_Node_39);
        Tree_77_Node_12 := IF ( le.p_age_in_years < 68.53344,Tree_77_Node_22,Tree_77_Node_23);
        Tree_77_Node_72 := IF ( le.p_SSNHighIssueAge < 430.5,187,188);
        Tree_77_Node_40 := CHOOSE ( le.p_admit_diag,Tree_77_Node_72,Tree_77_Node_72,141,Tree_77_Node_72,Tree_77_Node_72,Tree_77_Node_72,141,Tree_77_Node_72,Tree_77_Node_72,Tree_77_Node_72,Tree_77_Node_72,Tree_77_Node_72,Tree_77_Node_72);
        Tree_77_Node_74 := IF ( le.p_age_in_years < 35.08,189,190);
        Tree_77_Node_41 := CHOOSE ( le.p_admit_diag,Tree_77_Node_74,142,Tree_77_Node_74,Tree_77_Node_74,Tree_77_Node_74,Tree_77_Node_74,Tree_77_Node_74,142,Tree_77_Node_74,142,Tree_77_Node_74,Tree_77_Node_74,Tree_77_Node_74);
        Tree_77_Node_24 := IF ( le.p_PRSearchOtherCount < 7.5,Tree_77_Node_40,Tree_77_Node_41);
        Tree_77_Node_76 := CHOOSE ( le.p_admit_diag,191,191,192,192,192,191,191,192,191,191,191,191,191);
        Tree_77_Node_77 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 15.5,193,194);
        Tree_77_Node_42 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 29.5,Tree_77_Node_76,Tree_77_Node_77);
        Tree_77_Node_25 := IF ( le.p_LienReleasedAge < 145.5,Tree_77_Node_42,134);
        Tree_77_Node_13 := IF ( le.p_v1_ProspectTimeOnRecord < 21.5,Tree_77_Node_24,Tree_77_Node_25);
        Tree_77_Node_6 := IF ( le.p_CurrAddrCrimeIndex < 184.5,Tree_77_Node_12,Tree_77_Node_13);
        Tree_77_Node_7 := IF ( le.p_v1_RaAPropOwnerAVMMed < 126161.5,131,132);
        Tree_77_Node_3 := IF ( le.p_v1_CrtRecTimeNewest < 269.0,Tree_77_Node_6,Tree_77_Node_7);
        Tree_77_Node_1 := IF ( le.p_AddrChangeCount60 < 3.5,Tree_77_Node_2,Tree_77_Node_3);
    UNSIGNED2 Score1_Tree77_node := Tree_77_Node_1;
    REAL8 Score1_Tree77_score := CASE(Score1_Tree77_node,130=>0.076979615,131=>-0.010200071,132=>0.11356275,133=>0.064579844,134=>0.049235724,135=>-0.0121726,136=>-0.04763393,137=>0.06573595,138=>0.026409527,139=>-0.03685636,140=>-0.0058217207,141=>0.12278695,142=>0.015583432,143=>-9.074274E-4,144=>-0.005648365,145=>-0.015097475,146=>0.095237605,147=>0.01396848,148=>0.048175972,149=>0.008566809,150=>0.074432775,151=>0.02119965,152=>0.10363274,153=>-0.027368769,154=>0.041903146,155=>-0.009003624,156=>0.037500907,157=>0.0023118998,158=>0.020731896,159=>-0.023379575,160=>-0.0046734065,161=>0.014583321,162=>-0.002870216,163=>-0.005934315,164=>0.004346779,165=>-0.040188864,166=>0.021712806,167=>-0.0037071193,168=>0.03736973,169=>-0.023190008,170=>0.072347306,171=>-0.03235585,172=>0.011654628,173=>-0.021545626,174=>-0.0020081669,175=>-0.03339356,176=>-0.013762319,177=>-0.030255036,178=>0.03539525,179=>0.06397576,180=>-0.016051965,181=>-0.057767082,182=>-0.041793935,183=>0.027050363,184=>-0.016118811,185=>-0.050895493,186=>-0.012174885,187=>0.0066300454,188=>0.059197996,189=>-0.052470572,190=>-0.054389067,191=>-0.03160138,192=>0.012814165,193=>0.011947027,194=>0.051114913,0);
ENDMACRO;
