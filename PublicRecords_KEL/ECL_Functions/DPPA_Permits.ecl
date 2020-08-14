IMPORT codes;
IMPORT KEL13 AS KEL;

EXPORT DPPA_Permits := MODULE
	
	EXPORT BitOr(DATA100 a, DATA100 b) := KEL.Permits.BitOr(a, b);
	
	// Any states listed in this key are RESTRICTED with the DPPA value indicated in the Code field.
	// We also need to differentiate whether the source is Experian or not.
	SHARED DPPACodes := codes.key_codes_v3(KEYED(file_name='GENERAL') AND KEYED(field_name IN ['DL-PURPOSE', 'EXPERIAN-DL-PURPOSE']));
	
	SHARED SourceLayout := RECORD
		STRING5 State;
		BOOLEAN IsExperian;
	END;
	
	SHARED TaggedLayout := RECORD
		DATASET(SourceLayout) States;
		BOOLEAN RestrictDPPA1;
		BOOLEAN RestrictDPPA2;
		BOOLEAN RestrictDPPA3;
		BOOLEAN RestrictDPPA4;
		BOOLEAN RestrictDPPA5;
		BOOLEAN RestrictDPPA6;
		BOOLEAN RestrictDPPA7;
	END;
		
	SHARED DPPATagged := SORT(PROJECT(DPPACodes, TRANSFORM(TaggedLayout,
		SELF.States := DATASET([{TRIM(LEFT.Field_Name2), LEFT.Field_Name = 'EXPERIAN-DL-PURPOSE'}], SourceLayout);
		SELF.RestrictDPPA1 := (UNSIGNED1)LEFT.Code = 1;
		SELF.RestrictDPPA2 := (UNSIGNED1)LEFT.Code = 2;
		SELF.RestrictDPPA3 := (UNSIGNED1)LEFT.Code = 3;
		SELF.RestrictDPPA4 := (UNSIGNED1)LEFT.Code = 4;
		SELF.RestrictDPPA5 := (UNSIGNED1)LEFT.Code = 5;
		SELF.RestrictDPPA6 := (UNSIGNED1)LEFT.Code = 6;
		SELF.RestrictDPPA7 := (UNSIGNED1)LEFT.Code = 7;
		)), States[1].State, States[1].IsExperian);
	
	SHARED DPPACombinedState := SORT(ROLLUP(DPPATagged, LEFT.States[1].State = RIGHT.States[1].State AND LEFT.States[1].IsExperian = RIGHT.States[1].IsExperian, TRANSFORM(TaggedLayout,
		SELF.RestrictDPPA1 := LEFT.RestrictDPPA1 OR RIGHT.RestrictDPPA1;
		SELF.RestrictDPPA2 := LEFT.RestrictDPPA2 OR RIGHT.RestrictDPPA2;
		SELF.RestrictDPPA3 := LEFT.RestrictDPPA3 OR RIGHT.RestrictDPPA3;
		SELF.RestrictDPPA4 := LEFT.RestrictDPPA4 OR RIGHT.RestrictDPPA4;
		SELF.RestrictDPPA5 := LEFT.RestrictDPPA5 OR RIGHT.RestrictDPPA5;
		SELF.RestrictDPPA6 := LEFT.RestrictDPPA6 OR RIGHT.RestrictDPPA6;
		SELF.RestrictDPPA7 := LEFT.RestrictDPPA7 OR RIGHT.RestrictDPPA7;
		SELF.States := LEFT.States)), RestrictDPPA1, RestrictDPPA2, RestrictDPPA3, RestrictDPPA4, RestrictDPPA5, RestrictDPPA6, RestrictDPPA7, States[1].State, States[1].IsExperian);
	
	// Generate dataset at runtime to show data from which states can be returned for each DPPA value.
	// Each unique combination of permitted/restricted DPPA settings gets grouped together into a bit of the KEL DPM. 
	// For example, Experian Arizona and Experian Montana Vehicle records are allowed with a DPPA of 1, 2, 3, and 6, and restricted with any other DPPA value, so they make up one of the DPPA groups.
	EXPORT DPPAGroups := SORT(ROLLUP(DPPACombinedState, 
		LEFT.RestrictDPPA1 = RIGHT.RestrictDPPA1 AND 
		LEFT.RestrictDPPA2 = RIGHT.RestrictDPPA2 AND 
		LEFT.RestrictDPPA3 = RIGHT.RestrictDPPA3 AND 
		LEFT.RestrictDPPA4 = RIGHT.RestrictDPPA4 AND 
		LEFT.RestrictDPPA5 = RIGHT.RestrictDPPA5 AND
		LEFT.RestrictDPPA6 = RIGHT.RestrictDPPA6 AND
		LEFT.RestrictDPPA7 = RIGHT.RestrictDPPA7, TRANSFORM(TaggedLayout, SELF.States := LEFT.States + RIGHT.States; SELF := LEFT)), RECORD);

	// CheckDPPAPermits takes the an input DPPA value, and sets each KEL DPM DPPAGroup bit to 1 which the given DPPA value should give us access to 
	// based on the DPPAGroups defined above.
	EXPORT CheckDPPAPermits(FieldName, isFCRA, KELPermissions) := FUNCTIONMACRO
		DPPA_Permits :=
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[1].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup1) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[2].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup2) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[3].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup3) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[4].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup4) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[5].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup5) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[6].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup6) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[7].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup7) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[8].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup8) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[9].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup9) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[10].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup10) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[11].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup11) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[12].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup12) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[13].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup13) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[14].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup14) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[15].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup15) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[16].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup16) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[17].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup17) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[18].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup18) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[19].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup19) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[20].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup20) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[21].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup21) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[22].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup22) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[23].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup23) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[24].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup24) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[25].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup25) ,
				BitOr(IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[26].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup26) ,
							IF(NOT isFCRA AND PublicRecords_KEL.ECL_Functions.DPPA_Permits.DPPAGroups[27].FieldName = TRUE, KELPermissions.Permit__NONE, KELPermissions.Permit_DPPAGroup27)
							))))))))))))))))))))))))));
			
		RETURN DPPA_Permits;	
	ENDMACRO;
END;