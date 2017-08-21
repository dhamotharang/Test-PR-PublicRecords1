IMPORT CRIM;

EXPORT layout_fl_pasco := MODULE

	EXPORT raw_in	:= RECORD //RL = 123
		string7 	Record_Type;
		string14	CJIS_Case_Number;
		string30	Defendant_Name;
		string22	Defendant_Address;
		string15	City;
		string2		State;
		string5		Zip_Code;
		string6		Birth_Date;
		string6		Case_Filing_Date;
		string11	Statute_Reference;
		string1		Court_Action_Taken;
		string3		Sentence_Provisions;
		string1		Special_Sentence_Provisions;
	END;
	
	EXPORT statute_lkp	:= RECORD
		string11	statute;
		string71	description;
		string1		lf;
	END;
	
END;


