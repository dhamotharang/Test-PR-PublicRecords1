EXPORT Model1_Score1_Tree40(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_40_Node_50 := IF ( le.p_CurrAddrBurglaryIndex < 150.5,133,134);
        Tree_40_Node_51 := IF ( le.p_age_in_years < 58.256,135,136);
        Tree_40_Node_30 := IF ( le.p_CurrAddrCrimeIndex < 170.5,Tree_40_Node_50,Tree_40_Node_51);
        Tree_40_Node_52 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,137,138);
        Tree_40_Node_53 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,139,140);
        Tree_40_Node_31 := IF ( le.p_AddrChangeCount60 < 3.0,Tree_40_Node_52,Tree_40_Node_53);
        Tree_40_Node_16 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 0.5,Tree_40_Node_30,Tree_40_Node_31);
        Tree_40_Node_55 := IF ( le.p_SSNIssueState < 12.5,141,142);
        Tree_40_Node_33 := IF ( le.p_EstimatedAnnualIncome < 26000.5,126,Tree_40_Node_55);
        Tree_40_Node_17 := IF ( le.p_PrevAddrAgeOldestRecord < 12.5,119,Tree_40_Node_33);
        Tree_40_Node_8 := IF ( le.p_v1_HHCrtRecMmbrCnt < 4.5,Tree_40_Node_16,Tree_40_Node_17);
        Tree_40_Node_56 := IF ( le.p_LastNameChangeAge < 339.0,143,144);
        Tree_40_Node_57 := IF ( le.p_CurrAddrAgeOldestRecord < 32.5,145,146);
        Tree_40_Node_34 := IF ( le.p_CurrAddrAgeLastSale < 203.5,Tree_40_Node_56,Tree_40_Node_57);
        Tree_40_Node_18 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 7.5,Tree_40_Node_34,120);
        Tree_40_Node_58 := IF ( le.p_AssocSuspicousIdentitiesCount < 4.5,147,148);
        Tree_40_Node_36 := IF ( le.p_v1_HHCrtRecBkrptMmbrCnt < 1.5,Tree_40_Node_58,127);
        Tree_40_Node_19 := IF ( le.p_v1_PropSoldRatio < 1.375,Tree_40_Node_36,121);
        Tree_40_Node_9 := IF ( le.p_CurrAddrBurglaryIndex < 176.5,Tree_40_Node_18,Tree_40_Node_19);
        Tree_40_Node_4 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_40_Node_8,Tree_40_Node_9);
        Tree_40_Node_11 := IF ( le.p_DerogAge < 85.5,115,116);
        Tree_40_Node_5 := IF ( le.p_NonDerogCount12 < 2.5,114,Tree_40_Node_11);
        Tree_40_Node_2 := IF ( le.p_v1_CrtRecCnt < 99.5,Tree_40_Node_4,Tree_40_Node_5);
        Tree_40_Node_60 := IF ( le.p_NonDerogCount03 < 5.5,149,150);
        Tree_40_Node_61 := IF ( le.p_DivSSNAddrMSourceCount < 4.5,151,152);
        Tree_40_Node_38 := IF ( le.p_AssocSuspicousIdentitiesCount < 7.5,Tree_40_Node_60,Tree_40_Node_61);
        Tree_40_Node_62 := IF ( le.p_v1_PropCurrOwnedCnt < 0.5,153,154);
        Tree_40_Node_63 := IF ( le.p_PhoneEDAAgeNewestRecord < 88.5,155,156);
        Tree_40_Node_39 := IF ( le.p_CurrAddrAgeOldestRecord < 159.5,Tree_40_Node_62,Tree_40_Node_63);
        Tree_40_Node_22 := IF ( le.p_SSNAddrRecentCount < 0.5,Tree_40_Node_38,Tree_40_Node_39);
        Tree_40_Node_12 := IF ( le.p_FelonyCount < 13.5,Tree_40_Node_22,117);
        Tree_40_Node_64 := IF ( le.p_v1_CrtRecLienJudgCnt < 5.5,157,158);
        Tree_40_Node_65 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 30.5,159,160);
        Tree_40_Node_40 := IF ( le.p_v1_RaAHHCnt < 7.5,Tree_40_Node_64,Tree_40_Node_65);
        Tree_40_Node_24 := IF ( le.p_v1_CrtRecTimeNewest < 268.5,Tree_40_Node_40,122);
        Tree_40_Node_42 := IF ( le.p_SSNLowIssueAge < 640.5,128,129);
        Tree_40_Node_25 := IF ( le.p_LastNameChangeAge < 258.5,Tree_40_Node_42,123);
        Tree_40_Node_13 := IF ( le.p_CurrAddrAgeLastSale < 215.5,Tree_40_Node_24,Tree_40_Node_25);
        Tree_40_Node_6 := IF ( le.p_DivSSNAddrMSourceCount < 13.5,Tree_40_Node_12,Tree_40_Node_13);
        Tree_40_Node_45 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 32.5,130,131);
        Tree_40_Node_27 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.90625,124,Tree_40_Node_45);
        Tree_40_Node_14 := IF ( le.p_PropAgeOldestPurchase < 7.5,118,Tree_40_Node_27);
        Tree_40_Node_70 := IF ( le.p_v1_PropTimeLastSale < 50.5,161,162);
        Tree_40_Node_46 := IF ( le.p_PhoneEDAAgeOldestRecord < 194.5,Tree_40_Node_70,132);
        Tree_40_Node_72 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 17.5,163,164);
        Tree_40_Node_73 := IF ( le.p_EstimatedAnnualIncome < 31850.5,165,166);
        Tree_40_Node_47 := IF ( le.p_RelativesPropOwnedCount < 1.5,Tree_40_Node_72,Tree_40_Node_73);
        Tree_40_Node_28 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 1.5,Tree_40_Node_46,Tree_40_Node_47);
        Tree_40_Node_74 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 0.5,167,168);
        Tree_40_Node_75 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.4,169,170);
        Tree_40_Node_48 := IF ( le.p_PhoneOtherAgeOldestRecord < 132.0,Tree_40_Node_74,Tree_40_Node_75);
        Tree_40_Node_29 := IF ( le.p_PrevAddrMedianIncome < 92873.5,Tree_40_Node_48,125);
        Tree_40_Node_15 := IF ( le.p_PropAgeOldestPurchase < 231.5,Tree_40_Node_28,Tree_40_Node_29);
        Tree_40_Node_7 := IF ( le.p_PrevAddrMedianIncome < 19919.5,Tree_40_Node_14,Tree_40_Node_15);
        Tree_40_Node_3 := IF ( le.p_PRSearchLocateCount24 < 2.0,Tree_40_Node_6,Tree_40_Node_7);
        Tree_40_Node_1 := IF ( le.p_SSNLowIssueAge < 572.5,Tree_40_Node_2,Tree_40_Node_3);
    UNSIGNED2 Score1_Tree40_node := Tree_40_Node_1;
    REAL8 Score1_Tree40_score := CASE(Score1_Tree40_node,114=>0.002036274,115=>-0.06371172,116=>-0.09762587,117=>0.06396092,118=>0.17179522,119=>0.027541436,120=>0.077293016,121=>0.17549893,122=>0.0991457,123=>-0.02298124,124=>0.104118,125=>0.16234477,126=>0.022967238,127=>0.13634512,128=>-0.07812251,129=>-0.0794726,130=>-0.076980256,131=>0.044981588,132=>0.016765105,133=>-0.0021204497,134=>-0.012772792,135=>0.014195903,136=>-0.020685177,137=>0.028089399,138=>-0.0013758115,139=>-0.017760728,140=>0.011073207,141=>0.008044037,142=>-0.062064666,143=>-0.028939754,144=>0.008667421,145=>0.12452297,146=>-0.014033334,147=>-0.013656051,148=>0.09559793,149=>8.575411E-4,150=>-0.0203918,151=>0.02046412,152=>-0.06233319,153=>-0.020535866,154=>0.022100894,155=>0.039472412,156=>-0.060116153,157=>0.03629107,158=>-0.078882225,159=>-0.0021545272,160=>0.078104645,161=>-0.064492576,162=>-0.00989331,163=>0.0022484309,164=>0.15073095,165=>0.07068339,166=>-0.019879362,167=>0.04064339,168=>-0.037191384,169=>0.112827,170=>0.0071046664,0);
ENDMACRO;
