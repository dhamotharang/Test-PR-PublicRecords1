EXPORT Model1_Score1_Tree48_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_48_Node_25 := IF ( le.p_age_in_years < 0.10583313,82,83);
        Tree_48_Node_34 := IF ( le.p_age_in_years < 0.08498538,86,87);
        Tree_48_Node_24 := IF ( le.p_age_in_years < 0.11552307,Tree_48_Node_34,81);
        Tree_48_Node_15 := CHOOSE ( le.p_gender,Tree_48_Node_25,Tree_48_Node_24);
        Tree_48_Node_8 := IF ( le.p_age_in_years < 0.054960936,74,Tree_48_Node_15);
        Tree_48_Node_9 := CHOOSE ( le.p_gender,75,76);
        Tree_48_Node_4 := IF ( le.p_SSNLowIssueAge < 27.5,Tree_48_Node_8,Tree_48_Node_9);
        Tree_48_Node_38 := IF ( le.p_NonDerogCount01 < 3.5,88,89);
        Tree_48_Node_39 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 2.5,90,91);
        Tree_48_Node_26 := IF ( le.p_v1_RaAHHCnt < 1.5,Tree_48_Node_38,Tree_48_Node_39);
        Tree_48_Node_40 := IF ( le.p_NonDerogCount24 < 4.5,92,93);
        Tree_48_Node_41 := IF ( le.p_LastNameChangeAge < 144.5,94,95);
        Tree_48_Node_27 := IF ( le.p_AssocSuspicousIdentitiesCount < 3.5,Tree_48_Node_40,Tree_48_Node_41);
        Tree_48_Node_18 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,Tree_48_Node_26,Tree_48_Node_27);
        Tree_48_Node_10 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 11.0,Tree_48_Node_18,77);
        Tree_48_Node_42 := IF ( le.p_RelativesBankruptcyCount < 2.5,96,97);
        Tree_48_Node_43 := IF ( le.p_PrevAddrAgeLastSale < 143.5,98,99);
        Tree_48_Node_28 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 70.0,Tree_48_Node_42,Tree_48_Node_43);
        Tree_48_Node_44 := IF ( le.p_PrevAddrMedianIncome < 22877.5,100,101);
        Tree_48_Node_29 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 265.5,Tree_48_Node_44,84);
        Tree_48_Node_20 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_48_Node_28,Tree_48_Node_29);
        Tree_48_Node_21 := IF ( le.p_EstimatedAnnualIncome < 31171.5,79,80);
        Tree_48_Node_11 := IF ( le.p_CurrAddrAgeOldestRecord < 800.5,Tree_48_Node_20,Tree_48_Node_21);
        Tree_48_Node_5 := IF ( le.p_EstimatedAnnualIncome < 23507.5,Tree_48_Node_10,Tree_48_Node_11);
        Tree_48_Node_2 := IF ( le.p_age_in_years < 0.21328124,Tree_48_Node_4,Tree_48_Node_5);
        Tree_48_Node_47 := IF ( le.p_CurrAddrBurglaryIndex < 86.5,102,103);
        Tree_48_Node_32 := IF ( le.p_DivSSNAddrMSourceCount < 8.5,85,Tree_48_Node_47);
        Tree_48_Node_48 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 2.5,104,105);
        Tree_48_Node_49 := IF ( le.p_v1_RaAPPCurrOwnerMmbrCnt < 3.5,106,107);
        Tree_48_Node_33 := IF ( le.p_LienFiledAge < 193.5,Tree_48_Node_48,Tree_48_Node_49);
        Tree_48_Node_22 := IF ( le.p_SourceRiskLevel < 3.5,Tree_48_Node_32,Tree_48_Node_33);
        Tree_48_Node_12 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 1.5,Tree_48_Node_22,78);
        Tree_48_Node_6 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 188.5,Tree_48_Node_12,73);
        Tree_48_Node_3 := IF ( le.p_SubjectPhoneCount < 1.5,Tree_48_Node_6,72);
        Tree_48_Node_1 := IF ( le.p_EvictionAge < 151.5,Tree_48_Node_2,Tree_48_Node_3);
    SELF.Score1_Tree48_node := Tree_48_Node_1;
    SELF.Score1_Tree48_score := CASE(SELF.Score1_Tree48_node,72=>0.07856892,73=>0.08347055,74=>-0.0209832,75=>-0.009390947,76=>0.033452142,77=>-0.07328019,78=>0.03892432,79=>-0.0725782,80=>-0.055410795,81=>0.02031328,82=>0.03245667,83=>-0.016134419,84=>0.08469731,85=>0.0761226,86=>-0.06403295,87=>-0.06414791,88=>0.009425125,89=>0.04953922,90=>-0.028777974,91=>0.0019242963,92=>0.031895712,93=>-0.006474375,94=>0.017061327,95=>-0.053412795,96=>4.7992563E-4,97=>0.006347535,98=>-0.0024885286,99=>-0.020157507,100=>0.015702965,101=>-0.012595845,102=>-0.023463996,103=>-0.06988644,104=>-0.020064453,105=>-0.061773214,106=>-0.036065467,107=>0.0315728,0);
ENDMACRO;
