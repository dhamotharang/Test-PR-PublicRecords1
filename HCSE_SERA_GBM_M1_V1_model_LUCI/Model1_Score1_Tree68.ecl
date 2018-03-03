﻿EXPORT Model1_Score1_Tree68(p_PHONEEDAAGENEWESTRECORD,p_PHONEOTHERAGEOLDESTRECORD,p_V1_RAASENIORMMBRCNT,p_ADDRCHANGECOUNT24,p_V1_PROSPECTAGE,p_V1_RAACRTRECEVICTIONMMBRCNT,p_SSNISSUESTATE,p_SSNIDENTITIESCOUNT,p_V1_RAACRTRECLIENJUDGAMTMAX,p_V1_HHCOLLEGETIERMMBRHIGHEST,p_VARIATIONDOBCOUNT,p_LIENFILEDAGE,p_PREVADDRAGENEWESTRECORD,p_SSNHIGHISSUEAGE,p_V1_CRTRECCNT,p_PROPAGENEWESTSALE,p_PROPAGEOLDESTPURCHASE,p_PREVADDRMEDIANVALUE,p_SUBJECTSSNCOUNT,p_SUBJECTPHONECOUNT,p_CURRADDRCRIMEINDEX,p_FINANCIAL_CLASS,p_PREVADDRAGEOLDESTRECORD,p_ESTIMATEDANNUALINCOME,p_PREVADDRCARTHEFTINDEX,p_V1_HHPPCURROWNEDCNT,p_SSNADDRRECENTCOUNT,p_V1_CRTRECMSDMEANTIMENEWEST,p_SUBJECTADDRCOUNT,p_V1_PROPCURROWNEDAVMTTL,p_V1_RAAYOUNGADULTMMBRCNT,p_PREVADDRAGELASTSALE,p_LIENRELEASEDAGE,p_PHONEOTHERAGENEWESTRECORD,p_READMIT_LIFT,p_EVICTIONAGE,p_V1_CRTRECCNT12MO,p_CURRADDRAGEOLDESTRECORD,p_AGE_IN_YEARS,p_STATUSMOSTRECENT,p_V1_CRTRECLIENJUDGCNT,p_CURRADDRBURGLARYINDEX,p_V1_RAAPROPOWNERAVMHIGHEST,p_SSNADDRCOUNT,p_IDVERSSNCREDITBUREAUCOUNT,p_P_ESTIMATEDHHINCOMEPERCAPITA,p_V1_HHCNT,p_CURRADDRCOUNTYINDEX,p_V1_RAACRTRECFELONYMMBRCNT,p_V1_RAACOLLEGEATTENDEDMMBRCNT,p_PRSEARCHLOCATECOUNT,p_V1_RAAPROPOWNERAVMMED,p_DIVSSNIDENTITYMSOURCECOUNT,p_RECENTACTIVITYINDEX,p_CURRADDRLENOFRES,p_PRSEARCHOTHERCOUNT,p_CURRADDRMEDIANVALUE,p_V1_CRTRECLIENJUDGTIMENEWEST,p_WEALTHINDEX,p_CURRADDRAVMVALUE60,p_NONDEROGCOUNT60,p_V1_HHCRTRECLIENJUDGMMBRCNT,p_V1_LIFEEVTIMELASTASSETPURCHASE,p_PREVADDRLENOFRES,p_V1_RAAMIDDLEAGEMMBRCNT,p_V1_CRTRECTIMENEWEST,p_DIVSSNADDRMSOURCECOUNT,p_DIVSSNIDENTITYMSOURCEURELCOUNT,p_CURRADDRMEDIANINCOME,p_CURRADDRBLOCKINDEX,p_V1_RAACOLLEGELOWTIERMMBRCNT,p_CURRADDRMURDERINDEX,p_V1_RAACRTRECMMBRCNT12MO,p_V1_PROPTIMELASTSALE,p_V1_HHCRTRECMMBRCNT,p_VARIATIONMSOURCESSSNUNRELCOUNT,p_RELATIVESPROPOWNEDCOUNT,p_SSNLOWISSUEAGE,p_PATIENT_TYPE,p_V1_HHPROPCURROWNEDCNT,p_BP_4,p_ADDRCHANGECOUNT60,p_BP_3,p_BP_2,p_BP_1,p_V1_LIFEEVTIMEFIRSTASSETPURCHASE,p_PREVADDRBURGLARYINDEX,p_V1_HHCRTRECMSDMEANMMBRCNT,p_PROPOWNEDHISTORICALCOUNT,p_V1_HHESTIMATEDINCOMERANGE,p_ASSOCSUSPICOUSIDENTITIESCOUNT,p_V1_RAAMEDINCOMERANGE,p_CURRADDRAGELASTSALE,p_V1_CRTRECBKRPTTIMENEWEST,p_V1_PROSPECTESTIMATEDINCOMERANGE,p_ACCIDENTAGE,p_ADDRSTABILITY,p_NONDEROGCOUNT01,p_RELATIVESCOUNT,p_BPV_4,p_BPV_3,p_V1_RAACRTRECMSDMEANMMBRCNT,p_BPV_2,p_SUBJECTLASTNAMECOUNT,p_BPV_1,p_V1_HHMIDDLEAGEMMBRCNT,p_V1_HHCOLLEGEATTENDEDMMBRCNT,p_FELONYCOUNT,p_NONDEROGCOUNT06,p_PROPAGENEWESTPURCHASE,p_CURRADDRAVMVALUE12,p_V1_CRTRECMSDMEANCNT12MO,p_PREVADDRMURDERINDEX,p_V1_PROSPECTMARITALSTATUS,p_IDENTITYRISKLEVEL,p_PRSEARCHOTHERCOUNT24,p_V1_RAACRTRECLIENJUDGMMBRCNT,p_RELATIVESBANKRUPTCYCOUNT,p_CURRADDRCARTHEFTINDEX,p_PREVADDRCRIMEINDEX,p_NONDEROGCOUNT12,p_ADMIT_DIAG,p_V1_PPCURROWNEDAUTOCNT,p_READMIT_DIAG,p_GENDER,p_V1_CRTRECMSDMEANCNT,p_PHONEEDAAGEOLDESTRECORD,p_PREVADDRDWELLTYPE,p_V1_LIFEEVEVERRESIDEDCNT,p_V1_HHSENIORMMBRCNT,p_V1_PROSPECTTIMEONRECORD,p_ASSOCRISKLEVEL,p_SRCSCONFIRMIDADDRCOUNT,p_SEARCHSSNSEARCHCOUNT,p_V1_PROSPECTTIMELASTUPDATE,p_DEROGAGE,p_NONDEROGCOUNT24,p_V1_RAAOCCBUSINESSASSOCMMBRCNT,p_PREVADDRMEDIANINCOME,p_AGEOLDESTRECORD,p_V1_HHPPCURROWNEDAUTOCNT,p_V1_RAAPPCURROWNERMMBRCNT,p_NONDEROGCOUNT,p_LASTNAMECHANGEAGE,p_SEARCHUNVERIFIEDSSNCOUNTYEAR,p_V1_RAAPROPCURROWNERMMBRCNT) := MACRO

        Tree_68_Node_46 := IF ( le.p_PrevAddrMedianValue < 854427.5,99,100);
        Tree_68_Node_47 := IF ( le.p_PhoneEDAAgeNewestRecord < 9.5,101,102);
        Tree_68_Node_28 := IF ( le.p_SSNIssueState < 22.5,Tree_68_Node_46,Tree_68_Node_47);
        Tree_68_Node_49 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 208.0,105,106);
        Tree_68_Node_48 := IF ( le.p_P_EstimatedHHIncomePerCapita < 4.25,103,104);
        Tree_68_Node_29 := CHOOSE ( le.p_admit_diag,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_48,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_49,Tree_68_Node_48,Tree_68_Node_49);
        Tree_68_Node_16 := IF ( le.p_NonDerogCount01 < 4.5,Tree_68_Node_28,Tree_68_Node_29);
        Tree_68_Node_50 := CHOOSE ( le.p_readmit_diag,107,107,107,107,108,108,107,107,107,107,107,107,108);
        Tree_68_Node_30 := IF ( le.p_v1_RaACrtRecMsdmeanMmbrCnt < 11.5,Tree_68_Node_50,94);
        Tree_68_Node_31 := IF ( le.p_RecentActivityIndex < 1.5,95,96);
        Tree_68_Node_17 := CHOOSE ( le.p_admit_diag,Tree_68_Node_30,Tree_68_Node_30,Tree_68_Node_30,Tree_68_Node_30,Tree_68_Node_30,Tree_68_Node_31,Tree_68_Node_30,Tree_68_Node_31,Tree_68_Node_31,Tree_68_Node_30,Tree_68_Node_31,Tree_68_Node_30,Tree_68_Node_31);
        Tree_68_Node_8 := IF ( le.p_v1_CrtRecMsdmeanTimeNewest < 378.5,Tree_68_Node_16,Tree_68_Node_17);
        Tree_68_Node_18 := CHOOSE ( le.p_readmit_lift,83,84,83,83,83,83,83,83,83,83,83,83,83);
        Tree_68_Node_9 := CHOOSE ( le.p_admit_diag,Tree_68_Node_18,80,Tree_68_Node_18,80,Tree_68_Node_18,Tree_68_Node_18,Tree_68_Node_18,Tree_68_Node_18,Tree_68_Node_18,Tree_68_Node_18,Tree_68_Node_18,Tree_68_Node_18,Tree_68_Node_18);
        Tree_68_Node_4 := IF ( le.p_CurrAddrMedianValue < 843750.5,Tree_68_Node_8,Tree_68_Node_9);
        Tree_68_Node_5 := CHOOSE ( le.p_readmit_diag,79,78,78,78,78,78,78,79,78,79,79,79,79);
        Tree_68_Node_2 := IF ( le.p_v1_ProspectAge < 93.0,Tree_68_Node_4,Tree_68_Node_5);
        Tree_68_Node_55 := IF ( le.p_CurrAddrMurderIndex < 170.5,111,112);
        Tree_68_Node_54 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 120376.5,109,110);
        Tree_68_Node_34 := CHOOSE ( le.p_admit_diag,Tree_68_Node_55,Tree_68_Node_54,Tree_68_Node_55,Tree_68_Node_54,Tree_68_Node_55,Tree_68_Node_55,Tree_68_Node_54,Tree_68_Node_55,Tree_68_Node_55,Tree_68_Node_54,Tree_68_Node_54,Tree_68_Node_54,Tree_68_Node_54);
        Tree_68_Node_20 := IF ( le.p_PhoneOtherAgeNewestRecord < 119.0,Tree_68_Node_34,85);
        Tree_68_Node_12 := IF ( le.p_v1_RaAPropOwnerAVMHighest < 822786.0,Tree_68_Node_20,81);
        Tree_68_Node_22 := CHOOSE ( le.p_admit_diag,87,87,86,86,87,86,86,86,86,86,86,86,86);
        Tree_68_Node_23 := IF ( le.p_SSNHighIssueAge < 782.5,88,89);
        Tree_68_Node_13 := IF ( le.p_v1_RaACollegeAttendedMmbrCnt < 1.5,Tree_68_Node_22,Tree_68_Node_23);
        Tree_68_Node_6 := IF ( le.p_v1_RaAMiddleAgeMmbrCnt < 3.5,Tree_68_Node_12,Tree_68_Node_13);
        Tree_68_Node_58 := IF ( le.p_PrevAddrAgeOldestRecord < 169.0,115,116);
        Tree_68_Node_41 := IF ( le.p_NonDerogCount < 8.5,Tree_68_Node_58,98);
        Tree_68_Node_56 := IF ( le.p_CurrAddrAVMValue60 < 75878.5,113,114);
        Tree_68_Node_40 := IF ( le.p_PRSearchOtherCount < 0.5,Tree_68_Node_56,97);
        Tree_68_Node_24 := CHOOSE ( le.p_readmit_diag,Tree_68_Node_41,Tree_68_Node_41,Tree_68_Node_40,Tree_68_Node_40,Tree_68_Node_41,Tree_68_Node_40,Tree_68_Node_40,Tree_68_Node_41,Tree_68_Node_40,Tree_68_Node_40,Tree_68_Node_40,Tree_68_Node_40,Tree_68_Node_40);
        Tree_68_Node_25 := IF ( le.p_age_in_years < 95.72719,90,91);
        Tree_68_Node_14 := CHOOSE ( le.p_admit_diag,Tree_68_Node_24,Tree_68_Node_25,Tree_68_Node_24,Tree_68_Node_24,Tree_68_Node_24,Tree_68_Node_24,Tree_68_Node_25,Tree_68_Node_25,Tree_68_Node_25,Tree_68_Node_24,Tree_68_Node_24,Tree_68_Node_25,Tree_68_Node_24);
        Tree_68_Node_27 := IF ( le.p_PrevAddrLenOfRes < 351.5,92,93);
        Tree_68_Node_15 := CHOOSE ( le.p_admit_diag,Tree_68_Node_27,82,82,Tree_68_Node_27,Tree_68_Node_27,82,Tree_68_Node_27,82,82,82,Tree_68_Node_27,82,Tree_68_Node_27);
        Tree_68_Node_7 := IF ( le.p_v1_LifeEvTimeLastAssetPurchase < 20.5,Tree_68_Node_14,Tree_68_Node_15);
        Tree_68_Node_3 := IF ( le.p_AgeOldestRecord < 501.0,Tree_68_Node_6,Tree_68_Node_7);
        Tree_68_Node_1 := IF ( le.p_age_in_years < 93.09727,Tree_68_Node_2,Tree_68_Node_3);
    UNSIGNED2 Score1_Tree68_node := Tree_68_Node_1;
    REAL8 Score1_Tree68_score := CASE(Score1_Tree68_node,78=>-4.0478952E-4,79=>0.07926479,80=>-0.009585113,81=>0.048973773,82=>0.005201082,83=>-0.05895931,84=>-0.054871872,85=>0.02476312,86=>-0.004930217,87=>0.093313366,88=>0.009892718,89=>-0.058815427,90=>-0.0033279974,91=>0.0839393,92=>0.0956653,93=>0.04253577,94=>0.016666278,95=>0.0678978,96=>-0.046081275,97=>-0.027987402,98=>0.05173446,99=>-0.0035954926,100=>0.061203286,101=>0.0028421462,102=>-0.0012828059,103=>-0.038994968,104=>0.029577874,105=>-0.0017599029,106=>-0.021224026,107=>-0.03407798,108=>0.012967412,109=>-0.03326706,110=>-0.05419167,111=>-0.02370203,112=>0.028923035,113=>-0.05786813,114=>-0.059634116,115=>-0.058533818,116=>-0.009001847,0);
ENDMACRO;
