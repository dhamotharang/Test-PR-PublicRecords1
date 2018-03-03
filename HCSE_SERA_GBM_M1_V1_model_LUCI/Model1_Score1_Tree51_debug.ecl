﻿EXPORT Model1_Score1_Tree51_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_51_Node_38 := IF ( le.p_v1_ProspectAge < 46.5,107,108);
        Tree_51_Node_39 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.8,109,110);
        Tree_51_Node_24 := IF ( le.p_NonDerogCount12 < 2.5,Tree_51_Node_38,Tree_51_Node_39);
        Tree_51_Node_40 := CHOOSE ( le.p_admit_diag,112,112,112,112,111,111,111,111,111,112,111,111,111);
        Tree_51_Node_41 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 72.0,113,114);
        Tree_51_Node_25 := IF ( le.p_CurrAddrAgeLastSale < 108.5,Tree_51_Node_40,Tree_51_Node_41);
        Tree_51_Node_14 := IF ( le.p_PhoneOtherAgeOldestRecord < 143.5,Tree_51_Node_24,Tree_51_Node_25);
        Tree_51_Node_42 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 2.5,115,116);
        Tree_51_Node_43 := CHOOSE ( le.p_readmit_diag,117,117,118,118,118,118,117,117,118,117,118,118,118);
        Tree_51_Node_26 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_51_Node_42,Tree_51_Node_43);
        Tree_51_Node_44 := IF ( le.p_AddrChangeCount24 < 0.5,119,120);
        Tree_51_Node_45 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 7.5,121,122);
        Tree_51_Node_27 := IF ( le.p_WealthIndex < 4.5,Tree_51_Node_44,Tree_51_Node_45);
        Tree_51_Node_15 := IF ( le.p_AssocRiskLevel < 2.5,Tree_51_Node_26,Tree_51_Node_27);
        Tree_51_Node_8 := IF ( le.p_EstimatedAnnualIncome < 23507.5,Tree_51_Node_14,Tree_51_Node_15);
        Tree_51_Node_46 := IF ( le.p_AddrChangeCount60 < 0.5,123,124);
        Tree_51_Node_47 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 2.5,125,126);
        Tree_51_Node_28 := CHOOSE ( le.p_readmit_lift,Tree_51_Node_46,Tree_51_Node_47,Tree_51_Node_46,Tree_51_Node_46,Tree_51_Node_47,Tree_51_Node_46,Tree_51_Node_46,Tree_51_Node_46,Tree_51_Node_46,Tree_51_Node_46,Tree_51_Node_46,Tree_51_Node_46,Tree_51_Node_46);
        Tree_51_Node_49 := IF ( le.p_v1_HHPPCurrOwnedCnt < 2.5,127,128);
        Tree_51_Node_29 := IF ( le.p_NonDerogCount01 < 2.5,102,Tree_51_Node_49);
        Tree_51_Node_16 := CHOOSE ( le.p_admit_diag,Tree_51_Node_28,Tree_51_Node_29,Tree_51_Node_29,Tree_51_Node_29,Tree_51_Node_28,Tree_51_Node_28,Tree_51_Node_29,Tree_51_Node_29,Tree_51_Node_29,Tree_51_Node_28,Tree_51_Node_28,Tree_51_Node_28,Tree_51_Node_28);
        Tree_51_Node_9 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 169.5,Tree_51_Node_16,96);
        Tree_51_Node_4 := IF ( le.p_CurrAddrAgeLastSale < 548.5,Tree_51_Node_8,Tree_51_Node_9);
        Tree_51_Node_50 := IF ( le.p_v1_HHPropCurrOwnedCnt < 7.5,129,130);
        Tree_51_Node_51 := IF ( le.p_v1_RaAPropOwnerAVMMed < 255783.5,131,132);
        Tree_51_Node_30 := IF ( le.p_v1_PropTimeLastSale < 233.0,Tree_51_Node_50,Tree_51_Node_51);
        Tree_51_Node_31 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 1.5,103,104);
        Tree_51_Node_18 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 237.0,Tree_51_Node_30,Tree_51_Node_31);
        Tree_51_Node_19 := CHOOSE ( le.p_readmit_diag,100,99,100,99,99,99,100,99,99,99,99,99,99);
        Tree_51_Node_10 := IF ( le.p_BPV_2 < 3.0918427,Tree_51_Node_18,Tree_51_Node_19);
        Tree_51_Node_54 := IF ( le.p_PrevAddrMedianIncome < 44081.5,133,134);
        Tree_51_Node_34 := IF ( le.p_v1_PropTimeLastSale < 185.5,Tree_51_Node_54,105);
        Tree_51_Node_57 := IF ( le.p_v1_RaAPropOwnerAVMMed < 199678.5,135,136);
        Tree_51_Node_35 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 149999.5,106,Tree_51_Node_57);
        Tree_51_Node_21 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 1.5,Tree_51_Node_34,Tree_51_Node_35);
        Tree_51_Node_11 := CHOOSE ( le.p_readmit_lift,Tree_51_Node_21,Tree_51_Node_21,Tree_51_Node_21,97,Tree_51_Node_21,97,97,Tree_51_Node_21,97,Tree_51_Node_21,97,97,Tree_51_Node_21);
        Tree_51_Node_5 := IF ( le.p_AccidentAge < 15.5,Tree_51_Node_10,Tree_51_Node_11);
        Tree_51_Node_2 := IF ( le.p_BP_4 < 14.0,Tree_51_Node_4,Tree_51_Node_5);
        Tree_51_Node_58 := IF ( le.p_CurrAddrLenOfRes < 182.5,137,138);
        Tree_51_Node_59 := IF ( le.p_PrevAddrMedianIncome < 48213.5,139,140);
        Tree_51_Node_37 := IF ( le.p_v1_CrtRecTimeNewest < 148.5,Tree_51_Node_58,Tree_51_Node_59);
        Tree_51_Node_22 := CHOOSE ( le.p_readmit_lift,Tree_51_Node_37,Tree_51_Node_37,Tree_51_Node_37,101,101,101,Tree_51_Node_37,101,101,101,101,101,101);
        Tree_51_Node_12 := IF ( le.p_SubjectPhoneCount < 1.5,Tree_51_Node_22,98);
        Tree_51_Node_6 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 187.5,Tree_51_Node_12,95);
        Tree_51_Node_3 := CHOOSE ( le.p_readmit_diag,Tree_51_Node_6,Tree_51_Node_6,Tree_51_Node_6,Tree_51_Node_6,94,Tree_51_Node_6,Tree_51_Node_6,Tree_51_Node_6,94,Tree_51_Node_6,Tree_51_Node_6,Tree_51_Node_6,Tree_51_Node_6);
        Tree_51_Node_1 := IF ( le.p_EvictionAge < 151.5,Tree_51_Node_2,Tree_51_Node_3);
    SELF.Score1_Tree51_node := Tree_51_Node_1;
    SELF.Score1_Tree51_score := CASE(SELF.Score1_Tree51_node,128=>0.011157708,129=>-0.002500503,130=>0.023794176,131=>-0.009044616,132=>0.0956309,133=>-0.037418574,134=>-0.012103236,135=>0.09970052,136=>-0.011039265,137=>-0.03127009,138=>0.025761625,139=>-0.07114515,140=>-0.0326498,94=>0.07325651,95=>0.080202155,96=>0.04138928,97=>-0.05767167,98=>0.050318606,99=>0.008467538,100=>0.07601605,101=>-0.06405601,102=>0.054499418,103=>-0.018290605,104=>0.098480016,105=>0.04814786,106=>-0.0539325,107=>0.079274334,108=>-0.0064701824,109=>0.02391561,110=>-0.013259508,111=>0.0052774088,112=>0.07928934,113=>-0.062001515,114=>0.048622273,115=>0.006396165,116=>0.032652013,117=>-0.0028959846,118=>0.006304228,119=>0.0030970082,120=>-0.005353045,121=>-0.01638259,122=>0.10482747,123=>-0.071682945,124=>-0.056323435,125=>-0.019675506,126=>-0.06790589,127=>-0.049123645,0);
ENDMACRO;
