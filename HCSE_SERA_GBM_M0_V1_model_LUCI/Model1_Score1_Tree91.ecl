EXPORT Model1_Score1_Tree91(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_91_Node_52 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 3.5,138,139);
        Tree_91_Node_53 := IF ( le.p_EstimatedAnnualIncome < 35000.5,140,141);
        Tree_91_Node_32 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 8.5,Tree_91_Node_52,Tree_91_Node_53);
        Tree_91_Node_16 := IF ( le.p_BP_3 < 4.5,Tree_91_Node_32,122);
        Tree_91_Node_35 := IF ( le.p_SubjectAddrCount < 16.5,128,129);
        Tree_91_Node_17 := IF ( le.p_v1_CrtRecMsdmeanCnt < 0.5,123,Tree_91_Node_35);
        Tree_91_Node_8 := IF ( le.p_SearchUnverifiedSSNCountYear < 1.5,Tree_91_Node_16,Tree_91_Node_17);
        Tree_91_Node_56 := IF ( le.p_SSNLowIssueAge < 522.5,142,143);
        Tree_91_Node_57 := IF ( le.p_SSNIssueState < 50.5,144,145);
        Tree_91_Node_36 := IF ( le.p_SSNIssueState < 48.5,Tree_91_Node_56,Tree_91_Node_57);
        Tree_91_Node_59 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 2.5,146,147);
        Tree_91_Node_37 := IF ( le.p_SSNHighIssueAge < 635.5,130,Tree_91_Node_59);
        Tree_91_Node_18 := IF ( le.p_SSNHighIssueAge < 628.5,Tree_91_Node_36,Tree_91_Node_37);
        Tree_91_Node_60 := IF ( le.p_CurrAddrCarTheftIndex < 100.0,148,149);
        Tree_91_Node_61 := IF ( le.p_PrevAddrCrimeIndex < 59.5,150,151);
        Tree_91_Node_38 := IF ( le.p_EstimatedAnnualIncome < 46500.5,Tree_91_Node_60,Tree_91_Node_61);
        Tree_91_Node_19 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 255.5,Tree_91_Node_38,124);
        Tree_91_Node_9 := IF ( le.p_v1_CrtRecTimeNewest < 87.5,Tree_91_Node_18,Tree_91_Node_19);
        Tree_91_Node_4 := IF ( le.p_SearchVelocityRiskLevel < 6.5,Tree_91_Node_8,Tree_91_Node_9);
        Tree_91_Node_62 := IF ( le.p_StatusMostRecent < 2.5,152,153);
        Tree_91_Node_40 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 146.5,Tree_91_Node_62,131);
        Tree_91_Node_64 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 18.5,154,155);
        Tree_91_Node_41 := IF ( le.p_PrevAddrLenOfRes < 139.5,Tree_91_Node_64,132);
        Tree_91_Node_20 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,Tree_91_Node_40,Tree_91_Node_41);
        Tree_91_Node_66 := IF ( le.p_NonDerogCount24 < 3.5,156,157);
        Tree_91_Node_67 := IF ( le.p_NonDerogCount12 < 2.5,158,159);
        Tree_91_Node_42 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 1.5,Tree_91_Node_66,Tree_91_Node_67);
        Tree_91_Node_68 := IF ( le.p_PrevAddrMurderIndex < 99.5,160,161);
        Tree_91_Node_43 := IF ( le.p_v1_ProspectTimeLastUpdate < 129.0,Tree_91_Node_68,133);
        Tree_91_Node_21 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 0.5,Tree_91_Node_42,Tree_91_Node_43);
        Tree_91_Node_10 := IF ( le.p_v1_HHCrtRecFelonyMmbrCnt < 0.5,Tree_91_Node_20,Tree_91_Node_21);
        Tree_91_Node_23 := IF ( le.p_CurrAddrAVMValue12 < 9214.0,125,126);
        Tree_91_Node_11 := IF ( le.p_LienFiledAge < 4.5,116,Tree_91_Node_23);
        Tree_91_Node_5 := IF ( le.p_v1_CrtRecCnt < 39.5,Tree_91_Node_10,Tree_91_Node_11);
        Tree_91_Node_2 := IF ( le.p_BPV_1 < 1.1074375,Tree_91_Node_4,Tree_91_Node_5);
        Tree_91_Node_70 := IF ( le.p_VariationDOBCount < 1.5,162,163);
        Tree_91_Node_71 := IF ( le.p_CurrAddrBlockIndex < 1.058,164,165);
        Tree_91_Node_46 := IF ( le.p_v1_RaAMedIncomeRange < 2.5,Tree_91_Node_70,Tree_91_Node_71);
        Tree_91_Node_72 := IF ( le.p_FelonyCount < 4.5,166,167);
        Tree_91_Node_47 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 3.5,Tree_91_Node_72,134);
        Tree_91_Node_24 := IF ( le.p_DerogAge < 194.5,Tree_91_Node_46,Tree_91_Node_47);
        Tree_91_Node_12 := IF ( le.p_P_EstimatedHHIncomePerCapita < 4.5023437,Tree_91_Node_24,117);
        Tree_91_Node_74 := IF ( le.p_CurrAddrAgeLastSale < 240.5,168,169);
        Tree_91_Node_48 := IF ( le.p_SSNIssueState < 44.5,Tree_91_Node_74,135);
        Tree_91_Node_76 := IF ( le.p_NonDerogCount60 < 3.5,170,171);
        Tree_91_Node_77 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 4.5,172,173);
        Tree_91_Node_49 := IF ( le.p_v1_CrtRecMsdmeanCnt < 43.5,Tree_91_Node_76,Tree_91_Node_77);
        Tree_91_Node_26 := IF ( le.p_PhoneEDAAgeOldestRecord < 19.5,Tree_91_Node_48,Tree_91_Node_49);
        Tree_91_Node_13 := IF ( le.p_AddrChangeCount24 < 3.5,Tree_91_Node_26,118);
        Tree_91_Node_6 := IF ( le.p_PrevAddrMedianValue < 105467.5,Tree_91_Node_12,Tree_91_Node_13);
        Tree_91_Node_50 := IF ( le.p_v1_ProspectTimeOnRecord < 190.5,136,137);
        Tree_91_Node_28 := IF ( le.p_CurrAddrAgeLastSale < 53.5,Tree_91_Node_50,127);
        Tree_91_Node_14 := IF ( le.p_EstimatedAnnualIncome < 40508.5,Tree_91_Node_28,119);
        Tree_91_Node_15 := IF ( le.p_PrevAddrAgeLastSale < 4.5,120,121);
        Tree_91_Node_7 := IF ( le.p_CurrAddrAgeLastSale < 155.5,Tree_91_Node_14,Tree_91_Node_15);
        Tree_91_Node_3 := IF ( le.p_PrevAddrLenOfRes < 251.5,Tree_91_Node_6,Tree_91_Node_7);
        Tree_91_Node_1 := IF ( le.p_v1_CrtRecMsdmeanCnt < 36.5,Tree_91_Node_2,Tree_91_Node_3);
    UNSIGNED2 Score1_Tree91_node := Tree_91_Node_1;
    REAL8 Score1_Tree91_score := CASE(Score1_Tree91_node,116=>0.05639719,117=>0.05627868,118=>0.031236155,119=>0.038030855,120=>0.058989473,121=>0.017870212,122=>0.022811344,123=>0.054165035,124=>0.037852984,125=>-0.01903283,126=>0.026942369,127=>-0.04708352,128=>-0.028451854,129=>0.026629584,130=>0.076193586,131=>0.04283919,132=>-0.039332524,133=>0.018372994,134=>0.06510112,135=>0.0050845533,136=>0.020324418,137=>-0.036171313,138=>2.5407635E-4,139=>-0.0055891387,140=>-0.04498723,141=>-0.030459506,142=>-4.8128178E-4,143=>-0.024287514,144=>0.055751875,145=>-0.04478838,146=>-0.006721425,147=>0.06179724,148=>-0.03947392,149=>-0.016325401,150=>-0.044717852,151=>0.011112166,152=>0.0014146403,153=>0.02322552,154=>0.016391674,155=>-0.013778695,156=>-0.027007267,157=>0.004858001,158=>0.06298055,159=>0.016021306,160=>-0.005737738,161=>-0.032276373,162=>0.04293036,163=>-0.006506727,164=>-0.0127924895,165=>0.020257922,166=>-0.02548856,167=>0.025459494,168=>-0.03755193,169=>-0.0012957882,170=>0.046723444,171=>-0.0055949013,172=>-0.0042723576,173=>-0.02880945,0);
ENDMACRO;
