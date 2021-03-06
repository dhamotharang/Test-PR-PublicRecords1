EXPORT Model1_Score1_Tree96_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_96_Node_50 := IF ( le.p_CurrAddrAVMValue12 < 376000.0,150,151);
        Tree_96_Node_51 := IF ( le.p_PhoneEDAAgeOldestRecord < 9.5,152,153);
        Tree_96_Node_30 := IF ( le.p_LienReleasedAge < 226.5,Tree_96_Node_50,Tree_96_Node_51);
        Tree_96_Node_31 := IF ( le.p_PropAgeOldestPurchase < 31.5,140,141);
        Tree_96_Node_16 := IF ( le.p_CurrAddrCountyIndex < 4.4579687,Tree_96_Node_30,Tree_96_Node_31);
        Tree_96_Node_54 := IF ( le.p_v1_RaAMedIncomeRange < 0.0,154,155);
        Tree_96_Node_55 := CHOOSE ( le.p_readmit_lift,157,156,156,156,156,156,156,157,157,156,156,156,156);
        Tree_96_Node_32 := CHOOSE ( le.p_readmit_diag,Tree_96_Node_54,Tree_96_Node_54,Tree_96_Node_55,Tree_96_Node_54,Tree_96_Node_54,Tree_96_Node_55,Tree_96_Node_54,Tree_96_Node_54,Tree_96_Node_55,Tree_96_Node_54,Tree_96_Node_55,Tree_96_Node_54,Tree_96_Node_55);
        Tree_96_Node_17 := IF ( le.p_CurrAddrLenOfRes < 511.5,Tree_96_Node_32,137);
        Tree_96_Node_8 := IF ( le.p_CurrAddrAVMValue60 < 274610.5,Tree_96_Node_16,Tree_96_Node_17);
        Tree_96_Node_56 := IF ( le.p_v1_ProspectAge < 69.5,158,159);
        Tree_96_Node_57 := CHOOSE ( le.p_financial_class,161,161,161,160,160,160,160,160,160,160,161,161,160,161,160,160);
        Tree_96_Node_34 := CHOOSE ( le.p_readmit_diag,Tree_96_Node_56,Tree_96_Node_56,Tree_96_Node_56,Tree_96_Node_57,Tree_96_Node_56,Tree_96_Node_57,Tree_96_Node_57,Tree_96_Node_57,Tree_96_Node_56,Tree_96_Node_56,Tree_96_Node_56,Tree_96_Node_56,Tree_96_Node_56);
        Tree_96_Node_58 := IF ( le.p_CurrAddrMedianIncome < 93158.5,162,163);
        Tree_96_Node_59 := CHOOSE ( le.p_admit_diag,164,165,164,164,164,164,164,164,164,164,164,165,165);
        Tree_96_Node_35 := CHOOSE ( le.p_financial_class,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_59,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_58,Tree_96_Node_59,Tree_96_Node_58,Tree_96_Node_58);
        Tree_96_Node_18 := IF ( le.p_SubjectLastNameCount < 6.5,Tree_96_Node_34,Tree_96_Node_35);
        Tree_96_Node_9 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 488.5,Tree_96_Node_18,133);
        Tree_96_Node_4 := IF ( le.p_CurrAddrMedianIncome < 70686.5,Tree_96_Node_8,Tree_96_Node_9);
        Tree_96_Node_11 := IF ( le.p_DivSSNAddrMSourceCount < 5.5,134,135);
        Tree_96_Node_5 := IF ( le.p_WealthIndex < 3.5,132,Tree_96_Node_11);
        Tree_96_Node_2 := IF ( le.p_CurrAddrAVMValue60 < 473680.5,Tree_96_Node_4,Tree_96_Node_5);
        Tree_96_Node_60 := CHOOSE ( le.p_admit_diag,167,167,167,167,167,166,167,167,166,166,167,166,166);
        Tree_96_Node_61 := CHOOSE ( le.p_financial_class,168,168,169,169,168,168,168,168,168,168,169,168,168,168,168,168);
        Tree_96_Node_36 := IF ( le.p_PrevAddrCarTheftIndex < 147.5,Tree_96_Node_60,Tree_96_Node_61);
        Tree_96_Node_62 := IF ( le.p_RelativesBankruptcyCount < 6.5,170,171);
        Tree_96_Node_63 := CHOOSE ( le.p_admit_diag,173,172,173,173,172,172,172,172,172,172,172,173,172);
        Tree_96_Node_37 := IF ( le.p_v1_HHMiddleAgemmbrCnt < 2.5,Tree_96_Node_62,Tree_96_Node_63);
        Tree_96_Node_22 := CHOOSE ( le.p_gender,Tree_96_Node_36,Tree_96_Node_37);
        Tree_96_Node_38 := IF ( le.p_DerogAge < 68.5,142,143);
        Tree_96_Node_23 := IF ( le.p_CurrAddrBurglaryIndex < 41.5,Tree_96_Node_38,138);
        Tree_96_Node_12 := IF ( le.p_SubjectLastNameCount < 9.5,Tree_96_Node_22,Tree_96_Node_23);
        Tree_96_Node_67 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 127.0,174,175);
        Tree_96_Node_40 := CHOOSE ( le.p_readmit_lift,144,Tree_96_Node_67,Tree_96_Node_67,144,144,144,144,144,144,144,144,144,144);
        Tree_96_Node_24 := IF ( le.p_SSNIssueState < 48.5,Tree_96_Node_40,139);
        Tree_96_Node_68 := CHOOSE ( le.p_admit_diag,176,177,177,177,176,176,177,176,176,177,176,176,176);
        Tree_96_Node_42 := IF ( le.p_DivSSNIdentityMSourceCount < 1.5,Tree_96_Node_68,145);
        Tree_96_Node_70 := CHOOSE ( le.p_readmit_lift,178,179,178,178,178,178,178,178,178,179,178,178,178);
        Tree_96_Node_43 := IF ( le.p_PrevAddrAgeNewestRecord < 14.5,Tree_96_Node_70,146);
        Tree_96_Node_25 := IF ( le.p_CurrAddrAVMValue12 < 171069.5,Tree_96_Node_42,Tree_96_Node_43);
        Tree_96_Node_13 := CHOOSE ( le.p_readmit_diag,Tree_96_Node_24,Tree_96_Node_24,Tree_96_Node_25,Tree_96_Node_25,Tree_96_Node_24,Tree_96_Node_24,Tree_96_Node_25,Tree_96_Node_25,Tree_96_Node_24,Tree_96_Node_25,Tree_96_Node_25,Tree_96_Node_24,Tree_96_Node_24);
        Tree_96_Node_6 := IF ( le.p_PrevAddrCrimeIndex < 164.5,Tree_96_Node_12,Tree_96_Node_13);
        Tree_96_Node_72 := CHOOSE ( le.p_financial_class,180,181,181,180,180,180,180,180,180,181,180,180,181,181,180,180);
        Tree_96_Node_73 := CHOOSE ( le.p_readmit_lift,183,182,182,182,183,182,182,183,182,183,183,183,182);
        Tree_96_Node_44 := IF ( le.p_NonDerogCount < 5.5,Tree_96_Node_72,Tree_96_Node_73);
        Tree_96_Node_74 := CHOOSE ( le.p_readmit_diag,185,185,184,185,184,184,184,185,184,185,184,185,184);
        Tree_96_Node_75 := CHOOSE ( le.p_readmit_diag,186,186,187,186,186,186,186,187,187,187,186,186,186);
        Tree_96_Node_45 := IF ( le.p_CurrAddrBlockIndex < 0.9375,Tree_96_Node_74,Tree_96_Node_75);
        Tree_96_Node_26 := IF ( le.p_SubjectLastNameCount < 3.5,Tree_96_Node_44,Tree_96_Node_45);
        Tree_96_Node_77 := CHOOSE ( le.p_financial_class,190,190,190,190,190,190,190,190,190,191,191,190,190,191,191,190);
        Tree_96_Node_76 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.25,188,189);
        Tree_96_Node_46 := CHOOSE ( le.p_admit_diag,Tree_96_Node_77,Tree_96_Node_77,Tree_96_Node_77,Tree_96_Node_76,Tree_96_Node_76,Tree_96_Node_76,Tree_96_Node_76,Tree_96_Node_76,Tree_96_Node_77,Tree_96_Node_76,Tree_96_Node_76,Tree_96_Node_77,Tree_96_Node_76);
        Tree_96_Node_79 := IF ( le.p_PhoneEDAAgeOldestRecord < 193.5,192,193);
        Tree_96_Node_47 := IF ( le.p_PrevAddrMedianValue < 124999.5,147,Tree_96_Node_79);
        Tree_96_Node_27 := CHOOSE ( le.p_readmit_diag,Tree_96_Node_46,Tree_96_Node_46,Tree_96_Node_46,Tree_96_Node_46,Tree_96_Node_46,Tree_96_Node_46,Tree_96_Node_46,Tree_96_Node_47,Tree_96_Node_47,Tree_96_Node_47,Tree_96_Node_47,Tree_96_Node_46,Tree_96_Node_46);
        Tree_96_Node_14 := IF ( le.p_PhoneOtherAgeOldestRecord < 135.5,Tree_96_Node_26,Tree_96_Node_27);
        Tree_96_Node_80 := IF ( le.p_NonDerogCount60 < 4.5,194,195);
        Tree_96_Node_48 := IF ( le.p_SSNIdentitiesCount < 3.5,Tree_96_Node_80,148);
        Tree_96_Node_82 := IF ( le.p_PrevAddrCarTheftIndex < 180.5,196,197);
        Tree_96_Node_49 := IF ( le.p_AccidentAge < 52.5,Tree_96_Node_82,149);
        Tree_96_Node_28 := CHOOSE ( le.p_financial_class,Tree_96_Node_48,Tree_96_Node_48,Tree_96_Node_49,Tree_96_Node_49,Tree_96_Node_49,Tree_96_Node_49,Tree_96_Node_48,Tree_96_Node_48,Tree_96_Node_48,Tree_96_Node_48,Tree_96_Node_48,Tree_96_Node_49,Tree_96_Node_48,Tree_96_Node_49,Tree_96_Node_49,Tree_96_Node_48);
        Tree_96_Node_15 := IF ( le.p_v1_HHCnt < 7.5,Tree_96_Node_28,136);
        Tree_96_Node_7 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,Tree_96_Node_14,Tree_96_Node_15);
        Tree_96_Node_3 := IF ( le.p_CurrAddrBurglaryIndex < 103.0,Tree_96_Node_6,Tree_96_Node_7);
        Tree_96_Node_1 := IF ( le.p_CurrAddrMedianValue < 247069.5,Tree_96_Node_2,Tree_96_Node_3);
    SELF.Score1_Tree96_node := Tree_96_Node_1;
    SELF.Score1_Tree96_score := CASE(SELF.Score1_Tree96_node,132=>0.069042966,133=>0.05224103,134=>-0.04392915,135=>0.01933616,136=>0.04112351,137=>0.045883723,138=>-0.031603195,139=>0.026730834,140=>-0.04627476,141=>-0.02828397,142=>0.013507879,143=>0.06300351,144=>-0.045917764,145=>0.074492544,146=>0.0015119171,147=>0.0071492814,148=>0.028222693,149=>0.04553298,150=>-1.5260228E-5,151=>0.026513088,152=>0.008403663,153=>-0.019120812,154=>0.023331124,155=>-0.027559975,156=>-0.010812114,157=>0.051663283,158=>-5.628948E-4,159=>0.006018167,160=>7.8750035E-4,161=>0.016828224,162=>-0.0342949,163=>0.014898122,164=>-0.003176357,165=>0.06468839,166=>-0.022226006,167=>-0.0060245683,168=>0.0012663499,169=>0.064298205,170=>-0.0011212567,171=>0.023755208,172=>-0.027725859,173=>0.061780892,174=>-0.033965826,175=>0.007964493,176=>-0.03296534,177=>0.04884004,178=>-0.04607251,179=>-0.041805353,180=>-0.002845516,181=>0.044815835,182=>-0.01573197,183=>0.01129972,184=>-0.035700545,185=>0.014442038,186=>0.02148032,187=>0.110128455,188=>0.008367872,189=>-0.02821244,190=>0.011932523,191=>0.034997992,192=>0.03526642,193=>0.09978356,194=>-0.044723883,195=>-0.017040644,196=>-0.013547895,197=>0.02562117,0);
ENDMACRO;
