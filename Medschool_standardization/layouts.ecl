EXPORT Layouts:= MODULE
	export layoutMedicalSchoolInfo := Record
		string20 	State := '';
		string200	Name 	:= '';
		string100	CampusLocation := '';
		string4		YrEstablished := '';
		string4		YrFirstGradClass := '';
		String4		YrClosed := '';
		string20	Degree := '';
	end;
	export layoutMedicalSchoolInfo1:=record
			unsigned5 MSID := 0;
			layoutMedicalSchoolInfo;
	end;

	export layoutMedicalSchoolWord := Record
			string25 words:='';
			boolean campus :=false;
			boolean region :=false;
	End;

	export layoutMedicalSchoolWords := Record
			unsigned5 MSID := 0;
			dataset(layoutMedicalSchoolWord) wordcollection;		
			unsigned 	Score := 0;
	End;

	export layoutMedicalSchoolWordParse := Record
			string25 words:='';
	End;

	export layoutMedicalSchoolWord1 := Record
		unsigned5 MSID := 0;
		layoutMedicalSchoolWord;		
		unsigned 	WordCountMatch := 0;
		unsigned 	WordCountTotal := 0;
		decimal5_2 	ConfidenceScore := 0;
		unsigned 	Score := 0;
		String20  ConfidenceScoreFlags:='';
	End;

	export splitRec := record
			string 	word := '';
	end;
End;