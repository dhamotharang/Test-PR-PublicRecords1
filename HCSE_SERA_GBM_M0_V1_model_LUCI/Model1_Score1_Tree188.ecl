﻿EXPORT Model1_Score1_Tree188(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_188_Node_62 := IF ( le.p_v1_HHPropCurrOwnedCnt < 6.5,175,176);
        Tree_188_Node_63 := IF ( le.p_PhoneEDAAgeOldestRecord < 174.5,177,178);
        Tree_188_Node_32 := IF ( le.p_v1_HHPropCurrOwnedCnt < 8.0,Tree_188_Node_62,Tree_188_Node_63);
        Tree_188_Node_64 := IF ( le.p_AccidentAge < 36.5,179,180);
        Tree_188_Node_33 := IF ( le.p_AccidentAge < 55.5,Tree_188_Node_64,157);
        Tree_188_Node_16 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 1.5,Tree_188_Node_32,Tree_188_Node_33);
        Tree_188_Node_66 := IF ( le.p_EstimatedAnnualIncome < 33999.5,181,182);
        Tree_188_Node_35 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 19.5,Tree_188_Node_66,158);
        Tree_188_Node_17 := IF ( le.p_age_in_years < 46.06875,147,Tree_188_Node_35);
        Tree_188_Node_8 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 10.5,Tree_188_Node_16,Tree_188_Node_17);
        Tree_188_Node_69 := IF ( le.p_CurrAddrBurglaryIndex < 147.5,183,184);
        Tree_188_Node_36 := IF ( le.p_CurrAddrMedianIncome < 33249.5,159,Tree_188_Node_69);
        Tree_188_Node_37 := IF ( le.p_EstimatedAnnualIncome < 36094.5,160,161);
        Tree_188_Node_18 := IF ( le.p_PrevAddrLenOfRes < 124.5,Tree_188_Node_36,Tree_188_Node_37);
        Tree_188_Node_72 := IF ( le.p_CurrAddrMedianValue < 196874.5,185,186);
        Tree_188_Node_38 := IF ( le.p_CurrAddrMedianValue < 656250.5,Tree_188_Node_72,162);
        Tree_188_Node_74 := IF ( le.p_v1_ProspectTimeLastUpdate < 79.5,187,188);
        Tree_188_Node_75 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 29.5,189,190);
        Tree_188_Node_39 := IF ( le.p_PrevAddrMedianIncome < 64345.5,Tree_188_Node_74,Tree_188_Node_75);
        Tree_188_Node_19 := IF ( le.p_CurrAddrAVMValue12 < 160155.5,Tree_188_Node_38,Tree_188_Node_39);
        Tree_188_Node_9 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 156249.5,Tree_188_Node_18,Tree_188_Node_19);
        Tree_188_Node_4 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 3.5,Tree_188_Node_8,Tree_188_Node_9);
        Tree_188_Node_41 := IF ( le.p_v1_RaACrtRecLienJudgAmtMax < 12019.5,163,164);
        Tree_188_Node_21 := IF ( le.p_PhoneOtherAgeOldestRecord < 50.5,148,Tree_188_Node_41);
        Tree_188_Node_10 := IF ( le.p_PrevAddrAgeOldestRecord < 24.0,146,Tree_188_Node_21);
        Tree_188_Node_42 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 14.5,165,166);
        Tree_188_Node_22 := IF ( le.p_CurrAddrBurglaryIndex < 98.0,Tree_188_Node_42,149);
        Tree_188_Node_23 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 0.5,150,151);
        Tree_188_Node_11 := IF ( le.p_CurrAddrAgeLastSale < 58.5,Tree_188_Node_22,Tree_188_Node_23);
        Tree_188_Node_5 := IF ( le.p_v1_ProspectTimeLastUpdate < 31.5,Tree_188_Node_10,Tree_188_Node_11);
        Tree_188_Node_2 := IF ( le.p_RelativesBankruptcyCount < 8.5,Tree_188_Node_4,Tree_188_Node_5);
        Tree_188_Node_80 := IF ( le.p_PrevAddrMedianValue < 211841.5,191,192);
        Tree_188_Node_81 := IF ( le.p_SourceRiskLevel < 4.5,193,194);
        Tree_188_Node_46 := IF ( le.p_CurrAddrCarTheftIndex < 130.5,Tree_188_Node_80,Tree_188_Node_81);
        Tree_188_Node_82 := IF ( le.p_AddrChangeCount60 < 4.5,195,196);
        Tree_188_Node_83 := IF ( le.p_SSNLowIssueAge < 617.5,197,198);
        Tree_188_Node_47 := IF ( le.p_NonDerogCount60 < 6.5,Tree_188_Node_82,Tree_188_Node_83);
        Tree_188_Node_24 := IF ( le.p_v1_RaACollegeLowTierMmbrCnt < 0.5,Tree_188_Node_46,Tree_188_Node_47);
        Tree_188_Node_25 := IF ( le.p_NonDerogCount06 < 3.5,152,153);
        Tree_188_Node_12 := IF ( le.p_PrevAddrMedianIncome < 115357.5,Tree_188_Node_24,Tree_188_Node_25);
        Tree_188_Node_85 := IF ( le.p_CurrAddrCarTheftIndex < 119.5,199,200);
        Tree_188_Node_50 := IF ( le.p_NonDerogCount60 < 3.5,167,Tree_188_Node_85);
        Tree_188_Node_51 := IF ( le.p_age_in_years < 44.17625,168,169);
        Tree_188_Node_26 := IF ( le.p_CurrAddrLenOfRes < 62.5,Tree_188_Node_50,Tree_188_Node_51);
        Tree_188_Node_88 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 7.5,201,202);
        Tree_188_Node_89 := IF ( le.p_AssocRiskLevel < 1.5,203,204);
        Tree_188_Node_52 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 3.5,Tree_188_Node_88,Tree_188_Node_89);
        Tree_188_Node_90 := IF ( le.p_PRSearchLocateCount < 6.5,205,206);
        Tree_188_Node_91 := IF ( le.p_CurrAddrMedianIncome < 46693.5,207,208);
        Tree_188_Node_53 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 6.5,Tree_188_Node_90,Tree_188_Node_91);
        Tree_188_Node_27 := IF ( le.p_AddrChangeCount60 < 3.5,Tree_188_Node_52,Tree_188_Node_53);
        Tree_188_Node_13 := IF ( le.p_v1_ProspectTimeOnRecord < 118.0,Tree_188_Node_26,Tree_188_Node_27);
        Tree_188_Node_6 := IF ( le.p_SearchVelocityRiskLevel < 5.5,Tree_188_Node_12,Tree_188_Node_13);
        Tree_188_Node_93 := IF ( le.p_CurrAddrMedianValue < 143461.0,209,210);
        Tree_188_Node_54 := IF ( le.p_CurrAddrCrimeIndex < 29.5,170,Tree_188_Node_93);
        Tree_188_Node_28 := IF ( le.p_v1_HHCnt < 9.5,Tree_188_Node_54,154);
        Tree_188_Node_94 := IF ( le.p_PrevAddrMedianValue < 97092.5,211,212);
        Tree_188_Node_95 := IF ( le.p_CurrAddrMedianIncome < 78642.5,213,214);
        Tree_188_Node_56 := IF ( le.p_v1_ProspectTimeOnRecord < 271.5,Tree_188_Node_94,Tree_188_Node_95);
        Tree_188_Node_57 := IF ( le.p_CurrAddrBlockIndex < 1.1325,171,172);
        Tree_188_Node_29 := IF ( le.p_DivSSNIdentityMSourceUrelCount < 1.5,Tree_188_Node_56,Tree_188_Node_57);
        Tree_188_Node_14 := IF ( le.p_CurrAddrAVMValue60 < 137091.5,Tree_188_Node_28,Tree_188_Node_29);
        Tree_188_Node_58 := IF ( le.p_v1_ProspectTimeOnRecord < 231.5,173,174);
        Tree_188_Node_30 := IF ( le.p_PhoneOtherAgeNewestRecord < 64.5,Tree_188_Node_58,155);
        Tree_188_Node_100 := IF ( le.p_v1_HHCrtRecLienJudgMmbrCnt < 0.5,215,216);
        Tree_188_Node_101 := IF ( le.p_v1_RaAPropOwnerAVMMed < 205852.5,217,218);
        Tree_188_Node_60 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 313651.5,Tree_188_Node_100,Tree_188_Node_101);
        Tree_188_Node_31 := IF ( le.p_SSNHighIssueAge < 644.5,Tree_188_Node_60,156);
        Tree_188_Node_15 := IF ( le.p_v1_HHPPCurrOwnedCnt < 1.5,Tree_188_Node_30,Tree_188_Node_31);
        Tree_188_Node_7 := IF ( le.p_v1_PropTimeLastSale < 1.5,Tree_188_Node_14,Tree_188_Node_15);
        Tree_188_Node_3 := IF ( le.p_CurrAddrBlockIndex < 0.8867578,Tree_188_Node_6,Tree_188_Node_7);
        Tree_188_Node_1 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 5.5,Tree_188_Node_2,Tree_188_Node_3);
    UNSIGNED2 Score1_Tree188_node := Tree_188_Node_1;
    REAL8 Score1_Tree188_score := CASE(Score1_Tree188_node,146=>0.009522108,147=>0.0036651858,148=>-0.01736087,149=>0.0025432077,150=>-0.012358577,151=>0.0075309156,152=>0.023580657,153=>-0.006354169,154=>0.012901166,155=>-0.0037697938,156=>0.011567576,157=>-0.0173126,158=>-0.0028147628,159=>-0.015207888,160=>-0.01751432,161=>-0.013817265,162=>0.027012054,163=>-0.0102971615,164=>0.0045483094,165=>0.011725196,166=>0.029825768,167=>0.013159028,168=>-0.016935144,169=>-0.018575003,170=>0.01937907,171=>0.033086568,172=>0.008683151,173=>-0.016657596,174=>-0.017830344,175=>6.381599E-5,176=>-0.0047162916,177=>-0.0011699675,178=>0.00781883,179=>0.002148792,180=>0.029735751,181=>-0.018018425,182=>-0.017050607,183=>-0.0052686157,184=>0.01308407,185=>0.0013075019,186=>-0.004310992,187=>-0.0033585231,188=>0.010500806,189=>-0.012149161,190=>9.294024E-4,191=>-0.004021939,192=>-0.016955936,193=>0.009718699,194=>-0.010084168,195=>-0.012539986,196=>-5.406955E-4,197=>-0.016730942,198=>0.010940371,199=>-0.013264872,200=>0.003274956,201=>0.017337022,202=>-0.0011024841,203=>0.015623774,204=>-0.0053908965,205=>-0.017068105,206=>-0.0035800268,207=>0.007417107,208=>-0.010365998,209=>-2.1604914E-4,210=>-0.014090504,211=>-0.01303982,212=>0.015176334,213=>-0.01732929,214=>-6.174717E-4,215=>-0.016469061,216=>-0.017042905,217=>0.013467041,218=>-0.011142153,0);
ENDMACRO;
