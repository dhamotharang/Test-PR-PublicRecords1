EXPORT Clean_Name (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Infile) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header cleanMName (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header L) := TRANSFORM
		LNAME 			:= TRIM(L.LNAME);
		FNAME 			:= TRIM(L.FNAME);		
		MNAME 			:= TRIM(L.MNAME);
		SELF.MNAME	:= CleanMedicalWords.CleanMedicalName(MName);
		C_LNAME			:= CleanMedicalWords.cleanMedicalName(LNAME);
		C_FNAME			:= CleanMedicalWords.cleanMedicalName(FNAME);
		SELF.LNAME	:= IF (TRIM(C_LNAME) <> '',C_LNAME,LNAME);
		SELF.FNAME	:= IF (TRIM(C_FNAME) <> '',C_FNAME,FNAME);
		SELF 				:= L;
		SELF				:=	[];
	END;

	Norm_MName_DS := PROJECT (Infile, cleanMName(LEFT));
	
	RETURN Norm_MName_DS (TRIM(LName) <> '' and (FName) <> '');
end;
