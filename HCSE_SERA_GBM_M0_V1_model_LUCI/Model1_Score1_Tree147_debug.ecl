﻿EXPORT Model1_Score1_Tree147_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_147_Node_46 := IF ( le.p_LastNameChangeAge < 365.5,114,115);
        Tree_147_Node_47 := IF ( le.p_DerogAge < 260.5,116,117);
        Tree_147_Node_28 := IF ( le.p_LastNameChangeAge < 384.5,Tree_147_Node_46,Tree_147_Node_47);
        Tree_147_Node_49 := IF ( le.p_BP_4 < 3.5,118,119);
        Tree_147_Node_29 := IF ( le.p_NonDerogCount60 < 4.5,104,Tree_147_Node_49);
        Tree_147_Node_16 := IF ( le.p_PRSearchLocateCount < 27.5,Tree_147_Node_28,Tree_147_Node_29);
        Tree_147_Node_51 := IF ( le.p_LastNameChangeAge < 166.5,120,121);
        Tree_147_Node_30 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 0.5,105,Tree_147_Node_51);
        Tree_147_Node_17 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,Tree_147_Node_30,97);
        Tree_147_Node_8 := IF ( le.p_PRSearchLocateCount < 33.5,Tree_147_Node_16,Tree_147_Node_17);
        Tree_147_Node_52 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 0.5,122,123);
        Tree_147_Node_53 := IF ( le.p_PrevAddrAgeNewestRecord < 283.5,124,125);
        Tree_147_Node_32 := IF ( le.p_SSNLowIssueAge < 480.0,Tree_147_Node_52,Tree_147_Node_53);
        Tree_147_Node_18 := IF ( le.p_CurrAddrAgeOldestRecord < 688.5,Tree_147_Node_32,98);
        Tree_147_Node_54 := IF ( le.p_v1_CrtRecTimeNewest < 341.5,126,127);
        Tree_147_Node_55 := IF ( le.p_PrevAddrLenOfRes < 77.5,128,129);
        Tree_147_Node_34 := IF ( le.p_PrevAddrAgeNewestRecord < 114.5,Tree_147_Node_54,Tree_147_Node_55);
        Tree_147_Node_35 := IF ( le.p_PhoneOtherAgeOldestRecord < 63.5,106,107);
        Tree_147_Node_19 := IF ( le.p_SearchVelocityRiskLevel < 4.5,Tree_147_Node_34,Tree_147_Node_35);
        Tree_147_Node_9 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 203.5,Tree_147_Node_18,Tree_147_Node_19);
        Tree_147_Node_4 := IF ( le.p_NonDerogCount01 < 4.5,Tree_147_Node_8,Tree_147_Node_9);
        Tree_147_Node_20 := IF ( le.p_StatusMostRecent < 1.5,99,100);
        Tree_147_Node_38 := IF ( le.p_LastNameChangeAge < 261.5,108,109);
        Tree_147_Node_60 := IF ( le.p_EstimatedAnnualIncome < 35150.5,130,131);
        Tree_147_Node_61 := IF ( le.p_CurrAddrBurglaryIndex < 96.0,132,133);
        Tree_147_Node_39 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,Tree_147_Node_60,Tree_147_Node_61);
        Tree_147_Node_21 := IF ( le.p_v1_PropCurrOwnedCnt < 0.5,Tree_147_Node_38,Tree_147_Node_39);
        Tree_147_Node_11 := IF ( le.p_v1_ProspectTimeOnRecord < 151.5,Tree_147_Node_20,Tree_147_Node_21);
        Tree_147_Node_5 := IF ( le.p_CurrAddrLenOfRes < 7.5,92,Tree_147_Node_11);
        Tree_147_Node_2 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 379.0,Tree_147_Node_4,Tree_147_Node_5);
        Tree_147_Node_12 := IF ( le.p_v1_RaAMedIncomeRange < 5.5,94,95);
        Tree_147_Node_6 := IF ( le.p_PrevAddrMedianValue < 167200.5,Tree_147_Node_12,93);
        Tree_147_Node_63 := IF ( le.p_age_in_years < 37.165,134,135);
        Tree_147_Node_40 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,110,Tree_147_Node_63);
        Tree_147_Node_24 := IF ( le.p_age_in_years < 53.59039,Tree_147_Node_40,101);
        Tree_147_Node_14 := IF ( le.p_PrevAddrAgeLastSale < 114.0,Tree_147_Node_24,96);
        Tree_147_Node_64 := IF ( le.p_PrevAddrCarTheftIndex < 83.5,136,137);
        Tree_147_Node_42 := IF ( le.p_PrevAddrLenOfRes < 276.0,Tree_147_Node_64,111);
        Tree_147_Node_43 := IF ( le.p_DivSSNAddrMSourceCount < 6.5,112,113);
        Tree_147_Node_26 := IF ( le.p_PrevAddrAgeLastSale < 16.5,Tree_147_Node_42,Tree_147_Node_43);
        Tree_147_Node_27 := IF ( le.p_RelativesFelonyCount < 0.5,102,103);
        Tree_147_Node_15 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 1.5,Tree_147_Node_26,Tree_147_Node_27);
        Tree_147_Node_7 := IF ( le.p_v1_ProspectAge < 50.5,Tree_147_Node_14,Tree_147_Node_15);
        Tree_147_Node_3 := IF ( le.p_BP_4 < 4.0,Tree_147_Node_6,Tree_147_Node_7);
        Tree_147_Node_1 := IF ( le.p_CurrAddrBurglaryIndex < 197.5,Tree_147_Node_2,Tree_147_Node_3);
    SELF.Score1_Tree147_node := Tree_147_Node_1;
    SELF.Score1_Tree147_score := CASE(SELF.Score1_Tree147_node,128=>-0.01885918,129=>0.02463456,130=>-0.026160428,131=>-0.025141776,132=>-0.021623654,133=>0.0037985006,134=>-0.02514544,135=>-0.026125284,136=>-0.021002969,137=>0.0051021036,92=>0.01359393,93=>-0.00914293,94=>-0.026593195,95=>-0.022235664,96=>0.018389763,97=>0.0031416167,98=>0.017393788,99=>-0.016848588,100=>-0.026043987,101=>-0.026993057,102=>0.045596257,103=>0.0035113238,104=>0.037350144,105=>-0.01119291,106=>0.0336722,107=>-0.006740277,108=>-0.016169637,109=>0.02084243,110=>-0.010682999,111=>0.018934498,112=>-0.026254445,113=>-0.0032990377,114=>1.7939693E-4,115=>0.0040421705,116=>-0.001406938,117=>0.010401005,118=>-0.021182207,119=>0.018910088,120=>-0.025786113,121=>-0.02688726,122=>-0.0033139254,123=>-0.01628686,124=>2.1249011E-4,125=>-0.020453846,126=>-0.020015826,127=>-2.5837397E-4,0);
ENDMACRO;
