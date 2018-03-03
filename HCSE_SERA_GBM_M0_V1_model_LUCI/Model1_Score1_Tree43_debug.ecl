﻿EXPORT Model1_Score1_Tree43_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_43_Node_36 := IF ( le.p_RelativesBankruptcyCount < 8.5,98,99);
        Tree_43_Node_37 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 0.5,100,101);
        Tree_43_Node_22 := IF ( le.p_CurrAddrCarTheftIndex < 110.5,Tree_43_Node_36,Tree_43_Node_37);
        Tree_43_Node_38 := IF ( le.p_DivSSNAddrMSourceCount < 7.5,102,103);
        Tree_43_Node_23 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 225.5,Tree_43_Node_38,92);
        Tree_43_Node_14 := IF ( le.p_AddrChangeCount60 < 3.5,Tree_43_Node_22,Tree_43_Node_23);
        Tree_43_Node_8 := IF ( le.p_AccidentAge < 359.5,Tree_43_Node_14,87);
        Tree_43_Node_41 := IF ( le.p_StatusMostRecent < 1.5,104,105);
        Tree_43_Node_24 := IF ( le.p_AgeOldestRecord < 261.0,93,Tree_43_Node_41);
        Tree_43_Node_42 := IF ( le.p_PrevAddrMedianIncome < 63126.5,106,107);
        Tree_43_Node_25 := IF ( le.p_v1_RaAMedIncomeRange < 7.5,Tree_43_Node_42,94);
        Tree_43_Node_16 := IF ( le.p_AgeOldestRecord < 447.5,Tree_43_Node_24,Tree_43_Node_25);
        Tree_43_Node_26 := IF ( le.p_CurrAddrAgeLastSale < 49.5,95,96);
        Tree_43_Node_17 := IF ( le.p_BP_4 < 19.5,Tree_43_Node_26,88);
        Tree_43_Node_9 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 1.5,Tree_43_Node_16,Tree_43_Node_17);
        Tree_43_Node_4 := IF ( le.p_age_in_years < 88.725,Tree_43_Node_8,Tree_43_Node_9);
        Tree_43_Node_46 := IF ( le.p_CurrAddrBurglaryIndex < 160.5,108,109);
        Tree_43_Node_47 := IF ( le.p_v1_ProspectTimeOnRecord < 287.5,110,111);
        Tree_43_Node_28 := IF ( le.p_SrcsConfirmIDAddrCount < 11.5,Tree_43_Node_46,Tree_43_Node_47);
        Tree_43_Node_48 := IF ( le.p_CurrAddrBurglaryIndex < 150.5,112,113);
        Tree_43_Node_49 := IF ( le.p_AssocSuspicousIdentitiesCount < 0.5,114,115);
        Tree_43_Node_29 := IF ( le.p_CurrAddrLenOfRes < 415.5,Tree_43_Node_48,Tree_43_Node_49);
        Tree_43_Node_18 := IF ( le.p_NonDerogCount01 < 4.5,Tree_43_Node_28,Tree_43_Node_29);
        Tree_43_Node_50 := IF ( le.p_EvictionAge < 175.5,116,117);
        Tree_43_Node_30 := IF ( le.p_v1_PropSoldRatio < 15.46875,Tree_43_Node_50,97);
        Tree_43_Node_19 := IF ( le.p_CurrAddrTractIndex < 3.885625,Tree_43_Node_30,89);
        Tree_43_Node_10 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,Tree_43_Node_18,Tree_43_Node_19);
        Tree_43_Node_52 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 0.5,118,119);
        Tree_43_Node_53 := IF ( le.p_PrevAddrBurglaryIndex < 149.5,120,121);
        Tree_43_Node_32 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 1.5,Tree_43_Node_52,Tree_43_Node_53);
        Tree_43_Node_20 := IF ( le.p_v1_PropTimeLastSale < 197.5,Tree_43_Node_32,90);
        Tree_43_Node_54 := IF ( le.p_DerogSeverityIndex < 1.5,122,123);
        Tree_43_Node_55 := IF ( le.p_PrevAddrMedianValue < 399999.5,124,125);
        Tree_43_Node_34 := IF ( le.p_v1_HHCnt < 2.5,Tree_43_Node_54,Tree_43_Node_55);
        Tree_43_Node_21 := IF ( le.p_PhoneOtherAgeNewestRecord < 111.5,Tree_43_Node_34,91);
        Tree_43_Node_11 := IF ( le.p_DivSSNAddrMSourceCount < 6.5,Tree_43_Node_20,Tree_43_Node_21);
        Tree_43_Node_5 := IF ( le.p_CurrAddrMedianValue < 523437.5,Tree_43_Node_10,Tree_43_Node_11);
        Tree_43_Node_2 := IF ( le.p_SSNIssueState < 22.5,Tree_43_Node_4,Tree_43_Node_5);
        Tree_43_Node_7 := IF ( le.p_CurrAddrMedianValue < 135351.5,85,86);
        Tree_43_Node_3 := IF ( le.p_AgeOldestRecord < 325.0,84,Tree_43_Node_7);
        Tree_43_Node_1 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 8.5,Tree_43_Node_2,Tree_43_Node_3);
    SELF.Score1_Tree43_node := Tree_43_Node_1;
    SELF.Score1_Tree43_score := CASE(SELF.Score1_Tree43_node,84=>-0.008896443,85=>-0.075299054,86=>-0.055373795,87=>0.07585781,88=>0.053028055,89=>0.08245843,90=>0.07956897,91=>0.038700778,92=>0.041013233,93=>-7.737889E-4,94=>0.05543795,95=>0.013286538,96=>-0.07394968,97=>0.063342504,98=>-0.0075485436,99=>0.055877417,100=>0.023697242,101=>-0.002150042,102=>0.008060072,103=>-0.031592228,104=>-0.047831494,105=>-0.07444079,106=>-0.07478876,107=>-0.016484227,108=>0.0043607955,109=>-0.0022338836,110=>0.053434767,111=>0.0041657835,112=>-0.015593738,113=>0.007092063,114=>-0.017381132,115=>0.052551962,116=>-0.0046321508,117=>0.075242326,118=>-0.0153180305,119=>-0.06761076,120=>-0.0031723885,121=>0.050326727,122=>-0.05252459,123=>-0.0739724,124=>-0.051533114,125=>0.02081496,0);
ENDMACRO;
