﻿EXPORT Model1_Score1_Tree136(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_136_Node_46 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 4.5,144,145);
        Tree_136_Node_47 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,146,147);
        Tree_136_Node_26 := IF ( le.p_RelativesBankruptcyCount < 2.5,Tree_136_Node_46,Tree_136_Node_47);
        Tree_136_Node_48 := IF ( le.p_PrevAddrCrimeIndex < 160.5,148,149);
        Tree_136_Node_49 := IF ( le.p_CurrAddrAgeLastSale < 383.5,150,151);
        Tree_136_Node_27 := IF ( le.p_AssocRiskLevel < 2.5,Tree_136_Node_48,Tree_136_Node_49);
        Tree_136_Node_14 := IF ( le.p_EstimatedAnnualIncome < 66375.5,Tree_136_Node_26,Tree_136_Node_27);
        Tree_136_Node_50 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 0.5,152,153);
        Tree_136_Node_51 := IF ( le.p_v1_HHCrtRecMmbrCnt < 2.5,154,155);
        Tree_136_Node_28 := IF ( le.p_PropAgeNewestSale < 9.5,Tree_136_Node_50,Tree_136_Node_51);
        Tree_136_Node_29 := IF ( le.p_VariationDOBCount < 2.5,134,135);
        Tree_136_Node_15 := IF ( le.p_PrevAddrAgeNewestRecord < 338.5,Tree_136_Node_28,Tree_136_Node_29);
        Tree_136_Node_8 := IF ( le.p_LastNameChangeAge < 372.5,Tree_136_Node_14,Tree_136_Node_15);
        Tree_136_Node_54 := IF ( le.p_PrevAddrAgeNewestRecord < 110.5,156,157);
        Tree_136_Node_30 := IF ( le.p_PRSearchLocateCount < 17.5,Tree_136_Node_54,136);
        Tree_136_Node_56 := IF ( le.p_PrevAddrAgeNewestRecord < 81.0,158,159);
        Tree_136_Node_57 := IF ( le.p_CurrAddrBurglaryIndex < 57.5,160,161);
        Tree_136_Node_31 := IF ( le.p_CurrAddrCarTheftIndex < 59.5,Tree_136_Node_56,Tree_136_Node_57);
        Tree_136_Node_16 := IF ( le.p_v1_PropSoldRatio < 2.125,Tree_136_Node_30,Tree_136_Node_31);
        Tree_136_Node_32 := IF ( le.p_PrevAddrCrimeIndex < 99.5,137,138);
        Tree_136_Node_60 := IF ( le.p_PrevAddrLenOfRes < 205.5,162,163);
        Tree_136_Node_33 := IF ( le.p_VariationMSourcesSSNCount < 1.5,Tree_136_Node_60,139);
        Tree_136_Node_17 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 1.5,Tree_136_Node_32,Tree_136_Node_33);
        Tree_136_Node_9 := IF ( le.p_DerogAge < 281.5,Tree_136_Node_16,Tree_136_Node_17);
        Tree_136_Node_4 := IF ( le.p_LastNameChangeAge < 384.5,Tree_136_Node_8,Tree_136_Node_9);
        Tree_136_Node_2 := IF ( le.p_BPV_3 < 4.3605924,Tree_136_Node_4,128);
        Tree_136_Node_18 := IF ( le.p_PrevAddrCarTheftIndex < 24.5,131,132);
        Tree_136_Node_10 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 3.5,Tree_136_Node_18,129);
        Tree_136_Node_62 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 0.5,164,165);
        Tree_136_Node_63 := IF ( le.p_NonDerogCount24 < 4.5,166,167);
        Tree_136_Node_36 := IF ( le.p_AgeOldestRecord < 332.5,Tree_136_Node_62,Tree_136_Node_63);
        Tree_136_Node_37 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,140,141);
        Tree_136_Node_20 := IF ( le.p_PhoneOtherAgeNewestRecord < 24.5,Tree_136_Node_36,Tree_136_Node_37);
        Tree_136_Node_66 := IF ( le.p_LastNameChangeAge < 206.5,168,169);
        Tree_136_Node_38 := IF ( le.p_v1_HHPPCurrOwnedCnt < 2.5,Tree_136_Node_66,142);
        Tree_136_Node_21 := IF ( le.p_PhoneOtherAgeNewestRecord < 55.5,Tree_136_Node_38,133);
        Tree_136_Node_11 := IF ( le.p_AgeOldestRecord < 395.5,Tree_136_Node_20,Tree_136_Node_21);
        Tree_136_Node_6 := IF ( le.p_AgeOldestRecord < 221.5,Tree_136_Node_10,Tree_136_Node_11);
        Tree_136_Node_68 := IF ( le.p_age_in_years < 33.4975,170,171);
        Tree_136_Node_69 := IF ( le.p_VariationMSourcesSSNUnrelCount < 1.5,172,173);
        Tree_136_Node_40 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,Tree_136_Node_68,Tree_136_Node_69);
        Tree_136_Node_70 := IF ( le.p_PrevAddrBurglaryIndex < 119.5,174,175);
        Tree_136_Node_71 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 633696.5,176,177);
        Tree_136_Node_41 := IF ( le.p_CurrAddrMedianValue < 93750.5,Tree_136_Node_70,Tree_136_Node_71);
        Tree_136_Node_22 := IF ( le.p_VariationDOBCount < 1.5,Tree_136_Node_40,Tree_136_Node_41);
        Tree_136_Node_12 := IF ( le.p_age_in_years < 79.18586,Tree_136_Node_22,130);
        Tree_136_Node_72 := IF ( le.p_SSNHighIssueAge < 180.5,178,179);
        Tree_136_Node_73 := IF ( le.p_LastNameChangeAge < 235.5,180,181);
        Tree_136_Node_42 := IF ( le.p_CurrAddrMedianValue < 375000.5,Tree_136_Node_72,Tree_136_Node_73);
        Tree_136_Node_74 := IF ( le.p_v1_RaAElderlyMmbrCnt < 1.5,182,183);
        Tree_136_Node_43 := IF ( le.p_PhoneOtherAgeOldestRecord < 141.5,Tree_136_Node_74,143);
        Tree_136_Node_24 := IF ( le.p_CurrAddrMedianIncome < 90549.5,Tree_136_Node_42,Tree_136_Node_43);
        Tree_136_Node_76 := IF ( le.p_PrevAddrBurglaryIndex < 87.5,184,185);
        Tree_136_Node_77 := IF ( le.p_SrcsConfirmIDAddrCount < 6.5,186,187);
        Tree_136_Node_44 := IF ( le.p_v1_RaAYoungAdultMmbrCnt < 0.5,Tree_136_Node_76,Tree_136_Node_77);
        Tree_136_Node_78 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 21.5,188,189);
        Tree_136_Node_79 := IF ( le.p_PrevAddrMedianIncome < 74967.5,190,191);
        Tree_136_Node_45 := IF ( le.p_LastNameChangeAge < 415.5,Tree_136_Node_78,Tree_136_Node_79);
        Tree_136_Node_25 := IF ( le.p_SubjectAddrCount < 4.5,Tree_136_Node_44,Tree_136_Node_45);
        Tree_136_Node_13 := IF ( le.p_v1_HHEstimatedIncomeRange < 5.5,Tree_136_Node_24,Tree_136_Node_25);
        Tree_136_Node_7 := IF ( le.p_SSNIssueState < 17.5,Tree_136_Node_12,Tree_136_Node_13);
        Tree_136_Node_3 := IF ( le.p_CurrAddrBurglaryIndex < 4.0,Tree_136_Node_6,Tree_136_Node_7);
        Tree_136_Node_1 := IF ( le.p_PRSearchLocateCount24 < 0.5,Tree_136_Node_2,Tree_136_Node_3);
    UNSIGNED2 Score1_Tree136_node := Tree_136_Node_1;
    REAL8 Score1_Tree136_score := CASE(Score1_Tree136_node,128=>0.014795813,129=>0.06889319,130=>0.013600452,131=>-0.001529929,132=>0.0427958,133=>0.036493637,134=>0.057434402,135=>0.01880408,136=>0.034342337,137=>-0.029367711,138=>-3.8439783E-4,139=>0.041119535,140=>-0.029300492,141=>-0.028726012,142=>0.033187125,143=>0.0015160802,144=>-1.0514078E-4,145=>-0.0048607807,146=>-5.799646E-4,147=>0.0035169078,148=>5.681553E-4,149=>-0.014541536,150=>-0.010585252,151=>0.025974398,152=>0.00607798,153=>0.020940952,154=>-0.009900351,155=>0.022135487,156=>-0.001406644,157=>-0.006882194,158=>-0.013493904,159=>0.021950997,160=>0.06893106,161=>0.01329897,162=>2.1906466E-4,163=>0.030481901,164=>-0.00823995,165=>-0.02141839,166=>-0.005518475,167=>0.038388863,168=>-0.029272411,169=>0.009944428,170=>-0.017257195,171=>-0.028676486,172=>-0.0045153783,173=>0.030725649,174=>0.035411544,175=>-0.028762704,176=>-0.025598103,177=>-0.0062161945,178=>0.041709438,179=>9.0190035E-5,180=>-0.02827565,181=>0.044158857,182=>-0.02497389,183=>-0.0018229089,184=>0.01778928,185=>0.05646153,186=>-0.018516967,187=>0.026645692,188=>0.008783461,189=>-0.002970191,190=>-0.0016661853,191=>0.057807438,0);
ENDMACRO;
