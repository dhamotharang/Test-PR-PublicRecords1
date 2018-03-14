﻿EXPORT Model1_Score1_Tree134(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_134_Node_46 := IF ( le.p_SubjectAddrCount < 24.5,124,125);
        Tree_134_Node_47 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 289.5,126,127);
        Tree_134_Node_28 := IF ( le.p_RelativesCount < 25.5,Tree_134_Node_46,Tree_134_Node_47);
        Tree_134_Node_48 := IF ( le.p_EstimatedAnnualIncome < 25950.5,128,129);
        Tree_134_Node_49 := IF ( le.p_EvictionAge < 192.5,130,131);
        Tree_134_Node_29 := CHOOSE ( le.p_financial_class,Tree_134_Node_48,Tree_134_Node_48,Tree_134_Node_48,Tree_134_Node_48,Tree_134_Node_48,Tree_134_Node_48,Tree_134_Node_49,Tree_134_Node_48,Tree_134_Node_49,Tree_134_Node_48,Tree_134_Node_48,Tree_134_Node_49,Tree_134_Node_49,Tree_134_Node_49,Tree_134_Node_48,Tree_134_Node_48);
        Tree_134_Node_16 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 0.5,Tree_134_Node_28,Tree_134_Node_29);
        Tree_134_Node_52 := CHOOSE ( le.p_readmit_diag,136,136,136,137,136,136,136,136,136,136,136,136,136);
        Tree_134_Node_53 := IF ( le.p_RelativesPropOwnedCount < 2.5,138,139);
        Tree_134_Node_31 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 0.5,Tree_134_Node_52,Tree_134_Node_53);
        Tree_134_Node_50 := IF ( le.p_CurrAddrBurglaryIndex < 160.5,132,133);
        Tree_134_Node_51 := CHOOSE ( le.p_readmit_lift,135,135,134,135,135,135,134,134,134,134,134,134,134);
        Tree_134_Node_30 := IF ( le.p_BP_3 < 1.5,Tree_134_Node_50,Tree_134_Node_51);
        Tree_134_Node_17 := CHOOSE ( le.p_financial_class,Tree_134_Node_31,Tree_134_Node_30,Tree_134_Node_31,Tree_134_Node_31,Tree_134_Node_30,Tree_134_Node_31,Tree_134_Node_30,Tree_134_Node_31,Tree_134_Node_31,Tree_134_Node_31,Tree_134_Node_30,Tree_134_Node_30,Tree_134_Node_30,Tree_134_Node_31,Tree_134_Node_31,Tree_134_Node_30);
        Tree_134_Node_8 := IF ( le.p_PhoneEDAAgeNewestRecord < 48.5,Tree_134_Node_16,Tree_134_Node_17);
        Tree_134_Node_32 := CHOOSE ( le.p_readmit_diag,115,115,114,114,114,114,115,114,115,115,114,114,114);
        Tree_134_Node_33 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 9.5,116,117);
        Tree_134_Node_18 := IF ( le.p_AddrChangeCount60 < 2.5,Tree_134_Node_32,Tree_134_Node_33);
        Tree_134_Node_35 := IF ( le.p_CurrAddrMurderIndex < 69.5,118,119);
        Tree_134_Node_58 := CHOOSE ( le.p_readmit_lift,141,141,140,140,141,140,140,141,140,140,140,140,140);
        Tree_134_Node_59 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 2.5,142,143);
        Tree_134_Node_34 := IF ( le.p_CurrAddrBlockIndex < 1.1278125,Tree_134_Node_58,Tree_134_Node_59);
        Tree_134_Node_19 := CHOOSE ( le.p_financial_class,Tree_134_Node_35,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_35,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_34,Tree_134_Node_35,Tree_134_Node_34);
        Tree_134_Node_9 := IF ( le.p_PrevAddrAgeOldestRecord < 31.5,Tree_134_Node_18,Tree_134_Node_19);
        Tree_134_Node_4 := IF ( le.p_RelativesBankruptcyCount < 7.5,Tree_134_Node_8,Tree_134_Node_9);
        Tree_134_Node_23 := CHOOSE ( le.p_readmit_lift,110,111,110,110,110,110,110,110,110,110,110,110,110);
        Tree_134_Node_11 := IF ( le.p_v1_LifeEvEverResidedCnt < 2.0,107,Tree_134_Node_23);
        Tree_134_Node_36 := IF ( le.p_CurrAddrMedianValue < 249999.5,120,121);
        Tree_134_Node_21 := IF ( le.p_PropAgeOldestPurchase < 207.5,Tree_134_Node_36,109);
        Tree_134_Node_10 := CHOOSE ( le.p_readmit_diag,106,Tree_134_Node_21,106,106,106,106,106,106,106,106,106,106,106);
        Tree_134_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_134_Node_11,Tree_134_Node_10,Tree_134_Node_11,Tree_134_Node_11,Tree_134_Node_10,Tree_134_Node_10,Tree_134_Node_10,Tree_134_Node_10,Tree_134_Node_10,Tree_134_Node_10,Tree_134_Node_11,Tree_134_Node_10,Tree_134_Node_10);
        Tree_134_Node_2 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 1542967.5,Tree_134_Node_4,Tree_134_Node_5);
        Tree_134_Node_64 := IF ( le.p_PrevAddrCarTheftIndex < 140.5,144,145);
        Tree_134_Node_65 := IF ( le.p_AssocSuspicousIdentitiesCount < 10.0,146,147);
        Tree_134_Node_40 := IF ( le.p_PrevAddrCrimeIndex < 130.5,Tree_134_Node_64,Tree_134_Node_65);
        Tree_134_Node_66 := IF ( le.p_DivSSNAddrMSourceCount < 3.5,148,149);
        Tree_134_Node_41 := IF ( le.p_v1_RaAMedIncomeRange < 7.5,Tree_134_Node_66,122);
        Tree_134_Node_24 := CHOOSE ( le.p_readmit_diag,Tree_134_Node_40,Tree_134_Node_40,Tree_134_Node_41,Tree_134_Node_40,Tree_134_Node_41,Tree_134_Node_41,Tree_134_Node_41,Tree_134_Node_40,Tree_134_Node_40,Tree_134_Node_41,Tree_134_Node_40,Tree_134_Node_40,Tree_134_Node_40);
        Tree_134_Node_14 := IF ( le.p_v1_RaAPropOwnerAVMMed < 559962.5,Tree_134_Node_24,108);
        Tree_134_Node_69 := CHOOSE ( le.p_readmit_diag,151,151,151,150,150,150,150,150,150,150,151,150,150);
        Tree_134_Node_42 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.0486112,123,Tree_134_Node_69);
        Tree_134_Node_70 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 2.5,152,153);
        Tree_134_Node_71 := IF ( le.p_PhoneOtherAgeNewestRecord < 14.0,154,155);
        Tree_134_Node_43 := IF ( le.p_CurrAddrLenOfRes < 225.5,Tree_134_Node_70,Tree_134_Node_71);
        Tree_134_Node_26 := IF ( le.p_SSNIssueState < 22.0,Tree_134_Node_42,Tree_134_Node_43);
        Tree_134_Node_27 := CHOOSE ( le.p_readmit_diag,113,112,113,113,113,112,113,112,113,112,112,112,112);
        Tree_134_Node_15 := IF ( le.p_PhoneOtherAgeNewestRecord < 98.5,Tree_134_Node_26,Tree_134_Node_27);
        Tree_134_Node_7 := IF ( le.p_PhoneEDAAgeNewestRecord < 75.5,Tree_134_Node_14,Tree_134_Node_15);
        Tree_134_Node_6 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 7.5,104,105);
        Tree_134_Node_3 := CHOOSE ( le.p_readmit_lift,Tree_134_Node_7,Tree_134_Node_7,Tree_134_Node_7,Tree_134_Node_7,Tree_134_Node_6,Tree_134_Node_6,Tree_134_Node_6,Tree_134_Node_7,Tree_134_Node_6,Tree_134_Node_7,Tree_134_Node_7,Tree_134_Node_7,Tree_134_Node_7);
        Tree_134_Node_1 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 5.5,Tree_134_Node_2,Tree_134_Node_3);
    UNSIGNED2 Score1_Tree134_node := Tree_134_Node_1;
    REAL8 Score1_Tree134_score := CASE(Score1_Tree134_node,104=>-0.01613191,105=>-0.03246144,106=>-0.029739385,107=>0.025433833,108=>0.028602177,109=>-0.009571404,110=>-0.030472495,111=>-0.004946681,112=>-0.0096950205,113=>0.051663734,114=>0.007286992,115=>0.044893418,116=>-0.029899873,117=>0.022209993,118=>0.031496134,119=>-0.0017962013,120=>-0.02890031,121=>-0.028351482,122=>0.03247135,123=>-0.023160176,124=>-5.2917673E-4,125=>0.006700657,126=>0.005465741,127=>0.04347574,128=>0.0153249465,129=>-0.0012858069,130=>0.0028931636,131=>0.03307596,132=>-0.0021810213,133=>-0.008793687,134=>-0.03231085,135=>-0.008467835,136=>-0.0032099357,137=>0.0070637357,138=>0.004692836,139=>-0.002394057,140=>-0.028271466,141=>-0.0046777204,142=>-0.0036203514,143=>0.034167457,144=>-0.0056350296,145=>0.023226956,146=>-0.014298666,147=>0.0091619985,148=>0.027343187,149=>-0.0035895787,150=>-0.0038145008,151=>0.052269578,152=>-0.010877027,153=>0.015305969,154=>0.046131004,155=>-0.0050727,0);
ENDMACRO;
