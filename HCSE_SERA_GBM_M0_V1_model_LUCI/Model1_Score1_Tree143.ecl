EXPORT Model1_Score1_Tree143(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_143_Node_42 := IF ( le.p_NonDerogCount01 < 4.5,119,120);
        Tree_143_Node_43 := IF ( le.p_PrevAddrAgeNewestRecord < 338.5,121,122);
        Tree_143_Node_24 := IF ( le.p_LastNameChangeAge < 372.5,Tree_143_Node_42,Tree_143_Node_43);
        Tree_143_Node_44 := IF ( le.p_PRSearchLocateCount < 18.5,123,124);
        Tree_143_Node_45 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,125,126);
        Tree_143_Node_25 := IF ( le.p_DerogAge < 253.5,Tree_143_Node_44,Tree_143_Node_45);
        Tree_143_Node_14 := IF ( le.p_LastNameChangeAge < 384.5,Tree_143_Node_24,Tree_143_Node_25);
        Tree_143_Node_46 := IF ( le.p_PrevAddrMedianValue < 782626.5,127,128);
        Tree_143_Node_47 := IF ( le.p_PhoneOtherAgeOldestRecord < 121.5,129,130);
        Tree_143_Node_26 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 246201.5,Tree_143_Node_46,Tree_143_Node_47);
        Tree_143_Node_15 := IF ( le.p_CurrAddrLenOfRes < 527.5,Tree_143_Node_26,105);
        Tree_143_Node_8 := IF ( le.p_PrevAddrMedianValue < 369099.5,Tree_143_Node_14,Tree_143_Node_15);
        Tree_143_Node_4 := IF ( le.p_PropAgeNewestSale < 279.5,Tree_143_Node_8,103);
        Tree_143_Node_48 := IF ( le.p_ArrestCount24 < 0.5,131,132);
        Tree_143_Node_49 := IF ( le.p_P_EstimatedHHIncomePerCapita < 3.725,133,134);
        Tree_143_Node_28 := IF ( le.p_FelonyCount < 1.5,Tree_143_Node_48,Tree_143_Node_49);
        Tree_143_Node_50 := IF ( le.p_RelativesCount < 3.5,135,136);
        Tree_143_Node_29 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 5.5,Tree_143_Node_50,110);
        Tree_143_Node_16 := IF ( le.p_CurrAddrLenOfRes < 495.5,Tree_143_Node_28,Tree_143_Node_29);
        Tree_143_Node_52 := IF ( le.p_CurrAddrCarTheftIndex < 28.5,137,138);
        Tree_143_Node_30 := IF ( le.p_SubjectLastNameCount < 3.5,Tree_143_Node_52,111);
        Tree_143_Node_54 := IF ( le.p_PropAgeOldestPurchase < 552.0,139,140);
        Tree_143_Node_31 := IF ( le.p_age_in_years < 88.6825,Tree_143_Node_54,112);
        Tree_143_Node_17 := IF ( le.p_RelativesPropOwnedTaxTotal < 206608.0,Tree_143_Node_30,Tree_143_Node_31);
        Tree_143_Node_10 := IF ( le.p_AgeOldestRecord < 529.5,Tree_143_Node_16,Tree_143_Node_17);
        Tree_143_Node_56 := IF ( le.p_CurrAddrCarTheftIndex < 29.5,141,142);
        Tree_143_Node_32 := IF ( le.p_v1_ProspectTimeOnRecord < 511.5,Tree_143_Node_56,113);
        Tree_143_Node_33 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 1.5,114,115);
        Tree_143_Node_18 := IF ( le.p_RelativesPropOwnedTaxTotal < 410093.5,Tree_143_Node_32,Tree_143_Node_33);
        Tree_143_Node_60 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 0.5,143,144);
        Tree_143_Node_34 := IF ( le.p_RelativesPropOwnedTaxTotal < 894749.5,Tree_143_Node_60,116);
        Tree_143_Node_19 := IF ( le.p_v1_HHPropCurrOwnedCnt < 2.5,Tree_143_Node_34,106);
        Tree_143_Node_11 := IF ( le.p_PhoneOtherAgeOldestRecord < 21.5,Tree_143_Node_18,Tree_143_Node_19);
        Tree_143_Node_5 := IF ( le.p_v1_ProspectTimeLastUpdate < 167.5,Tree_143_Node_10,Tree_143_Node_11);
        Tree_143_Node_2 := IF ( le.p_PrevAddrMedianIncome < 82169.5,Tree_143_Node_4,Tree_143_Node_5);
        Tree_143_Node_62 := IF ( le.p_RecentActivityIndex < 2.5,145,146);
        Tree_143_Node_63 := IF ( le.p_v1_ProspectAge < 62.5,147,148);
        Tree_143_Node_36 := IF ( le.p_PrevAddrAgeNewestRecord < 74.5,Tree_143_Node_62,Tree_143_Node_63);
        Tree_143_Node_64 := IF ( le.p_DivSSNAddrMSourceCount < 1.5,149,150);
        Tree_143_Node_65 := IF ( le.p_CurrAddrTractIndex < 1.114,151,152);
        Tree_143_Node_37 := IF ( le.p_v1_RaAPropOwnerAVMMed < 479595.5,Tree_143_Node_64,Tree_143_Node_65);
        Tree_143_Node_20 := IF ( le.p_PrevAddrAgeNewestRecord < 86.5,Tree_143_Node_36,Tree_143_Node_37);
        Tree_143_Node_38 := IF ( le.p_AgeOldestRecord < 469.5,117,118);
        Tree_143_Node_21 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 119.5,Tree_143_Node_38,107);
        Tree_143_Node_12 := IF ( le.p_v1_PropSoldRatio < 7.734375,Tree_143_Node_20,Tree_143_Node_21);
        Tree_143_Node_23 := IF ( le.p_v1_RaAPropOwnerAVMMed < 243337.5,108,109);
        Tree_143_Node_13 := IF ( le.p_age_in_years < 60.402187,104,Tree_143_Node_23);
        Tree_143_Node_6 := IF ( le.p_LienFiledAge < 224.5,Tree_143_Node_12,Tree_143_Node_13);
        Tree_143_Node_3 := IF ( le.p_v1_CrtRecMsdmeanCnt < 21.5,Tree_143_Node_6,102);
        Tree_143_Node_1 := IF ( le.p_v1_PropCurrOwnedAVMTtl < 439050.5,Tree_143_Node_2,Tree_143_Node_3);
    UNSIGNED2 Score1_Tree143_node := Tree_143_Node_1;
    REAL8 Score1_Tree143_score := CASE(Score1_Tree143_node,102=>0.015184432,103=>0.024220672,104=>-0.009686374,105=>0.029668614,106=>0.04918654,107=>0.055052172,108=>-0.026986033,109=>-0.02658643,110=>0.05541957,111=>0.001613401,112=>0.018488862,113=>0.01140226,114=>-0.004378284,115=>0.053588152,116=>0.04196106,117=>-0.02035294,118=>0.03285832,119=>1.1567801E-4,120=>-0.0026492723,121=>0.004876384,122=>0.037154198,123=>-0.001967698,124=>0.029545696,125=>0.018161276,126=>-0.0028054193,127=>-0.009983239,128=>0.019861858,129=>-0.008582137,130=>0.026100729,131=>0.0014229447,132=>0.019547397,133=>-0.017306672,134=>0.011557221,135=>0.028090915,136=>-0.007713602,137=>-0.007646768,138=>-0.027294308,139=>-0.012004258,140=>0.018426301,141=>-0.0043683364,142=>-0.020222066,143=>0.024481526,144=>0.0020372819,145=>-0.0041297833,146=>0.009533137,147=>-0.016224787,148=>-0.026551899,149=>0.041107398,150=>0.0056376928,151=>-0.026153848,152=>-0.026525335,0);
ENDMACRO;
