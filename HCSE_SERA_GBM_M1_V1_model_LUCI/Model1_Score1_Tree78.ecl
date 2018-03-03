﻿EXPORT Model1_Score1_Tree78(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_78_Node_48 := IF ( le.p_PrevAddrAgeNewestRecord < 22.5,152,153);
        Tree_78_Node_49 := IF ( le.p_CurrAddrAgeOldestRecord < 239.5,154,155);
        Tree_78_Node_26 := IF ( le.p_SubjectAddrCount < 10.5,Tree_78_Node_48,Tree_78_Node_49);
        Tree_78_Node_14 := IF ( le.p_PropAgeNewestSale < 271.5,Tree_78_Node_26,142);
        Tree_78_Node_50 := IF ( le.p_DerogAge < 260.5,156,157);
        Tree_78_Node_51 := IF ( le.p_SSNIssueState < 14.5,158,159);
        Tree_78_Node_28 := IF ( le.p_v1_PropTimeLastSale < 73.5,Tree_78_Node_50,Tree_78_Node_51);
        Tree_78_Node_52 := IF ( le.p_PhoneEDAAgeOldestRecord < 29.5,160,161);
        Tree_78_Node_53 := IF ( le.p_CurrAddrAVMValue12 < 256796.5,162,163);
        Tree_78_Node_29 := IF ( le.p_NonDerogCount < 8.5,Tree_78_Node_52,Tree_78_Node_53);
        Tree_78_Node_15 := IF ( le.p_v1_PropTimeLastSale < 104.5,Tree_78_Node_28,Tree_78_Node_29);
        Tree_78_Node_8 := IF ( le.p_CurrAddrAVMValue60 < 106444.5,Tree_78_Node_14,Tree_78_Node_15);
        Tree_78_Node_54 := IF ( le.p_NonDerogCount60 < 6.5,164,165);
        Tree_78_Node_55 := IF ( le.p_CurrAddrCarTheftIndex < 89.5,166,167);
        Tree_78_Node_30 := IF ( le.p_LastNameChangeAge < 159.5,Tree_78_Node_54,Tree_78_Node_55);
        Tree_78_Node_56 := CHOOSE ( le.p_readmit_lift,169,168,169,169,169,169,169,169,168,169,169,169,169);
        Tree_78_Node_57 := IF ( le.p_PrevAddrLenOfRes < 110.5,170,171);
        Tree_78_Node_31 := IF ( le.p_PrevAddrCrimeIndex < 20.5,Tree_78_Node_56,Tree_78_Node_57);
        Tree_78_Node_16 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 15.5,Tree_78_Node_30,Tree_78_Node_31);
        Tree_78_Node_58 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,172,173);
        Tree_78_Node_59 := IF ( le.p_v1_ProspectTimeOnRecord < 47.5,174,175);
        Tree_78_Node_32 := CHOOSE ( le.p_gender,Tree_78_Node_58,Tree_78_Node_59);
        Tree_78_Node_17 := CHOOSE ( le.p_readmit_lift,Tree_78_Node_32,Tree_78_Node_32,Tree_78_Node_32,Tree_78_Node_32,143,Tree_78_Node_32,Tree_78_Node_32,Tree_78_Node_32,143,Tree_78_Node_32,143,Tree_78_Node_32,143);
        Tree_78_Node_9 := CHOOSE ( le.p_financial_class,Tree_78_Node_16,Tree_78_Node_16,Tree_78_Node_17,Tree_78_Node_16,Tree_78_Node_16,Tree_78_Node_16,Tree_78_Node_17,Tree_78_Node_16,Tree_78_Node_16,Tree_78_Node_17,Tree_78_Node_17,Tree_78_Node_16,Tree_78_Node_16,Tree_78_Node_16,Tree_78_Node_16,Tree_78_Node_17);
        Tree_78_Node_4 := IF ( le.p_PrevAddrMedianValue < 208108.5,Tree_78_Node_8,Tree_78_Node_9);
        Tree_78_Node_62 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,178,179);
        Tree_78_Node_63 := IF ( le.p_RelativesPropOwnedCount < 8.5,180,181);
        Tree_78_Node_35 := IF ( le.p_v1_PropTimeLastSale < 10.5,Tree_78_Node_62,Tree_78_Node_63);
        Tree_78_Node_60 := IF ( le.p_age_in_years < 62.119,176,177);
        Tree_78_Node_34 := IF ( le.p_PropAgeNewestSale < 83.5,Tree_78_Node_60,147);
        Tree_78_Node_18 := CHOOSE ( le.p_readmit_lift,Tree_78_Node_35,Tree_78_Node_35,Tree_78_Node_35,Tree_78_Node_35,Tree_78_Node_35,Tree_78_Node_34,Tree_78_Node_34,Tree_78_Node_34,Tree_78_Node_35,Tree_78_Node_35,Tree_78_Node_34,Tree_78_Node_35,Tree_78_Node_35);
        Tree_78_Node_64 := CHOOSE ( le.p_financial_class,182,182,183,182,183,182,182,182,182,182,182,183,182,183,182,182);
        Tree_78_Node_65 := CHOOSE ( le.p_admit_diag,185,185,185,184,184,184,184,184,184,184,184,185,184);
        Tree_78_Node_36 := IF ( le.p_CurrAddrCarTheftIndex < 59.0,Tree_78_Node_64,Tree_78_Node_65);
        Tree_78_Node_67 := IF ( le.p_CurrAddrMedianIncome < 76799.5,186,187);
        Tree_78_Node_37 := CHOOSE ( le.p_readmit_diag,Tree_78_Node_67,Tree_78_Node_67,Tree_78_Node_67,148,148,148,148,148,148,148,Tree_78_Node_67,148,148);
        Tree_78_Node_19 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 1.5,Tree_78_Node_36,Tree_78_Node_37);
        Tree_78_Node_10 := IF ( le.p_v1_CrtRecTimeNewest < 200.5,Tree_78_Node_18,Tree_78_Node_19);
        Tree_78_Node_70 := IF ( le.p_SubjectPhoneCount < 0.5,190,191);
        Tree_78_Node_71 := IF ( le.p_SSNIssueState < 44.5,192,193);
        Tree_78_Node_39 := IF ( le.p_age_in_years < 56.13125,Tree_78_Node_70,Tree_78_Node_71);
        Tree_78_Node_68 := IF ( le.p_PrevAddrAgeNewestRecord < 267.5,188,189);
        Tree_78_Node_38 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 3.5,Tree_78_Node_68,149);
        Tree_78_Node_20 := CHOOSE ( le.p_financial_class,Tree_78_Node_39,Tree_78_Node_39,Tree_78_Node_38,Tree_78_Node_39,Tree_78_Node_38,Tree_78_Node_38,Tree_78_Node_38,Tree_78_Node_38,Tree_78_Node_39,Tree_78_Node_39,Tree_78_Node_38,Tree_78_Node_38,Tree_78_Node_38,Tree_78_Node_39,Tree_78_Node_39,Tree_78_Node_38);
        Tree_78_Node_72 := IF ( le.p_PhoneOtherAgeOldestRecord < 101.0,194,195);
        Tree_78_Node_73 := CHOOSE ( le.p_readmit_diag,197,196,197,196,196,196,196,196,196,196,196,196,196);
        Tree_78_Node_40 := IF ( le.p_RelativesBankruptcyCount < 0.5,Tree_78_Node_72,Tree_78_Node_73);
        Tree_78_Node_21 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 624999.5,Tree_78_Node_40,144);
        Tree_78_Node_11 := CHOOSE ( le.p_readmit_lift,Tree_78_Node_20,Tree_78_Node_20,Tree_78_Node_20,Tree_78_Node_20,Tree_78_Node_20,Tree_78_Node_21,Tree_78_Node_21,Tree_78_Node_21,Tree_78_Node_20,Tree_78_Node_20,Tree_78_Node_20,Tree_78_Node_21,Tree_78_Node_20);
        Tree_78_Node_5 := IF ( le.p_PrevAddrMurderIndex < 47.5,Tree_78_Node_10,Tree_78_Node_11);
        Tree_78_Node_2 := IF ( le.p_PrevAddrMedianIncome < 82169.5,Tree_78_Node_4,Tree_78_Node_5);
        Tree_78_Node_74 := IF ( le.p_v1_LifeEvEverResidedCnt < 2.5,198,199);
        Tree_78_Node_75 := CHOOSE ( le.p_readmit_diag,200,201,200,200,201,200,200,201,201,200,201,200,201);
        Tree_78_Node_42 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 3.5,Tree_78_Node_74,Tree_78_Node_75);
        Tree_78_Node_22 := IF ( le.p_v1_HHPropCurrOwnedCnt < 11.0,Tree_78_Node_42,145);
        Tree_78_Node_76 := CHOOSE ( le.p_readmit_lift,203,203,202,202,202,202,202,202,202,202,202,202,202);
        Tree_78_Node_45 := IF ( le.p_SrcsConfirmIDAddrCount < 10.5,Tree_78_Node_76,150);
        Tree_78_Node_23 := IF ( le.p_PrevAddrLenOfRes < 15.5,146,Tree_78_Node_45);
        Tree_78_Node_12 := IF ( le.p_v1_CrtRecTimeNewest < 232.5,Tree_78_Node_22,Tree_78_Node_23);
        Tree_78_Node_78 := CHOOSE ( le.p_admit_diag,205,204,205,204,204,204,204,204,204,204,205,204,204);
        Tree_78_Node_46 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 0.5,Tree_78_Node_78,151);
        Tree_78_Node_80 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 2.5,206,207);
        Tree_78_Node_81 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 736704.5,208,209);
        Tree_78_Node_47 := CHOOSE ( le.p_readmit_lift,Tree_78_Node_80,Tree_78_Node_81,Tree_78_Node_80,Tree_78_Node_80,Tree_78_Node_81,Tree_78_Node_80,Tree_78_Node_80,Tree_78_Node_80,Tree_78_Node_80,Tree_78_Node_81,Tree_78_Node_80,Tree_78_Node_81,Tree_78_Node_80);
        Tree_78_Node_24 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.53125,Tree_78_Node_46,Tree_78_Node_47);
        Tree_78_Node_13 := IF ( le.p_DerogAge < 160.5,Tree_78_Node_24,141);
        Tree_78_Node_6 := IF ( le.p_CurrAddrAVMValue60 < 232245.5,Tree_78_Node_12,Tree_78_Node_13);
        Tree_78_Node_3 := IF ( le.p_CurrAddrLenOfRes < 698.5,Tree_78_Node_6,140);
        Tree_78_Node_1 := IF ( le.p_NonDerogCount06 < 5.5,Tree_78_Node_2,Tree_78_Node_3);
    UNSIGNED2 Score1_Tree78_node := Tree_78_Node_1;
    REAL8 Score1_Tree78_score := CASE(Score1_Tree78_node,140=>0.042175587,141=>0.042142164,142=>0.054711446,143=>0.046377897,144=>0.06881369,145=>0.042242263,146=>0.020095672,147=>0.002777935,148=>-0.05292086,149=>0.07922271,150=>0.008104916,151=>0.051427476,152=>-0.0010176228,153=>-0.0057940898,154=>5.5048455E-5,155=>0.009510158,156=>0.0032361776,157=>0.026690656,158=>0.083867416,159=>0.014736484,160=>-0.0019107815,161=>-0.0317495,162=>0.009962884,163=>-0.023703663,164=>-0.017940829,165=>0.024233093,166=>-0.007004371,167=>0.009263878,168=>-0.021171242,169=>0.060919583,170=>-0.03700627,171=>-0.014016396,172=>-0.014401467,173=>0.03194217,174=>0.031272568,175=>0.002281332,176=>-0.020725459,177=>-0.04833825,178=>0.007247796,179=>-0.021188017,180=>-0.013068758,181=>0.073170274,182=>-0.04023368,183=>0.05211862,184=>0.00746907,185=>0.098926514,186=>0.035948765,187=>-0.051058277,188=>-0.0051182494,189=>0.05571694,190=>0.018875603,191=>0.07113317,192=>0.009874024,193=>-0.015771413,194=>0.01427221,195=>-0.04113653,196=>0.009754349,197=>0.08252315,198=>-0.005805251,199=>0.014648401,200=>-0.03357861,201=>-0.0033883145,202=>-0.05327697,203=>-0.04129237,204=>-0.051059388,205=>-0.00791141,206=>-0.052668534,207=>-0.016209451,208=>-0.04325692,209=>-5.539803E-4,0);
ENDMACRO;
