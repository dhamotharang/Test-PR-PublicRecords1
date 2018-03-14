﻿EXPORT Model1_Score1_Tree63_debug(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_63_Node_34 := IF ( le.p_PhoneOtherAgeOldestRecord < 11.5,79,80);
        Tree_63_Node_35 := IF ( le.p_VariationDOBCount < 0.5,81,82);
        Tree_63_Node_20 := IF ( le.p_IDVerSSNCreditBureauCount < 1.5,Tree_63_Node_34,Tree_63_Node_35);
        Tree_63_Node_37 := CHOOSE ( le.p_readmit_diag,86,85,86,85,86,85,85,85,85,85,86,85,85);
        Tree_63_Node_36 := IF ( le.p_v1_CrtRecTimeNewest < 123.0,83,84);
        Tree_63_Node_21 := CHOOSE ( le.p_readmit_lift,Tree_63_Node_37,Tree_63_Node_37,Tree_63_Node_36,Tree_63_Node_36,Tree_63_Node_36,Tree_63_Node_36,Tree_63_Node_36,Tree_63_Node_37,Tree_63_Node_36,Tree_63_Node_37,Tree_63_Node_36,Tree_63_Node_36,Tree_63_Node_36);
        Tree_63_Node_12 := IF ( le.p_PhoneOtherAgeOldestRecord < 239.5,Tree_63_Node_20,Tree_63_Node_21);
        Tree_63_Node_39 := CHOOSE ( le.p_readmit_lift,89,89,89,90,89,90,89,89,89,89,89,90,89);
        Tree_63_Node_38 := IF ( le.p_v1_HHPPCurrOwnedAutoCnt < 7.5,87,88);
        Tree_63_Node_22 := CHOOSE ( le.p_readmit_diag,Tree_63_Node_39,Tree_63_Node_38,Tree_63_Node_39,Tree_63_Node_38,Tree_63_Node_38,Tree_63_Node_39,Tree_63_Node_38,Tree_63_Node_38,Tree_63_Node_38,Tree_63_Node_38,Tree_63_Node_38,Tree_63_Node_39,Tree_63_Node_39);
        Tree_63_Node_23 := IF ( le.p_CurrAddrBurglaryIndex < 89.5,72,73);
        Tree_63_Node_13 := IF ( le.p_v1_CrtRecBkrptTimeNewest < 241.5,Tree_63_Node_22,Tree_63_Node_23);
        Tree_63_Node_8 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 1.5,Tree_63_Node_12,Tree_63_Node_13);
        Tree_63_Node_14 := CHOOSE ( le.p_readmit_lift,65,66,65,65,65,66,65,65,65,65,65,65,65);
        Tree_63_Node_9 := IF ( le.p_PrevAddrMedianValue < 125650.5,Tree_63_Node_14,64);
        Tree_63_Node_4 := IF ( le.p_v1_RaACrtRecFelonyMmbrCnt < 8.5,Tree_63_Node_8,Tree_63_Node_9);
        Tree_63_Node_42 := CHOOSE ( le.p_admit_diag,92,92,91,91,92,91,92,92,91,91,91,91,91);
        Tree_63_Node_27 := IF ( le.p_v1_HHCollegeTierMmbrHighest < 3.5,Tree_63_Node_42,74);
        Tree_63_Node_16 := IF ( le.p_EstimatedAnnualIncome < 21562.5,67,Tree_63_Node_27);
        Tree_63_Node_28 := CHOOSE ( le.p_financial_class,75,76,76,76,76,75,76,76,76,76,75,76,76,75,75,75);
        Tree_63_Node_29 := CHOOSE ( le.p_admit_diag,78,78,77,77,77,78,77,77,77,77,77,77,78);
        Tree_63_Node_17 := IF ( le.p_SrcsConfirmIDAddrCount < 4.5,Tree_63_Node_28,Tree_63_Node_29);
        Tree_63_Node_10 := IF ( le.p_v1_PPCurrOwnedAutoCnt < 1.5,Tree_63_Node_16,Tree_63_Node_17);
        Tree_63_Node_19 := IF ( le.p_v1_ProspectEstimatedIncomeRange < 2.5,70,71);
        Tree_63_Node_18 := IF ( le.p_LastNameChangeAge < 182.5,68,69);
        Tree_63_Node_11 := CHOOSE ( le.p_readmit_diag,Tree_63_Node_19,Tree_63_Node_18,Tree_63_Node_19,Tree_63_Node_19,Tree_63_Node_19,Tree_63_Node_18,Tree_63_Node_18,Tree_63_Node_19,Tree_63_Node_18,Tree_63_Node_18,Tree_63_Node_19,Tree_63_Node_19,Tree_63_Node_18);
        Tree_63_Node_5 := IF ( le.p_CurrAddrAVMValue60 < 106444.5,Tree_63_Node_10,Tree_63_Node_11);
        Tree_63_Node_2 := IF ( le.p_PrevAddrMurderIndex < 198.5,Tree_63_Node_4,Tree_63_Node_5);
        Tree_63_Node_3 := CHOOSE ( le.p_admit_diag,63,62,63,62,62,62,62,62,62,62,63,62,62);
        Tree_63_Node_1 := IF ( le.p_PrevAddrMurderIndex < 199.5,Tree_63_Node_2,Tree_63_Node_3);
    SELF.Score1_Tree63_node := Tree_63_Node_1;
    SELF.Score1_Tree63_score := CASE(SELF.Score1_Tree63_node,62=>-0.06387868,63=>-0.0029460911,64=>-0.015792087,65=>-0.062359743,66=>-0.05959205,67=>0.055266265,68=>-0.03752917,69=>0.04254981,70=>0.12937883,71=>0.03462003,72=>0.09044068,73=>-0.006980955,74=>0.053155184,75=>0.025268804,76=>0.108966164,77=>-0.042772762,78=>0.04413528,79=>-0.006082351,80=>-0.028551498,81=>0.019299509,82=>8.731529E-4,83=>-0.06313162,84=>-0.020807132,85=>-0.030391945,86=>0.034977667,87=>-0.014572666,88=>0.03668077,89=>-8.9036906E-4,90=>0.040613994,91=>-0.039169364,92=>-0.002768741,0);
ENDMACRO;
