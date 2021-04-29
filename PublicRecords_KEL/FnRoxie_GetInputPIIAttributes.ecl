﻿IMPORT KEL13 AS KEL;

EXPORT FnRoxie_GetInputPIIAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
            PublicRecords_KEL.Interface_Options Options,
						DATASET(PublicRecords_KEL.ECL_Functions.Layouts_FDC().Layout_FDC) FDCDataset) := FUNCTION
            		
	LayoutInputPIIAttributes := PublicRecords_KEL.KEL_Queries_MAS_Consumer.L_Compile.Input_Attributes_V1_Dynamic_Res0_Layout;

	
	InputPIIAttributesResults := NOCOMBINE(JOIN(RepInput, FDCDataset, LEFT.G_ProcUID = RIGHT.G_ProcUID, TRANSFORM(LayoutInputPIIAttributes,
		PIIAttributes := PublicRecords_KEL.KEL_Queries_MAS_Consumer.Q_Input_Attributes_V1_Dynamic(DATASET(LEFT), (INTEGER) LEFT.P_InpClnArchDt[1..8], Options.KEL_Permissions_Mask, Options.isFCRA, DATASET(RIGHT)).Res0;
		SELF := PIIAttributes[1]), 
	LEFT OUTER, ATMOST(100), KEEP(1)));
		
	InputPIIAttributes := KEL.Clean(InputPIIAttributesResults, TRUE, TRUE, TRUE);		
	
	ds_changedatatype := PROJECT(InputPIIAttributes,
		TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPIIWithExtras,
			SELF.P_InpValAddrZipBadLenFlag := (STRING)LEFT.P_InpValAddrZipBadLenFlag,
			SELF.P_InpValAddrZipAllZeroFlag := (STRING)LEFT.P_InpValAddrZipAllZeroFlag,
			SELF.P_InpValAddrStateBadAbbrFlag := (STRING)LEFT.P_InpValAddrStateBadAbbrFlag,
			SELF.P_InpValEmailUserAllZeroFlag := (STRING)LEFT.P_InpValEmailUserAllZeroFlag,
			SELF.P_InpValEmailUserBadCharFlag := (STRING)LEFT.P_InpValEmailUserBadCharFlag,
			SELF.P_InpValEmailDomAllZeroFlag := (STRING)LEFT.P_InpValEmailDomAllZeroFlag,
			SELF.P_InpValEmailDomBadCharFlag := (STRING)LEFT.P_InpValEmailDomBadCharFlag,
			SELF.P_InpValEmailBogusFlag := (STRING)LEFT.P_InpValEmailBogusFlag,
			SELF.P_InpValSSNBadCharFlag := (STRING)LEFT.P_InpValSSNBadCharFlag,
			SELF.P_InpValSSNBadLenFlag := (STRING)LEFT.P_InpValSSNBadLenFlag,
			SELF.P_InpValSSNBogusFlag := (STRING)LEFT.P_InpValSSNBogusFlag,
			SELF.P_InpValSSNNonSSAFlag := (STRING)LEFT.P_InpValSSNNonSSAFlag,
			SELF.P_InpValSSNIsITINFlag := (STRING)LEFT.P_InpValSSNIsITINFlag,
			SELF.P_InpValNameBogusFlag := (STRING)LEFT.P_InpValNameBogusFlag,
			SELF.P_InpValPhoneHomeBadCharFlag := (STRING)LEFT.P_InpValPhoneHomeBadCharFlag,
			SELF.P_InpValPhoneHomeBadLenFlag := (STRING)LEFT.P_InpValPhoneHomeBadLenFlag,
			SELF.P_InpValPhoneHomeBogusFlag := (STRING)LEFT.P_InpValPhoneHomeBogusFlag,
			SELF.P_InpValPhoneWorkBadCharFlag := (STRING)LEFT.P_InpValPhoneWorkBadCharFlag,
			SELF.P_InpValPhoneWorkBadLenFlag := (STRING)LEFT.P_InpValPhoneWorkBadLenFlag,
			SELF.P_InpValPhoneWorkBogusFlag := (STRING)LEFT.P_InpValPhoneWorkBogusFlag,
			// SELF.p_inpclnaddrlocid := (INTEGER)LEFT.p_inpclnaddrlocid, 
			SELF.P_InpSSNIs4Digits := (STRING)LEFT.P_InpSSNIs4Digits,
			// SELF.P_InpClnAddrPropertyUID := PublicRecords_KEL.E_Property(KEL_Settings).Lookup (KeyVal = TRIM((STRING)LEFT.P_InpClnAddrPrimRng) + '|' + 
					// TRIM((STRING)LEFT.P_InpClnAddrPreDir) + '|' + 
					// TRIM((STRING)LEFT.P_InpClnAddrPrimName) + '|' + 
					// TRIM((STRING)LEFT.P_InpClnAddrSffx) + '|' + 
					// TRIM((STRING)LEFT.P_InpClnAddrPostDir) + '|' + 
					// TRIM((STRING)LEFT.P_InpClnAddrZip5) + '|' + 
					// TRIM((STRING)LEFT.P_InpClnAddrSecRng))[1].uid;
			SELF.PI_InpAddrAVMRatio1Y := (DECIMAL7_2)LEFT.PI_InpAddrAVMRatio1Y;
			SELF.PI_InpAddrAVMRatio5Y := (DECIMAL7_2)LEFT.PI_InpAddrAVMRatio5Y;
			SELF.PI_InpAddrOnFileFlagEv := (STRING)LEFT.PI_InpAddrOnFileFlagEv,
			SELF.PI_InpAddrIsVacantFlag := (STRING)LEFT.PI_InpAddrIsVacantFlag,
			SELF.PI_InpAddrIsThrowbackFlag := (STRING)LEFT.PI_InpAddrIsThrowbackFlag,
			SELF.PI_InpAddrSeasonalType := (STRING)LEFT.PI_InpAddrSeasonalType,
			SELF.PI_InpAddrIsDNDFlag := (STRING)LEFT.PI_InpAddrIsDNDFlag,
			SELF.PI_InpAddrIsCollegeFlag := (STRING)LEFT.PI_InpAddrIsCollegeFlag,
			SELF.PI_InpAddrIsCMRAFlag := (STRING)LEFT.PI_InpAddrIsCMRAFlag,
			SELF.PI_InpAddrIsSimpAddrFlag := (STRING)LEFT.PI_InpAddrIsSimpAddrFlag,
			SELF.PI_InpAddrIsDropDeliveryFlag := (STRING)LEFT.PI_InpAddrIsDropDeliveryFlag,
			SELF.PI_InpAddrIsBusinessFlag := (STRING)LEFT.PI_InpAddrIsBusinessFlag,
			SELF.PI_InpAddrOWGMFlag := (STRING)LEFT.PI_InpAddrOWGMFlag,
			SELF.PI_InpAddrIsMultiUnitFlag := (STRING)LEFT.PI_InpAddrIsMultiUnitFlag,
			SELF.PI_InpAddrIsAptFlag := (STRING)LEFT.PI_InpAddrIsAptFlag,
			SELF.PI_InpDOBAge := (INTEGER)LEFT.PI_InpDOBAge,
			SELF.PI_InpSSNIsDeceasedFlag := (STRING)LEFT.PI_InpSSNIsDeceasedFlag,
			SELF.PI_InpSSNDeceasedDt := (STRING)LEFT.PI_InpSSNDeceasedDt,
			SELF.PI_InpAddrStateDLAvailFlag := IF(Options.IsFCRA, '', (STRING)LEFT.PI_InpAddrStateDLAvailFlag),
			SELF.PI_InpAddrStateVoterAvailFlag := (STRING)LEFT.PI_InpAddrStateVoterAvailFlag,
			SELF.PI_InpPhoneSICCodeHRList := (STRING)LEFT.PI_InpPhoneSICCodeHRList,
			SELF.PI_InpPhoneNAICSCodeHRList := (STRING)LEFT.PI_InpPhoneNAICSCodeHRList,
			SELF.PI_InpPhoneIsHRCorrectFacFlag := (STRING)LEFT.PI_InpPhoneIsHRCorrectFacFlag,
			SELF.PI_InpPhoneType := (STRING)LEFT.PI_InpPhoneType,
			SELF.PI_InpPhoneIsBusPhoneFlag := (STRING)LEFT.PI_InpPhoneIsBusPhoneFlag,
			// SELF.PI_InpAddrIsPOBoxFlag := (STRING)LEFT.PI_InpAddrIsPOBoxFlag,
			// SELF.PI_InpAddrIsMilitaryFlag := (STRING)LEFT.PI_InpAddrIsMilitaryFlag,
			SELF.PI_SrchPerInpSSNCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchPerInpSSNCnt1Y),
			SELF.PI_SrchLexIDPerInpSSNCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchLexIDPerInpSSNCnt1Y),
			SELF.PI_SrchLNamePerInpSSNCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchLNamePerInpSSNCnt1Y),
			SELF.PI_SrchAddrPerInpSSNCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchAddrPerInpSSNCnt1Y),
			SELF.PI_SrchDOBPerInpSSNCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchDOBPerInpSSNCnt1Y),
			SELF.PI_SrchPerInpAddrCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchPerInpAddrCnt1Y),
			SELF.PI_SrchLexIDPerInpAddrCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchLexIDPerInpAddrCnt1Y),
			SELF.PI_SrchLNamePerInpAddrCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchLNamePerInpAddrCnt1Y),
			SELF.PI_SrchSSNPerInpAddrCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchSSNPerInpAddrCnt1Y),
			SELF.PI_SrchPerInpEmailCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchPerInpEmailCnt1Y),
			SELF.PI_SrchLexIDPerInpEmailCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchLexIDPerInpEmailCnt1Y),
			SELF.PI_SrchPerInpPhoneCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchPerInpPhoneCnt1Y),
			SELF.PI_SrchLexIDPerInpPhoneCnt1Y := IF(Options.IsFCRA,0,(INTEGER)LEFT.PI_SrchLexIDPerInpPhoneCnt1Y),
			SELF.BestDataAppended := Options.BestPIIAppend,
			SELF.PI_AlrtInpNameWatchlistRecNum := IF(Options.IsFCRA, '', (STRING)LEFT.PI_AlrtInpNameWatchlistRecNum),
      SELF.PI_AlrtInpNameOnWatchlistFlag := IF(Options.IsFCRA, '', (STRING)LEFT.PI_AlrtInpNameOnWatchlistFlag),
			SELF.IPaddr := (STRING)LEFT.IPaddr,
			SELF.IPresponse := (STRING)LEFT.IPresponse,
			SELF.NetAcuityRoyalty := (INTEGER4)LEFT.NetAcuityRoyalty,
			SELF.TargusRoyalty := (INTEGER4)LEFT.TargusRoyalty,
			SELF.TargusSrc := (STRING)LEFT.TargusSrc,			
			SELF.InsPhoneHit := IF(Options.IsFCRA, 0, (INTEGER4)LEFT.InsPhoneHit),
			SELF.InsPhoneSrc := IF(Options.IsFCRA, '', (STRING)LEFT.InsPhoneSrc),
			SELF := LEFT,
			SELF := []));
	
		RETURN ds_changedatatype;
END;
