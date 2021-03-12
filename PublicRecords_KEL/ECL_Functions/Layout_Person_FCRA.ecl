﻿EXPORT Layout_Person_FCRA := RECORD
	INTEGER G_ProcUID;
	STRING65 P_InpAcct;
	INTEGER7 P_InpLexID;
	STRING78 P_InpNameFirst;
	STRING120 P_InpAddrLine1;
	STRING120 P_InpAddrLine2;
	STRING50 P_InpAddrCity;
	STRING25 P_InpAddrState;
	STRING10 P_InpAddrZip;
	STRING16 P_InpPhoneHome;
	STRING16 P_InpPhoneWork;
	STRING54 P_InpEmail;
	STRING45 P_InpIPAddr;
	STRING20 P_InpArchDt;
	STRING1 P_InpAcctFlag;
	STRING1 P_InpLexIDFlag;
	STRING1 P_InpNameFirstFlag;
	STRING1 P_InpNameMidFlag;
	STRING1 P_InpNameLastFlag;
	STRING1 P_InpAddrStFlag;
	STRING1 P_InpAddrCityFlag;
	STRING1 P_InpAddrStateFlag;
	STRING1 P_InpAddrZipFlag;
	STRING1 P_InpSSNFlag;
	STRING1 P_InpDOBFlag;
	STRING1 P_InpDLFlag;
	STRING1 P_InpDLStateFlag;
	STRING1 P_InpPhoneHomeFlag;
	STRING1 P_InpPhoneWorkFlag;
	STRING1 P_InpEmailFlag;
	STRING1 P_InpIPAddrFlag;
	STRING1 P_InpArchDtFlag;
	INTEGER7 P_LexID;
	INTEGER3 P_LexIDScore;
	STRING6 P_InpClnNamePrfx;
	STRING20 P_InpClnNameFirst;
	STRING6 P_InpClnNameSffx;
	STRING10 P_InpClnAddrPrimRng;
	STRING6 P_InpClnAddrPreDir;
	STRING28 P_InpClnAddrPrimName;
	STRING6 P_InpClnAddrSffx;
	STRING6 P_InpClnAddrPostDir;
	STRING10 P_InpClnAddrUnitDesig;
	STRING8 P_InpClnAddrSecRng;
	STRING25 P_InpClnAddrCity;
	STRING25 P_InpClnAddrCityPost;
	STRING6 P_InpClnAddrState;
	STRING6 P_InpClnAddrZip5;
	STRING6 P_InpClnAddrZip4;
	STRING P_InpClnAddrSt;
	STRING P_InpClnAddrFull;
	STRING10 P_InpClnAddrLat;
	STRING11 P_InpClnAddrLng;
	STRING6 P_InpClnAddrStateCode;
	STRING6 P_InpClnAddrCnty;
	STRING7 P_InpClnAddrGeo;
	STRING6 P_InpClnAddrType;
	STRING6 P_InpClnAddrStatus;
	// INTEGER7 P_InpClnAddrLocID;
	STRING10 P_InpClnPhoneHome;
	STRING10 P_InpClnPhoneWork;
	STRING54 P_InpClnEmail;
	STRING20 P_InpClnArchDt;
	STRING6 P_InpClnNamePrfxFlag;
	STRING6 P_InpClnNameFirstFlag;
	STRING6 P_InpClnNameMidFlag;
	STRING6 P_InpClnNameLastFlag;
	STRING6 P_InpClnNameSffxFlag;
	STRING6 P_InpClnAddrPrimRngFlag;
	STRING6 P_InpClnAddrPreDirFlag;
	STRING6 P_InpClnAddrPrimNameFlag;
	STRING6 P_InpClnAddrSffxFlag;
	STRING6 P_InpClnAddrPostDirFlag;
	STRING6 P_InpClnAddrUnitDesigFlag;
	STRING6 P_InpClnAddrSecRngFlag;
	STRING6 P_InpClnAddrCityFlag;
	STRING6 P_InpClnAddrCityPostFlag;
	STRING6 P_InpClnAddrStateFlag;
	STRING6 P_InpClnAddrZip5Flag;
	STRING6 P_InpClnAddrZip4Flag;
	STRING6 P_InpValAddrZipBadLenFlag,
	STRING6 P_InpValAddrZipAllZeroFlag,
	STRING6 P_InpValAddrStateBadAbbrFlag,
	STRING6 P_InpClnAddrStFlag;
	STRING6 P_InpClnAddrFullFlag;
	STRING6 P_InpClnAddrLatFlag;
	STRING6 P_InpClnAddrLngFlag;
	STRING6 P_InpClnAddrCntyFlag;
	STRING6 P_InpClnAddrGeoFlag;
	STRING6 P_InpClnAddrTypeFlag;
	STRING6 P_InpClnAddrStatusFlag;
	STRING6 P_InpClnSSNFlag;
	STRING6 P_InpValSSNBadCharFlag,
	STRING6 P_InpValSSNBadLenFlag,
	STRING6 P_InpValSSNBogusFlag,
	STRING6 P_InpValSSNNonSSAFlag,
	STRING6 P_InpValSSNIsITINFlag,
	STRING6 P_InpClnDOBFlag;
	STRING6 P_InpClnDLFlag;
	STRING6 P_InpClnDLStateFlag;
	STRING6 P_InpClnPhoneHomeFlag;
	STRING6 P_InpClnPhoneWorkFlag;
	STRING6 P_InpClnEmailFlag;
	STRING6 P_InpClnIPAddrFlag,
	STRING6 P_InpValEmailUserAllZeroFlag,
	STRING6 P_InpValEmailUserBadCharFlag,
	STRING6 P_InpValEmailDomAllZeroFlag,
	STRING6 P_InpValEmailDomBadCharFlag,
	STRING6 P_InpValEmailBogusFlag,
	STRING6 P_InpClnArchDtFlag;
	STRING6 P_InpValNameBogusFlag;
	STRING6 P_InpValPhoneHomeBadCharFlag;
	STRING6 P_InpValPhoneHomeBadLenFlag;
	STRING6 P_InpValPhoneHomeBogusFlag;
	STRING6 P_InpValPhoneWorkBadCharFlag;
	STRING6 P_InpValPhoneWorkBadLenFlag;
	STRING6 P_InpValPhoneWorkBogusFlag;
	STRING30 P_InpClnEmailUser;
	STRING30 P_InpClnEmailDom;
	STRING6  P_InpClnEmailExt;
	STRING45 P_InpClnIPAddr,
	STRING6 P_InpValNameInvalidFlag,
	STRING6 P_InpValAddrStInvalidFlag,
	STRING6 P_InpValPhoneHomeInvalidFlag,
	STRING6 P_InpValPhoneWorkInvalidFlag,
	STRING6 P_InpValSSNInvalidFlag,
	STRING6 P_InpValDLInvalidFlag,
	STRING6 P_InpValDLStateInvalidFlag,
	STRING6 P_InpValDOBInvalidFlag,
	STRING6 P_InpValEmailInvalidFlag,
	STRING6 P_InpValArchDtInvalidFlag,
	STRING6 P_InpSSNIs4Digits;
	INTEGER4 PI_InpAddrAVMVal;
	INTEGER4 PI_InpAddrAVMValA1Y;
	DECIMAL7_2 PI_InpAddrAVMRatio1Y;
	INTEGER4 PI_InpAddrAVMValA5Y;
	DECIMAL7_2 PI_InpAddrAVMRatio5Y;
	INTEGER4 PI_InpAddrAVMConfScore;
	STRING6 PI_InpAddrOnFileFlagEv;
	STRING6 PI_InpAddrIsVacantFlag;
	STRING6 PI_InpAddrIsThrowbackFlag;
	STRING6 PI_InpAddrSeasonalType;
	STRING6 PI_InpAddrIsDNDFlag;
	STRING6 PI_InpAddrIsCollegeFlag;
	STRING6 PI_InpAddrIsCMRAFlag;
	STRING6 PI_InpAddrIsSimpAddrFlag;
	STRING6 PI_InpAddrIsDropDeliveryFlag;
	STRING6 PI_InpAddrIsBusinessFlag;
	STRING6 PI_InpAddrOWGMFlag;
	STRING6 PI_InpAddrIsMultiUnitFlag;
	STRING6 PI_InpAddrIsAptFlag;
	//STRING6 PI_InpAddrIsPOBoxFlag;
	//STRING6 PI_InpAddrIsMilitaryFlag;
	//STRING PI_InpAddrSICCodeHRList;
	//STRING PI_InpAddrNAICSCodeHRList;
	//STRING6 PI_InpAddrIsHRCorrectFacFlag;
	INTEGER PI_InpDOBAge;
	STRING6 PI_InpSSNIsDeceasedFlag;
	STRING10 PI_InpSSNDeceasedDt;
	STRING6 PI_InpAddrStateVoterAvailFlag;
	//STRING PI_InpPhoneSICCodeHRList;
	//STRING PI_InpPhoneNAICSCodeHRList;
	//STRING6 PI_InpPhoneIsHRCorrectFacFlag;
	//STRING6 PI_InpPhoneType;
	//STRING6 PI_InpPhoneIsBusPhoneFlag;
	STRING10 G_BuildDrgCrimDt;
	STRING10 G_BuildAstVehAirDt;
	STRING10 G_BuildAstVehWtrDt;
	STRING10 G_BuildAstPropDt;
	STRING10 G_BuildEduDt;
	STRING10 G_BuildEmailDt;
	STRING6	P_LexIDSeenFlag;
	STRING6 P_LexIDIsDeceasedFlag;
	INTEGER3 PL_AstVehAirCntEv;
	STRING PL_AstVehAirEmrgDtListEv;
	STRING10 PL_AstVehAirEmrgNewDtEv; 		
	STRING10 PL_AstVehAirEmrgOldDtEv; 	
	INTEGER3 PL_AstVehAirEmrgNewMsncEv; 
	INTEGER3 PL_AstVehAirEmrgOldMsncEv;
	INTEGER3 PL_AstVehWtrCntEv;
	STRING PL_AstVehWtrEmrgDtListEv;
	STRING10 PL_AstVehWtrEmrgNewDtEv;
	STRING10 PL_AstVehWtrEmrgOldDtEv;
	INTEGER3 PL_AstVehWtrEmrgNewMsncEv;
	INTEGER3 PL_AstVehWtrEmrgOldMsncEv;
	// Property
	INTEGER3 PL_AstPropCntEv;
	STRING900 PL_AstPropNewDtListEv;
	STRING900 PL_AstPropOldDtListEv;
	INTEGER3 PL_AstPropCurrCnt;
	INTEGER3 PL_AstPropSaleCntEv;
	STRING PL_AstPropSaleAmtListEv;
	INTEGER4 PL_AstPropSaleTotEv;
	STRING900 PL_AstPropSaleDtListEv;
	STRING10 PL_AstPropSaleNewDtEv;
	STRING10 PL_AstPropSaleOldDtEv;
	INTEGER3 PL_AstPropSaleNewMsncEv;
	INTEGER3 PL_AstPropSaleOldMsncEv;
	INTEGER3 PL_DrgCrimCnt1Y;
	INTEGER3 PL_DrgCrimCnt7Y;
	STRING10 PL_DrgCrimNewDt1Y;
	STRING10 PL_DrgCrimOldDt1Y;
	STRING10 PL_DrgCrimNewDt7Y;
	STRING10 PL_DrgCrimOldDt7Y;
	INTEGER3 PL_DrgCrimNewMsnc1Y;
	INTEGER3 PL_DrgCrimOldMsnc1Y;
	INTEGER3 PL_DrgCrimNewMsnc7Y;
	INTEGER3 PL_DrgCrimOldMsnc7Y;
	INTEGER3 PL_DrgCrimFelCnt1Y;
	INTEGER3 PL_DrgCrimFelCnt7Y;
	STRING10 PL_DrgCrimFelNewDt1Y;
	STRING10 PL_DrgCrimFelOldDt1Y;
	STRING10 PL_DrgCrimFelNewDt7Y;
	STRING10 PL_DrgCrimFelOldDt7Y;
	INTEGER3 PL_DrgCrimFelNewMsnc1Y;
	INTEGER3 PL_DrgCrimFelOldMsnc1Y;
	INTEGER3 PL_DrgCrimFelNewMsnc7Y;
	INTEGER3 PL_DrgCrimFelOldMsnc7Y;
	INTEGER3 PL_DrgCrimNfelCnt1Y;
	INTEGER3 PL_DrgCrimNfelCnt7Y;
	STRING10 PL_DrgCrimNfelNewDt1Y;
	STRING10 PL_DrgCrimNfelOldDt1Y;
	STRING10 PL_DrgCrimNfelNewDt7Y;
	STRING10 PL_DrgCrimNfelOldDt7Y;
	INTEGER3 PL_DrgCrimNfelNewMsnc1Y;
	INTEGER3 PL_DrgCrimNfelOldMsnc1Y;
	INTEGER3 PL_DrgCrimNfelNewMsnc7Y;
	INTEGER3 PL_DrgCrimNfelOldMsnc7Y;
	STRING6 PL_DrgCrimSeverityIndx7Y;
	STRING6 PL_DrgCrimBehaviorIndx7Y;
	STRING10 G_BuildDrgBkDt ;
	INTEGER3 PL_DrgBkCnt1Y ;
	INTEGER3 PL_DrgBkCnt7Y ;
	INTEGER3 PL_DrgBkCnt10Y ;
	STRING PL_DrgBkDtList1Y ;
	STRING PL_DrgBkDtList7Y ;
	STRING PL_DrgBkDtList10Y ;
	STRING10 PL_DrgBkNewDt1Y ;
	STRING10 PL_DrgBkNewDt7Y ;
	STRING10 PL_DrgBkNewDt10Y ;
	STRING10 PL_DrgBkOldDt1Y ;
	STRING10 PL_DrgBkOldDt7Y ;
	STRING10 PL_DrgBkOldDt10Y ;
	INTEGER3 PL_DrgBkNewMsnc1Y ;
	INTEGER3 PL_DrgBkNewMsnc7Y ;
	INTEGER3 PL_DrgBkNewMsnc10Y ;
	INTEGER3 PL_DrgBkOldMsnc1Y ;
	INTEGER3 PL_DrgBkOldMsnc7Y ;
	INTEGER3 PL_DrgBkOldMsnc10Y ;
	STRING PL_DrgBkChList1Y ;
	STRING PL_DrgBkChList7Y ;
	STRING PL_DrgBkChList10Y ;
	STRING6 PL_DrgBkNewChType1Y ;
	STRING6 PL_DrgBkNewChType7Y ;
	STRING6 PL_DrgBkNewChType10Y ;
	INTEGER3 PL_DrgBkCh7Cnt1Y ;
	INTEGER3 PL_DrgBkCh7Cnt7Y ;
	INTEGER3 PL_DrgBkCh7Cnt10Y ;
	INTEGER3 PL_DrgBkCh13Cnt1Y ;
	INTEGER3 PL_DrgBkCh13Cnt7Y ;
	INTEGER3 PL_DrgBkCh13Cnt10Y ;
	STRING10 PL_DrgBkUpdtNewDt1Y ;
	STRING10 PL_DrgBkUpdtNewDt7Y ;
	STRING10 PL_DrgBkUpdtNewDt10Y ;
	INTEGER3 PL_DrgBkUpdtNewMsnc1Y ;
	INTEGER3 PL_DrgBkUpdtNewMsnc7Y ;
	INTEGER3 PL_DrgBkUpdtNewMsnc10Y ;
	STRING PL_DrgBkDispList1Y ;
	STRING PL_DrgBkDispList7Y ;
	STRING PL_DrgBkDispList10Y ;
	STRING10 PL_DrgBkNewDispType1Y ;
	STRING10 PL_DrgBkNewDispType7Y ;
	STRING10 PL_DrgBkNewDispType10Y ;
	STRING10 PL_DrgBkNewDispDt1Y ;
	STRING10 PL_DrgBkNewDispDt7Y ;
	STRING10 PL_DrgBkNewDispDt10Y ;
	INTEGER3 PL_DrgBkNewDispMsnc1Y ;
	INTEGER3 PL_DrgBkNewDispMsnc7Y ;
	INTEGER3 PL_DrgBkNewDispMsnc10Y ;
	INTEGER3 PL_DrgBkDispCnt1Y ;
	INTEGER3 PL_DrgBkDispCnt7Y ;
	INTEGER3 PL_DrgBkDispCnt10Y ;
	INTEGER3 PL_DrgBkDsmsCnt1Y ;
	INTEGER3 PL_DrgBkDsmsCnt7Y ;
	INTEGER3 PL_DrgBkDsmsCnt10Y ;
	INTEGER3 PL_DrgBkDschCnt1Y ;
	INTEGER3 PL_DrgBkDschCnt7Y ;
	INTEGER3 PL_DrgBkDschCnt10Y ;
	STRING PL_DrgBkTypeList1Y ;
	STRING PL_DrgBkTypeList7Y ;
	STRING PL_DrgBkTypeList10Y ;
	STRING6 PL_DrgBkBusFlag1Y ;
	STRING6 PL_DrgBkBusFlag7Y ;
	STRING6 PL_DrgBkBusFlag10Y ;
	STRING6 PL_DrgBkSeverityIndx10Y ;
	STRING10 G_BuildProfLicDt;
	STRING6 PL_ProfLicFlagEv;
	STRING500 PL_ProfLicIssueDtListEv;
	STRING500 PL_ProfLicExpDtListEv;
	STRING100 PL_ProfLicIndxByLicListEv;
	STRING6 PL_ProfLicActvFlag;
	STRING10 PL_ProfLicActvNewIssueDt;
	STRING10 PL_ProfLicActvNewExpDt;
	STRING60 PL_ProfLicActvNewType;
	STRING150 PL_ProfLicActvNewTitleType;
	STRING6 PL_ProfLicActvNewIndx;
	STRING6 PL_ProfLicActvNewSrcType;
	// Best PII
	STRING200 PL_CurrAddrFull;
	// STRING200 PL_CurrAddrLocID;
	STRING200 PL_PrevAddrFull;
	// STRING200 PL_PrevAddrLocID;
	STRING6 PL_CurrAddrCnty;
	STRING7 PL_CurrAddrGeo;
	STRING10 PL_CurrAddrLat;
	STRING11 PL_CurrAddrLng;
	STRING6 PL_CurrAddrType;
	STRING6 PL_CurrAddrStatus;
	STRING6 PL_PrevAddrCnty;
	STRING7 PL_PrevAddrGeo;
	STRING10 PL_PrevAddrLat;
	STRING11 PL_PrevAddrLng;
	STRING6 PL_PrevAddrType;
	STRING6 PL_PrevAddrStatus;
	//Current Address
	STRING6 PL_CurrAddrIsVacantFlag;
	STRING6 PL_CurrAddrIsThrowbackFlag;
	STRING6 PL_CurrAddrSeasonalType;
	STRING6 PL_CurrAddrIsDNDFlag;
	STRING6 PL_CurrAddrIsCollegeFlag;
	STRING6 PL_CurrAddrIsCMRAFlag;
	STRING6 PL_CurrAddrIsSimpAddrFlag;
	STRING6 PL_CurrAddrIsDropDeliveryFlag;
	STRING6 PL_CurrAddrIsBusinessFlag;
	STRING6 PL_CurrAddrIsMultiUnitFlag;
	STRING6 PL_CurrAddrIsAptFlag;
	//Previous Address
	STRING6 PL_PrevAddrIsSimpAddrFlag;
	STRING6 PL_PrevAddrIsBusinessFlag;
	//consumer liens
	STRING10 G_BuildDrgLnJDt;
	INTEGER3 PL_DrgJudgCnt7Y;
	INTEGER3 PL_DrgLTDCnt7Y;
	STRING PL_DrgLTDAmtList7Y;
	STRING PL_DrgLTDDtList7Y;
	INTEGER3 PL_DrgLTDNewMsnc7Y;
	INTEGER3 PL_DrgLTDOldMsnc7Y;
	INTEGER3 PL_DrgLienCnt7Y;
	//Consumer Suits
	INTEGER3 PL_DrgSuitCnt7Y;
	STRING PL_DrgSuitAmtList7Y;
	INTEGER3 PL_DrgSuitAmtTot7Y;
	STRING PL_DrgSuitDtList7Y;
	INTEGER3 PL_DrgSuitNewMsnc7Y;
	INTEGER3 PL_DrgSuitOldMsnc7Y;
	//OverAllLnJ
	INTEGER3 PL_DrgLnJCnt7Y;
	STRING	PL_DrgLnJAmtList7Y;
	STRING	PL_DrgLnJDtList7Y;
	STRING10 PL_DrgLnJNewDt7Y;
	INTEGER3 PL_DrgLnJNewMsnc7Y;
	STRING10 PL_DrgLnJOldDt7Y;
	INTEGER3 PL_DrgLnJOldMsnc7Y;
	//Education
	STRING6 PL_EduRecFlagEv;
	STRING50 PL_EduSrcListEv;
	STRING6 PL_EduHSRecFlagEv;
	STRING6 PL_EduCollRecFlagEv;
	STRING PL_EduCollSrcEmrgDtListEv;
	STRING PL_EduCollSrcLastDtListEv;
	STRING8 PL_EduCollSrcNewRecOldDtEv;
	STRING8 PL_EduCollSrcNewRecNewDtEv;
	INTEGER3 PL_EduCollSrcNewRecOldMsncEv;
	INTEGER3 PL_EduCollSrcNewRecNewMsncEv;
	INTEGER3 PL_EduCollRecSpanEv;
	//Email
	INTEGER3 PL_EmailCntEv;
	//Derog History
	INTEGER3 PL_DrgCnt7Y;
	STRING PL_DrgDtList7Y;
	INTEGER3 PL_DrgOldMsnc7Y;
	INTEGER3 PL_DrgNewMsnc7Y;		
	//Best PII
	STRING20 PL_BestNameFirst;
	STRING20 PL_BestNameMid;
	STRING20 PL_BestNameLast;
	STRING10 PL_BestSSN;
	STRING10 PL_BestDOB;
	INTEGER3 PL_BestDOBAge;
	// Inquiries
	STRING10 G_BuildInqDt;
	// FCRA Velocity Inquiries
	INTEGER3 PL_InqPerLexIDCnt1Y;
	INTEGER3 PL_InqSSNPerLexIDCnt1Y;
	INTEGER3 PL_InqAddrPerLexIDCnt1Y;
	INTEGER3 PL_InqLNamePerLexIDCnt1Y;
	INTEGER3 PL_InqFNamePerLexIDCnt1Y;
	INTEGER3 PL_InqPhonePerLexIDCnt1Y;
	INTEGER3 PL_InqDOBPerLexIDCnt1Y;
	INTEGER3 PL_InqPerLexIDWInpFLSCnt1Y;
	// Inquiry PII Corroboration
	INTEGER3 PL_InqPerLexIDWInpASCnt1Y;
	INTEGER3 PL_InqPerLexIDWInpSDCnt1Y;
	INTEGER3 PL_InqPerLexIDWInpPSCnt1Y;
	INTEGER3 PL_InqPerLexIDWInpFLASCnt1Y;
	INTEGER3 PL_InqPerLexIDWInpFLPSCnt1Y;
	INTEGER3 PL_InqPerLexIDWInpFLAPSCnt1Y;
	//Short Term Lending
	INTEGER PL_STLCnt1Y;
	INTEGER PL_STLCnt2Y;
	INTEGER PL_STLCnt5Y;
	STRING PL_STLDtList5Y;
	//Person Header Source Verification
	// STRING10 G_BuildHdrDt;
	// INTEGER PL_VerSrcCntEv;
	// STRING100 PL_VerSrcListEv;
	// STRING300 PL_VerSrcEmrgDtListEv;
	// STRING300 PL_VerSrcLastDtListEv;
	// STRING10 PL_VerSrcOldDtEv;
	// STRING10 PL_VerSrcNewDtEv;
	// STRING6 P_LexIDRstdOnlyFlag;
	string6 PL_AlrtCorrectedFlag;
	string6 PL_AlrtConsStatementFlag;
	string6 PL_AlrtDisputeFlag;
	string6 PL_AlrtSecurityFreezeFlag;
	string6 PL_AlrtSecurityAlertFlag;
	string6 PL_AlrtIDTheftFlag;
	
END;