EXPORT Model1_Score1_Tree52_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_52_Node_44 := IF ( le.p_RelativesBankruptcyCount < 2.5,128,129);
        Tree_52_Node_45 := IF ( le.p_CurrAddrAVMValue60 < 105901.5,130,131);
        Tree_52_Node_28 := IF ( le.p_DerogAge < 191.5,Tree_52_Node_44,Tree_52_Node_45);
        Tree_52_Node_46 := IF ( le.p_SubjectAddrCount < 3.5,132,133);
        Tree_52_Node_47 := IF ( le.p_v1_HHEstimatedIncomeRange < 2.5,134,135);
        Tree_52_Node_29 := IF ( le.p_PhoneOtherAgeOldestRecord < 117.5,Tree_52_Node_46,Tree_52_Node_47);
        Tree_52_Node_16 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 234.5,Tree_52_Node_28,Tree_52_Node_29);
        Tree_52_Node_48 := IF ( le.p_AgeOldestRecord < 323.5,136,137);
        Tree_52_Node_31 := IF ( le.p_v1_ProspectAge < 73.5,Tree_52_Node_48,120);
        Tree_52_Node_17 := IF ( le.p_DivSSNAddrMSourceCount < 1.5,118,Tree_52_Node_31);
        Tree_52_Node_8 := IF ( le.p_LienReleasedAge < 111.5,Tree_52_Node_16,Tree_52_Node_17);
        Tree_52_Node_50 := IF ( le.p_EstimatedAnnualIncome < 38500.5,138,139);
        Tree_52_Node_33 := IF ( le.p_PrevAddrMedianIncome < 77291.5,Tree_52_Node_50,121);
        Tree_52_Node_18 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 19993.5,119,Tree_52_Node_33);
        Tree_52_Node_9 := IF ( le.p_PRSearchLocateCount < 4.5,Tree_52_Node_18,114);
        Tree_52_Node_4 := IF ( le.p_LienReleasedAge < 170.0,Tree_52_Node_8,Tree_52_Node_9);
        Tree_52_Node_52 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 4.5,140,141);
        Tree_52_Node_34 := IF ( le.p_BPV_1 < 2.896375,Tree_52_Node_52,122);
        Tree_52_Node_55 := IF ( le.p_BPV_4 < -1.78458,142,143);
        Tree_52_Node_35 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,123,Tree_52_Node_55);
        Tree_52_Node_20 := IF ( le.p_SSNLowIssueAge < 496.5,Tree_52_Node_34,Tree_52_Node_35);
        Tree_52_Node_11 := IF ( le.p_NonDerogCount12 < 4.5,Tree_52_Node_20,115);
        Tree_52_Node_5 := IF ( le.p_IDVerSSNCreditBureauCount < 2.5,112,Tree_52_Node_11);
        Tree_52_Node_2 := IF ( le.p_v1_CrtRecMsdmeanCnt < 23.5,Tree_52_Node_4,Tree_52_Node_5);
        Tree_52_Node_56 := IF ( le.p_PhoneEDAAgeOldestRecord < 143.5,144,145);
        Tree_52_Node_57 := IF ( le.p_BPV_4 < -1.73838,146,147);
        Tree_52_Node_36 := IF ( le.p_SearchUnverifiedSSNCountYear < 1.5,Tree_52_Node_56,Tree_52_Node_57);
        Tree_52_Node_58 := IF ( le.p_CurrAddrTractIndex < 0.645,148,149);
        Tree_52_Node_59 := IF ( le.p_v1_HHCrtRecMmbrCnt < 0.5,150,151);
        Tree_52_Node_37 := IF ( le.p_PhoneOtherAgeOldestRecord < 55.5,Tree_52_Node_58,Tree_52_Node_59);
        Tree_52_Node_22 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 79.5,Tree_52_Node_36,Tree_52_Node_37);
        Tree_52_Node_60 := IF ( le.p_BP_3 < 1.5,152,153);
        Tree_52_Node_61 := IF ( le.p_NonDerogCount06 < 3.5,154,155);
        Tree_52_Node_38 := IF ( le.p_SubjectLastNameCount < 9.5,Tree_52_Node_60,Tree_52_Node_61);
        Tree_52_Node_62 := IF ( le.p_CurrAddrAgeOldestRecord < 335.5,156,157);
        Tree_52_Node_63 := IF ( le.p_CurrAddrAVMValue12 < 102499.5,158,159);
        Tree_52_Node_39 := IF ( le.p_v1_PropTimeLastSale < 95.5,Tree_52_Node_62,Tree_52_Node_63);
        Tree_52_Node_23 := IF ( le.p_v1_ProspectAge < 78.5,Tree_52_Node_38,Tree_52_Node_39);
        Tree_52_Node_12 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 2.5,Tree_52_Node_22,Tree_52_Node_23);
        Tree_52_Node_64 := IF ( le.p_PrevAddrCarTheftIndex < 110.5,160,161);
        Tree_52_Node_65 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,162,163);
        Tree_52_Node_40 := IF ( le.p_SubjectAddrCount < 37.0,Tree_52_Node_64,Tree_52_Node_65);
        Tree_52_Node_41 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 1.5,124,125);
        Tree_52_Node_25 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 264.5,Tree_52_Node_40,Tree_52_Node_41);
        Tree_52_Node_13 := IF ( le.p_age_in_years < 21.057032,116,Tree_52_Node_25);
        Tree_52_Node_6 := IF ( le.p_AddrChangeCount60 < 4.5,Tree_52_Node_12,Tree_52_Node_13);
        Tree_52_Node_68 := IF ( le.p_age_in_years < 56.84,164,165);
        Tree_52_Node_42 := IF ( le.p_RelativesPropOwnedCount < 16.0,Tree_52_Node_68,126);
        Tree_52_Node_70 := IF ( le.p_PrevAddrCarTheftIndex < 29.5,166,167);
        Tree_52_Node_43 := IF ( le.p_VariationMSourcesSSNCount < 1.5,Tree_52_Node_70,127);
        Tree_52_Node_26 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.4375,Tree_52_Node_42,Tree_52_Node_43);
        Tree_52_Node_14 := IF ( le.p_CurrAddrCountyIndex < 3.5800781,Tree_52_Node_26,117);
        Tree_52_Node_7 := IF ( le.p_PhoneEDAAgeNewestRecord < 127.5,Tree_52_Node_14,113);
        Tree_52_Node_3 := IF ( le.p_RelativesPropOwnedTaxTotal < 2127854.5,Tree_52_Node_6,Tree_52_Node_7);
        Tree_52_Node_1 := IF ( le.p_SSNAddrCount < 6.5,Tree_52_Node_2,Tree_52_Node_3);
    SELF.Score1_Tree52_node := Tree_52_Node_1;
    SELF.Score1_Tree52_score := CASE(SELF.Score1_Tree52_node,112=>0.016999414,113=>0.0548769,114=>0.047968306,115=>0.016791694,116=>0.0896849,117=>0.037457075,118=>0.11815575,119=>-0.023381284,120=>0.08164625,121=>-0.05183125,122=>-0.07250457,123=>-0.043856848,124=>-0.0069522085,125=>0.08634997,126=>-0.028790109,127=>0.02313638,128=>-0.0028594497,129=>0.0083518475,130=>0.011565033,131=>0.06265027,132=>-0.005491268,133=>-0.05190894,134=>0.09172846,135=>-0.025995709,136=>0.058522232,137=>-0.044050794,138=>-0.06934661,139=>-0.06746714,140=>-0.04119598,141=>0.015050232,142=>-0.072760925,143=>-0.06899789,144=>0.008593193,145=>-0.0013311215,146=>0.083338015,147=>-0.015979696,148=>0.03141339,149=>0.11686337,150=>0.082336135,151=>-0.0035435765,152=>-0.0019670401,153=>0.012412765,154=>0.06166669,155=>-0.006666201,156=>0.020411855,157=>-0.010770231,158=>0.01103399,159=>-0.026226113,160=>-0.0042122304,161=>-0.020655274,162=>0.003971896,163=>0.09055563,164=>-0.06573358,165=>-0.06740744,166=>-0.0031304392,167=>-0.061070114,0);
ENDMACRO;
