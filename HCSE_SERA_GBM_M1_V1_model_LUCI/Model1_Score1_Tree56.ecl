﻿EXPORT Model1_Score1_Tree56(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_56_Node_38 := IF ( le.p_age_in_years < 92.82,112,113);
        Tree_56_Node_39 := CHOOSE ( le.p_financial_class,114,115,115,114,114,114,115,114,115,114,115,114,115,115,114,114);
        Tree_56_Node_24 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 4.5,Tree_56_Node_38,Tree_56_Node_39);
        Tree_56_Node_40 := CHOOSE ( le.p_financial_class,116,116,116,116,116,117,117,116,116,116,116,117,116,116,116,116);
        Tree_56_Node_25 := IF ( le.p_AddrChangeCount60 < 5.5,Tree_56_Node_40,107);
        Tree_56_Node_14 := IF ( le.p_EvictionAge < 44.5,Tree_56_Node_24,Tree_56_Node_25);
        Tree_56_Node_44 := CHOOSE ( le.p_readmit_lift,122,122,122,122,122,122,122,122,123,122,123,122,123);
        Tree_56_Node_45 := IF ( le.p_EstimatedAnnualIncome < 35000.5,124,125);
        Tree_56_Node_27 := CHOOSE ( le.p_financial_class,Tree_56_Node_44,Tree_56_Node_44,Tree_56_Node_45,Tree_56_Node_44,Tree_56_Node_44,Tree_56_Node_44,Tree_56_Node_44,Tree_56_Node_45,Tree_56_Node_45,Tree_56_Node_45,Tree_56_Node_45,Tree_56_Node_45,Tree_56_Node_44,Tree_56_Node_45,Tree_56_Node_45,Tree_56_Node_44);
        Tree_56_Node_43 := IF ( le.p_v1_ProspectTimeLastUpdate < 143.5,120,121);
        Tree_56_Node_42 := IF ( le.p_CurrAddrMedianValue < 199999.5,118,119);
        Tree_56_Node_26 := CHOOSE ( le.p_financial_class,Tree_56_Node_43,Tree_56_Node_43,Tree_56_Node_43,Tree_56_Node_43,Tree_56_Node_42,Tree_56_Node_43,Tree_56_Node_43,Tree_56_Node_43,Tree_56_Node_42,Tree_56_Node_43,Tree_56_Node_42,Tree_56_Node_42,Tree_56_Node_43,Tree_56_Node_42,Tree_56_Node_42,Tree_56_Node_43);
        Tree_56_Node_15 := CHOOSE ( le.p_patient_type,Tree_56_Node_27,Tree_56_Node_26);
        Tree_56_Node_8 := IF ( le.p_BPV_4 < -2.738854,Tree_56_Node_14,Tree_56_Node_15);
        Tree_56_Node_46 := IF ( le.p_DivSSNIdentityMSourceCount < 1.5,126,127);
        Tree_56_Node_47 := CHOOSE ( le.p_readmit_diag,128,128,128,129,129,129,129,128,129,129,128,129,128);
        Tree_56_Node_28 := IF ( le.p_age_in_years < 87.31125,Tree_56_Node_46,Tree_56_Node_47);
        Tree_56_Node_17 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 2.5,Tree_56_Node_28,105);
        Tree_56_Node_9 := IF ( le.p_NonDerogCount01 < 1.5,102,Tree_56_Node_17);
        Tree_56_Node_4 := IF ( le.p_PrevAddrAgeOldestRecord < 516.5,Tree_56_Node_8,Tree_56_Node_9);
        Tree_56_Node_49 := IF ( le.p_PhoneEDAAgeOldestRecord < 193.5,132,133);
        Tree_56_Node_48 := IF ( le.p_v1_HHPropCurrOwnedCnt < 2.5,130,131);
        Tree_56_Node_30 := CHOOSE ( le.p_admit_diag,Tree_56_Node_49,Tree_56_Node_48,Tree_56_Node_49,Tree_56_Node_48,Tree_56_Node_49,Tree_56_Node_48,Tree_56_Node_48,Tree_56_Node_49,Tree_56_Node_48,Tree_56_Node_48,Tree_56_Node_49,Tree_56_Node_48,Tree_56_Node_48);
        Tree_56_Node_50 := CHOOSE ( le.p_readmit_lift,135,135,134,135,134,135,135,135,135,135,134,134,134);
        Tree_56_Node_31 := CHOOSE ( le.p_readmit_diag,Tree_56_Node_50,Tree_56_Node_50,Tree_56_Node_50,Tree_56_Node_50,Tree_56_Node_50,Tree_56_Node_50,Tree_56_Node_50,Tree_56_Node_50,108,108,Tree_56_Node_50,Tree_56_Node_50,Tree_56_Node_50);
        Tree_56_Node_18 := CHOOSE ( le.p_financial_class,Tree_56_Node_30,Tree_56_Node_30,Tree_56_Node_31,Tree_56_Node_30,Tree_56_Node_31,Tree_56_Node_30,Tree_56_Node_30,Tree_56_Node_30,Tree_56_Node_30,Tree_56_Node_30,Tree_56_Node_31,Tree_56_Node_31,Tree_56_Node_30,Tree_56_Node_31,Tree_56_Node_30,Tree_56_Node_30);
        Tree_56_Node_10 := IF ( le.p_v1_RaAPropOwnerAVMMed < 72937.0,Tree_56_Node_18,103);
        Tree_56_Node_55 := IF ( le.p_v1_ProspectTimeLastUpdate < 528.5,136,137);
        Tree_56_Node_33 := IF ( le.p_AddrStability < 3.5,111,Tree_56_Node_55);
        Tree_56_Node_32 := IF ( le.p_v1_HHPropCurrOwnedCnt < 1.5,109,110);
        Tree_56_Node_20 := CHOOSE ( le.p_readmit_lift,Tree_56_Node_33,Tree_56_Node_33,Tree_56_Node_33,Tree_56_Node_32,Tree_56_Node_32,Tree_56_Node_32,Tree_56_Node_32,Tree_56_Node_32,Tree_56_Node_32,Tree_56_Node_32,Tree_56_Node_32,Tree_56_Node_33,Tree_56_Node_32);
        Tree_56_Node_56 := CHOOSE ( le.p_readmit_lift,138,139,139,138,139,139,138,138,138,138,138,139,138);
        Tree_56_Node_57 := IF ( le.p_PhoneEDAAgeOldestRecord < 193.5,140,141);
        Tree_56_Node_35 := IF ( le.p_v1_RaAPropOwnerAVMMed < 284886.5,Tree_56_Node_56,Tree_56_Node_57);
        Tree_56_Node_21 := IF ( le.p_PrevAddrMedianValue < 75853.5,106,Tree_56_Node_35);
        Tree_56_Node_11 := IF ( le.p_PrevAddrAgeLastSale < 47.5,Tree_56_Node_20,Tree_56_Node_21);
        Tree_56_Node_5 := IF ( le.p_v1_RaAPropOwnerAVMMed < 78124.5,Tree_56_Node_10,Tree_56_Node_11);
        Tree_56_Node_2 := IF ( le.p_PropAgeOldestPurchase < 509.0,Tree_56_Node_4,Tree_56_Node_5);
        Tree_56_Node_58 := CHOOSE ( le.p_readmit_lift,142,143,143,142,142,142,142,142,142,143,142,142,142);
        Tree_56_Node_59 := IF ( le.p_v1_CrtRecTimeNewest < 83.0,144,145);
        Tree_56_Node_36 := IF ( le.p_CurrAddrMedianIncome < 61022.5,Tree_56_Node_58,Tree_56_Node_59);
        Tree_56_Node_60 := IF ( le.p_PrevAddrCarTheftIndex < 69.5,146,147);
        Tree_56_Node_61 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 2.5,148,149);
        Tree_56_Node_37 := IF ( le.p_PhoneEDAAgeNewestRecord < 99.5,Tree_56_Node_60,Tree_56_Node_61);
        Tree_56_Node_22 := CHOOSE ( le.p_readmit_diag,Tree_56_Node_36,Tree_56_Node_37,Tree_56_Node_37,Tree_56_Node_37,Tree_56_Node_36,Tree_56_Node_36,Tree_56_Node_36,Tree_56_Node_36,Tree_56_Node_36,Tree_56_Node_36,Tree_56_Node_36,Tree_56_Node_37,Tree_56_Node_36);
        Tree_56_Node_12 := IF ( le.p_SubjectPhoneCount < 1.5,Tree_56_Node_22,104);
        Tree_56_Node_6 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 187.5,Tree_56_Node_12,101);
        Tree_56_Node_3 := CHOOSE ( le.p_readmit_diag,Tree_56_Node_6,Tree_56_Node_6,Tree_56_Node_6,Tree_56_Node_6,100,Tree_56_Node_6,Tree_56_Node_6,Tree_56_Node_6,100,Tree_56_Node_6,Tree_56_Node_6,Tree_56_Node_6,Tree_56_Node_6);
        Tree_56_Node_1 := IF ( le.p_EvictionAge < 151.5,Tree_56_Node_2,Tree_56_Node_3);
    UNSIGNED2 Score1_Tree56_node := Tree_56_Node_1;
    REAL8 Score1_Tree56_score := CASE(Score1_Tree56_node,100=>0.061248545,101=>0.06739866,102=>0.07173689,103=>0.10462045,104=>0.043455184,105=>0.026963064,106=>0.05798132,107=>0.029100256,108=>0.092081115,109=>-0.011526678,110=>-0.07150598,111=>0.046415526,112=>-0.004017838,113=>-0.023329949,114=>-0.045911927,115=>0.021467581,116=>-0.04227183,117=>0.028161442,118=>-0.020507421,119=>0.00403434,120=>0.0023894317,121=>0.15983522,122=>-0.007188223,123=>0.04220048,124=>0.0047700983,125=>7.20959E-4,126=>-0.044913795,127=>-0.016500698,128=>-0.022170054,129=>0.042893812,130=>-0.052760076,131=>-0.008101495,132=>-0.010133485,133=>0.08085437,134=>-0.026434856,135=>0.020242317,136=>-0.029382195,137=>0.01841864,138=>-0.041443985,139=>-0.0033689318,140=>0.0062820893,141=>0.11256741,142=>-0.07045989,143=>-0.049200945,144=>-0.06467068,145=>0.018276189,146=>-0.0114362845,147=>-0.05435839,148=>-0.025185667,149=>0.07836869,0);
ENDMACRO;
