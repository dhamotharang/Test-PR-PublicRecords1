EXPORT Model1_Score1_Tree15(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_15_Node_28 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,123,124);
        Tree_15_Node_48 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 4.5,131,132);
        Tree_15_Node_29 := IF ( le.p_SSNLowIssueAge < 640.5,Tree_15_Node_48,125);
        Tree_15_Node_16 := IF ( le.p_SubjectLastNameCount < 1.5,Tree_15_Node_28,Tree_15_Node_29);
        Tree_15_Node_50 := IF ( le.p_v1_HHCnt < 4.5,133,134);
        Tree_15_Node_30 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 52017.5,Tree_15_Node_50,126);
        Tree_15_Node_17 := IF ( le.p_PrevAddrAgeLastSale < 487.5,Tree_15_Node_30,119);
        Tree_15_Node_8 := IF ( le.p_BP_4 < 14.5,Tree_15_Node_16,Tree_15_Node_17);
        Tree_15_Node_52 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 1.5,135,136);
        Tree_15_Node_53 := IF ( le.p_v1_RaAMedIncomeRange < 7.5,137,138);
        Tree_15_Node_33 := IF ( le.p_PrevAddrMedianValue < 122916.5,Tree_15_Node_52,Tree_15_Node_53);
        Tree_15_Node_18 := IF ( le.p_BP_4 < 10.5,120,Tree_15_Node_33);
        Tree_15_Node_9 := IF ( le.p_PrevAddrMedianIncome < 92943.5,Tree_15_Node_18,116);
        Tree_15_Node_4 := IF ( le.p_CurrAddrAgeOldestRecord < 219.5,Tree_15_Node_8,Tree_15_Node_9);
        Tree_15_Node_5 := IF ( le.p_CurrAddrCarTheftIndex < 77.5,114,115);
        Tree_15_Node_2 := IF ( le.p_PropAgeOldestPurchase < 579.0,Tree_15_Node_4,Tree_15_Node_5);
        Tree_15_Node_54 := IF ( le.p_CurrAddrCrimeIndex < 190.5,139,140);
        Tree_15_Node_55 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 151499.5,141,142);
        Tree_15_Node_34 := IF ( le.p_DerogAge < 202.5,Tree_15_Node_54,Tree_15_Node_55);
        Tree_15_Node_56 := IF ( le.p_SourceRiskLevel < 3.5,143,144);
        Tree_15_Node_57 := IF ( le.p_PropAgeOldestPurchase < 143.5,145,146);
        Tree_15_Node_35 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,Tree_15_Node_56,Tree_15_Node_57);
        Tree_15_Node_20 := IF ( le.p_age_in_years < 60.316875,Tree_15_Node_34,Tree_15_Node_35);
        Tree_15_Node_58 := IF ( le.p_EstimatedAnnualIncome < 24600.5,147,148);
        Tree_15_Node_59 := IF ( le.p_v1_CrtRecLienJudgCnt < 1.5,149,150);
        Tree_15_Node_36 := IF ( le.p_BPV_2 < 2.1244562,Tree_15_Node_58,Tree_15_Node_59);
        Tree_15_Node_60 := IF ( le.p_NonDerogCount60 < 5.5,151,152);
        Tree_15_Node_61 := IF ( le.p_PrevAddrCrimeIndex < 160.5,153,154);
        Tree_15_Node_37 := IF ( le.p_PrevAddrDwellType < 5.5,Tree_15_Node_60,Tree_15_Node_61);
        Tree_15_Node_21 := IF ( le.p_PropAgeNewestPurchase < 415.5,Tree_15_Node_36,Tree_15_Node_37);
        Tree_15_Node_12 := IF ( le.p_SubjectSSNCount < 1.5,Tree_15_Node_20,Tree_15_Node_21);
        Tree_15_Node_62 := IF ( le.p_v1_HHCnt < 7.5,155,156);
        Tree_15_Node_38 := IF ( le.p_VariationMSourcesSSNCount < 5.5,Tree_15_Node_62,127);
        Tree_15_Node_64 := IF ( le.p_CurrAddrMedianIncome < 99086.0,157,158);
        Tree_15_Node_39 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 127.5,Tree_15_Node_64,128);
        Tree_15_Node_22 := IF ( le.p_SubjectLastNameCount < 9.5,Tree_15_Node_38,Tree_15_Node_39);
        Tree_15_Node_66 := IF ( le.p_CurrAddrAgeOldestRecord < 634.5,159,160);
        Tree_15_Node_67 := IF ( le.p_v1_CrtRecTimeNewest < 73.5,161,162);
        Tree_15_Node_40 := IF ( le.p_PRSearchOtherCount < 25.5,Tree_15_Node_66,Tree_15_Node_67);
        Tree_15_Node_68 := IF ( le.p_CurrAddrAgeLastSale < 143.5,163,164);
        Tree_15_Node_69 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 133.5,165,166);
        Tree_15_Node_41 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.8125,Tree_15_Node_68,Tree_15_Node_69);
        Tree_15_Node_23 := IF ( le.p_SSNIssueState < 28.5,Tree_15_Node_40,Tree_15_Node_41);
        Tree_15_Node_13 := IF ( le.p_SrcsConfirmIDAddrCount < 4.5,Tree_15_Node_22,Tree_15_Node_23);
        Tree_15_Node_6 := IF ( le.p_EstimatedAnnualIncome < 41484.5,Tree_15_Node_12,Tree_15_Node_13);
        Tree_15_Node_70 := IF ( le.p_RelativesBankruptcyCount < 2.5,167,168);
        Tree_15_Node_71 := IF ( le.p_v1_CrtRecCnt < 64.5,169,170);
        Tree_15_Node_42 := IF ( le.p_PrevAddrCarTheftIndex < 180.5,Tree_15_Node_70,Tree_15_Node_71);
        Tree_15_Node_43 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 7.5,129,130);
        Tree_15_Node_24 := IF ( le.p_v1_PropSoldRatio < 3.2798438,Tree_15_Node_42,Tree_15_Node_43);
        Tree_15_Node_25 := IF ( le.p_DerogAge < 91.5,121,122);
        Tree_15_Node_14 := IF ( le.p_BP_1 < 10.5,Tree_15_Node_24,Tree_15_Node_25);
        Tree_15_Node_15 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 93592.5,117,118);
        Tree_15_Node_7 := IF ( le.p_BPV_2 < 3.6988301,Tree_15_Node_14,Tree_15_Node_15);
        Tree_15_Node_3 := IF ( le.p_BPV_3 < 1.8425039,Tree_15_Node_6,Tree_15_Node_7);
        Tree_15_Node_1 := IF ( le.p_BPV_4 < -2.8944707,Tree_15_Node_2,Tree_15_Node_3);
    UNSIGNED2 Score1_Tree15_node := Tree_15_Node_1;
    REAL8 Score1_Tree15_score := CASE(Score1_Tree15_node,114=>0.008253182,115=>0.15410483,116=>0.09634544,117=>0.11345599,118=>0.03755264,119=>0.10115917,120=>0.12487829,121=>0.11828453,122=>0.052097168,123=>0.059456654,124=>-0.07797808,125=>-0.0129204,126=>0.07940108,127=>0.14951333,128=>0.2053142,129=>0.046550207,130=>0.15295896,131=>-0.091780335,132=>-0.03419879,133=>-0.041893445,134=>-0.08170126,135=>0.004948295,136=>0.11209971,137=>-0.060074456,138=>0.087041646,139=>-0.008743596,140=>0.02443863,141=>0.017710445,142=>0.26094437,143=>0.016977873,144=>-0.0013522544,145=>0.00768473,146=>0.03465103,147=>0.044404328,148=>0.012377416,149=>0.058361057,150=>-0.018017873,151=>-0.09340591,152=>-0.032467093,153=>-0.02663948,154=>0.067962654,155=>6.996261E-4,156=>0.0637288,157=>-0.01323679,158=>0.2607273,159=>-0.004630062,160=>0.0859926,161=>0.008190424,162=>0.25971594,163=>-0.027348615,164=>-0.063268155,165=>-0.013995012,166=>0.036424797,167=>0.0018333748,168=>0.031799834,169=>0.052818827,170=>-0.0418915,0);
ENDMACRO;
