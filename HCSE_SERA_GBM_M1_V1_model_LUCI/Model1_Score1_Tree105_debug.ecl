EXPORT Model1_Score1_Tree105_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_105_Node_44 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 8.5,133,134);
        Tree_105_Node_45 := CHOOSE ( le.p_readmit_diag,135,135,135,136,135,136,136,135,135,136,135,135,136);
        Tree_105_Node_24 := IF ( le.p_SubjectAddrCount < 37.5,Tree_105_Node_44,Tree_105_Node_45);
        Tree_105_Node_46 := CHOOSE ( le.p_admit_diag,138,138,138,138,138,137,138,137,137,138,137,138,138);
        Tree_105_Node_47 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 5.5,139,140);
        Tree_105_Node_25 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 1.5,Tree_105_Node_46,Tree_105_Node_47);
        Tree_105_Node_14 := IF ( le.p_CurrAddrAVMValue60 < 38883.5,Tree_105_Node_24,Tree_105_Node_25);
        Tree_105_Node_50 := CHOOSE ( le.p_financial_class,141,141,142,141,142,141,141,141,142,141,141,142,142,142,141,141);
        Tree_105_Node_51 := IF ( le.p_PropAgeNewestPurchase < 287.5,143,144);
        Tree_105_Node_27 := CHOOSE ( le.p_readmit_diag,Tree_105_Node_50,Tree_105_Node_50,Tree_105_Node_50,Tree_105_Node_50,Tree_105_Node_51,Tree_105_Node_51,Tree_105_Node_51,Tree_105_Node_50,Tree_105_Node_50,Tree_105_Node_50,Tree_105_Node_51,Tree_105_Node_50,Tree_105_Node_50);
        Tree_105_Node_26 := IF ( le.p_v1_HHPPCurrOwnedCnt < 1.5,120,121);
        Tree_105_Node_15 := CHOOSE ( le.p_readmit_lift,Tree_105_Node_27,Tree_105_Node_27,Tree_105_Node_27,Tree_105_Node_26,Tree_105_Node_26,Tree_105_Node_27,Tree_105_Node_26,Tree_105_Node_26,Tree_105_Node_26,Tree_105_Node_27,Tree_105_Node_27,Tree_105_Node_26,Tree_105_Node_27);
        Tree_105_Node_8 := IF ( le.p_CurrAddrAVMValue60 < 55300.5,Tree_105_Node_14,Tree_105_Node_15);
        Tree_105_Node_52 := IF ( le.p_SrcsConfirmIDAddrCount < 9.5,145,146);
        Tree_105_Node_53 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,147,148);
        Tree_105_Node_28 := IF ( le.p_BPV_4 < -1.9918938,Tree_105_Node_52,Tree_105_Node_53);
        Tree_105_Node_54 := CHOOSE ( le.p_financial_class,149,150,149,149,149,149,149,149,150,150,150,149,149,149,150,150);
        Tree_105_Node_55 := CHOOSE ( le.p_admit_diag,151,151,151,152,151,152,152,151,151,151,151,151,151);
        Tree_105_Node_29 := IF ( le.p_AccidentAge < 55.5,Tree_105_Node_54,Tree_105_Node_55);
        Tree_105_Node_16 := IF ( le.p_P_EstimatedHHIncomePerCapita < 4.234375,Tree_105_Node_28,Tree_105_Node_29);
        Tree_105_Node_30 := IF ( le.p_RelativesBankruptcyCount < 2.5,122,123);
        Tree_105_Node_31 := IF ( le.p_CurrAddrAgeLastSale < 90.5,124,125);
        Tree_105_Node_17 := IF ( le.p_CurrAddrMedianValue < 140624.5,Tree_105_Node_30,Tree_105_Node_31);
        Tree_105_Node_9 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 6.5,Tree_105_Node_16,Tree_105_Node_17);
        Tree_105_Node_4 := IF ( le.p_CurrAddrAVMValue60 < 74510.5,Tree_105_Node_8,Tree_105_Node_9);
        Tree_105_Node_60 := IF ( le.p_v1_ProspectTimeLastUpdate < 59.5,153,154);
        Tree_105_Node_61 := IF ( le.p_PhoneEDAAgeOldestRecord < 183.5,155,156);
        Tree_105_Node_32 := IF ( le.p_PhoneOtherAgeNewestRecord < 33.5,Tree_105_Node_60,Tree_105_Node_61);
        Tree_105_Node_18 := IF ( le.p_PropAgeOldestPurchase < 362.0,Tree_105_Node_32,116);
        Tree_105_Node_35 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 0.5,126,127);
        Tree_105_Node_19 := IF ( le.p_CurrAddrMedianIncome < 31026.5,117,Tree_105_Node_35);
        Tree_105_Node_10 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 150.5,Tree_105_Node_18,Tree_105_Node_19);
        Tree_105_Node_5 := IF ( le.p_LienFiledAge < 227.0,Tree_105_Node_10,115);
        Tree_105_Node_2 := IF ( le.p_BPV_1 < 2.4171953,Tree_105_Node_4,Tree_105_Node_5);
        Tree_105_Node_64 := IF ( le.p_DivSSNIdentityMSourceUrelCount < 1.5,157,158);
        Tree_105_Node_36 := IF ( le.p_BP_4 < 16.0,Tree_105_Node_64,128);
        Tree_105_Node_37 := IF ( le.p_WealthIndex < 2.5,129,130);
        Tree_105_Node_20 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 5.5,Tree_105_Node_36,Tree_105_Node_37);
        Tree_105_Node_70 := IF ( le.p_PrevAddrMedianIncome < 25496.5,163,164);
        Tree_105_Node_71 := CHOOSE ( le.p_financial_class,165,165,165,165,166,165,165,165,166,165,165,166,165,165,165,165);
        Tree_105_Node_39 := IF ( le.p_CurrAddrLenOfRes < 200.5,Tree_105_Node_70,Tree_105_Node_71);
        Tree_105_Node_68 := IF ( le.p_NonDerogCount < 7.5,159,160);
        Tree_105_Node_69 := IF ( le.p_CurrAddrCarTheftIndex < 100.0,161,162);
        Tree_105_Node_38 := CHOOSE ( le.p_readmit_lift,Tree_105_Node_68,Tree_105_Node_69,Tree_105_Node_69,Tree_105_Node_68,Tree_105_Node_69,Tree_105_Node_68,Tree_105_Node_68,Tree_105_Node_68,Tree_105_Node_68,Tree_105_Node_69,Tree_105_Node_68,Tree_105_Node_68,Tree_105_Node_69);
        Tree_105_Node_21 := CHOOSE ( le.p_admit_diag,Tree_105_Node_39,Tree_105_Node_39,Tree_105_Node_38,Tree_105_Node_38,Tree_105_Node_39,Tree_105_Node_39,Tree_105_Node_38,Tree_105_Node_39,Tree_105_Node_39,Tree_105_Node_38,Tree_105_Node_39,Tree_105_Node_38,Tree_105_Node_39);
        Tree_105_Node_12 := IF ( le.p_NonDerogCount06 < 2.5,Tree_105_Node_20,Tree_105_Node_21);
        Tree_105_Node_72 := CHOOSE ( le.p_readmit_diag,167,167,167,167,167,167,167,167,167,168,168,167,168);
        Tree_105_Node_40 := IF ( le.p_AgeOldestRecord < 410.5,Tree_105_Node_72,131);
        Tree_105_Node_75 := CHOOSE ( le.p_financial_class,169,169,170,169,169,169,170,169,169,170,169,169,169,170,169,169);
        Tree_105_Node_41 := IF ( le.p_PrevAddrMedianIncome < 62000.5,132,Tree_105_Node_75);
        Tree_105_Node_22 := IF ( le.p_PrevAddrMedianIncome < 55775.5,Tree_105_Node_40,Tree_105_Node_41);
        Tree_105_Node_23 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 5.5,118,119);
        Tree_105_Node_13 := IF ( le.p_v1_CrtRecTimeNewest < 132.5,Tree_105_Node_22,Tree_105_Node_23);
        Tree_105_Node_6 := CHOOSE ( le.p_readmit_diag,Tree_105_Node_12,Tree_105_Node_12,Tree_105_Node_12,Tree_105_Node_13,Tree_105_Node_13,Tree_105_Node_12,Tree_105_Node_12,Tree_105_Node_12,Tree_105_Node_13,Tree_105_Node_13,Tree_105_Node_13,Tree_105_Node_12,Tree_105_Node_13);
        Tree_105_Node_3 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 319.0,Tree_105_Node_6,114);
        Tree_105_Node_1 := IF ( le.p_AssocSuspicousIdentitiesCount < 5.5,Tree_105_Node_2,Tree_105_Node_3);
    SELF.Score1_Tree105_node := Tree_105_Node_1;
    SELF.Score1_Tree105_score := CASE(SELF.Score1_Tree105_node,114=>0.030790672,115=>-0.035421915,116=>0.028284403,117=>0.04840415,118=>0.06584106,119=>0.014277731,120=>-0.039726514,121=>-6.4742216E-4,122=>0.017652178,123=>-0.034936193,124=>0.01889328,125=>0.072365135,126=>0.025886364,127=>-0.019335032,128=>0.044031054,129=>0.0053476742,130=>0.055005863,131=>0.017906372,132=>0.055788036,133=>-5.466034E-4,134=>-0.014330804,135=>0.0047985525,136=>0.061883204,137=>-0.02171689,138=>0.02912746,139=>-0.0024226075,140=>0.04167554,141=>-0.024369938,142=>-0.005375055,143=>0.022456259,144=>-0.032434713,145=>-0.0066607706,146=>0.010094872,147=>0.002160121,148=>-0.0028613727,149=>0.0019895483,150=>0.011258609,151=>-0.028422207,152=>0.022621749,153=>0.008500067,154=>-0.020624222,155=>-0.010620363,156=>0.017751602,157=>-0.027461264,158=>0.015380341,159=>-0.01609829,160=>-0.043292023,161=>-0.03015506,162=>8.874104E-4,163=>0.0044194646,164=>-0.013436988,165=>-0.0070361076,166=>0.03132248,167=>-0.030088054,168=>-0.0013251398,169=>-0.016602725,170=>0.03281904,0);
ENDMACRO;
