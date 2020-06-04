IMPORT PublicRecords_KEL, Vault, Risk_Indicators;

EXPORT FnThor_Get_TPM_Phones := MODULE


	EXPORT Consumer(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) PersonInput,
																		PublicRecords_KEL.Interface_Options OptionsRaw,
																		PublicRecords_KEL.CFG_Compile KEL_Settings = PublicRecords_KEL.CFG_Compile) := FUNCTION
																	
		Options := PublicRecords_KEL.ECL_Functions.Fn_Set_Interface_Options(OptionsRaw, KEL_Settings);
	
		KeyTPM := IF(Options.isFCRA, Vault.Files().Key_telcordia_tpm_slim_Source, Risk_Indicators.Key_Telcordia_TPM_Slim_Vault.SourceFile);//calling source file to aviod ingested vault files with archive dates
	
		TPM := JOIN(DISTRIBUTE(PersonInput, HASH64(P_InpClnPhoneHome[1..7])), DISTRIBUTE(KeyTPM, HASH64(npa, nxx, tb)), 
								LEFT.P_InpClnPhoneHome!='' AND
								LEFT.P_InpClnPhoneHome[1..3]= RIGHT.npa and 
								LEFT.P_InpClnPhoneHome[4..6]= RIGHT.nxx and
								LEFT.P_InpClnPhoneHome[7] = RIGHT.tb, 
						TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
									SELF.DialIndicator := RIGHT.dial_ind;
									SELF.PointID := RIGHT.point_id;
									SELF.NXXType := RIGHT.nxx_type;
									SELF.ZIPMatch := If(LEFT.P_InpClnAddrZip5[1..5] IN SET(RIGHT.zipcodes, zip), TRUE, FALSE);
									SELF := LEFT), 
						LEFT OUTER, ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT), KEEP(1), LOCAL);
																									
		RETURN TPM;																
	END;
	
EXPORT Business(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
																		PublicRecords_KEL.Interface_Options OptionsRaw,
																		PublicRecords_KEL.CFG_Compile KEL_Settings = PublicRecords_KEL.CFG_Compile) := function
																		
		Options := PublicRecords_KEL.ECL_Functions.Fn_Set_Interface_Options(OptionsRaw, KEL_Settings);
					
		TPM := JOIN(DISTRIBUTE(BusinessInput, HASH64(B_InpClnPhone[1..7])), DISTRIBUTE( Risk_Indicators.Key_Telcordia_TPM_Slim_Vault.SourceFile, HASH64(npa, nxx, tb)), //calling source file to aviod ingested vault files with archive dates
													LEFT.B_InpClnPhone !='' AND
													LEFT.B_InpClnPhone[1..3] = RIGHT.npa and 
													left.B_InpClnPhone[4..6] = RIGHT.nxx and
													LEFT.B_InpClnPhone[7] = RIGHT.tb, //and
							TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII,
									SELF.DialIndicator := right.dial_ind;
									SELF.PointID := RIGHT.point_id;
									SELF.NXXType := RIGHT.nxx_type;
									SELF.ZIPMatch := If(LEFT.B_InpClnAddrZip5[1..5] IN SET(RIGHT.zipcodes, zip), TRUE, FALSE);
									SELF := LEFT),
						LEFT OUTER, ATMOST(PublicRecords_KEL.ECL_Functions.Constants.DEFAULT_JOIN_LIMIT), KEEP(1), LOCAL);
																									
		RETURN TPM;																
	END;			

END;