EXPORT Model1_Score1_Tree26(p_PHONEOTHERAGEOLDESTRECORD,p_PHONEEDAAGENEWESTRECORD,p_RELATIVESPROPOWNEDTAXTOTAL,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_RAAELDERLYMMBRCNT,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_CURRADDRTAXMARKETVALUE,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_PREVADDRAGEOLDESTRECORD,p_V1_PROPSOLDCNT12MO,p_ESTIMATEDANNUALINCOME,p_V1_HHPPCURROWNEDCNT,p_PREVADDRCARTHEFTINDEX,p_SSNADDRRECENTCOUNT,p_LIENFILEDCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_CURRADDRBURGLARYINDEX,p_V1_CRTRECLIENJUDGCNT,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_HHCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_RECENTACTIVITYINDEX,p_DIVSSNIDENTITYMSOURCECOUNT,p_CURRADDRLENOFRES,p_V1_RAAHHCNT,p_ARRESTCOUNT24,p_V1_RAACRTRECMMBRCNT,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_HHCRTRECFELONYMMBRCNT,p_VARIATIONMSOURCESSSNCOUNT,p_V1_RAACRTRECEVICTIONMMBRCNT12MO,p_V1_CRTRECFELONYCNT,p_CURRADDRAVMVALUE60,p_V1_CRTRECLIENJUDGTIMENEWEST,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_CRTRECTIMENEWEST,p_V1_RAAMIDDLEAGEMMBRCNT,p_CURRADDRTRACTINDEX,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SOURCERISKLEVEL,p_SSNLOWISSUEAGE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_V1_RAAMEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_CURRADDRAGELASTSALE,p_V1_PROPSOLDRATIO,p_V1_CRTRECBKRPTTIMENEWEST,p_NONDEROGCOUNT03,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_NONDEROGCOUNT01,p_V1_HHCRTRECBKRPTMMBRCNT,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHPROPCURRAVMHIGHEST,p_FELONYCOUNT,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_NONDEROGCOUNT06,p_DEROGSEVERITYINDEX,p_CURRADDRAVMVALUE12,p_PROPAGENEWESTPURCHASE,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_V1_PROPCURROWNEDCNT,p_CURRADDRCARTHEFTINDEX,p_RELATIVESFELONYCOUNT,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_V1_HHCRTRECMSDMEANMMBRCNT12MO,p_V1_PPCURROWNEDAUTOCNT,p_GENDER,p_PHONEEDAAGEOLDESTRECORD,p_V1_CRTRECMSDMEANCNT,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_SEARCHVELOCITYRISKLEVEL,p_PRSEARCHLOCATECOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_DEROGAGE,p_NONDEROGCOUNT24,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_26_Node_52 := IF ( le.p_ArrestCount24 < 0.5,157,158);
        Tree_26_Node_53 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 5.5,159,160);
        Tree_26_Node_32 := IF ( le.p_PrevAddrBurglaryIndex < 170.5,Tree_26_Node_52,Tree_26_Node_53);
        Tree_26_Node_54 := IF ( le.p_PrevAddrLenOfRes < 8.5,161,162);
        Tree_26_Node_33 := IF ( le.p_v1_ProspectTimeOnRecord < 197.0,Tree_26_Node_54,151);
        Tree_26_Node_16 := IF ( le.p_RelativesCount < 32.5,Tree_26_Node_32,Tree_26_Node_33);
        Tree_26_Node_56 := IF ( le.p_SearchSSNSearchCount < 7.5,163,164);
        Tree_26_Node_34 := IF ( le.p_LienReleasedAge < 111.5,Tree_26_Node_56,152);
        Tree_26_Node_17 := IF ( le.p_v1_CrtRecTimeNewest < 195.5,Tree_26_Node_34,148);
        Tree_26_Node_8 := IF ( le.p_PrevAddrLenOfRes < 184.5,Tree_26_Node_16,Tree_26_Node_17);
        Tree_26_Node_58 := IF ( le.p_AddrChangeCount24 < 1.5,165,166);
        Tree_26_Node_59 := IF ( le.p_PrevAddrAgeOldestRecord < 262.5,167,168);
        Tree_26_Node_36 := IF ( le.p_PrevAddrDwellType < 3.5,Tree_26_Node_58,Tree_26_Node_59);
        Tree_26_Node_60 := IF ( le.p_CurrAddrBurglaryIndex < 151.0,169,170);
        Tree_26_Node_37 := IF ( le.p_PhoneEDAAgeNewestRecord < 59.5,Tree_26_Node_60,153);
        Tree_26_Node_18 := IF ( le.p_BP_2 < 1.5,Tree_26_Node_36,Tree_26_Node_37);
        Tree_26_Node_9 := IF ( le.p_PrevAddrAgeNewestRecord < 101.0,Tree_26_Node_18,142);
        Tree_26_Node_4 := IF ( le.p_CurrAddrCarTheftIndex < 128.5,Tree_26_Node_8,Tree_26_Node_9);
        Tree_26_Node_62 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 8.5,171,172);
        Tree_26_Node_63 := IF ( le.p_PhoneEDAAgeOldestRecord < 165.5,173,174);
        Tree_26_Node_38 := IF ( le.p_PhoneEDAAgeOldestRecord < 19.5,Tree_26_Node_62,Tree_26_Node_63);
        Tree_26_Node_20 := IF ( le.p_BPV_2 < 1.0946875,Tree_26_Node_38,149);
        Tree_26_Node_65 := IF ( le.p_PrevAddrBurglaryIndex < 159.5,175,176);
        Tree_26_Node_41 := IF ( le.p_PRSearchOtherCount < 1.5,154,Tree_26_Node_65);
        Tree_26_Node_21 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 0.5,150,Tree_26_Node_41);
        Tree_26_Node_10 := IF ( le.p_PrevAddrAgeLastSale < 111.5,Tree_26_Node_20,Tree_26_Node_21);
        Tree_26_Node_11 := IF ( le.p_v1_RaASeniorMmbrCnt < 0.5,143,144);
        Tree_26_Node_5 := IF ( le.p_CurrAddrMedianIncome < 53468.5,Tree_26_Node_10,Tree_26_Node_11);
        Tree_26_Node_2 := IF ( le.p_CurrAddrBurglaryIndex < 187.0,Tree_26_Node_4,Tree_26_Node_5);
        Tree_26_Node_66 := IF ( le.p_v1_RaACrtRecLienJudgMmbrCnt < 5.5,177,178);
        Tree_26_Node_67 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 198610.5,179,180);
        Tree_26_Node_42 := IF ( le.p_v1_RaACrtRecMmbrCnt12Mo < 2.5,Tree_26_Node_66,Tree_26_Node_67);
        Tree_26_Node_68 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 226.5,181,182);
        Tree_26_Node_43 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 3.5,Tree_26_Node_68,155);
        Tree_26_Node_24 := IF ( le.p_PrevAddrAgeOldestRecord < 239.5,Tree_26_Node_42,Tree_26_Node_43);
        Tree_26_Node_70 := IF ( le.p_v1_RaAHHCnt < 1.5,183,184);
        Tree_26_Node_71 := IF ( le.p_PhoneOtherAgeOldestRecord < 54.5,185,186);
        Tree_26_Node_44 := IF ( le.p_CurrAddrMurderIndex < 169.5,Tree_26_Node_70,Tree_26_Node_71);
        Tree_26_Node_72 := IF ( le.p_PhoneEDAAgeOldestRecord < 183.5,187,188);
        Tree_26_Node_73 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 1.5,189,190);
        Tree_26_Node_45 := IF ( le.p_P_EstimatedHHIncomePerCapita < 1.296875,Tree_26_Node_72,Tree_26_Node_73);
        Tree_26_Node_25 := IF ( le.p_v1_ProspectTimeOnRecord < 223.5,Tree_26_Node_44,Tree_26_Node_45);
        Tree_26_Node_12 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 234374.5,Tree_26_Node_24,Tree_26_Node_25);
        Tree_26_Node_74 := IF ( le.p_v1_RaACrtRecEvictionMmbrCnt < 0.5,191,192);
        Tree_26_Node_75 := IF ( le.p_SSNIssueState < 14.5,193,194);
        Tree_26_Node_46 := IF ( le.p_LienReleasedAge < 226.5,Tree_26_Node_74,Tree_26_Node_75);
        Tree_26_Node_76 := IF ( le.p_SrcsConfirmIDAddrCount < 4.5,195,196);
        Tree_26_Node_77 := IF ( le.p_CurrAddrCarTheftIndex < 150.5,197,198);
        Tree_26_Node_47 := IF ( le.p_v1_ProspectAge < 75.5,Tree_26_Node_76,Tree_26_Node_77);
        Tree_26_Node_26 := CHOOSE ( le.p_gender,Tree_26_Node_46,Tree_26_Node_47);
        Tree_26_Node_78 := IF ( le.p_VariationDOBCount < 3.5,199,200);
        Tree_26_Node_48 := IF ( le.p_PrevAddrMurderIndex < 159.5,Tree_26_Node_78,156);
        Tree_26_Node_80 := IF ( le.p_SrcsConfirmIDAddrCount < 7.5,201,202);
        Tree_26_Node_81 := IF ( le.p_NonDerogCount12 < 3.5,203,204);
        Tree_26_Node_49 := IF ( le.p_v1_HHEstimatedIncomeRange < 4.5,Tree_26_Node_80,Tree_26_Node_81);
        Tree_26_Node_27 := IF ( le.p_EstimatedAnnualIncome < 30656.5,Tree_26_Node_48,Tree_26_Node_49);
        Tree_26_Node_13 := IF ( le.p_PrevAddrAgeOldestRecord < 504.5,Tree_26_Node_26,Tree_26_Node_27);
        Tree_26_Node_6 := IF ( le.p_EstimatedAnnualIncome < 25582.5,Tree_26_Node_12,Tree_26_Node_13);
        Tree_26_Node_82 := IF ( le.p_RecentActivityIndex < 1.5,205,206);
        Tree_26_Node_83 := IF ( le.p_VariationDOBCount < 3.5,207,208);
        Tree_26_Node_50 := IF ( le.p_PrevAddrCrimeIndex < 180.5,Tree_26_Node_82,Tree_26_Node_83);
        Tree_26_Node_84 := IF ( le.p_SSNAddrCount < 19.5,209,210);
        Tree_26_Node_85 := IF ( le.p_v1_CrtRecLienJudgTimeNewest < 146.5,211,212);
        Tree_26_Node_51 := IF ( le.p_PrevAddrMurderIndex < 139.5,Tree_26_Node_84,Tree_26_Node_85);
        Tree_26_Node_28 := IF ( le.p_DerogAge < 122.5,Tree_26_Node_50,Tree_26_Node_51);
        Tree_26_Node_14 := IF ( le.p_LienFiledAge < 227.5,Tree_26_Node_28,145);
        Tree_26_Node_15 := IF ( le.p_PhoneOtherAgeNewestRecord < 7.5,146,147);
        Tree_26_Node_7 := IF ( le.p_v1_CrtRecCnt < 99.5,Tree_26_Node_14,Tree_26_Node_15);
        Tree_26_Node_3 := IF ( le.p_BPV_1 < 2.4171953,Tree_26_Node_6,Tree_26_Node_7);
        Tree_26_Node_1 := IF ( le.p_age_in_years < 43.296093,Tree_26_Node_2,Tree_26_Node_3);
    UNSIGNED2 Score1_Tree26_node := Tree_26_Node_1;
    REAL8 Score1_Tree26_score := CASE(Score1_Tree26_node,142=>0.15295675,143=>0.14336413,144=>-0.064925075,145=>-0.078575134,146=>-0.09598256,147=>-0.009388108,148=>0.05559698,149=>-0.092626445,150=>0.08989978,151=>-0.019641709,152=>0.045870174,153=>-0.027937802,154=>0.024845118,155=>0.09458662,156=>0.09227991,157=>-0.017922979,158=>0.025568718,159=>-2.2218915E-4,160=>0.09114453,161=>-0.08959861,162=>-0.08666564,163=>-0.05585842,164=>0.022597758,165=>0.03977469,166=>-0.033338025,167=>-0.009492705,168=>0.0940034,169=>0.09432282,170=>0.015955765,171=>-0.061219234,172=>0.011958563,173=>-0.086523816,174=>-0.051516548,175=>-0.08863889,176=>-0.0559446,177=>0.006013119,178=>0.07008901,179=>0.030667357,180=>0.17069629,181=>-0.012126912,182=>0.10227797,183=>0.14005576,184=>0.020716585,185=>0.18938655,186=>0.022183768,187=>0.0045888294,188=>0.099879526,189=>-0.09190829,190=>-0.026362184,191=>-0.0044943513,192=>0.004463263,193=>0.036357433,194=>-0.05721217,195=>0.009497691,196=>-0.0030594456,197=>0.016396863,198=>-0.0121294595,199=>-0.023172984,200=>0.06831037,201=>-0.08884644,202=>-0.009832827,203=>0.020967318,204=>-0.028996697,205=>-0.019491185,206=>0.035379067,207=>-0.062942736,208=>0.00917174,209=>0.009820147,210=>0.081624046,211=>0.037567336,212=>0.1445565,0);
ENDMACRO;
