EXPORT Functions_FacilityType := MODULE

		Layout := RECORD
			unsigned1 FacilityTypeID,
			string20  FacilityTypeName
		END;	

		EXPORT Values := DATASET([
						{ 1, 'AGENCY'},
						{ 2, 'AMBULANCE'},
						{ 3, 'EQUIPMENT SUPPLIES'},
						{ 4, 'EXTENDED CARE'},
						{ 5, 'HOSPITAL'},
						{ 6, 'IMAGING'},
						{ 7, 'LABORATORY'},
						{ 8, 'MANAGEMENT'},
						{ 9, 'MISCELLANEOUS'},
						{10, 'OUTPATIENT FACILITY'},
						{11, 'PHARMACY'},
						{12, 'PRACT'}
						], 
						Layout);

END;