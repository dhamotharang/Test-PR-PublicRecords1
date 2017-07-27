EXPORT Clean_Name (DATASET (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header) Infile) := FUNCTION

	HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header cleanMName (HealthCareProvider.Layout_HealthProvider.HealthCareProvider_Header L) := TRANSFORM
		LNAME 			:= TRIM(L.LNAME);
		FNAME 			:= TRIM(L.FNAME);		
		MNAME 			:= TRIM(L.MNAME);
		SELF.MNAME	:= 	CleanMedicalWords.CleanMedicalName(MName);
		SELF.LNAME	:=	CleanMedicalWords.cleanMedicalName(LNAME);
		SELF.FNAME	:=	CleanMedicalWords.cleanMedicalName(FNAME);
		SELF 				:= L;
		SELF				:=	[];
	END;

	Norm_MName_DS := PROJECT (Infile, cleanMName(LEFT));
	
	RETURN Norm_MName_DS (TRIM(LName) <> '' and (FName) <> '');
end;
