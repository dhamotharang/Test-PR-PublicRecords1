IMPORT PublicRecords_KEL, Risk_Indicators;

EXPORT FnRoxie_Get_TPM_Phones := MODULE


	EXPORT Consumer(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII) PersonInput,
																		PublicRecords_KEL.Interface_Options Options) := FUNCTION
																		
		KeyTPM := IF(Options.isFCRA, Risk_Indicators.Key_FCRA_Telcordia_tpm_Slim, Risk_Indicators.Key_Telcordia_tpm_slim);
	
		TPM := JOIN(PersonInput, KeyTPM, 
								LEFT.P_InpClnPhoneHome!='' AND
								KEYED(LEFT.P_InpClnPhoneHome[1..3]= RIGHT.npa) AND 
								KEYED(LEFT.P_InpClnPhoneHome[4..6]= RIGHT.nxx) AND
								KEYED(LEFT.P_InpClnPhoneHome[7] = RIGHT.tb), 
						TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputPII,
									SELF.DialIndicator := RIGHT.dial_ind;
									SELF.PointID := RIGHT.point_id;
									SELF.NXXType := RIGHT.nxx_type;
									SELF.ZIPMatch := If(LEFT.P_InpClnAddrZip5[1..5] IN SET(RIGHT.zipcodes, zip), TRUE, FALSE);
									SELF := LEFT), 
						LEFT OUTER, ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(1));
																									
		RETURN TPM;																
	END;															
	
	EXPORT Business(DATASET(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII) BusinessInput,
																		PublicRecords_KEL.Interface_Options Options) := FUNCTION
					
		TPM := JOIN(BusinessInput, Risk_Indicators.Key_Telcordia_tpm_slim, 
													LEFT.B_InpClnPhone!='' AND
													KEYED(LEFT.B_InpClnPhone[1..3]=RIGHT.npa) AND 
													KEYED(LEFT.B_InpClnPhone[4..6]=RIGHT.nxx) AND
													KEYED(LEFT.B_InpClnPhone[7] =RIGHT.tb),
						TRANSFORM(PublicRecords_KEL.ECL_Functions.Layouts.LayoutInputBII,
									SELF.DialIndicator := right.dial_ind;
									SELF.PointID := RIGHT.point_id;
									SELF.NXXType := RIGHT.nxx_type;
									SELF.ZIPMatch := If(LEFT.B_InpClnAddrZip5[1..5] IN SET(RIGHT.zipcodes, zip), TRUE, FALSE);
									SELF := LEFT), 
						LEFT OUTER, ATMOST(PublicRecords_KEL.ECL_Functions.Constants.Default_Atmost_1000), KEEP(1));
																									
		RETURN TPM;																
	END;			

END;