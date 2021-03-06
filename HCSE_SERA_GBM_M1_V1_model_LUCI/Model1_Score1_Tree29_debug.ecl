EXPORT Model1_Score1_Tree29_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_29_Node_5 := IF ( le.p_age_in_years < 0.46238708,126,127);
        Tree_29_Node_53 := IF ( le.p_age_in_years < 0.13141784,147,148);
        Tree_29_Node_28 := CHOOSE ( le.p_readmit_lift,136,136,Tree_29_Node_53,Tree_29_Node_53,Tree_29_Node_53,Tree_29_Node_53,136,Tree_29_Node_53,Tree_29_Node_53,Tree_29_Node_53,Tree_29_Node_53,Tree_29_Node_53,136);
        Tree_29_Node_16 := IF ( le.p_age_in_years < 0.34472615,Tree_29_Node_28,128);
        Tree_29_Node_17 := IF ( le.p_age_in_years < 1.1930797,129,130);
        Tree_29_Node_8 := IF ( le.p_age_in_years < 0.76231384,Tree_29_Node_16,Tree_29_Node_17);
        Tree_29_Node_34 := IF ( le.p_age_in_years < 0.28899956,139,140);
        Tree_29_Node_19 := IF ( le.p_age_in_years < 0.68733215,Tree_29_Node_34,131);
        Tree_29_Node_56 := CHOOSE ( le.p_financial_class,151,152,151,151,151,151,151,151,151,151,151,152,151,152,151,151);
        Tree_29_Node_33 := IF ( le.p_SSNLowIssueAge < 31.5,Tree_29_Node_56,138);
        Tree_29_Node_55 := IF ( le.p_age_in_years < 1.199707,149,150);
        Tree_29_Node_32 := CHOOSE ( le.p_financial_class,Tree_29_Node_55,137,Tree_29_Node_55,Tree_29_Node_55,137,Tree_29_Node_55,Tree_29_Node_55,Tree_29_Node_55,Tree_29_Node_55,Tree_29_Node_55,Tree_29_Node_55,Tree_29_Node_55,Tree_29_Node_55,137,137,Tree_29_Node_55);
        Tree_29_Node_18 := CHOOSE ( le.p_readmit_lift,Tree_29_Node_33,Tree_29_Node_32,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33,Tree_29_Node_33);
        Tree_29_Node_9 := CHOOSE ( le.p_admit_diag,Tree_29_Node_19,Tree_29_Node_18,Tree_29_Node_19,Tree_29_Node_18,Tree_29_Node_19,Tree_29_Node_19,Tree_29_Node_19,Tree_29_Node_19,Tree_29_Node_19,Tree_29_Node_19,Tree_29_Node_19,Tree_29_Node_19,Tree_29_Node_19);
        Tree_29_Node_4 := CHOOSE ( le.p_readmit_diag,Tree_29_Node_8,Tree_29_Node_9,Tree_29_Node_8,Tree_29_Node_9,Tree_29_Node_8,Tree_29_Node_8,Tree_29_Node_8,Tree_29_Node_9,Tree_29_Node_9,Tree_29_Node_8,Tree_29_Node_8,Tree_29_Node_8,Tree_29_Node_9);
        Tree_29_Node_2 := CHOOSE ( le.p_admit_diag,Tree_29_Node_5,Tree_29_Node_4,Tree_29_Node_4,Tree_29_Node_4,Tree_29_Node_5,Tree_29_Node_4,Tree_29_Node_4,Tree_29_Node_4,Tree_29_Node_4,Tree_29_Node_5,Tree_29_Node_4,Tree_29_Node_4,Tree_29_Node_4);
        Tree_29_Node_60 := IF ( le.p_SubjectSSNCount < 4.5,153,154);
        Tree_29_Node_61 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.5,155,156);
        Tree_29_Node_36 := CHOOSE ( le.p_readmit_lift,Tree_29_Node_60,Tree_29_Node_60,Tree_29_Node_60,Tree_29_Node_60,Tree_29_Node_60,Tree_29_Node_61,Tree_29_Node_61,Tree_29_Node_61,Tree_29_Node_60,Tree_29_Node_60,Tree_29_Node_61,Tree_29_Node_60,Tree_29_Node_61);
        Tree_29_Node_62 := IF ( le.p_v1_HHSeniorMmbrCnt < 0.5,157,158);
        Tree_29_Node_63 := IF ( le.p_SSNIssueState < 14.5,159,160);
        Tree_29_Node_37 := CHOOSE ( le.p_financial_class,Tree_29_Node_62,Tree_29_Node_62,Tree_29_Node_63,Tree_29_Node_63,Tree_29_Node_62,Tree_29_Node_63,Tree_29_Node_62,Tree_29_Node_63,Tree_29_Node_63,Tree_29_Node_63,Tree_29_Node_62,Tree_29_Node_63,Tree_29_Node_63,Tree_29_Node_63,Tree_29_Node_63,Tree_29_Node_62);
        Tree_29_Node_20 := IF ( le.p_PrevAddrBurglaryIndex < 180.5,Tree_29_Node_36,Tree_29_Node_37);
        Tree_29_Node_64 := IF ( le.p_EvictionAge < 11.5,161,162);
        Tree_29_Node_38 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 9.5,Tree_29_Node_64,141);
        Tree_29_Node_66 := IF ( le.p_CurrAddrMedianIncome < 69759.5,163,164);
        Tree_29_Node_67 := IF ( le.p_v1_ProspectTimeLastUpdate < 89.5,165,166);
        Tree_29_Node_39 := IF ( le.p_PrevAddrMedianIncome < 42896.5,Tree_29_Node_66,Tree_29_Node_67);
        Tree_29_Node_21 := IF ( le.p_CurrAddrCountyIndex < 0.778125,Tree_29_Node_38,Tree_29_Node_39);
        Tree_29_Node_12 := CHOOSE ( le.p_readmit_diag,Tree_29_Node_20,Tree_29_Node_20,Tree_29_Node_20,Tree_29_Node_20,Tree_29_Node_20,Tree_29_Node_21,Tree_29_Node_21,Tree_29_Node_21,Tree_29_Node_20,Tree_29_Node_21,Tree_29_Node_20,Tree_29_Node_20,Tree_29_Node_20);
        Tree_29_Node_70 := IF ( le.p_CurrAddrCountyIndex < 1.445,167,168);
        Tree_29_Node_41 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 1.5,Tree_29_Node_70,144);
        Tree_29_Node_40 := IF ( le.p_CurrAddrBurglaryIndex < 99.5,142,143);
        Tree_29_Node_22 := CHOOSE ( le.p_admit_diag,Tree_29_Node_41,Tree_29_Node_41,Tree_29_Node_41,Tree_29_Node_41,Tree_29_Node_40,Tree_29_Node_40,Tree_29_Node_41,Tree_29_Node_41,Tree_29_Node_41,Tree_29_Node_40,Tree_29_Node_40,Tree_29_Node_41,Tree_29_Node_40);
        Tree_29_Node_72 := IF ( le.p_CurrAddrBlockIndex < 1.696,169,170);
        Tree_29_Node_73 := IF ( le.p_PrevAddrLenOfRes < 207.5,171,172);
        Tree_29_Node_42 := CHOOSE ( le.p_admit_diag,Tree_29_Node_72,Tree_29_Node_72,Tree_29_Node_72,Tree_29_Node_72,Tree_29_Node_72,Tree_29_Node_73,Tree_29_Node_72,Tree_29_Node_72,Tree_29_Node_73,Tree_29_Node_72,Tree_29_Node_72,Tree_29_Node_73,Tree_29_Node_72);
        Tree_29_Node_23 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 156.5,Tree_29_Node_42,132);
        Tree_29_Node_13 := IF ( le.p_PrevAddrCarTheftIndex < 47.5,Tree_29_Node_22,Tree_29_Node_23);
        Tree_29_Node_6 := IF ( le.p_age_in_years < 93.22813,Tree_29_Node_12,Tree_29_Node_13);
        Tree_29_Node_75 := IF ( le.p_BPV_2 < 2.91354,175,176);
        Tree_29_Node_74 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 6.5,173,174);
        Tree_29_Node_44 := CHOOSE ( le.p_financial_class,Tree_29_Node_75,Tree_29_Node_74,Tree_29_Node_74,Tree_29_Node_74,Tree_29_Node_74,Tree_29_Node_74,Tree_29_Node_75,Tree_29_Node_75,Tree_29_Node_75,Tree_29_Node_74,Tree_29_Node_74,Tree_29_Node_75,Tree_29_Node_74,Tree_29_Node_75,Tree_29_Node_75,Tree_29_Node_74);
        Tree_29_Node_76 := CHOOSE ( le.p_readmit_lift,178,178,178,178,178,177,177,177,178,178,178,177,177);
        Tree_29_Node_77 := CHOOSE ( le.p_readmit_lift,179,179,179,179,180,180,179,180,179,180,179,179,179);
        Tree_29_Node_45 := IF ( le.p_CurrAddrMedianValue < 187499.5,Tree_29_Node_76,Tree_29_Node_77);
        Tree_29_Node_24 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_29_Node_44,Tree_29_Node_45);
        Tree_29_Node_25 := CHOOSE ( le.p_financial_class,133,133,133,133,133,134,133,133,134,133,133,133,133,133,134,133);
        Tree_29_Node_14 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 1406250.0,Tree_29_Node_24,Tree_29_Node_25);
        Tree_29_Node_79 := CHOOSE ( le.p_admit_diag,183,183,183,184,183,183,183,183,184,183,183,183,184);
        Tree_29_Node_78 := IF ( le.p_CurrAddrBurglaryIndex < 39.5,181,182);
        Tree_29_Node_48 := CHOOSE ( le.p_readmit_diag,Tree_29_Node_79,Tree_29_Node_79,Tree_29_Node_78,Tree_29_Node_78,Tree_29_Node_78,Tree_29_Node_79,Tree_29_Node_78,Tree_29_Node_78,Tree_29_Node_79,Tree_29_Node_79,Tree_29_Node_79,Tree_29_Node_78,Tree_29_Node_78);
        Tree_29_Node_80 := CHOOSE ( le.p_readmit_lift,185,185,186,186,185,185,186,186,186,185,186,186,185);
        Tree_29_Node_49 := IF ( le.p_v1_PropTimeLastSale < 120.5,Tree_29_Node_80,145);
        Tree_29_Node_26 := IF ( le.p_CurrAddrAgeOldestRecord < 351.5,Tree_29_Node_48,Tree_29_Node_49);
        Tree_29_Node_82 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 0.5,187,188);
        Tree_29_Node_50 := IF ( le.p_v1_HHPropCurrOwnedCnt < 2.5,Tree_29_Node_82,146);
        Tree_29_Node_27 := CHOOSE ( le.p_readmit_diag,Tree_29_Node_50,Tree_29_Node_50,Tree_29_Node_50,135,135,Tree_29_Node_50,135,Tree_29_Node_50,135,Tree_29_Node_50,135,Tree_29_Node_50,Tree_29_Node_50);
        Tree_29_Node_15 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 79.5,Tree_29_Node_26,Tree_29_Node_27);
        Tree_29_Node_7 := IF ( le.p_NonDerogCount06 < 5.5,Tree_29_Node_14,Tree_29_Node_15);
        Tree_29_Node_3 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_29_Node_6,Tree_29_Node_7);
        Tree_29_Node_1 := IF ( le.p_age_in_years < 1.5996094,Tree_29_Node_2,Tree_29_Node_3);
    SELF.Score1_Tree29_node := Tree_29_Node_1;
    SELF.Score1_Tree29_score := CASE(SELF.Score1_Tree29_node,126=>0.09999856,127=>0.029195247,128=>0.009736577,129=>-0.08193159,130=>-0.081268035,131=>-0.008477335,132=>0.07539333,133=>0.028527616,134=>0.14055777,135=>0.13264024,136=>-0.083000876,137=>-0.07774486,138=>0.054961104,139=>0.03357238,140=>0.038619272,141=>0.10223772,142=>-0.050577193,143=>-0.08812247,144=>0.111561544,145=>0.13657828,146=>0.076695465,147=>-0.08056083,148=>-0.032299142,149=>-0.07766324,150=>-0.07788867,151=>-0.039524287,152=>-0.028576357,153=>0.0025778722,154=>-0.04579314,155=>0.0070754257,156=>0.043993823,157=>-0.01661633,158=>0.102488205,159=>0.09065901,160=>0.021184139,161=>0.02244285,162=>-0.0077966047,163=>-0.011161601,164=>0.07151121,165=>-0.0028198215,166=>-0.06293817,167=>0.002175515,168=>-0.08714076,169=>-0.07040028,170=>0.003937471,171=>-0.05121771,172=>0.043795343,173=>-0.0114530455,174=>0.028476398,175=>-1.2345395E-4,176=>0.033006076,177=>-0.045278613,178=>0.015532223,179=>-0.01582602,180=>0.06473718,181=>-0.008839793,182=>-0.06468956,183=>-0.028536038,184=>0.038480982,185=>-0.018992921,186=>0.04296548,187=>0.021021413,188=>-0.07238811,0);
ENDMACRO;
