EXPORT Model1_Score1_Tree172_debug(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_172_Node_50 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 12.5,129,130);
        Tree_172_Node_51 := IF ( le.p_v1_CrtRecTimeNewest < 30.0,131,132);
        Tree_172_Node_30 := IF ( le.p_BPV_1 < 4.6853123,Tree_172_Node_50,Tree_172_Node_51);
        Tree_172_Node_52 := IF ( le.p_v1_HHCollegeAttendedMmbrCnt < 0.5,133,134);
        Tree_172_Node_53 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 309.5,135,136);
        Tree_172_Node_31 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 7.5,Tree_172_Node_52,Tree_172_Node_53);
        Tree_172_Node_16 := IF ( le.p_AssocSuspicousIdentitiesCount < 5.5,Tree_172_Node_30,Tree_172_Node_31);
        Tree_172_Node_55 := IF ( le.p_NonDerogCount06 < 4.5,137,138);
        Tree_172_Node_32 := IF ( le.p_LastNameChangeAge < 51.5,118,Tree_172_Node_55);
        Tree_172_Node_33 := IF ( le.p_v1_HHPropCurrAVMHighest < 75009.5,119,120);
        Tree_172_Node_17 := IF ( le.p_v1_RaAHHCnt < 10.5,Tree_172_Node_32,Tree_172_Node_33);
        Tree_172_Node_8 := IF ( le.p_PhoneOtherAgeOldestRecord < 175.5,Tree_172_Node_16,Tree_172_Node_17);
        Tree_172_Node_34 := IF ( le.p_PrevAddrAgeLastSale < 17.5,121,122);
        Tree_172_Node_60 := IF ( le.p_PropOwnedHistoricalCount < 0.5,139,140);
        Tree_172_Node_35 := IF ( le.p_EstimatedAnnualIncome < 46500.5,Tree_172_Node_60,123);
        Tree_172_Node_18 := IF ( le.p_v1_CrtRecTimeNewest < 9.0,Tree_172_Node_34,Tree_172_Node_35);
        Tree_172_Node_62 := IF ( le.p_NonDerogCount12 < 4.5,141,142);
        Tree_172_Node_63 := IF ( le.p_v1_RaAMedIncomeRange < 6.5,143,144);
        Tree_172_Node_37 := IF ( le.p_PrevAddrMedianIncome < 49010.5,Tree_172_Node_62,Tree_172_Node_63);
        Tree_172_Node_19 := IF ( le.p_v1_LifeEvEverResidedCnt < 0.5,111,Tree_172_Node_37);
        Tree_172_Node_9 := IF ( le.p_SearchVelocityRiskLevel < 2.5,Tree_172_Node_18,Tree_172_Node_19);
        Tree_172_Node_4 := IF ( le.p_PhoneOtherAgeOldestRecord < 197.5,Tree_172_Node_8,Tree_172_Node_9);
        Tree_172_Node_10 := IF ( le.p_SSNHighIssueAge < 598.5,107,108);
        Tree_172_Node_65 := IF ( le.p_SSNLowIssueAge < 574.0,145,146);
        Tree_172_Node_39 := IF ( le.p_EstimatedAnnualIncome < 30780.5,124,Tree_172_Node_65);
        Tree_172_Node_22 := IF ( le.p_v1_ProspectTimeOnRecord < 74.5,112,Tree_172_Node_39);
        Tree_172_Node_23 := IF ( le.p_PrevAddrDwellType < 4.0,113,114);
        Tree_172_Node_11 := IF ( le.p_v1_RaAPropOwnerAVMMed < 161328.5,Tree_172_Node_22,Tree_172_Node_23);
        Tree_172_Node_5 := IF ( le.p_v1_RaACrtRecMmbrCnt < 3.0,Tree_172_Node_10,Tree_172_Node_11);
        Tree_172_Node_2 := IF ( le.p_PhoneOtherAgeOldestRecord < 249.5,Tree_172_Node_4,Tree_172_Node_5);
        Tree_172_Node_12 := IF ( le.p_CurrAddrBurglaryIndex < 135.5,109,110);
        Tree_172_Node_6 := IF ( le.p_SubjectPhoneCount < 0.5,Tree_172_Node_12,106);
        Tree_172_Node_26 := IF ( le.p_PhoneEDAAgeOldestRecord < 163.0,115,116);
        Tree_172_Node_45 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 18.0,125,126);
        Tree_172_Node_27 := IF ( le.p_v1_HHPPCurrOwnedCnt < 0.5,117,Tree_172_Node_45);
        Tree_172_Node_14 := IF ( le.p_PrevAddrCarTheftIndex < 63.5,Tree_172_Node_26,Tree_172_Node_27);
        Tree_172_Node_68 := IF ( le.p_DivSSNAddrMSourceCount < 5.5,147,148);
        Tree_172_Node_69 := IF ( le.p_PrevAddrBurglaryIndex < 149.5,149,150);
        Tree_172_Node_46 := IF ( le.p_v1_PropCurrOwnedCnt < 1.5,Tree_172_Node_68,Tree_172_Node_69);
        Tree_172_Node_70 := IF ( le.p_AddrChangeCount60 < 1.5,151,152);
        Tree_172_Node_47 := IF ( le.p_CurrAddrAVMValue60 < 229700.0,Tree_172_Node_70,127);
        Tree_172_Node_28 := IF ( le.p_PrevAddrMedianValue < 187499.5,Tree_172_Node_46,Tree_172_Node_47);
        Tree_172_Node_72 := IF ( le.p_v1_HHCnt < 6.5,153,154);
        Tree_172_Node_73 := IF ( le.p_BPV_2 < 2.8077,155,156);
        Tree_172_Node_48 := IF ( le.p_PrevAddrCarTheftIndex < 19.5,Tree_172_Node_72,Tree_172_Node_73);
        Tree_172_Node_75 := IF ( le.p_SubjectSSNCount < 2.5,157,158);
        Tree_172_Node_49 := IF ( le.p_VariationMSourcesSSNUnrelCount < 0.5,128,Tree_172_Node_75);
        Tree_172_Node_29 := IF ( le.p_SrcsConfirmIDAddrCount < 7.5,Tree_172_Node_48,Tree_172_Node_49);
        Tree_172_Node_15 := IF ( le.p_CurrAddrAgeOldestRecord < 25.5,Tree_172_Node_28,Tree_172_Node_29);
        Tree_172_Node_7 := IF ( le.p_EstimatedAnnualIncome < 24445.5,Tree_172_Node_14,Tree_172_Node_15);
        Tree_172_Node_3 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 144.5,Tree_172_Node_6,Tree_172_Node_7);
        Tree_172_Node_1 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 142.5,Tree_172_Node_2,Tree_172_Node_3);
    SELF.Score1_Tree172_node := Tree_172_Node_1;
    SELF.Score1_Tree172_score := CASE(SELF.Score1_Tree172_node,106=>5.611238E-4,107=>0.01933759,108=>-0.005259408,109=>-0.020108394,110=>-0.020846602,111=>0.03552268,112=>-0.0040727085,113=>0.010076677,114=>-0.011621945,115=>0.0057420847,116=>0.028192652,117=>-0.010900329,118=>0.008257301,119=>-0.0117319245,120=>0.021660851,121=>0.019678922,122=>-0.011867577,123=>-0.012431219,124=>-0.020195251,125=>0.015403783,126=>-0.0015172922,127=>0.011072034,128=>0.01726151,129=>1.8286648E-4,130=>-0.0043119173,131=>0.0017613781,132=>0.015613543,133=>-0.014847183,134=>0.0011621685,135=>-0.0013076096,136=>0.016961271,137=>-0.015470859,138=>5.247383E-5,139=>-0.020720536,140=>-0.020019516,141=>-0.015101001,142=>0.004747103,143=>0.027236138,144=>-0.0075526834,145=>-0.01956861,146=>-0.01990075,147=>-0.0139186485,148=>0.0036383546,149=>0.0065744687,150=>0.037439592,151=>5.5465306E-4,152=>-0.015371008,153=>-0.0011516633,154=>0.016321152,155=>-0.0056133326,156=>0.005687227,157=>-0.0010594393,158=>0.009539925,0);
ENDMACRO;
