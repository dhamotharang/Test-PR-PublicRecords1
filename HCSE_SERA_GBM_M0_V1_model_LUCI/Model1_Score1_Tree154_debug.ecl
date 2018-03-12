﻿EXPORT Model1_Score1_Tree154_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_154_Node_20 := IF ( le.p_LastNameChangeAge < 365.5,55,56);
        Tree_154_Node_21 := IF ( le.p_PrevAddrAgeNewestRecord < 100.5,57,58);
        Tree_154_Node_12 := IF ( le.p_LastNameChangeAge < 384.5,Tree_154_Node_20,Tree_154_Node_21);
        Tree_154_Node_22 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 2.5,59,60);
        Tree_154_Node_23 := IF ( le.p_P_EstimatedHHIncomePerCapita < 5.25,61,62);
        Tree_154_Node_13 := IF ( le.p_PrevAddrDwellType < 1.5,Tree_154_Node_22,Tree_154_Node_23);
        Tree_154_Node_8 := IF ( le.p_PropOwnedHistoricalCount < 2.5,Tree_154_Node_12,Tree_154_Node_13);
        Tree_154_Node_24 := IF ( le.p_PrevAddrMedianValue < 49999.5,63,64);
        Tree_154_Node_14 := IF ( le.p_PrevAddrCarTheftIndex < 109.5,Tree_154_Node_24,50);
        Tree_154_Node_15 := IF ( le.p_v1_HHPropCurrAVMHighest < 298437.5,51,52);
        Tree_154_Node_9 := IF ( le.p_CurrAddrCarTheftIndex < 100.0,Tree_154_Node_14,Tree_154_Node_15);
        Tree_154_Node_6 := IF ( le.p_v1_RaAMedIncomeRange < 10.5,Tree_154_Node_8,Tree_154_Node_9);
        Tree_154_Node_28 := IF ( le.p_SSNIssueState < 8.0,65,66);
        Tree_154_Node_29 := IF ( le.p_LastNameChangeAge < 307.5,67,68);
        Tree_154_Node_16 := IF ( le.p_SSNIssueState < 41.5,Tree_154_Node_28,Tree_154_Node_29);
        Tree_154_Node_10 := IF ( le.p_v1_RaACrtRecMmbrCnt < 14.5,Tree_154_Node_16,48);
        Tree_154_Node_19 := IF ( le.p_age_in_years < 55.561874,53,54);
        Tree_154_Node_11 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,49,Tree_154_Node_19);
        Tree_154_Node_7 := IF ( le.p_AssocRiskLevel < 4.5,Tree_154_Node_10,Tree_154_Node_11);
        Tree_154_Node_4 := IF ( le.p_EstimatedAnnualIncome < 91612.0,Tree_154_Node_6,Tree_154_Node_7);
        Tree_154_Node_2 := IF ( le.p_CurrAddrAgeOldestRecord < 821.0,Tree_154_Node_4,47);
        Tree_154_Node_1 := IF ( le.p_CurrAddrLenOfRes < 848.5,Tree_154_Node_2,46);
    SELF.Score1_Tree154_node := Tree_154_Node_1;
    SELF.Score1_Tree154_score := CASE(SELF.Score1_Tree154_node,64=>-0.01567416,65=>0.010748037,66=>-0.010158448,67=>-0.0031451657,68=>0.039270002,46=>-0.016453302,47=>0.018148437,48=>0.015260763,49=>-0.02390044,50=>0.016613802,51=>-0.02441075,52=>-0.0147752715,53=>-0.023043865,54=>-0.023445223,55=>-9.173986E-5,56=>0.003815875,57=>-8.013787E-4,58=>-0.0057758484,59=>0.0072903964,60=>-0.0054762308,61=>-2.0931482E-4,62=>0.005214026,63=>0.010662264,0);
ENDMACRO;
