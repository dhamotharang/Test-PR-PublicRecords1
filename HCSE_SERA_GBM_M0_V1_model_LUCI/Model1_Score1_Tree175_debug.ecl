﻿EXPORT Model1_Score1_Tree175_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_175_Node_46 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,146,147);
        Tree_175_Node_47 := IF ( le.p_v1_ProspectTimeOnRecord < 143.5,148,149);
        Tree_175_Node_26 := IF ( le.p_CurrAddrBlockIndex < 1.98375,Tree_175_Node_46,Tree_175_Node_47);
        Tree_175_Node_48 := IF ( le.p_CurrAddrCarTheftIndex < 39.5,150,151);
        Tree_175_Node_49 := IF ( le.p_LastNameChangeAge < 325.5,152,153);
        Tree_175_Node_27 := IF ( le.p_CurrAddrCountyIndex < 1.1653125,Tree_175_Node_48,Tree_175_Node_49);
        Tree_175_Node_14 := IF ( le.p_v1_RaAMedIncomeRange < 10.5,Tree_175_Node_26,Tree_175_Node_27);
        Tree_175_Node_8 := IF ( le.p_CurrAddrCountyIndex < 4.334375,Tree_175_Node_14,129);
        Tree_175_Node_50 := IF ( le.p_LienReleasedAge < 33.5,154,155);
        Tree_175_Node_51 := IF ( le.p_SSNHighIssueAge < 393.5,156,157);
        Tree_175_Node_28 := IF ( le.p_v1_RaASeniorMmbrCnt < 0.5,Tree_175_Node_50,Tree_175_Node_51);
        Tree_175_Node_29 := IF ( le.p_CurrAddrMedianValue < 218749.5,133,134);
        Tree_175_Node_16 := IF ( le.p_CurrAddrAVMValue60 < 453750.5,Tree_175_Node_28,Tree_175_Node_29);
        Tree_175_Node_55 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,158,159);
        Tree_175_Node_30 := IF ( le.p_SubjectAddrCount < 11.5,135,Tree_175_Node_55);
        Tree_175_Node_31 := IF ( le.p_PrevAddrBurglaryIndex < 146.5,136,137);
        Tree_175_Node_17 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 1.5,Tree_175_Node_30,Tree_175_Node_31);
        Tree_175_Node_9 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 3.5,Tree_175_Node_16,Tree_175_Node_17);
        Tree_175_Node_4 := IF ( le.p_CurrAddrBlockIndex < 2.087422,Tree_175_Node_8,Tree_175_Node_9);
        Tree_175_Node_32 := IF ( le.p_LastNameChangeAge < 209.5,138,139);
        Tree_175_Node_61 := IF ( le.p_SSNHighIssueAge < 586.5,160,161);
        Tree_175_Node_33 := IF ( le.p_SubjectAddrCount < 8.5,140,Tree_175_Node_61);
        Tree_175_Node_18 := IF ( le.p_PhoneOtherAgeOldestRecord < 101.5,Tree_175_Node_32,Tree_175_Node_33);
        Tree_175_Node_62 := IF ( le.p_PrevAddrMedianValue < 199999.5,162,163);
        Tree_175_Node_63 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 129.0,164,165);
        Tree_175_Node_34 := IF ( le.p_EstimatedAnnualIncome < 33187.5,Tree_175_Node_62,Tree_175_Node_63);
        Tree_175_Node_64 := IF ( le.p_v1_CrtRecMsdmeanCnt < 0.5,166,167);
        Tree_175_Node_65 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,168,169);
        Tree_175_Node_35 := IF ( le.p_EstimatedAnnualIncome < 66375.5,Tree_175_Node_64,Tree_175_Node_65);
        Tree_175_Node_19 := IF ( le.p_CurrAddrTractIndex < 2.8367188,Tree_175_Node_34,Tree_175_Node_35);
        Tree_175_Node_10 := IF ( le.p_NonDerogCount03 < 2.5,Tree_175_Node_18,Tree_175_Node_19);
        Tree_175_Node_66 := IF ( le.p_v1_ProspectAge < 71.5,170,171);
        Tree_175_Node_36 := IF ( le.p_PrevAddrCrimeIndex < 83.0,Tree_175_Node_66,141);
        Tree_175_Node_21 := IF ( le.p_v1_CrtRecTimeNewest < 111.5,Tree_175_Node_36,131);
        Tree_175_Node_11 := IF ( le.p_PrevAddrAgeLastSale < 5.5,130,Tree_175_Node_21);
        Tree_175_Node_5 := IF ( le.p_PrevAddrMedianIncome < 168323.5,Tree_175_Node_10,Tree_175_Node_11);
        Tree_175_Node_2 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 439050.5,Tree_175_Node_4,Tree_175_Node_5);
        Tree_175_Node_68 := IF ( le.p_SubjectAddrCount < 10.5,172,173);
        Tree_175_Node_69 := IF ( le.p_CurrAddrLenOfRes < 338.5,174,175);
        Tree_175_Node_38 := IF ( le.p_CurrAddrBlockIndex < 0.890625,Tree_175_Node_68,Tree_175_Node_69);
        Tree_175_Node_22 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 1.5,Tree_175_Node_38,132);
        Tree_175_Node_70 := IF ( le.p_v1_HHCrtRecMmbrCnt < 0.5,176,177);
        Tree_175_Node_40 := IF ( le.p_PrevAddrAgeOldestRecord < 293.5,Tree_175_Node_70,142);
        Tree_175_Node_72 := IF ( le.p_v1_ProspectTimeOnRecord < 236.5,178,179);
        Tree_175_Node_73 := IF ( le.p_v1_LifeEvEverResidedCnt < 1.5,180,181);
        Tree_175_Node_41 := IF ( le.p_PrevAddrLenOfRes < 52.5,Tree_175_Node_72,Tree_175_Node_73);
        Tree_175_Node_23 := IF ( le.p_SourceRiskLevel < 3.5,Tree_175_Node_40,Tree_175_Node_41);
        Tree_175_Node_12 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,Tree_175_Node_22,Tree_175_Node_23);
        Tree_175_Node_74 := IF ( le.p_NonDerogCount60 < 5.5,182,183);
        Tree_175_Node_75 := IF ( le.p_PrevAddrDwellType < 5.5,184,185);
        Tree_175_Node_42 := IF ( le.p_CurrAddrMurderIndex < 99.5,Tree_175_Node_74,Tree_175_Node_75);
        Tree_175_Node_76 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.73,186,187);
        Tree_175_Node_43 := IF ( le.p_CurrAddrCrimeIndex < 150.5,Tree_175_Node_76,143);
        Tree_175_Node_24 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.390625,Tree_175_Node_42,Tree_175_Node_43);
        Tree_175_Node_78 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,188,189);
        Tree_175_Node_44 := IF ( le.p_v1_RaAPropOwnerAVMMed < 267667.5,Tree_175_Node_78,144);
        Tree_175_Node_80 := IF ( le.p_PhoneEDAAgeOldestRecord < 163.0,190,191);
        Tree_175_Node_45 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,Tree_175_Node_80,145);
        Tree_175_Node_25 := IF ( le.p_PrevAddrBurglaryIndex < 129.5,Tree_175_Node_44,Tree_175_Node_45);
        Tree_175_Node_13 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 2.5,Tree_175_Node_24,Tree_175_Node_25);
        Tree_175_Node_6 := IF ( le.p_CurrAddrAgeLastSale < 63.5,Tree_175_Node_12,Tree_175_Node_13);
        Tree_175_Node_3 := IF ( le.p_PropAgeNewestSale < 225.0,Tree_175_Node_6,128);
        Tree_175_Node_1 := IF ( le.p_SSNHighIssueAge < 787.5,Tree_175_Node_2,Tree_175_Node_3);
    SELF.Score1_Tree175_node := Tree_175_Node_1;
    SELF.Score1_Tree175_score := CASE(SELF.Score1_Tree175_node,128=>0.018771159,129=>0.017373119,130=>0.023678541,131=>0.022535145,132=>0.013561722,133=>0.01633758,134=>-0.0058479956,135=>-0.012027446,136=>0.0018412813,137=>0.029465294,138=>-0.0060936194,139=>-0.01970962,140=>-0.0031181227,141=>0.00648839,142=>0.036739122,143=>0.02003504,144=>-0.01944063,145=>-0.02018176,146=>-3.1637927E-4,147=>5.0276914E-4,148=>0.022029,149=>-0.0017285511,150=>-0.012840389,151=>-0.019680064,152=>0.012484545,153=>-0.019313917,154=>-0.0022161368,155=>0.016611781,156=>0.0027287542,157=>-0.009069012,158=>0.012481758,159=>-0.009200292,160=>0.0039522992,161=>0.031610824,162=>-0.020312196,163=>-0.0094179865,164=>-0.0024667778,165=>-0.01078884,166=>0.024976145,167=>-0.007365247,168=>-0.015071763,169=>0.010497247,170=>-0.019072212,171=>-0.019336933,172=>-0.015198379,173=>0.0045378483,174=>-0.008123798,175=>0.014677734,176=>0.023440957,177=>-0.010097756,178=>-0.0046043443,179=>0.028285729,180=>-0.010345327,181=>0.008456963,182=>-0.019897802,183=>-0.022534115,184=>0.0041578286,185=>-0.016556881,186=>0.012304231,187=>-0.0065808613,188=>-0.02042577,189=>-0.019865166,190=>0.011125213,191=>-0.009868206,0);
ENDMACRO;
