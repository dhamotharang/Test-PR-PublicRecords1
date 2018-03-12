﻿EXPORT Model1_Score1_Tree130_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_130_Node_54 := IF ( le.p_v1_CrtRecTimeNewest < 216.0,152,153);
        Tree_130_Node_55 := IF ( le.p_age_in_years < 54.6,154,155);
        Tree_130_Node_30 := IF ( le.p_AddrChangeCount60 < 7.5,Tree_130_Node_54,Tree_130_Node_55);
        Tree_130_Node_31 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,143,144);
        Tree_130_Node_16 := IF ( le.p_CurrAddrCountyIndex < 4.4579687,Tree_130_Node_30,Tree_130_Node_31);
        Tree_130_Node_59 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,156,157);
        Tree_130_Node_32 := IF ( le.p_v1_RaAMedIncomeRange < 0.0,145,Tree_130_Node_59);
        Tree_130_Node_17 := IF ( le.p_CurrAddrCarTheftIndex < 190.5,Tree_130_Node_32,135);
        Tree_130_Node_8 := IF ( le.p_CurrAddrAVMValue60 < 278271.5,Tree_130_Node_16,Tree_130_Node_17);
        Tree_130_Node_60 := IF ( le.p_AddrChangeCount60 < 6.5,158,159);
        Tree_130_Node_61 := IF ( le.p_CurrAddrAgeLastSale < 143.5,160,161);
        Tree_130_Node_34 := IF ( le.p_v1_CrtRecMsdmeanCnt < 30.5,Tree_130_Node_60,Tree_130_Node_61);
        Tree_130_Node_62 := IF ( le.p_PhoneEDAAgeOldestRecord < 132.5,162,163);
        Tree_130_Node_63 := IF ( le.p_NonDerogCount24 < 4.5,164,165);
        Tree_130_Node_35 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 4.5,Tree_130_Node_62,Tree_130_Node_63);
        Tree_130_Node_18 := IF ( le.p_SubjectLastNameCount < 6.5,Tree_130_Node_34,Tree_130_Node_35);
        Tree_130_Node_9 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 488.5,Tree_130_Node_18,133);
        Tree_130_Node_4 := IF ( le.p_CurrAddrMedianIncome < 70686.5,Tree_130_Node_8,Tree_130_Node_9);
        Tree_130_Node_20 := IF ( le.p_CurrAddrAgeLastSale < 36.5,136,137);
        Tree_130_Node_10 := IF ( le.p_CurrAddrAgeLastSale < 99.5,Tree_130_Node_20,134);
        Tree_130_Node_5 := IF ( le.p_PropAgeNewestPurchase < 167.5,Tree_130_Node_10,132);
        Tree_130_Node_2 := IF ( le.p_CurrAddrAVMValue60 < 473680.5,Tree_130_Node_4,Tree_130_Node_5);
        Tree_130_Node_64 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 2.5,166,167);
        Tree_130_Node_65 := IF ( le.p_VariationDOBCount < 3.5,168,169);
        Tree_130_Node_38 := IF ( le.p_SubjectLastNameCount < 1.5,Tree_130_Node_64,Tree_130_Node_65);
        Tree_130_Node_66 := IF ( le.p_RelativesPropOwnedTaxTotal < 594879.5,170,171);
        Tree_130_Node_67 := IF ( le.p_BPV_4 < -1.8718975,172,173);
        Tree_130_Node_39 := IF ( le.p_PropAgeNewestSale < 191.5,Tree_130_Node_66,Tree_130_Node_67);
        Tree_130_Node_22 := IF ( le.p_v1_ProspectTimeLastUpdate < 197.5,Tree_130_Node_38,Tree_130_Node_39);
        Tree_130_Node_68 := IF ( le.p_PropAgeOldestPurchase < 146.5,174,175);
        Tree_130_Node_69 := IF ( le.p_v1_CrtRecCnt < 6.5,176,177);
        Tree_130_Node_40 := IF ( le.p_NonDerogCount < 8.5,Tree_130_Node_68,Tree_130_Node_69);
        Tree_130_Node_41 := IF ( le.p_v1_LifeEvEverResidedCnt < 1.5,146,147);
        Tree_130_Node_23 := IF ( le.p_v1_HHCrtRecBkrptMmbrCnt < 1.5,Tree_130_Node_40,Tree_130_Node_41);
        Tree_130_Node_12 := IF ( le.p_BPV_4 < -1.5618258,Tree_130_Node_22,Tree_130_Node_23);
        Tree_130_Node_24 := IF ( le.p_PrevAddrMedianValue < 109375.5,138,139);
        Tree_130_Node_72 := IF ( le.p_age_in_years < 73.598,178,179);
        Tree_130_Node_73 := IF ( le.p_NonDerogCount24 < 5.5,180,181);
        Tree_130_Node_44 := IF ( le.p_EstimatedAnnualIncome < 37406.5,Tree_130_Node_72,Tree_130_Node_73);
        Tree_130_Node_25 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 2.5,Tree_130_Node_44,140);
        Tree_130_Node_13 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 78124.5,Tree_130_Node_24,Tree_130_Node_25);
        Tree_130_Node_6 := IF ( le.p_PrevAddrCrimeIndex < 180.5,Tree_130_Node_12,Tree_130_Node_13);
        Tree_130_Node_74 := IF ( le.p_PrevAddrMurderIndex < 140.5,182,183);
        Tree_130_Node_46 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 1.5,Tree_130_Node_74,148);
        Tree_130_Node_47 := IF ( le.p_v1_ProspectAge < 60.5,149,150);
        Tree_130_Node_26 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 191.5,Tree_130_Node_46,Tree_130_Node_47);
        Tree_130_Node_78 := IF ( le.p_v1_HHCnt < 2.5,184,185);
        Tree_130_Node_79 := IF ( le.p_NonDerogCount12 < 5.5,186,187);
        Tree_130_Node_48 := IF ( le.p_CurrAddrTaxMarketValue < 188635.5,Tree_130_Node_78,Tree_130_Node_79);
        Tree_130_Node_80 := IF ( le.p_PRSearchOtherCount < 2.5,188,189);
        Tree_130_Node_49 := IF ( le.p_PropAgeNewestSale < 168.5,Tree_130_Node_80,151);
        Tree_130_Node_27 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 132.5,Tree_130_Node_48,Tree_130_Node_49);
        Tree_130_Node_14 := IF ( le.p_CurrAddrTractIndex < 0.703125,Tree_130_Node_26,Tree_130_Node_27);
        Tree_130_Node_82 := IF ( le.p_CurrAddrBurglaryIndex < 147.5,190,191);
        Tree_130_Node_83 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,192,193);
        Tree_130_Node_50 := IF ( le.p_BP_4 < 7.5,Tree_130_Node_82,Tree_130_Node_83);
        Tree_130_Node_84 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,194,195);
        Tree_130_Node_85 := IF ( le.p_PhoneEDAAgeOldestRecord < 142.5,196,197);
        Tree_130_Node_51 := IF ( le.p_v1_CrtRecCnt12Mo < 0.5,Tree_130_Node_84,Tree_130_Node_85);
        Tree_130_Node_28 := IF ( le.p_SubjectAddrCount < 19.5,Tree_130_Node_50,Tree_130_Node_51);
        Tree_130_Node_29 := IF ( le.p_LastNameChangeAge < 182.5,141,142);
        Tree_130_Node_15 := IF ( le.p_SubjectAddrCount < 29.5,Tree_130_Node_28,Tree_130_Node_29);
        Tree_130_Node_7 := IF ( le.p_v1_RaAHHCnt < 3.5,Tree_130_Node_14,Tree_130_Node_15);
        Tree_130_Node_3 := IF ( le.p_CurrAddrBurglaryIndex < 103.0,Tree_130_Node_6,Tree_130_Node_7);
        Tree_130_Node_1 := IF ( le.p_CurrAddrMedianValue < 247069.5,Tree_130_Node_2,Tree_130_Node_3);
    SELF.Score1_Tree130_node := Tree_130_Node_1;
    SELF.Score1_Tree130_score := CASE(SELF.Score1_Tree130_node,132=>-0.030637266,133=>0.036591973,134=>0.04492037,135=>0.02036664,136=>0.029304175,137=>-0.0123001775,138=>0.028320812,139=>-0.023488412,140=>0.0018667637,141=>-0.012206376,142=>0.034043193,143=>-0.031716958,144=>-0.020870032,145=>0.01784304,146=>0.056277547,147=>2.8034204E-4,148=>0.034510422,149=>0.061951987,150=>0.009572864,151=>0.028113011,152=>2.2037262E-4,153=>-0.002357868,154=>-0.011742707,155=>0.0047114864,156=>-0.017130958,157=>0.0072890418,158=>0.0025440555,159=>0.031247353,160=>-0.025950033,161=>0.004607044,162=>-0.02837764,163=>-0.010077992,164=>0.04777412,165=>-0.017467547,166=>-5.362578E-4,167=>0.024805104,168=>-0.005052006,169=>0.0029524053,170=>-0.02428818,171=>8.2476425E-4,172=>-0.022252087,173=>0.022059595,174=>-0.017143568,175=>0.008820288,176=>0.003067959,177=>0.028791972,178=>-0.030922946,179=>-0.032808688,180=>-0.0300866,181=>-0.020297125,182=>-0.008405519,183=>0.008843565,184=>0.0051076873,185=>0.050366793,186=>0.0049131773,187=>0.03805395,188=>-0.0231295,189=>0.0034391526,190=>0.009385659,191=>-0.01027544,192=>3.960911E-4,193=>-0.017956678,194=>-0.028876936,195=>-0.018266706,196=>0.019832885,197=>-0.013545791,0);
ENDMACRO;
