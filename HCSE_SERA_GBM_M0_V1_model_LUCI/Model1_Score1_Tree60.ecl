EXPORT Model1_Score1_Tree60(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_60_Node_54 := IF ( le.p_BP_4 < 13.5,152,153);
        Tree_60_Node_55 := IF ( le.p_NonDerogCount01 < 2.5,154,155);
        Tree_60_Node_30 := IF ( le.p_BP_2 < 2.5,Tree_60_Node_54,Tree_60_Node_55);
        Tree_60_Node_56 := IF ( le.p_v1_LifeEvTimeFirstAssetPurchase < 31.5,156,157);
        Tree_60_Node_57 := IF ( le.p_v1_RaAPropCurrOwnerMmbrCnt < 4.5,158,159);
        Tree_60_Node_31 := IF ( le.p_AccidentAge < 55.5,Tree_60_Node_56,Tree_60_Node_57);
        Tree_60_Node_16 := IF ( le.p_v1_HHCnt < 7.5,Tree_60_Node_30,Tree_60_Node_31);
        Tree_60_Node_32 := IF ( le.p_v1_ProspectTimeOnRecord < 193.5,138,139);
        Tree_60_Node_60 := IF ( le.p_PrevAddrBurglaryIndex < 9.5,160,161);
        Tree_60_Node_61 := IF ( le.p_CurrAddrAgeLastSale < 95.5,162,163);
        Tree_60_Node_33 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt12Mo < 1.5,Tree_60_Node_60,Tree_60_Node_61);
        Tree_60_Node_17 := IF ( le.p_VariationMSourcesSSNUnrelCount < 0.5,Tree_60_Node_32,Tree_60_Node_33);
        Tree_60_Node_8 := IF ( le.p_v1_HHCrtRecMsdmeanMmbrCnt < 3.5,Tree_60_Node_16,Tree_60_Node_17);
        Tree_60_Node_62 := IF ( le.p_AddrChangeCount60 < 6.5,164,165);
        Tree_60_Node_63 := IF ( le.p_BP_3 < 1.5,166,167);
        Tree_60_Node_34 := IF ( le.p_CurrAddrCarTheftIndex < 140.5,Tree_60_Node_62,Tree_60_Node_63);
        Tree_60_Node_64 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 307029.5,168,169);
        Tree_60_Node_35 := IF ( le.p_CurrAddrAgeOldestRecord < 252.5,Tree_60_Node_64,140);
        Tree_60_Node_18 := IF ( le.p_PrevAddrCrimeIndex < 190.5,Tree_60_Node_34,Tree_60_Node_35);
        Tree_60_Node_19 := IF ( le.p_v1_HHEstimatedIncomeRange < 3.5,131,132);
        Tree_60_Node_9 := IF ( le.p_v1_HHPPCurrOwnedCnt < 6.5,Tree_60_Node_18,Tree_60_Node_19);
        Tree_60_Node_4 := IF ( le.p_EvictionAge < 49.5,Tree_60_Node_8,Tree_60_Node_9);
        Tree_60_Node_66 := IF ( le.p_PrevAddrMedianIncome < 47999.5,170,171);
        Tree_60_Node_67 := IF ( le.p_v1_ProspectAge < 72.5,172,173);
        Tree_60_Node_38 := IF ( le.p_SrcsConfirmIDAddrCount < 6.5,Tree_60_Node_66,Tree_60_Node_67);
        Tree_60_Node_69 := IF ( le.p_PrevAddrAgeLastSale < 89.5,174,175);
        Tree_60_Node_39 := IF ( le.p_EstimatedAnnualIncome < 26250.5,141,Tree_60_Node_69);
        Tree_60_Node_20 := IF ( le.p_CurrAddrMedianIncome < 56900.5,Tree_60_Node_38,Tree_60_Node_39);
        Tree_60_Node_10 := IF ( le.p_SubjectLastNameCount < 7.5,Tree_60_Node_20,129);
        Tree_60_Node_70 := IF ( le.p_SSNHighIssueAge < 750.5,176,177);
        Tree_60_Node_71 := IF ( le.p_LienReleasedAge < 207.5,178,179);
        Tree_60_Node_40 := IF ( le.p_PropAgeNewestPurchase < 159.5,Tree_60_Node_70,Tree_60_Node_71);
        Tree_60_Node_41 := IF ( le.p_PhoneOtherAgeOldestRecord < 112.0,142,143);
        Tree_60_Node_22 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 254.5,Tree_60_Node_40,Tree_60_Node_41);
        Tree_60_Node_74 := IF ( le.p_P_EstimatedHHIncomePerCapita < 0.6,180,181);
        Tree_60_Node_75 := IF ( le.p_RelativesPropOwnedCount < 2.5,182,183);
        Tree_60_Node_42 := IF ( le.p_age_in_years < 74.40063,Tree_60_Node_74,Tree_60_Node_75);
        Tree_60_Node_23 := IF ( le.p_CurrAddrMedianIncome < 102544.5,Tree_60_Node_42,133);
        Tree_60_Node_11 := IF ( le.p_PrevAddrAgeOldestRecord < 293.0,Tree_60_Node_22,Tree_60_Node_23);
        Tree_60_Node_5 := IF ( le.p_EstimatedAnnualIncome < 30422.5,Tree_60_Node_10,Tree_60_Node_11);
        Tree_60_Node_2 := IF ( le.p_LienReleasedAge < 81.5,Tree_60_Node_4,Tree_60_Node_5);
        Tree_60_Node_76 := IF ( le.p_EstimatedAnnualIncome < 38150.5,184,185);
        Tree_60_Node_77 := IF ( le.p_v1_CrtRecLienJudgCnt < 1.5,186,187);
        Tree_60_Node_44 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,Tree_60_Node_76,Tree_60_Node_77);
        Tree_60_Node_45 := IF ( le.p_PrevAddrCrimeIndex < 59.5,144,145);
        Tree_60_Node_24 := IF ( le.p_SearchVelocityRiskLevel < 5.5,Tree_60_Node_44,Tree_60_Node_45);
        Tree_60_Node_12 := IF ( le.p_SSNAddrCount < 25.5,Tree_60_Node_24,130);
        Tree_60_Node_6 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 127.5,Tree_60_Node_12,128);
        Tree_60_Node_46 := IF ( le.p_age_in_years < 67.68,146,147);
        Tree_60_Node_26 := IF ( le.p_PrevAddrAgeLastSale < 102.5,Tree_60_Node_46,134);
        Tree_60_Node_27 := IF ( le.p_v1_CrtRecTimeNewest < 99.5,135,136);
        Tree_60_Node_14 := IF ( le.p_SSNAddrCount < 14.5,Tree_60_Node_26,Tree_60_Node_27);
        Tree_60_Node_50 := IF ( le.p_CurrAddrBurglaryIndex < 89.5,148,149);
        Tree_60_Node_51 := IF ( le.p_CurrAddrBurglaryIndex < 39.5,150,151);
        Tree_60_Node_28 := IF ( le.p_AssocSuspicousIdentitiesCount < 1.5,Tree_60_Node_50,Tree_60_Node_51);
        Tree_60_Node_86 := IF ( le.p_RelativesBankruptcyCount < 1.5,188,189);
        Tree_60_Node_87 := IF ( le.p_SSNHighIssueAge < 631.5,190,191);
        Tree_60_Node_53 := IF ( le.p_PhoneEDAAgeNewestRecord < 8.5,Tree_60_Node_86,Tree_60_Node_87);
        Tree_60_Node_29 := IF ( le.p_v1_ProspectAge < 49.5,137,Tree_60_Node_53);
        Tree_60_Node_15 := IF ( le.p_PrevAddrBurglaryIndex < 87.5,Tree_60_Node_28,Tree_60_Node_29);
        Tree_60_Node_7 := IF ( le.p_LienReleasedAge < 247.5,Tree_60_Node_14,Tree_60_Node_15);
        Tree_60_Node_3 := CHOOSE ( le.p_gender,Tree_60_Node_6,Tree_60_Node_7);
        Tree_60_Node_1 := IF ( le.p_LienReleasedAge < 220.5,Tree_60_Node_2,Tree_60_Node_3);
    UNSIGNED2 Score1_Tree60_node := Tree_60_Node_1;
    REAL8 Score1_Tree60_score := CASE(Score1_Tree60_node,128=>0.017766697,129=>0.10786394,130=>0.028209737,131=>0.0027002057,132=>0.09772627,133=>0.030932395,134=>-0.029115701,135=>-0.038959533,136=>0.031638943,137=>0.06833377,138=>0.13064007,139=>-0.014107422,140=>0.06950173,141=>-0.064741135,142=>-0.015688889,143=>0.15712203,144=>0.03185328,145=>-0.042849608,146=>-0.062522784,147=>-0.06473846,148=>0.04179769,149=>0.11218869,150=>0.04399297,151=>-0.042211793,152=>0.0013930687,153=>-0.002128492,154=>-0.017415525,155=>0.022582922,156=>0.016206348,157=>-0.019965004,158=>0.0014382937,159=>0.09302094,160=>0.009348493,161=>-0.019294862,162=>0.06322726,163=>-0.026823228,164=>-0.022216529,165=>0.020962398,166=>-0.0060478225,167=>0.049096137,168=>-0.00845034,169=>0.06386222,170=>0.019480962,171=>0.062957436,172=>-0.048470296,173=>0.027059568,174=>-0.025613733,175=>0.03655445,176=>0.005505769,177=>0.06753336,178=>-0.018233314,179=>0.06441639,180=>-0.0017832855,181=>-0.056007557,182=>-0.031365562,183=>0.055485882,184=>-0.065198965,185=>-0.06242414,186=>-0.030946525,187=>-0.06266092,188=>-0.035330664,189=>0.022271698,190=>-0.062345773,191=>-0.063890696,0);
ENDMACRO;
