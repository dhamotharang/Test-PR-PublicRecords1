EXPORT Model1_Score1_Tree20_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_20_Node_46 := IF ( le.p_age_in_years < 0.0375,132,133);
        Tree_20_Node_47 := CHOOSE ( le.p_gender,134,135);
        Tree_20_Node_26 := IF ( le.p_SSNHighIssueAge < -0.5,Tree_20_Node_46,Tree_20_Node_47);
        Tree_20_Node_14 := IF ( le.p_age_in_years < 0.75981444,Tree_20_Node_26,119);
        Tree_20_Node_48 := IF ( le.p_AddrChangeCount24 < 1.5,136,137);
        Tree_20_Node_28 := IF ( le.p_PropAgeOldestPurchase < 576.5,Tree_20_Node_48,125);
        Tree_20_Node_50 := IF ( le.p_PRSearchOtherCount < 0.5,138,139);
        Tree_20_Node_51 := IF ( le.p_PrevAddrCrimeIndex < 29.5,140,141);
        Tree_20_Node_29 := IF ( le.p_PhoneEDAAgeOldestRecord < 183.5,Tree_20_Node_50,Tree_20_Node_51);
        Tree_20_Node_15 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 2.5,Tree_20_Node_28,Tree_20_Node_29);
        Tree_20_Node_8 := IF ( le.p_age_in_years < 0.853125,Tree_20_Node_14,Tree_20_Node_15);
        Tree_20_Node_52 := IF ( le.p_v1_CrtRecCnt12Mo < 1.5,142,143);
        Tree_20_Node_53 := IF ( le.p_EstimatedAnnualIncome < 40600.5,144,145);
        Tree_20_Node_30 := IF ( le.p_SSNIssueState < 33.5,Tree_20_Node_52,Tree_20_Node_53);
        Tree_20_Node_16 := IF ( le.p_age_in_years < 66.419685,Tree_20_Node_30,120);
        Tree_20_Node_55 := IF ( le.p_EstimatedAnnualIncome < 38582.5,146,147);
        Tree_20_Node_32 := IF ( le.p_EstimatedAnnualIncome < 31625.5,126,Tree_20_Node_55);
        Tree_20_Node_17 := IF ( le.p_age_in_years < 39.949844,Tree_20_Node_32,121);
        Tree_20_Node_9 := IF ( le.p_DerogAge < 33.5,Tree_20_Node_16,Tree_20_Node_17);
        Tree_20_Node_4 := IF ( le.p_PRSearchOtherCount < 4.5,Tree_20_Node_8,Tree_20_Node_9);
        Tree_20_Node_2 := IF ( le.p_CurrAddrCarTheftIndex < 199.0,Tree_20_Node_4,116);
        Tree_20_Node_56 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,148,149);
        Tree_20_Node_57 := IF ( le.p_age_in_years < 21.446,150,151);
        Tree_20_Node_34 := IF ( le.p_AddrChangeCount60 < 4.5,Tree_20_Node_56,Tree_20_Node_57);
        Tree_20_Node_58 := IF ( le.p_SubjectLastNameCount < 1.5,152,153);
        Tree_20_Node_59 := IF ( le.p_PrevAddrAgeLastSale < 239.5,154,155);
        Tree_20_Node_35 := IF ( le.p_v1_RaAMedIncomeRange < 2.5,Tree_20_Node_58,Tree_20_Node_59);
        Tree_20_Node_18 := IF ( le.p_BPV_1 < 2.896375,Tree_20_Node_34,Tree_20_Node_35);
        Tree_20_Node_60 := IF ( le.p_RelativesPropOwnedCount < 7.5,156,157);
        Tree_20_Node_61 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,158,159);
        Tree_20_Node_36 := IF ( le.p_v1_ProspectAge < 62.0,Tree_20_Node_60,Tree_20_Node_61);
        Tree_20_Node_62 := IF ( le.p_BP_4 < 9.5,160,161);
        Tree_20_Node_63 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,162,163);
        Tree_20_Node_37 := IF ( le.p_PrevAddrMedianValue < 218749.5,Tree_20_Node_62,Tree_20_Node_63);
        Tree_20_Node_19 := IF ( le.p_v1_HHCrtRecBkrptMmbrCnt < 1.5,Tree_20_Node_36,Tree_20_Node_37);
        Tree_20_Node_10 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_20_Node_18,Tree_20_Node_19);
        Tree_20_Node_64 := IF ( le.p_v1_LifeEvEverResidedCnt < 3.5,164,165);
        Tree_20_Node_65 := IF ( le.p_v1_PropTimeLastSale < 147.5,166,167);
        Tree_20_Node_38 := IF ( le.p_v1_HHEstimatedIncomeRange < 7.5,Tree_20_Node_64,Tree_20_Node_65);
        Tree_20_Node_20 := IF ( le.p_v1_HHPropCurrOwnedCnt < 10.5,Tree_20_Node_38,122);
        Tree_20_Node_11 := IF ( le.p_CurrAddrAgeOldestRecord < 696.5,Tree_20_Node_20,117);
        Tree_20_Node_6 := IF ( le.p_NonDerogCount06 < 5.5,Tree_20_Node_10,Tree_20_Node_11);
        Tree_20_Node_66 := IF ( le.p_CurrAddrMedianIncome < 42291.5,168,169);
        Tree_20_Node_40 := IF ( le.p_LienFiledCount < 2.5,Tree_20_Node_66,127);
        Tree_20_Node_22 := IF ( le.p_CurrAddrCrimeIndex < 130.5,Tree_20_Node_40,123);
        Tree_20_Node_42 := IF ( le.p_PrevAddrAgeOldestRecord < 60.5,128,129);
        Tree_20_Node_23 := IF ( le.p_v1_CrtRecMsdmeanCnt < 7.5,Tree_20_Node_42,124);
        Tree_20_Node_12 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 17.5,Tree_20_Node_22,Tree_20_Node_23);
        Tree_20_Node_70 := IF ( le.p_PRSearchLocateCount < 1.5,170,171);
        Tree_20_Node_44 := IF ( le.p_BPV_1 < 2.726,Tree_20_Node_70,130);
        Tree_20_Node_73 := IF ( le.p_v1_HHCnt < 4.5,172,173);
        Tree_20_Node_45 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 1.5,131,Tree_20_Node_73);
        Tree_20_Node_24 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,Tree_20_Node_44,Tree_20_Node_45);
        Tree_20_Node_13 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 397772.5,Tree_20_Node_24,118);
        Tree_20_Node_7 := IF ( le.p_PrevAddrAgeLastSale < 3.5,Tree_20_Node_12,Tree_20_Node_13);
        Tree_20_Node_3 := IF ( le.p_BPV_3 < 2.7154999,Tree_20_Node_6,Tree_20_Node_7);
        Tree_20_Node_1 := IF ( le.p_BPV_4 < -2.8944707,Tree_20_Node_2,Tree_20_Node_3);
    SELF.Score1_Tree20_node := Tree_20_Node_1;
    SELF.Score1_Tree20_score := CASE(SELF.Score1_Tree20_node,116=>0.086452566,117=>0.16547886,118=>-0.05159356,119=>0.060509566,120=>-0.09428614,121=>-0.09386511,122=>0.08595209,123=>-0.05830299,124=>-0.011920869,125=>0.08348089,126=>-0.09138741,127=>0.083991215,128=>-0.10571694,129=>-0.038282994,130=>0.047895655,131=>-0.031304702,132=>-0.050215874,133=>-0.013083425,134=>-0.046393115,135=>0.04133761,136=>0.00194263,137=>-0.0903484,138=>-0.05965728,139=>-0.020888977,140=>0.14696383,141=>-0.019113017,142=>0.022534205,143=>-0.08978621,144=>-0.090758994,145=>-0.08882332,146=>-0.09012247,147=>-0.08901016,148=>0.0021819756,149=>0.008808058,150=>0.14401196,151=>-0.014850748,152=>0.14482081,153=>0.049505167,154=>0.022052659,155=>-0.07131621,156=>-0.033091865,157=>0.069787405,158=>0.047761507,159=>-0.011064571,160=>0.033485204,161=>0.18602274,162=>-0.09311672,163=>0.027449062,164=>-0.021221003,165=>0.012710956,166=>-0.09165863,167=>-0.03853338,168=>0.037579514,169=>-0.03861471,170=>0.16670375,171=>0.06448254,172=>0.14559099,173=>0.007422348,0);
ENDMACRO;
