EXPORT Model1_Score1_Tree23(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_23_Node_29 := IF ( le.p_age_in_years < 0.16585724,115,116);
        Tree_23_Node_17 := IF ( le.p_age_in_years < 0.10488327,106,Tree_23_Node_29);
        Tree_23_Node_27 := IF ( le.p_age_in_years < 0.19412398,113,114);
        Tree_23_Node_16 := IF ( le.p_age_in_years < 0.11484039,105,Tree_23_Node_27);
        Tree_23_Node_9 := CHOOSE ( le.p_gender,Tree_23_Node_17,Tree_23_Node_16);
        Tree_23_Node_4 := IF ( le.p_age_in_years < 0.055097654,102,Tree_23_Node_9);
        Tree_23_Node_5 := CHOOSE ( le.p_gender,103,104);
        Tree_23_Node_2 := IF ( le.p_SSNLowIssueAge < 26.0,Tree_23_Node_4,Tree_23_Node_5);
        Tree_23_Node_50 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 4.5,121,122);
        Tree_23_Node_51 := IF ( le.p_age_in_years < 31.765,123,124);
        Tree_23_Node_30 := IF ( le.p_NonDerogCount60 < 3.5,Tree_23_Node_50,Tree_23_Node_51);
        Tree_23_Node_52 := IF ( le.p_PrevAddrCrimeIndex < 120.5,125,126);
        Tree_23_Node_31 := IF ( le.p_BPV_2 < 3.0349374,Tree_23_Node_52,117);
        Tree_23_Node_18 := IF ( le.p_BP_4 < 13.5,Tree_23_Node_30,Tree_23_Node_31);
        Tree_23_Node_54 := IF ( le.p_VariationMSourcesSSNUnrelCount < 2.5,127,128);
        Tree_23_Node_55 := IF ( le.p_PrevAddrMedianIncome < 25496.5,129,130);
        Tree_23_Node_32 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_23_Node_54,Tree_23_Node_55);
        Tree_23_Node_19 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 1406249.5,Tree_23_Node_32,107);
        Tree_23_Node_12 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_23_Node_18,Tree_23_Node_19);
        Tree_23_Node_56 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,131,132);
        Tree_23_Node_57 := IF ( le.p_NonDerogCount06 < 3.5,133,134);
        Tree_23_Node_34 := IF ( le.p_PrevAddrAgeLastSale < 48.5,Tree_23_Node_56,Tree_23_Node_57);
        Tree_23_Node_20 := IF ( le.p_CurrAddrMedianValue < 168417.5,Tree_23_Node_34,108);
        Tree_23_Node_21 := IF ( le.p_PrevAddrMedianIncome < 49902.5,109,110);
        Tree_23_Node_13 := IF ( le.p_SSNLowIssueAge < 624.5,Tree_23_Node_20,Tree_23_Node_21);
        Tree_23_Node_6 := IF ( le.p_BPV_3 < 2.7198868,Tree_23_Node_12,Tree_23_Node_13);
        Tree_23_Node_58 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 1.5,135,136);
        Tree_23_Node_59 := IF ( le.p_SubjectLastNameCount < 4.5,137,138);
        Tree_23_Node_38 := IF ( le.p_CurrAddrMedianValue < 437499.5,Tree_23_Node_58,Tree_23_Node_59);
        Tree_23_Node_39 := IF ( le.p_PropAgeOldestPurchase < 95.5,118,119);
        Tree_23_Node_22 := IF ( le.p_SubjectPhoneCount < 2.5,Tree_23_Node_38,Tree_23_Node_39);
        Tree_23_Node_62 := IF ( le.p_FelonyCount < 2.5,139,140);
        Tree_23_Node_40 := IF ( le.p_SearchVelocityRiskLevel < 8.5,Tree_23_Node_62,120);
        Tree_23_Node_64 := IF ( le.p_CurrAddrAgeOldestRecord < 38.5,141,142);
        Tree_23_Node_65 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 3.5,143,144);
        Tree_23_Node_41 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 4.5,Tree_23_Node_64,Tree_23_Node_65);
        Tree_23_Node_23 := IF ( le.p_v1_CrtRecTimeNewest < 150.5,Tree_23_Node_40,Tree_23_Node_41);
        Tree_23_Node_14 := IF ( le.p_v1_RaAPropOwnerAVMMed < 227245.5,Tree_23_Node_22,Tree_23_Node_23);
        Tree_23_Node_66 := IF ( le.p_RelativesPropOwnedCount < 7.5,145,146);
        Tree_23_Node_67 := IF ( le.p_CurrAddrCrimeIndex < 110.5,147,148);
        Tree_23_Node_42 := IF ( le.p_NonDerogCount06 < 5.5,Tree_23_Node_66,Tree_23_Node_67);
        Tree_23_Node_68 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,149,150);
        Tree_23_Node_69 := IF ( le.p_DivSSNAddrMSourceCount < 10.5,151,152);
        Tree_23_Node_43 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 0.5,Tree_23_Node_68,Tree_23_Node_69);
        Tree_23_Node_24 := IF ( le.p_v1_HHCrtRecBkrptMmbrCnt < 1.5,Tree_23_Node_42,Tree_23_Node_43);
        Tree_23_Node_25 := IF ( le.p_v1_RaAPropOwnerAVMMed < 159865.5,111,112);
        Tree_23_Node_15 := IF ( le.p_v1_HHPPCurrOwnedCnt < 7.5,Tree_23_Node_24,Tree_23_Node_25);
        Tree_23_Node_7 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_23_Node_14,Tree_23_Node_15);
        Tree_23_Node_3 := IF ( le.p_SearchSSNSearchCount < 1.5,Tree_23_Node_6,Tree_23_Node_7);
        Tree_23_Node_1 := IF ( le.p_age_in_years < 0.31992188,Tree_23_Node_2,Tree_23_Node_3);
    UNSIGNED2 Score1_Tree23_node := Tree_23_Node_1;
    REAL8 Score1_Tree23_score := CASE(Score1_Tree23_node,102=>-0.045188077,103=>-0.03306263,104=>0.03816421,105=>-0.0833305,106=>0.056273982,107=>0.15535103,108=>-0.07139366,109=>-0.07696227,110=>0.007560225,111=>0.1441587,112=>-0.03274604,113=>0.012216392,114=>-0.030780911,115=>-0.019186242,116=>-0.08367617,117=>0.07693973,118=>-0.017939862,119=>0.19196098,120=>0.08820754,121=>0.023348873,122=>0.09524584,123=>0.061320517,124=>0.008709163,125=>0.005611746,126=>-0.009129842,127=>-0.0020114544,128=>0.033011768,129=>0.047820322,130=>0.004722147,131=>0.050218444,132=>-0.0313023,133=>0.043771394,134=>0.13415718,135=>-0.0031383124,136=>0.0077849193,137=>-0.061947178,138=>0.018031875,139=>-0.020408316,140=>0.04196355,141=>0.06176973,142=>-0.029609345,143=>0.028789988,144=>0.1853393,145=>-0.0413159,146=>0.057854228,147=>-0.022747064,148=>0.13226086,149=>-0.038846232,150=>0.1330135,151=>-0.06916093,152=>0.017989596,0);
ENDMACRO;
