
import Risk_indicators, Models, Std, Profilebooster, Luci, Ut;

export Healthcare_SocioEconomic_Batch_Service_V5 := MACRO

	batch_in := dataset([],Models.Layouts_Healthcare_Core.Layout_SocioEconomic_Batch_In) : stored('batch_in',few);
	unsigned1 DPPAPurpose_in := 1 : stored('DPPAPurpose');
	unsigned1 GLBPurpose_in := 0 : stored('GLBPurpose');
	string DataRestrictionMask_in := '' : stored('DataRestrictionMask');
	string50 DataPermissionMask_in := '' : stored('DataPermissionMask');
	IF(DataRestrictionMask_in='', FAIL('A blank DataRestrictionMask value is supplied.'));
	IF(DataPermissionMask_in='', FAIL('A blank DataPermissionMask value is supplied.'));
	String Socio_Core_Option := '1' : stored('Options');
	unsigned1 ofac_version_in     := 1        : stored('OFACVersion');
	gateways_in_ds := Gateway.Configuration.Get();
	IF(DPPAPurpose_in <> Models.Healthcare_Constants_Core.authorized_DPPA OR GLBPurpose_in <> Models.Healthcare_Constants_Core.authorized_GLBA, FAIL('Supplied Permissible Purpose Settings (GLBPurpose and/or DPPAPurpose) are invalid'));
	
	isCoreRequestValid := TRUE;

	string10 ReadmissionScore_Category_5_Low_In  := '34.8015' : stored('ReadmissionScore_Category_5_Low');
	string10 ReadmissionScore_Category_4_High_In := '34.8014' : stored('ReadmissionScore_Category_4_High');
	string10 ReadmissionScore_Category_4_Low_In  := '16.3241' : stored('ReadmissionScore_Category_4_Low');
	string10 ReadmissionScore_Category_3_High_In := '16.3240' : stored('ReadmissionScore_Category_3_High');
	string10 ReadmissionScore_Category_3_Low_In  := '12.2211' : stored('ReadmissionScore_Category_3_Low');
	string10 ReadmissionScore_Category_2_High_In := '12.2210' : stored('ReadmissionScore_Category_2_High');
	string10 ReadmissionScore_Category_2_Low_In  := '8.5245' : stored('ReadmissionScore_Category_2_Low');
	string10 ReadmissionScore_Category_1_High_In := '8.5244'  : stored('ReadmissionScore_Category_1_High');

	string10 MedicationAdherenceScore_Category_5_High_In := '37.5323' : stored('MedicationAdherenceScore_Category_5_High');
	string10 MedicationAdherenceScore_Category_4_Low_In  := '37.5324' : stored('MedicationAdherenceScore_Category_4_Low');
	string10 MedicationAdherenceScore_Category_4_High_In := '64.3456' : stored('MedicationAdherenceScore_Category_4_High');
	string10 MedicationAdherenceScore_Category_3_Low_In  := '64.3457' : stored('MedicationAdherenceScore_Category_3_Low');
	string10 MedicationAdherenceScore_Category_3_High_In := '74.2270' : stored('MedicationAdherenceScore_Category_3_High');
	string10 MedicationAdherenceScore_Category_2_Low_In  := '74.2271' : stored('MedicationAdherenceScore_Category_2_Low');
	string10 MedicationAdherenceScore_Category_2_High_In := '79.9234' : stored('MedicationAdherenceScore_Category_2_High');
	string10 MedicationAdherenceScore_Category_1_Low_In  := '79.9235' : stored('MedicationAdherenceScore_Category_1_Low');
	
	string10 MotivationScore_Category_5_High_In := '20.6416' : stored('MotivationScore_Category_5_High');
	string10 MotivationScore_Category_4_Low_In  := '20.6417' : stored('MotivationScore_Category_4_Low');
	string10 MotivationScore_Category_4_High_In := '27.7633' : stored('MotivationScore_Category_4_High');
	string10 MotivationScore_Category_3_Low_In  := '27.7634' : stored('MotivationScore_Category_3_Low');
	string10 MotivationScore_Category_3_High_In := '34.4366' : stored('MotivationScore_Category_3_High');
	string10 MotivationScore_Category_2_Low_In  := '34.4367' : stored('MotivationScore_Category_2_Low');
	string10 MotivationScore_Category_2_High_In := '41.6533' : stored('MotivationScore_Category_2_High');
	string10 MotivationScore_Category_1_Low_In  := '41.6534' : stored('MotivationScore_Category_1_Low');

	DECIMAL7_4 ReadmissionScore_Category_5_Low := (DECIMAL7_4)ReadmissionScore_Category_5_Low_In ;
	DECIMAL7_4 ReadmissionScore_Category_4_High := (DECIMAL7_4)ReadmissionScore_Category_4_High_In ;
	DECIMAL7_4 ReadmissionScore_Category_4_Low := (DECIMAL7_4)ReadmissionScore_Category_4_Low_In ;
	DECIMAL7_4 ReadmissionScore_Category_3_High := (DECIMAL7_4)ReadmissionScore_Category_3_High_In ;
	DECIMAL7_4 ReadmissionScore_Category_3_Low := (DECIMAL7_4)ReadmissionScore_Category_3_Low_In ;
	DECIMAL7_4 ReadmissionScore_Category_2_High := (DECIMAL7_4)ReadmissionScore_Category_2_High_In ;
	DECIMAL7_4 ReadmissionScore_Category_2_Low := (DECIMAL7_4)ReadmissionScore_Category_2_Low_In ;
	DECIMAL7_4 ReadmissionScore_Category_1_High := (DECIMAL7_4)ReadmissionScore_Category_1_High_In ;
	
	DECIMAL7_4 MedicationAdherenceScore_Category_5_High := (DECIMAL7_4)MedicationAdherenceScore_Category_5_High_In ;
	DECIMAL7_4 MedicationAdherenceScore_Category_4_Low := (DECIMAL7_4)MedicationAdherenceScore_Category_4_Low_In ;
	DECIMAL7_4 MedicationAdherenceScore_Category_4_High := (DECIMAL7_4)MedicationAdherenceScore_Category_4_High_In ;
	DECIMAL7_4 MedicationAdherenceScore_Category_3_Low := (DECIMAL7_4)MedicationAdherenceScore_Category_3_Low_In ;
	DECIMAL7_4 MedicationAdherenceScore_Category_3_High := (DECIMAL7_4)MedicationAdherenceScore_Category_3_High_In ;
	DECIMAL7_4 MedicationAdherenceScore_Category_2_Low := (DECIMAL7_4)MedicationAdherenceScore_Category_2_Low_In ;
	DECIMAL7_4 MedicationAdherenceScore_Category_2_High := (DECIMAL7_4)MedicationAdherenceScore_Category_2_High_In ;
	DECIMAL7_4 MedicationAdherenceScore_Category_1_Low := (DECIMAL7_4)MedicationAdherenceScore_Category_1_Low_In ;

	DECIMAL7_4 MotivationScore_Category_5_High := (DECIMAL7_4)MotivationScore_Category_5_High_In ;
	DECIMAL7_4 MotivationScore_Category_4_Low := (DECIMAL7_4)MotivationScore_Category_4_Low_In ;
	DECIMAL7_4 MotivationScore_Category_4_High := (DECIMAL7_4)MotivationScore_Category_4_High_In ;
	DECIMAL7_4 MotivationScore_Category_3_Low := (DECIMAL7_4)MotivationScore_Category_3_Low_In ;
	DECIMAL7_4 MotivationScore_Category_3_High := (DECIMAL7_4)MotivationScore_Category_3_High_In ;
	DECIMAL7_4 MotivationScore_Category_2_Low := (DECIMAL7_4)MotivationScore_Category_2_Low_In ;
	DECIMAL7_4 MotivationScore_Category_2_High := (DECIMAL7_4)MotivationScore_Category_2_High_In ;
	DECIMAL7_4 MotivationScore_Category_1_Low := (DECIMAL7_4)MotivationScore_Category_1_Low_In ;

	// If complete validation of the input category thresholds is needed, high values are needed in the input
	IF(ReadmissionScore_Category_2_Low <= ReadmissionScore_Category_1_High OR 
		ReadmissionScore_Category_3_Low <= ReadmissionScore_Category_2_High OR
		ReadmissionScore_Category_4_Low <= ReadmissionScore_Category_3_High OR
		ReadmissionScore_Category_5_Low <= ReadmissionScore_Category_4_High,
		FAIL('Bad ReadmissionScore_Category thresholds supplied.'));
	// If complete validation of the input category thresholds is needed, high values are needed in the input
	IF(MedicationAdherenceScore_Category_4_Low <= MedicationAdherenceScore_Category_5_High OR 
		MedicationAdherenceScore_Category_3_Low <= MedicationAdherenceScore_Category_4_High OR
		MedicationAdherenceScore_Category_2_Low <= MedicationAdherenceScore_Category_3_High OR
		MedicationAdherenceScore_Category_1_Low <= MedicationAdherenceScore_Category_2_High,
		FAIL('Bad MedicationAdherenceScore_Category thresholds supplied.'));
	// If complete validation of the input category thresholds is needed, high values are needed in the input
	IF(MotivationScore_Category_4_Low <= MotivationScore_Category_5_High OR 
	MotivationScore_Category_3_Low <= MotivationScore_Category_4_High OR
	MotivationScore_Category_2_Low <= MotivationScore_Category_3_High OR
	MotivationScore_Category_1_Low <= MotivationScore_Category_2_High,
	FAIL('Bad MotivationScore_Category thresholds supplied.'));

	Models.Healthcare_SocioEconomic_Core(isCoreRequestValid, batch_in, DPPAPurpose_in, GLBPurpose_in, DataRestrictionMask_in, DataPermissionMask_in, 
											trim(STD.Str.ToUpperCase(Socio_Core_Option),left,right), ofac_version_in, gateways_in_ds, coreResults);
	
	FinalOutput := Models.Healthcare_SocioEconomic_Transforms_Batch_Service_V5.AddScoreCategories(
											coreResults,
											ReadmissionScore_Category_5_Low,
											ReadmissionScore_Category_4_Low,
											ReadmissionScore_Category_3_Low,
											ReadmissionScore_Category_2_Low,
											MedicationAdherenceScore_Category_4_Low,
											MedicationAdherenceScore_Category_3_Low,
											MedicationAdherenceScore_Category_2_Low,
											MedicationAdherenceScore_Category_1_Low,
											MotivationScore_Category_4_Low,
											MotivationScore_Category_3_Low,
											MotivationScore_Category_2_Low,
											MotivationScore_Category_1_Low
											);
    output(FinalOutput, NAMED('Results'));


ENDMACRO;	