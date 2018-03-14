﻿EXPORT Model1_Score1_Tree6(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_6_Node_60 := CHOOSE ( le.p_gender,177,176);
        Tree_6_Node_61 := CHOOSE ( le.p_gender,178,179);
        Tree_6_Node_33 := IF ( le.p_age_in_years < 0.14476402,Tree_6_Node_60,Tree_6_Node_61);
        Tree_6_Node_16 := IF ( le.p_age_in_years < 0.035241395,154,Tree_6_Node_33);
        Tree_6_Node_35 := IF ( le.p_age_in_years < 0.50535494,162,163);
        Tree_6_Node_17 := IF ( le.p_age_in_years < 0.43543214,155,Tree_6_Node_35);
        Tree_6_Node_8 := IF ( le.p_age_in_years < 0.3469922,Tree_6_Node_16,Tree_6_Node_17);
        Tree_6_Node_9 := CHOOSE ( le.p_gender,152,153);
        Tree_6_Node_4 := IF ( le.p_SSNLowIssueAge < 27.5,Tree_6_Node_8,Tree_6_Node_9);
        Tree_6_Node_64 := CHOOSE ( le.p_gender,180,181);
        Tree_6_Node_36 := IF ( le.p_PrevAddrMedianValue < 88974.5,Tree_6_Node_64,164);
        Tree_6_Node_67 := IF ( le.p_RelativesCount < 8.5,182,183);
        Tree_6_Node_37 := IF ( le.p_CurrAddrMurderIndex < 140.5,165,Tree_6_Node_67);
        Tree_6_Node_20 := IF ( le.p_PrevAddrMedianIncome < 34798.5,Tree_6_Node_36,Tree_6_Node_37);
        Tree_6_Node_21 := IF ( le.p_CurrAddrAgeLastSale < 13.5,156,157);
        Tree_6_Node_10 := IF ( le.p_PhoneOtherAgeOldestRecord < 119.5,Tree_6_Node_20,Tree_6_Node_21);
        Tree_6_Node_68 := IF ( le.p_DerogAge < 115.5,184,185);
        Tree_6_Node_40 := IF ( le.p_PrevAddrBurglaryIndex < 179.5,Tree_6_Node_68,166);
        Tree_6_Node_22 := IF ( le.p_CurrAddrCountyIndex < 2.77875,Tree_6_Node_40,158);
        Tree_6_Node_70 := IF ( le.p_RelativesPropOwnedCount < 0.5,186,187);
        Tree_6_Node_42 := IF ( le.p_NonDerogCount < 9.5,Tree_6_Node_70,167);
        Tree_6_Node_23 := IF ( le.p_CurrAddrAVMValue60 < 193571.5,Tree_6_Node_42,159);
        Tree_6_Node_11 := IF ( le.p_PrevAddrAgeLastSale < 79.5,Tree_6_Node_22,Tree_6_Node_23);
        Tree_6_Node_5 := IF ( le.p_CurrAddrMedianIncome < 38191.5,Tree_6_Node_10,Tree_6_Node_11);
        Tree_6_Node_2 := IF ( le.p_age_in_years < 0.63984376,Tree_6_Node_4,Tree_6_Node_5);
        Tree_6_Node_72 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt12Mo < 0.5,188,189);
        Tree_6_Node_73 := IF ( le.p_PrevAddrAgeNewestRecord < 143.5,190,191);
        Tree_6_Node_44 := IF ( le.p_NonDerogCount06 < 3.5,Tree_6_Node_72,Tree_6_Node_73);
        Tree_6_Node_45 := IF ( le.p_PrevAddrDwellType < 4.0,168,169);
        Tree_6_Node_24 := IF ( le.p_BPV_3 < 2.597053,Tree_6_Node_44,Tree_6_Node_45);
        Tree_6_Node_76 := IF ( le.p_PrevAddrBurglaryIndex < 180.5,192,193);
        Tree_6_Node_77 := IF ( le.p_VariationMSourcesSSNUnrelCount < 2.5,194,195);
        Tree_6_Node_46 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 0.5,Tree_6_Node_76,Tree_6_Node_77);
        Tree_6_Node_78 := IF ( le.p_PrevAddrMedianValue < 299999.5,196,197);
        Tree_6_Node_79 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 3.5,198,199);
        Tree_6_Node_47 := IF ( le.p_PhoneOtherAgeNewestRecord < 52.5,Tree_6_Node_78,Tree_6_Node_79);
        Tree_6_Node_25 := IF ( le.p_BPV_3 < 2.1759093,Tree_6_Node_46,Tree_6_Node_47);
        Tree_6_Node_12 := IF ( le.p_SSNHighIssueAge < 451.0,Tree_6_Node_24,Tree_6_Node_25);
        Tree_6_Node_80 := IF ( le.p_CurrAddrCarTheftIndex < 89.5,200,201);
        Tree_6_Node_81 := IF ( le.p_P_EstimatedHHIncomePerCapita < 2.738889,202,203);
        Tree_6_Node_48 := IF ( le.p_CurrAddrLenOfRes < 633.5,Tree_6_Node_80,Tree_6_Node_81);
        Tree_6_Node_82 := IF ( le.p_PrevAddrDwellType < 3.5,204,205);
        Tree_6_Node_49 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 5.5,Tree_6_Node_82,170);
        Tree_6_Node_26 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_6_Node_48,Tree_6_Node_49);
        Tree_6_Node_84 := IF ( le.p_RelativesBankruptcyCount < 2.5,206,207);
        Tree_6_Node_85 := IF ( le.p_PrevAddrMurderIndex < 19.5,208,209);
        Tree_6_Node_50 := IF ( le.p_v1_ProspectAge < 45.5,Tree_6_Node_84,Tree_6_Node_85);
        Tree_6_Node_86 := IF ( le.p_v1_HHPropCurrAVMHighest < 146013.0,210,211);
        Tree_6_Node_87 := IF ( le.p_CurrAddrAVMValue60 < 207158.5,212,213);
        Tree_6_Node_51 := IF ( le.p_PropAgeNewestPurchase < 32.5,Tree_6_Node_86,Tree_6_Node_87);
        Tree_6_Node_27 := IF ( le.p_LastNameChangeAge < 280.5,Tree_6_Node_50,Tree_6_Node_51);
        Tree_6_Node_13 := IF ( le.p_BPV_3 < 2.0706234,Tree_6_Node_26,Tree_6_Node_27);
        Tree_6_Node_6 := IF ( le.p_EstimatedAnnualIncome < 42522.0,Tree_6_Node_12,Tree_6_Node_13);
        Tree_6_Node_88 := IF ( le.p_RelativesBankruptcyCount < 7.5,214,215);
        Tree_6_Node_89 := IF ( le.p_CurrAddrAVMValue12 < 693051.5,216,217);
        Tree_6_Node_52 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,Tree_6_Node_88,Tree_6_Node_89);
        Tree_6_Node_90 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 4.5,218,219);
        Tree_6_Node_91 := IF ( le.p_CurrAddrAVMValue12 < 233656.5,220,221);
        Tree_6_Node_53 := IF ( le.p_v1_LifeEvEverResidedCnt < 2.5,Tree_6_Node_90,Tree_6_Node_91);
        Tree_6_Node_28 := IF ( le.p_v1_CrtRecLienJudgCnt < 1.5,Tree_6_Node_52,Tree_6_Node_53);
        Tree_6_Node_54 := IF ( le.p_BP_2 < 2.5,171,172);
        Tree_6_Node_95 := IF ( le.p_v1_RaAPropOwnerAVMMed < 176331.5,222,223);
        Tree_6_Node_55 := IF ( le.p_v1_RaAOccBusinessAssocMmbrCnt < 0.5,173,Tree_6_Node_95);
        Tree_6_Node_29 := IF ( le.p_CurrAddrLenOfRes < 25.5,Tree_6_Node_54,Tree_6_Node_55);
        Tree_6_Node_14 := IF ( le.p_BP_3 < 2.5,Tree_6_Node_28,Tree_6_Node_29);
        Tree_6_Node_97 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 153.5,224,225);
        Tree_6_Node_56 := IF ( le.p_DerogSeverityIndex < 3.5,174,Tree_6_Node_97);
        Tree_6_Node_98 := IF ( le.p_age_in_years < 57.6655,226,227);
        Tree_6_Node_57 := IF ( le.p_BP_3 < 10.5,Tree_6_Node_98,175);
        Tree_6_Node_30 := IF ( le.p_PrevAddrMedianValue < 74600.5,Tree_6_Node_56,Tree_6_Node_57);
        Tree_6_Node_31 := IF ( le.p_CurrAddrAgeLastSale < 15.5,160,161);
        Tree_6_Node_15 := IF ( le.p_BPV_2 < 2.9375598,Tree_6_Node_30,Tree_6_Node_31);
        Tree_6_Node_7 := IF ( le.p_BPV_1 < 2.8324845,Tree_6_Node_14,Tree_6_Node_15);
        Tree_6_Node_3 := IF ( le.p_BPV_2 < 1.0100651,Tree_6_Node_6,Tree_6_Node_7);
        Tree_6_Node_1 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.0546875,Tree_6_Node_2,Tree_6_Node_3);
    UNSIGNED2 Score1_Tree6_node := Tree_6_Node_1;
    REAL8 Score1_Tree6_score := CASE(Score1_Tree6_node,152=>-0.06715356,153=>0.025229122,154=>-0.084268056,155=>0.03379049,156=>0.12299394,157=>-0.06535642,158=>0.03281155,159=>0.09611212,160=>0.2105333,161=>0.119773336,162=>-0.102743156,163=>-0.060331013,164=>0.08887089,165=>-0.073782556,166=>-0.0034725019,167=>0.071440175,168=>-0.0060089687,169=>0.1482853,170=>0.16589592,171=>-0.02698918,172=>0.13843979,173=>0.1822372,174=>0.22028281,175=>0.15992348,176=>-0.074567996,177=>-0.02936186,178=>-0.10277849,179=>-0.06824715,180=>-0.029621199,181=>-0.007935102,182=>-0.10558118,183=>-0.10422638,184=>-0.0833292,185=>-0.026440287,186=>0.040901463,187=>-0.08620505,188=>0.0114880875,189=>-0.017345782,190=>-0.020918705,191=>0.12116887,192=>0.02584562,193=>0.05864405,194=>0.010018964,195=>0.07684235,196=>0.08210213,197=>0.2160115,198=>-0.05480703,199=>0.077512816,200=>-0.011072653,201=>0.0074761403,202=>0.026943628,203=>0.29502717,204=>-0.00109111,205=>-0.04540771,206=>-0.10669021,207=>-0.007949334,208=>0.18043984,209=>0.017794866,210=>0.062594794,211=>0.2779015,212=>-0.0657481,213=>0.14993747,214=>0.06474486,215=>0.29793668,216=>0.002306637,217=>0.17060351,218=>0.060113218,219=>-0.094715655,220=>-0.030789247,221=>0.073332354,222=>0.041146863,223=>0.15488203,224=>-0.0324418,225=>0.23165411,226=>0.01874646,227=>0.120732546,0);
ENDMACRO;
