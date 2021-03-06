EXPORT Model1_Score1_Tree79(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_79_Node_46 := IF ( le.p_LienReleasedAge < 175.5,123,124);
        Tree_79_Node_47 := CHOOSE ( le.p_financial_class,126,126,126,125,126,126,126,126,125,126,125,126,126,126,126,126);
        Tree_79_Node_30 := IF ( le.p_CurrAddrBurglaryIndex < 190.5,Tree_79_Node_46,Tree_79_Node_47);
        Tree_79_Node_48 := IF ( le.p_PrevAddrBurglaryIndex < 120.5,127,128);
        Tree_79_Node_49 := IF ( le.p_SrcsConfirmIDAddrCount < 2.5,129,130);
        Tree_79_Node_31 := IF ( le.p_v1_ProspectMaritalStatus < 0.5,Tree_79_Node_48,Tree_79_Node_49);
        Tree_79_Node_16 := IF ( le.p_age_in_years < 40.95,Tree_79_Node_30,Tree_79_Node_31);
        Tree_79_Node_50 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 192.5,131,132);
        Tree_79_Node_51 := IF ( le.p_SubjectLastNameCount < 2.5,133,134);
        Tree_79_Node_32 := CHOOSE ( le.p_readmit_diag,Tree_79_Node_50,Tree_79_Node_50,Tree_79_Node_51,Tree_79_Node_51,Tree_79_Node_51,Tree_79_Node_50,Tree_79_Node_51,Tree_79_Node_51,Tree_79_Node_50,Tree_79_Node_51,Tree_79_Node_50,Tree_79_Node_51,Tree_79_Node_51);
        Tree_79_Node_17 := CHOOSE ( le.p_readmit_lift,Tree_79_Node_32,Tree_79_Node_32,Tree_79_Node_32,Tree_79_Node_32,Tree_79_Node_32,113,Tree_79_Node_32,Tree_79_Node_32,Tree_79_Node_32,113,113,113,Tree_79_Node_32);
        Tree_79_Node_8 := IF ( le.p_v1_HHEstimatedIncomeRange < 7.5,Tree_79_Node_16,Tree_79_Node_17);
        Tree_79_Node_55 := IF ( le.p_PrevAddrAgeLastSale < 47.5,137,138);
        Tree_79_Node_35 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 4.5,118,Tree_79_Node_55);
        Tree_79_Node_53 := CHOOSE ( le.p_admit_diag,136,135,136,135,135,135,135,135,135,135,135,135,135);
        Tree_79_Node_34 := CHOOSE ( le.p_readmit_lift,117,Tree_79_Node_53,117,117,117,117,117,117,117,Tree_79_Node_53,117,117,117);
        Tree_79_Node_18 := CHOOSE ( le.p_readmit_diag,Tree_79_Node_35,Tree_79_Node_34,Tree_79_Node_35,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_34,Tree_79_Node_35);
        Tree_79_Node_9 := IF ( le.p_PrevAddrMedianValue < 714640.5,Tree_79_Node_18,107);
        Tree_79_Node_4 := IF ( le.p_v1_RaAPropOwnerAVMMed < 781249.5,Tree_79_Node_8,Tree_79_Node_9);
        Tree_79_Node_57 := IF ( le.p_NonDerogCount12 < 4.5,139,140);
        Tree_79_Node_36 := CHOOSE ( le.p_readmit_lift,119,Tree_79_Node_57,119,119,119,119,119,119,119,119,119,119,119);
        Tree_79_Node_59 := IF ( le.p_v1_HHEstimatedIncomeRange < 5.5,141,142);
        Tree_79_Node_37 := IF ( le.p_CurrAddrAgeLastSale < 24.5,120,Tree_79_Node_59);
        Tree_79_Node_20 := IF ( le.p_v1_RaAPropOwnerAVMMed < 125477.5,Tree_79_Node_36,Tree_79_Node_37);
        Tree_79_Node_10 := IF ( le.p_v1_HHSeniorMmbrCnt < 1.5,Tree_79_Node_20,108);
        Tree_79_Node_11 := IF ( le.p_PhoneOtherAgeOldestRecord < 293.5,109,110);
        Tree_79_Node_5 := CHOOSE ( le.p_readmit_diag,Tree_79_Node_10,Tree_79_Node_10,Tree_79_Node_11,Tree_79_Node_10,Tree_79_Node_11,Tree_79_Node_11,Tree_79_Node_10,Tree_79_Node_11,Tree_79_Node_10,Tree_79_Node_10,Tree_79_Node_10,Tree_79_Node_10,Tree_79_Node_10);
        Tree_79_Node_2 := IF ( le.p_PhoneOtherAgeOldestRecord < 249.5,Tree_79_Node_4,Tree_79_Node_5);
        Tree_79_Node_64 := CHOOSE ( le.p_readmit_diag,149,150,150,150,150,149,149,150,149,149,150,149,149);
        Tree_79_Node_65 := IF ( le.p_v1_RaAPropOwnerAVMMed < 125000.5,151,152);
        Tree_79_Node_43 := CHOOSE ( le.p_financial_class,Tree_79_Node_64,Tree_79_Node_65,Tree_79_Node_64,Tree_79_Node_64,Tree_79_Node_65,Tree_79_Node_64,Tree_79_Node_64,Tree_79_Node_64,Tree_79_Node_64,Tree_79_Node_64,Tree_79_Node_65,Tree_79_Node_65,Tree_79_Node_64,Tree_79_Node_64,Tree_79_Node_64,Tree_79_Node_64);
        Tree_79_Node_28 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.55859375,116,Tree_79_Node_43);
        Tree_79_Node_66 := IF ( le.p_NonDerogCount24 < 3.5,153,154);
        Tree_79_Node_44 := CHOOSE ( le.p_readmit_diag,Tree_79_Node_66,Tree_79_Node_66,122,122,Tree_79_Node_66,Tree_79_Node_66,Tree_79_Node_66,Tree_79_Node_66,Tree_79_Node_66,122,Tree_79_Node_66,Tree_79_Node_66,Tree_79_Node_66);
        Tree_79_Node_68 := CHOOSE ( le.p_readmit_lift,156,156,156,156,156,156,155,155,156,156,156,155,155);
        Tree_79_Node_69 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 129.5,157,158);
        Tree_79_Node_45 := IF ( le.p_v1_HHCnt < 7.5,Tree_79_Node_68,Tree_79_Node_69);
        Tree_79_Node_29 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.31054688,Tree_79_Node_44,Tree_79_Node_45);
        Tree_79_Node_14 := IF ( le.p_BPV_4 < -2.4898672,Tree_79_Node_28,Tree_79_Node_29);
        Tree_79_Node_7 := IF ( le.p_PRSearchOtherCount < 36.0,Tree_79_Node_14,106);
        Tree_79_Node_60 := CHOOSE ( le.p_readmit_lift,144,144,143,143,143,143,143,143,143,143,143,143,143);
        Tree_79_Node_38 := CHOOSE ( le.p_financial_class,121,Tree_79_Node_60,121,Tree_79_Node_60,Tree_79_Node_60,121,Tree_79_Node_60,Tree_79_Node_60,Tree_79_Node_60,121,Tree_79_Node_60,121,Tree_79_Node_60,Tree_79_Node_60,Tree_79_Node_60,Tree_79_Node_60);
        Tree_79_Node_24 := CHOOSE ( le.p_readmit_diag,114,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38,Tree_79_Node_38);
        Tree_79_Node_63 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 0.5,147,148);
        Tree_79_Node_62 := IF ( le.p_PrevAddrAgeLastSale < 113.5,145,146);
        Tree_79_Node_40 := CHOOSE ( le.p_readmit_diag,Tree_79_Node_63,Tree_79_Node_62,Tree_79_Node_62,Tree_79_Node_63,Tree_79_Node_63,Tree_79_Node_62,Tree_79_Node_62,Tree_79_Node_62,Tree_79_Node_62,Tree_79_Node_62,Tree_79_Node_63,Tree_79_Node_63,Tree_79_Node_62);
        Tree_79_Node_25 := IF ( le.p_SSNLowIssueAge < 736.5,Tree_79_Node_40,115);
        Tree_79_Node_12 := IF ( le.p_SubjectAddrCount < 11.5,Tree_79_Node_24,Tree_79_Node_25);
        Tree_79_Node_13 := CHOOSE ( le.p_readmit_lift,112,111,112,112,112,112,112,112,112,112,111,111,111);
        Tree_79_Node_6 := IF ( le.p_PrevAddrAgeOldestRecord < 335.5,Tree_79_Node_12,Tree_79_Node_13);
        Tree_79_Node_3 := CHOOSE ( le.p_admit_diag,Tree_79_Node_7,Tree_79_Node_7,Tree_79_Node_7,Tree_79_Node_7,Tree_79_Node_6,Tree_79_Node_6,Tree_79_Node_7,Tree_79_Node_7,Tree_79_Node_6,Tree_79_Node_6,Tree_79_Node_7,Tree_79_Node_7,Tree_79_Node_6);
        Tree_79_Node_1 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 142.5,Tree_79_Node_2,Tree_79_Node_3);
    UNSIGNED2 Score1_Tree79_node := Tree_79_Node_1;
    REAL8 Score1_Tree79_score := CASE(Score1_Tree79_node,106=>0.063876964,107=>0.04606351,108=>0.013960132,109=>-0.053384405,110=>0.05490947,111=>-0.050906457,112=>0.038925305,113=>0.05379621,114=>-0.010328553,115=>0.024811732,116=>0.07422842,117=>-0.0529389,118=>0.042815894,119=>-0.0538746,120=>0.002151819,121=>-0.05189605,122=>0.004667498,123=>-0.0024741974,124=>0.053420335,125=>-0.042573683,126=>-0.012644205,127=>0.0034805117,128=>-5.5597542E-5,129=>0.012603668,130=>-0.0031527204,131=>-0.024667593,132=>0.032860216,133=>0.025074273,134=>-0.01844125,135=>-0.05054405,136=>-0.028444223,137=>-0.05077188,138=>-0.010139996,139=>-0.05107961,140=>-0.031608075,141=>-0.05206303,142=>-0.034478944,143=>-0.05617956,144=>-0.04821218,145=>-0.04510363,146=>-0.0057688584,147=>-0.017510273,148=>0.050486397,149=>-0.048109826,150=>0.007039878,151=>0.118718706,152=>0.008957473,153=>-0.004442636,154=>-0.046368968,155=>-0.043996256,156=>-0.0029631003,157=>0.0060663405,158=>0.07100528,0);
ENDMACRO;
