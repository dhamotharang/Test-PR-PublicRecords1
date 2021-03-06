EXPORT Model1_Score1_Tree33(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_33_Node_5 := IF ( le.p_age_in_years < 0.46238708,114,115);
        Tree_33_Node_49 := IF ( le.p_age_in_years < 0.13141784,133,134);
        Tree_33_Node_28 := CHOOSE ( le.p_readmit_lift,124,124,Tree_33_Node_49,Tree_33_Node_49,Tree_33_Node_49,Tree_33_Node_49,124,Tree_33_Node_49,Tree_33_Node_49,Tree_33_Node_49,Tree_33_Node_49,Tree_33_Node_49,124);
        Tree_33_Node_16 := IF ( le.p_age_in_years < 0.34472615,Tree_33_Node_28,118);
        Tree_33_Node_17 := IF ( le.p_age_in_years < 1.2053874,119,120);
        Tree_33_Node_8 := IF ( le.p_age_in_years < 0.76231384,Tree_33_Node_16,Tree_33_Node_17);
        Tree_33_Node_34 := IF ( le.p_age_in_years < 0.28899956,127,128);
        Tree_33_Node_19 := IF ( le.p_age_in_years < 0.68733215,Tree_33_Node_34,121);
        Tree_33_Node_52 := CHOOSE ( le.p_financial_class,137,138,137,137,137,137,137,137,137,137,137,138,137,138,137,137);
        Tree_33_Node_33 := IF ( le.p_SSNLowIssueAge < 31.5,Tree_33_Node_52,126);
        Tree_33_Node_51 := IF ( le.p_age_in_years < 1.199707,135,136);
        Tree_33_Node_32 := CHOOSE ( le.p_financial_class,Tree_33_Node_51,125,Tree_33_Node_51,Tree_33_Node_51,125,Tree_33_Node_51,Tree_33_Node_51,Tree_33_Node_51,Tree_33_Node_51,Tree_33_Node_51,Tree_33_Node_51,Tree_33_Node_51,Tree_33_Node_51,125,125,Tree_33_Node_51);
        Tree_33_Node_18 := CHOOSE ( le.p_readmit_lift,Tree_33_Node_33,Tree_33_Node_32,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33,Tree_33_Node_33);
        Tree_33_Node_9 := CHOOSE ( le.p_admit_diag,Tree_33_Node_19,Tree_33_Node_18,Tree_33_Node_19,Tree_33_Node_18,Tree_33_Node_19,Tree_33_Node_19,Tree_33_Node_19,Tree_33_Node_19,Tree_33_Node_19,Tree_33_Node_19,Tree_33_Node_19,Tree_33_Node_19,Tree_33_Node_19);
        Tree_33_Node_4 := CHOOSE ( le.p_readmit_diag,Tree_33_Node_8,Tree_33_Node_9,Tree_33_Node_8,Tree_33_Node_9,Tree_33_Node_8,Tree_33_Node_8,Tree_33_Node_8,Tree_33_Node_9,Tree_33_Node_9,Tree_33_Node_8,Tree_33_Node_8,Tree_33_Node_8,Tree_33_Node_9);
        Tree_33_Node_2 := CHOOSE ( le.p_admit_diag,Tree_33_Node_5,Tree_33_Node_4,Tree_33_Node_4,Tree_33_Node_4,Tree_33_Node_5,Tree_33_Node_4,Tree_33_Node_4,Tree_33_Node_4,Tree_33_Node_4,Tree_33_Node_5,Tree_33_Node_4,Tree_33_Node_4,Tree_33_Node_4);
        Tree_33_Node_60 := IF ( le.p_EvictionAge < 13.5,145,146);
        Tree_33_Node_61 := IF ( le.p_v1_CrtRecTimeNewest < 227.0,147,148);
        Tree_33_Node_38 := IF ( le.p_BPV_2 < 2.579697,Tree_33_Node_60,Tree_33_Node_61);
        Tree_33_Node_62 := IF ( le.p_CurrAddrMedianValue < 122994.0,149,150);
        Tree_33_Node_63 := CHOOSE ( le.p_admit_diag,152,152,152,152,152,151,151,152,152,151,152,152,152);
        Tree_33_Node_39 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_33_Node_62,Tree_33_Node_63);
        Tree_33_Node_21 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_33_Node_38,Tree_33_Node_39);
        Tree_33_Node_56 := CHOOSE ( le.p_admit_diag,140,139,139,140,139,140,139,139,139,140,139,140,139);
        Tree_33_Node_57 := IF ( le.p_PhoneEDAAgeNewestRecord < 99.0,141,142);
        Tree_33_Node_36 := IF ( le.p_CurrAddrMedianValue < 76896.5,Tree_33_Node_56,Tree_33_Node_57);
        Tree_33_Node_59 := CHOOSE ( le.p_financial_class,143,144,144,143,143,144,143,143,143,144,143,143,144,143,143,143);
        Tree_33_Node_37 := IF ( le.p_CurrAddrMedianValue < 46137.5,129,Tree_33_Node_59);
        Tree_33_Node_20 := IF ( le.p_CurrAddrMedianIncome < 19095.5,Tree_33_Node_36,Tree_33_Node_37);
        Tree_33_Node_12 := CHOOSE ( le.p_patient_type,Tree_33_Node_21,Tree_33_Node_20);
        Tree_33_Node_64 := IF ( le.p_SubjectLastNameCount < 9.5,153,154);
        Tree_33_Node_65 := CHOOSE ( le.p_financial_class,155,156,155,156,155,155,156,155,155,155,156,155,156,156,156,155);
        Tree_33_Node_40 := IF ( le.p_CurrAddrCarTheftIndex < 100.5,Tree_33_Node_64,Tree_33_Node_65);
        Tree_33_Node_41 := IF ( le.p_PhoneOtherAgeNewestRecord < 31.5,130,131);
        Tree_33_Node_22 := IF ( le.p_BPV_2 < 3.110811,Tree_33_Node_40,Tree_33_Node_41);
        Tree_33_Node_70 := IF ( le.p_PrevAddrMurderIndex < 29.5,161,162);
        Tree_33_Node_43 := IF ( le.p_v1_HHPPCurrOwnedCnt < 4.5,Tree_33_Node_70,132);
        Tree_33_Node_68 := IF ( le.p_AddrStability < 4.5,157,158);
        Tree_33_Node_69 := CHOOSE ( le.p_admit_diag,159,159,159,159,160,159,159,160,159,160,159,159,159);
        Tree_33_Node_42 := IF ( le.p_PhoneOtherAgeNewestRecord < 95.5,Tree_33_Node_68,Tree_33_Node_69);
        Tree_33_Node_23 := CHOOSE ( le.p_readmit_lift,Tree_33_Node_43,Tree_33_Node_42,Tree_33_Node_42,Tree_33_Node_43,Tree_33_Node_43,Tree_33_Node_43,Tree_33_Node_42,Tree_33_Node_42,Tree_33_Node_42,Tree_33_Node_42,Tree_33_Node_42,Tree_33_Node_43,Tree_33_Node_43);
        Tree_33_Node_13 := CHOOSE ( le.p_readmit_diag,Tree_33_Node_22,Tree_33_Node_22,Tree_33_Node_23,Tree_33_Node_22,Tree_33_Node_22,Tree_33_Node_22,Tree_33_Node_22,Tree_33_Node_23,Tree_33_Node_22,Tree_33_Node_23,Tree_33_Node_23,Tree_33_Node_22,Tree_33_Node_22);
        Tree_33_Node_6 := IF ( le.p_CurrAddrMedianValue < 246093.5,Tree_33_Node_12,Tree_33_Node_13);
        Tree_33_Node_74 := CHOOSE ( le.p_financial_class,167,167,167,167,167,167,168,167,167,167,167,167,167,167,168,167);
        Tree_33_Node_75 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 3.5,169,170);
        Tree_33_Node_46 := IF ( le.p_SubjectAddrCount < 20.5,Tree_33_Node_74,Tree_33_Node_75);
        Tree_33_Node_25 := IF ( le.p_v1_HHPropCurrOwnedCnt < 12.5,Tree_33_Node_46,123);
        Tree_33_Node_73 := IF ( le.p_v1_ProspectMaritalStatus < 0.5,165,166);
        Tree_33_Node_72 := IF ( le.p_EstimatedAnnualIncome < 40000.5,163,164);
        Tree_33_Node_45 := CHOOSE ( le.p_readmit_diag,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_72,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73,Tree_33_Node_73);
        Tree_33_Node_24 := IF ( le.p_PrevAddrAgeOldestRecord < 31.5,122,Tree_33_Node_45);
        Tree_33_Node_14 := CHOOSE ( le.p_admit_diag,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_24,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_25,Tree_33_Node_24,Tree_33_Node_25);
        Tree_33_Node_15 := IF ( le.p_v1_ProspectTimeOnRecord < 720.5,116,117);
        Tree_33_Node_7 := IF ( le.p_CurrAddrAgeOldestRecord < 700.5,Tree_33_Node_14,Tree_33_Node_15);
        Tree_33_Node_3 := IF ( le.p_NonDerogCount01 < 4.5,Tree_33_Node_6,Tree_33_Node_7);
        Tree_33_Node_1 := IF ( le.p_age_in_years < 1.5996094,Tree_33_Node_2,Tree_33_Node_3);
    UNSIGNED2 Score1_Tree33_node := Tree_33_Node_1;
    REAL8 Score1_Tree33_score := CASE(Score1_Tree33_node,114=>0.087892145,115=>0.02758993,116=>0.21114457,117=>-0.04218372,118=>0.011458906,119=>-0.07810996,120=>-0.077569276,121=>-0.005891166,122=>0.040737495,123=>0.092184424,124=>-0.07908178,125=>-0.074535966,126=>0.050348382,127=>0.03115661,128=>0.03545355,129=>0.08028154,130=>-0.0042842715,131=>0.079250604,132=>0.15606536,133=>-0.07692989,134=>-0.027755348,135=>-0.07446531,136=>-0.07466867,137=>-0.035058886,138=>-0.02429007,139=>-0.03283037,140=>0.03363542,141=>0.033598438,142=>0.20585802,143=>-0.02532902,144=>-0.0034567993,145=>0.008750775,146=>-0.008631185,147=>0.027254615,148=>-0.068010546,149=>-0.0054812543,150=>0.003463045,151=>-0.01831018,152=>0.014972223,153=>-0.014794494,154=>0.06775841,155=>-0.010490901,156=>0.02748034,157=>0.026231728,158=>-0.010735156,159=>0.009473542,160=>0.18689157,161=>-0.030136835,162=>0.03740563,163=>-0.08818181,164=>-0.06406038,165=>-0.074971594,166=>-0.010048163,167=>-0.0077757817,168=>0.07188592,169=>0.010717122,170=>-0.0547767,0);
ENDMACRO;
