EXPORT Model1_Score1_Tree73_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_73_Node_30 := IF ( le.p_v1_HHCrtRecMmbrCnt < 4.5,84,85);
        Tree_73_Node_31 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt12Mo < 0.5,86,87);
        Tree_73_Node_20 := IF ( le.p_v1_HHCollegeAttendedMmbrCnt < 3.5,Tree_73_Node_30,Tree_73_Node_31);
        Tree_73_Node_33 := IF ( le.p_SubjectAddrCount < 4.5,88,89);
        Tree_73_Node_21 := IF ( le.p_SSNLowIssueAge < 447.5,78,Tree_73_Node_33);
        Tree_73_Node_12 := IF ( le.p_PhoneOtherAgeOldestRecord < 239.5,Tree_73_Node_20,Tree_73_Node_21);
        Tree_73_Node_34 := IF ( le.p_PrevAddrMedianValue < 49999.5,90,91);
        Tree_73_Node_35 := IF ( le.p_CurrAddrCrimeIndex < 120.5,92,93);
        Tree_73_Node_22 := IF ( le.p_PrevAddrAgeLastSale < 447.5,Tree_73_Node_34,Tree_73_Node_35);
        Tree_73_Node_23 := IF ( le.p_CurrAddrBurglaryIndex < 89.5,79,80);
        Tree_73_Node_13 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 241.5,Tree_73_Node_22,Tree_73_Node_23);
        Tree_73_Node_8 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_73_Node_12,Tree_73_Node_13);
        Tree_73_Node_38 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 2.5,94,95);
        Tree_73_Node_39 := IF ( le.p_PhoneEDAAgeNewestRecord < 9.5,96,97);
        Tree_73_Node_24 := IF ( le.p_LastNameChangeAge < 327.5,Tree_73_Node_38,Tree_73_Node_39);
        Tree_73_Node_41 := IF ( le.p_PhoneEDAAgeNewestRecord < 26.5,98,99);
        Tree_73_Node_25 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 2.5,81,Tree_73_Node_41);
        Tree_73_Node_14 := IF ( le.p_v1_HHEstimatedIncomeRange < 4.5,Tree_73_Node_24,Tree_73_Node_25);
        Tree_73_Node_42 := IF ( le.p_EstimatedAnnualIncome < 38150.5,100,101);
        Tree_73_Node_26 := IF ( le.p_RelativesPropOwnedTaxTotal < 146142.5,Tree_73_Node_42,82);
        Tree_73_Node_15 := IF ( le.p_PhoneEDAAgeOldestRecord < 183.5,Tree_73_Node_26,77);
        Tree_73_Node_9 := IF ( le.p_v1_LifeEvEverResidedCnt < 3.5,Tree_73_Node_14,Tree_73_Node_15);
        Tree_73_Node_4 := IF ( le.p_EvictionAge < 151.5,Tree_73_Node_8,Tree_73_Node_9);
        Tree_73_Node_44 := IF ( le.p_PhoneOtherAgeNewestRecord < 58.5,102,103);
        Tree_73_Node_45 := IF ( le.p_v1_ProspectTimeOnRecord < 110.5,104,105);
        Tree_73_Node_28 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 280706.0,Tree_73_Node_44,Tree_73_Node_45);
        Tree_73_Node_47 := IF ( le.p_v1_HHEstimatedIncomeRange < 2.5,106,107);
        Tree_73_Node_29 := IF ( le.p_BPV_4 < -1.8108125,83,Tree_73_Node_47);
        Tree_73_Node_17 := IF ( le.p_PrevAddrMedianValue < 142076.5,Tree_73_Node_28,Tree_73_Node_29);
        Tree_73_Node_10 := IF ( le.p_EstimatedAnnualIncome < 20484.5,74,Tree_73_Node_17);
        Tree_73_Node_11 := IF ( le.p_PhoneEDAAgeOldestRecord < 36.0,75,76);
        Tree_73_Node_5 := IF ( le.p_BPV_3 < 2.088171,Tree_73_Node_10,Tree_73_Node_11);
        Tree_73_Node_2 := IF ( le.p_PrevAddrCrimeIndex < 199.0,Tree_73_Node_4,Tree_73_Node_5);
        Tree_73_Node_3 := IF ( le.p_CurrAddrBurglaryIndex < 115.0,72,73);
        Tree_73_Node_1 := IF ( le.p_PrevAddrMurderIndex < 199.5,Tree_73_Node_2,Tree_73_Node_3);
    SELF.Score1_Tree73_node := Tree_73_Node_1;
    SELF.Score1_Tree73_score := CASE(SELF.Score1_Tree73_node,72=>-0.0035692018,73=>-0.05601978,74=>0.05666523,75=>0.062750325,76=>0.015184967,77=>0.09156112,78=>0.03208475,79=>0.0909427,80=>-0.009580152,81=>0.035304278,82=>0.027500935,83=>-0.03624237,84=>4.7121805E-4,85=>-0.01027142,86=>-0.016270867,87=>0.06775352,88=>0.019528681,89=>-0.031428207,90=>0.009847476,91=>-0.009438568,92=>0.06789102,93=>-0.053949475,94=>-0.047728006,95=>-0.010615672,96=>-0.034371372,97=>0.029811552,98=>-0.054544605,99=>0.0023358066,100=>-0.055222493,101=>-0.03619233,102=>-0.010028535,103=>-0.055843823,104=>0.05611846,105=>-0.009266192,106=>0.0645899,107=>0.013102705,0);
ENDMACRO;
