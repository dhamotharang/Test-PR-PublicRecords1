﻿EXPORT Model1_Score1_Tree27_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_27_Node_29 := IF ( le.p_age_in_years < 0.16585724,105,106);
        Tree_27_Node_17 := IF ( le.p_age_in_years < 0.10488327,97,Tree_27_Node_29);
        Tree_27_Node_44 := IF ( le.p_age_in_years < 0.09531884,110,111);
        Tree_27_Node_26 := IF ( le.p_age_in_years < 0.12421607,Tree_27_Node_44,104);
        Tree_27_Node_16 := IF ( le.p_age_in_years < 0.18454026,Tree_27_Node_26,96);
        Tree_27_Node_9 := CHOOSE ( le.p_gender,Tree_27_Node_17,Tree_27_Node_16);
        Tree_27_Node_4 := IF ( le.p_age_in_years < 0.055097654,92,Tree_27_Node_9);
        Tree_27_Node_5 := IF ( le.p_SSNLowIssueAge < 56.5,93,94);
        Tree_27_Node_2 := IF ( le.p_SSNLowIssueAge < 26.0,Tree_27_Node_4,Tree_27_Node_5);
        Tree_27_Node_48 := IF ( le.p_EvictionAge < 43.5,112,113);
        Tree_27_Node_49 := IF ( le.p_v1_CrtRecTimeNewest < 227.0,114,115);
        Tree_27_Node_30 := IF ( le.p_BPV_2 < 2.579697,Tree_27_Node_48,Tree_27_Node_49);
        Tree_27_Node_50 := IF ( le.p_CurrAddrMedianValue < 172250.5,116,117);
        Tree_27_Node_51 := IF ( le.p_LienFiledAge < 287.5,118,119);
        Tree_27_Node_31 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,Tree_27_Node_50,Tree_27_Node_51);
        Tree_27_Node_18 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_27_Node_30,Tree_27_Node_31);
        Tree_27_Node_33 := IF ( le.p_PRSearchLocateCount < 3.5,107,108);
        Tree_27_Node_19 := IF ( le.p_AgeOldestRecord < 335.5,98,Tree_27_Node_33);
        Tree_27_Node_12 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 8.5,Tree_27_Node_18,Tree_27_Node_19);
        Tree_27_Node_54 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 251.5,120,121);
        Tree_27_Node_55 := IF ( le.p_PrevAddrMurderIndex < 169.5,122,123);
        Tree_27_Node_34 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 216.0,Tree_27_Node_54,Tree_27_Node_55);
        Tree_27_Node_20 := IF ( le.p_v1_HHPropCurrOwnedCnt < 12.5,Tree_27_Node_34,99);
        Tree_27_Node_57 := IF ( le.p_PrevAddrAgeLastSale < 31.5,126,127);
        Tree_27_Node_56 := IF ( le.p_PropOwnedHistoricalCount < 3.5,124,125);
        Tree_27_Node_36 := CHOOSE ( le.p_gender,Tree_27_Node_57,Tree_27_Node_56);
        Tree_27_Node_21 := IF ( le.p_CurrAddrAgeLastSale < 191.5,Tree_27_Node_36,100);
        Tree_27_Node_13 := IF ( le.p_CurrAddrMedianValue < 224925.5,Tree_27_Node_20,Tree_27_Node_21);
        Tree_27_Node_6 := IF ( le.p_NonDerogCount01 < 4.5,Tree_27_Node_12,Tree_27_Node_13);
        Tree_27_Node_58 := IF ( le.p_PrevAddrCarTheftIndex < 140.5,128,129);
        Tree_27_Node_59 := IF ( le.p_CurrAddrAgeOldestRecord < 269.5,130,131);
        Tree_27_Node_38 := IF ( le.p_PrevAddrCrimeIndex < 180.5,Tree_27_Node_58,Tree_27_Node_59);
        Tree_27_Node_60 := IF ( le.p_LienFiledAge < 68.5,132,133);
        Tree_27_Node_39 := IF ( le.p_CurrAddrBurglaryIndex < 40.5,Tree_27_Node_60,109);
        Tree_27_Node_22 := IF ( le.p_SubjectLastNameCount < 9.5,Tree_27_Node_38,Tree_27_Node_39);
        Tree_27_Node_23 := IF ( le.p_v1_ProspectTimeLastUpdate < 73.5,101,102);
        Tree_27_Node_14 := IF ( le.p_BPV_2 < 2.9667,Tree_27_Node_22,Tree_27_Node_23);
        Tree_27_Node_62 := IF ( le.p_SSNIssueState < 44.0,134,135);
        Tree_27_Node_63 := IF ( le.p_PrevAddrDwellType < 0.0,136,137);
        Tree_27_Node_42 := IF ( le.p_v1_LifeEvEverResidedCnt < 1.5,Tree_27_Node_62,Tree_27_Node_63);
        Tree_27_Node_24 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 458830.5,Tree_27_Node_42,103);
        Tree_27_Node_15 := IF ( le.p_CurrAddrAgeOldestRecord < 632.5,Tree_27_Node_24,95);
        Tree_27_Node_7 := IF ( le.p_CurrAddrCarTheftIndex < 116.5,Tree_27_Node_14,Tree_27_Node_15);
        Tree_27_Node_3 := IF ( le.p_CurrAddrMedianValue < 246093.5,Tree_27_Node_6,Tree_27_Node_7);
        Tree_27_Node_1 := IF ( le.p_age_in_years < 0.31992188,Tree_27_Node_2,Tree_27_Node_3);
    SELF.Score1_Tree27_node := Tree_27_Node_1;
    SELF.Score1_Tree27_score := CASE(SELF.Score1_Tree27_node,128=>-0.01210172,129=>0.012823461,130=>-0.0681868,131=>0.011784044,132=>0.033361763,133=>0.19901618,134=>0.0077387816,135=>0.07635864,136=>0.06525382,137=>-0.019605814,92=>-0.038518615,93=>0.045754164,94=>-0.019346608,95=>0.1449448,96=>0.01798036,97=>0.049544327,98=>-0.02171208,99=>0.084398024,100=>0.21918957,101=>-0.036768224,102=>0.07507818,103=>0.15494236,104=>-0.08013741,105=>-0.015679816,106=>-0.080019,107=>-0.09042815,108=>-0.06822613,109=>-0.06591638,110=>-0.07967393,111=>0.0068786545,112=>0.0076486315,113=>-0.013414276,114=>0.023488821,115=>-0.06652591,116=>-0.0027689028,117=>0.008753906,118=>0.011386422,119=>0.1129944,120=>-0.010639919,121=>0.08132925,122=>-0.048618145,123=>0.020962209,124=>-0.072776176,125=>0.06263301,126=>3.6281603E-4,127=>0.12986575,0);
ENDMACRO;
