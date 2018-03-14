﻿EXPORT Model1_Score1_Tree153(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_153_Node_58 := IF ( le.p_FelonyCount < 5.5,156,157);
        Tree_153_Node_59 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 480.0,158,159);
        Tree_153_Node_32 := IF ( le.p_CurrAddrCarTheftIndex < 80.5,Tree_153_Node_58,Tree_153_Node_59);
        Tree_153_Node_60 := IF ( le.p_PrevAddrCrimeIndex < 190.5,160,161);
        Tree_153_Node_61 := IF ( le.p_DivSSNAddrMSourceCount < 11.5,162,163);
        Tree_153_Node_33 := IF ( le.p_CurrAddrBurglaryIndex < 140.5,Tree_153_Node_60,Tree_153_Node_61);
        Tree_153_Node_16 := IF ( le.p_CurrAddrCarTheftIndex < 89.5,Tree_153_Node_32,Tree_153_Node_33);
        Tree_153_Node_62 := IF ( le.p_PrevAddrMedianValue < 152057.0,164,165);
        Tree_153_Node_63 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,166,167);
        Tree_153_Node_34 := IF ( le.p_CurrAddrCrimeIndex < 110.5,Tree_153_Node_62,Tree_153_Node_63);
        Tree_153_Node_64 := IF ( le.p_CurrAddrCarTheftIndex < 59.0,168,169);
        Tree_153_Node_65 := IF ( le.p_PropAgeOldestPurchase < 449.5,170,171);
        Tree_153_Node_35 := IF ( le.p_v1_ProspectAge < 64.5,Tree_153_Node_64,Tree_153_Node_65);
        Tree_153_Node_17 := IF ( le.p_CurrAddrTractIndex < 0.64765626,Tree_153_Node_34,Tree_153_Node_35);
        Tree_153_Node_8 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 378.5,Tree_153_Node_16,Tree_153_Node_17);
        Tree_153_Node_67 := IF ( le.p_VariationMSourcesSSNCount < 1.5,172,173);
        Tree_153_Node_36 := IF ( le.p_CurrAddrAgeOldestRecord < 21.5,145,Tree_153_Node_67);
        Tree_153_Node_68 := IF ( le.p_PropAgeNewestSale < 135.0,174,175);
        Tree_153_Node_37 := IF ( le.p_CurrAddrMedianValue < 359692.5,Tree_153_Node_68,146);
        Tree_153_Node_18 := IF ( le.p_RelativesBankruptcyCount < 1.5,Tree_153_Node_36,Tree_153_Node_37);
        Tree_153_Node_70 := IF ( le.p_RelativesPropOwnedTaxTotal < 308501.5,176,177);
        Tree_153_Node_71 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 180.5,178,179);
        Tree_153_Node_39 := IF ( le.p_PrevAddrAgeLastSale < 41.5,Tree_153_Node_70,Tree_153_Node_71);
        Tree_153_Node_19 := IF ( le.p_SSNHighIssueAge < 386.5,135,Tree_153_Node_39);
        Tree_153_Node_9 := IF ( le.p_PrevAddrBurglaryIndex < 87.5,Tree_153_Node_18,Tree_153_Node_19);
        Tree_153_Node_4 := IF ( le.p_LienReleasedAge < 220.5,Tree_153_Node_8,Tree_153_Node_9);
        Tree_153_Node_10 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 0.5,132,133);
        Tree_153_Node_22 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 3.5,136,137);
        Tree_153_Node_23 := IF ( le.p_SearchVelocityRiskLevel < 2.5,138,139);
        Tree_153_Node_11 := IF ( le.p_AssocSuspicousIdentitiesCount < 1.5,Tree_153_Node_22,Tree_153_Node_23);
        Tree_153_Node_5 := IF ( le.p_PrevAddrMurderIndex < 67.5,Tree_153_Node_10,Tree_153_Node_11);
        Tree_153_Node_2 := IF ( le.p_CurrAddrTractIndex < 1.8555142,Tree_153_Node_4,Tree_153_Node_5);
        Tree_153_Node_45 := IF ( le.p_AssocSuspicousIdentitiesCount < 1.5,147,148);
        Tree_153_Node_24 := IF ( le.p_PrevAddrAgeOldestRecord < 26.5,140,Tree_153_Node_45);
        Tree_153_Node_74 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 1.5,180,181);
        Tree_153_Node_75 := IF ( le.p_PrevAddrDwellType < 6.0,182,183);
        Tree_153_Node_46 := IF ( le.p_PrevAddrBurglaryIndex < 160.5,Tree_153_Node_74,Tree_153_Node_75);
        Tree_153_Node_76 := IF ( le.p_SSNLowIssueAge < 383.5,184,185);
        Tree_153_Node_77 := IF ( le.p_PRSearchOtherCount < 5.0,186,187);
        Tree_153_Node_47 := IF ( le.p_SubjectLastNameCount < 2.5,Tree_153_Node_76,Tree_153_Node_77);
        Tree_153_Node_25 := IF ( le.p_CurrAddrMedianValue < 171996.5,Tree_153_Node_46,Tree_153_Node_47);
        Tree_153_Node_12 := IF ( le.p_CurrAddrMedianValue < 70311.5,Tree_153_Node_24,Tree_153_Node_25);
        Tree_153_Node_78 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 1.5,188,189);
        Tree_153_Node_79 := IF ( le.p_PrevAddrAgeNewestRecord < 102.5,190,191);
        Tree_153_Node_48 := IF ( le.p_CurrAddrAgeOldestRecord < 332.5,Tree_153_Node_78,Tree_153_Node_79);
        Tree_153_Node_80 := IF ( le.p_v1_LifeEvEverResidedCnt < 2.5,192,193);
        Tree_153_Node_49 := IF ( le.p_PrevAddrMurderIndex < 125.5,Tree_153_Node_80,149);
        Tree_153_Node_26 := IF ( le.p_P_EstimatedHHIncomePerCapita < 4.765625,Tree_153_Node_48,Tree_153_Node_49);
        Tree_153_Node_82 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 306466.5,194,195);
        Tree_153_Node_51 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 4.5,Tree_153_Node_82,150);
        Tree_153_Node_27 := IF ( le.p_CurrAddrMedianValue < 78124.5,141,Tree_153_Node_51);
        Tree_153_Node_13 := IF ( le.p_PrevAddrCrimeIndex < 176.5,Tree_153_Node_26,Tree_153_Node_27);
        Tree_153_Node_6 := IF ( le.p_PrevAddrAgeOldestRecord < 125.5,Tree_153_Node_12,Tree_153_Node_13);
        Tree_153_Node_52 := IF ( le.p_PhoneEDAAgeOldestRecord < 14.5,151,152);
        Tree_153_Node_86 := IF ( le.p_CurrAddrBlockIndex < 2.649,196,197);
        Tree_153_Node_53 := IF ( le.p_SourceRiskLevel < 4.5,Tree_153_Node_86,153);
        Tree_153_Node_28 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,Tree_153_Node_52,Tree_153_Node_53);
        Tree_153_Node_14 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 2.5,Tree_153_Node_28,134);
        Tree_153_Node_54 := IF ( le.p_CurrAddrAVMValue60 < 105788.5,154,155);
        Tree_153_Node_30 := IF ( le.p_v1_ProspectTimeLastUpdate < 70.5,Tree_153_Node_54,142);
        Tree_153_Node_31 := IF ( le.p_PropAgeNewestPurchase < 154.5,143,144);
        Tree_153_Node_15 := IF ( le.p_age_in_years < 69.84383,Tree_153_Node_30,Tree_153_Node_31);
        Tree_153_Node_7 := IF ( le.p_PhoneOtherAgeNewestRecord < 10.5,Tree_153_Node_14,Tree_153_Node_15);
        Tree_153_Node_3 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 121.0,Tree_153_Node_6,Tree_153_Node_7);
        Tree_153_Node_1 := IF ( le.p_CurrAddrTractIndex < 1.9008398,Tree_153_Node_2,Tree_153_Node_3);
    UNSIGNED2 Score1_Tree153_node := Tree_153_Node_1;
    REAL8 Score1_Tree153_score := CASE(Score1_Tree153_node,132=>0.0056745373,133=>-0.017563283,134=>0.003712801,135=>0.017967211,136=>0.009537754,137=>0.047741283,138=>-0.024471825,139=>0.011182691,140=>-0.008506871,141=>0.00829779,142=>0.022541553,143=>-0.02536006,144=>-0.009351111,145=>-0.014433454,146=>0.010264788,147=>0.031659797,148=>-5.798609E-4,149=>0.03624448,150=>0.006633557,151=>-0.025678681,152=>-0.024759395,153=>-0.004115394,154=>-0.024081454,155=>0.013097863,156=>6.5208085E-5,157=>-0.0064627915,158=>-0.0049575972,159=>0.027255356,160=>0.0020269484,161=>-0.0049671363,162=>-9.7293156E-4,163=>0.0023404553,164=>-0.01670788,165=>0.005315203,166=>-0.00860295,167=>0.016596861,168=>0.015570793,169=>-0.02424786,170=>-0.022599395,171=>-6.156478E-4,172=>0.0059877927,173=>0.030211464,174=>-0.01993001,175=>-7.1331154E-4,176=>-0.02295164,177=>-0.0076574474,178=>-0.016725501,179=>0.005138648,180=>-0.019486053,181=>-0.005225936,182=>-0.020747755,183=>0.009931468,184=>-0.023560109,185=>0.017631564,186=>-0.021384567,187=>0.0035852697,188=>-0.00699449,189=>0.0043325135,190=>0.017909026,191=>-0.013572511,192=>-0.009126466,193=>0.033881202,194=>-0.025048763,195=>-0.012242533,196=>-0.024168102,197=>-0.012371068,0);
ENDMACRO;
