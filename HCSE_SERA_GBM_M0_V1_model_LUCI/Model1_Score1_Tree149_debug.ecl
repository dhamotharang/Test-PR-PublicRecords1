EXPORT Model1_Score1_Tree149_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_149_Node_26 := IF ( le.p_v1_CrtRecMsdmeanCnt < 47.5,49,50);
        Tree_149_Node_27 := IF ( le.p_AssocRiskLevel < 1.5,51,52);
        Tree_149_Node_20 := IF ( le.p_BPV_1 < 2.3000624,Tree_149_Node_26,Tree_149_Node_27);
        Tree_149_Node_14 := IF ( le.p_v1_CrtRecMsdmeanCnt < 67.5,Tree_149_Node_20,45);
        Tree_149_Node_15 := IF ( le.p_SSNHighIssueAge < 418.5,46,47);
        Tree_149_Node_8 := IF ( le.p_v1_CrtRecMsdmeanCnt12Mo < 11.5,Tree_149_Node_14,Tree_149_Node_15);
        Tree_149_Node_28 := IF ( le.p_BP_3 < 8.5,53,54);
        Tree_149_Node_29 := IF ( le.p_SSNHighIssueAge < 467.0,55,56);
        Tree_149_Node_24 := IF ( le.p_v1_ProspectTimeLastUpdate < 6.5,Tree_149_Node_28,Tree_149_Node_29);
        Tree_149_Node_16 := IF ( le.p_age_in_years < 60.52797,Tree_149_Node_24,48);
        Tree_149_Node_9 := IF ( le.p_v1_CrtRecCnt12Mo < 6.5,Tree_149_Node_16,42);
        Tree_149_Node_4 := IF ( le.p_v1_CrtRecCnt < 75.0,Tree_149_Node_8,Tree_149_Node_9);
        Tree_149_Node_5 := IF ( le.p_BP_3 < 9.5,39,40);
        Tree_149_Node_2 := IF ( le.p_BP_1 < 10.5,Tree_149_Node_4,Tree_149_Node_5);
        Tree_149_Node_12 := IF ( le.p_BPV_1 < 3.0918918,43,44);
        Tree_149_Node_7 := IF ( le.p_CurrAddrTaxMarketValue < 59083.5,Tree_149_Node_12,41);
        Tree_149_Node_3 := IF ( le.p_NonDerogCount12 < 2.5,38,Tree_149_Node_7);
        Tree_149_Node_1 := IF ( le.p_v1_CrtRecCnt < 98.5,Tree_149_Node_2,Tree_149_Node_3);
    SELF.Score1_Tree149_node := Tree_149_Node_1;
    SELF.Score1_Tree149_score := CASE(SELF.Score1_Tree149_node,38=>0.0017491971,39=>-4.5858684E-5,40=>0.017969687,41=>-0.0015045153,42=>0.0074034156,43=>-0.024754865,44=>-0.029282285,45=>0.0142091615,46=>2.5104603E-4,47=>0.03280325,48=>0.0063795815,49=>-3.0397478E-5,50=>-0.0062966417,51=>0.006614237,52=>5.416598E-4,53=>-0.025642386,54=>-0.028004818,55=>0.0066709705,56=>-0.022697661,0);
ENDMACRO;
