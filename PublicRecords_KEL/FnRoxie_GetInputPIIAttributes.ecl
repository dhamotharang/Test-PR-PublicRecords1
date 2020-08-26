IMPORT KEL13 AS KEL;
EXPORT FnRoxie_GetInputPIIAttributes(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) RepInput,
            PublicRecords_KEL.Interface_Options Options) := FUNCTION
            		
    
	InputPIIAttributesResults := PublicRecords_KEL.Q_Input_Attributes_V1(RepInput, (INTEGER) RepInput[1].P_InpClnArchDt[1..8], Options.KEL_Permissions_Mask).Res0;
	InputPIIAttributes := KEL.Clean(InputPIIAttributesResults, TRUE, TRUE, TRUE);		
		
		ds_changedatatype :=
		                  PROJECT(InputPIIAttributes,
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
																		// SELF.P_InpValNameBogusFlag := (STRING)LEFT.P_InpValNameBogusFlag,
																		SELF.P_InpValPhoneHomeBadCharFlag := (STRING)LEFT.P_InpValPhoneHomeBadCharFlag,
																		SELF.P_InpValPhoneHomeBadLenFlag := (STRING)LEFT.P_InpValPhoneHomeBadLenFlag,
																		SELF.P_InpValPhoneHomeBogusFlag := (STRING)LEFT.P_InpValPhoneHomeBogusFlag,
																		SELF.P_InpValPhoneWorkBadCharFlag := (STRING)LEFT.P_InpValPhoneWorkBadCharFlag,
																		SELF.P_InpValPhoneWorkBadLenFlag := (STRING)LEFT.P_InpValPhoneWorkBadLenFlag,
																		SELF.P_InpValPhoneWorkBogusFlag := (STRING)LEFT.P_InpValPhoneWorkBogusFlag,
																		// SELF.p_inpclnaddrlocid := (INTEGER)LEFT.p_inpclnaddrlocid, 
																		// SELF.P_InpClnAddrPropertyUID := PublicRecords_KEL.E_Property(KEL_Settings).Lookup (KeyVal = TRIM((STRING)LEFT.P_InpClnAddrPrimRng) + '|' + 
																																														// TRIM((STRING)LEFT.P_InpClnAddrPreDir) + '|' + 
																																														// TRIM((STRING)LEFT.P_InpClnAddrPrimName) + '|' + 
																																														// TRIM((STRING)LEFT.P_InpClnAddrSffx) + '|' + 
																																														// TRIM((STRING)LEFT.P_InpClnAddrPostDir) + '|' + 
																																														// TRIM((STRING)LEFT.P_InpClnAddrZip5) + '|' + 
																																														// TRIM((STRING)LEFT.P_InpClnAddrSecRng))[1].uid;
																		// SELF.PI_InpAddrAVMRatio1Y := (DECIMAL7_2)LEFT.PI_InpAddrAVMRatio1Y;
																		// SELF.PI_InpAddrAVMRatio5Y := (DECIMAL7_2)LEFT.PI_InpAddrAVMRatio5Y;
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
																		SELF := LEFT,
																		SELF := []));

		
		RETURN ds_changedatatype;
END;