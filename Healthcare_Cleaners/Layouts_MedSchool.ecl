Import Medschool_standardization;
EXPORT Layouts_MedSchool := MODULE
	export layoutmedschoolbatchin := record
		string20	 	acctno := '';
		String100 	medSchoolName := '';
		String20 		state := '';
	end;

	export layoutMedicalSchoolFinal := Record
		string20	 	acctno := '';
		String100 	raw_medSchoolName := '';
		String20 		raw_state := '';
		unsigned5 	MSID := 0;
		unsigned 		Score := 0;
		decimal5_2 	ConfidenceScore := 0;
		String20  	ConfidenceScoreFlags:='';
		Medschool_standardization.layouts.layoutMedicalSchoolInfo;
	End;
	export layoutMedicalSchoolTmp := Record
		string20	 	acctno := '';
		dataset(layoutMedicalSchoolFinal) rawRecs;
	end;
End;