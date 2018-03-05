﻿EXPORT Model1_Score1_Tree189_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_189_Node_42 := IF ( le.p_StatusMostRecent < 2.5,103,104);
        Tree_189_Node_43 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,105,106);
        Tree_189_Node_28 := IF ( le.p_PrevAddrAgeLastSale < 544.5,Tree_189_Node_42,Tree_189_Node_43);
        Tree_189_Node_44 := IF ( le.p_v1_ProspectAge < 87.5,107,108);
        Tree_189_Node_45 := IF ( le.p_PropAgeNewestSale < 236.5,109,110);
        Tree_189_Node_29 := IF ( le.p_SSNLowIssueAge < 768.5,Tree_189_Node_44,Tree_189_Node_45);
        Tree_189_Node_16 := IF ( le.p_age_in_years < 83.17969,Tree_189_Node_28,Tree_189_Node_29);
        Tree_189_Node_46 := IF ( le.p_CurrAddrCrimeIndex < 49.5,111,112);
        Tree_189_Node_47 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 3.5,113,114);
        Tree_189_Node_30 := IF ( le.p_SSNIssueState < 25.5,Tree_189_Node_46,Tree_189_Node_47);
        Tree_189_Node_49 := IF ( le.p_CurrAddrMurderIndex < 110.5,115,116);
        Tree_189_Node_31 := IF ( le.p_PrevAddrLenOfRes < 63.5,98,Tree_189_Node_49);
        Tree_189_Node_17 := IF ( le.p_v1_ProspectTimeLastUpdate < 496.5,Tree_189_Node_30,Tree_189_Node_31);
        Tree_189_Node_8 := IF ( le.p_age_in_years < 88.725,Tree_189_Node_16,Tree_189_Node_17);
        Tree_189_Node_50 := IF ( le.p_SSNAddrCount < 11.5,117,118);
        Tree_189_Node_32 := IF ( le.p_PrevAddrMurderIndex < 169.5,Tree_189_Node_50,99);
        Tree_189_Node_52 := IF ( le.p_AssocRiskLevel < 3.5,119,120);
        Tree_189_Node_53 := IF ( le.p_v1_ProspectTimeLastUpdate < 167.5,121,122);
        Tree_189_Node_33 := IF ( le.p_CurrAddrMedianValue < 142727.5,Tree_189_Node_52,Tree_189_Node_53);
        Tree_189_Node_18 := IF ( le.p_PrevAddrAgeOldestRecord < 96.5,Tree_189_Node_32,Tree_189_Node_33);
        Tree_189_Node_9 := IF ( le.p_AccidentAge < 47.5,Tree_189_Node_18,88);
        Tree_189_Node_4 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 346.5,Tree_189_Node_8,Tree_189_Node_9);
        Tree_189_Node_55 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 7.5,123,124);
        Tree_189_Node_34 := IF ( le.p_v1_RaACrtRecMmbrCnt < 0.5,100,Tree_189_Node_55);
        Tree_189_Node_21 := IF ( le.p_v1_CrtRecTimeNewest < 87.5,Tree_189_Node_34,93);
        Tree_189_Node_10 := IF ( le.p_NonDerogCount60 < 3.5,89,Tree_189_Node_21);
        Tree_189_Node_5 := IF ( le.p_PrevAddrMedianValue < 718567.5,Tree_189_Node_10,86);
        Tree_189_Node_2 := IF ( le.p_v1_RaAPropOwnerAVMMed < 781249.5,Tree_189_Node_4,Tree_189_Node_5);
        Tree_189_Node_36 := IF ( le.p_EstimatedAnnualIncome < 36750.5,101,102);
        Tree_189_Node_22 := IF ( le.p_PrevAddrMedianValue < 159449.5,Tree_189_Node_36,94);
        Tree_189_Node_58 := IF ( le.p_PropAgeNewestPurchase < 237.5,125,126);
        Tree_189_Node_59 := IF ( le.p_VariationDOBCount < 3.5,127,128);
        Tree_189_Node_39 := IF ( le.p_CurrAddrBurglaryIndex < 139.5,Tree_189_Node_58,Tree_189_Node_59);
        Tree_189_Node_23 := IF ( le.p_age_in_years < 64.61188,95,Tree_189_Node_39);
        Tree_189_Node_12 := IF ( le.p_SSNLowIssueAge < 598.0,Tree_189_Node_22,Tree_189_Node_23);
        Tree_189_Node_13 := IF ( le.p_v1_ProspectTimeOnRecord < 220.5,90,91);
        Tree_189_Node_6 := IF ( le.p_v1_RaACrtRecMmbrCnt < 11.5,Tree_189_Node_12,Tree_189_Node_13);
        Tree_189_Node_27 := IF ( le.p_CurrAddrCrimeIndex < 68.5,96,97);
        Tree_189_Node_15 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 380.5,92,Tree_189_Node_27);
        Tree_189_Node_7 := IF ( le.p_v1_RaACrtRecMmbrCnt < 2.5,87,Tree_189_Node_15);
        Tree_189_Node_3 := IF ( le.p_PropAgeNewestPurchase < 298.0,Tree_189_Node_6,Tree_189_Node_7);
        Tree_189_Node_1 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 373.5,Tree_189_Node_2,Tree_189_Node_3);
    SELF.Score1_Tree189_node := Tree_189_Node_1;
    SELF.Score1_Tree189_score := CASE(SELF.Score1_Tree189_node,128=>0.01202717,86=>0.009442383,87=>-0.0028296357,88=>0.02301463,89=>0.006346831,90=>-0.0015792834,91=>0.013977408,92=>-0.017455481,93=>-7.622955E-4,94=>-0.006046268,95=>0.016989026,96=>-0.016570115,97=>-0.017007263,98=>-0.003217328,99=>0.028905686,100=>-0.0051609227,101=>-0.017080422,102=>-0.016424458,103=>-3.040298E-4,104=>4.980574E-4,105=>-0.009102299,106=>0.0043842467,107=>0.0041121733,108=>0.024376824,109=>4.769839E-4,110=>0.014660745,111=>6.9505186E-4,112=>-0.010165268,113=>-5.9955346E-4,114=>-0.014843359,115=>0.008707976,116=>0.022588227,117=>-0.0019198217,118=>0.01551785,119=>-0.00927802,120=>0.006897976,121=>0.0013138097,122=>0.018835798,123=>-0.016592586,124=>-0.010757479,125=>-0.011154502,126=>0.0064042998,127=>-4.9199624E-4,0);
ENDMACRO;
