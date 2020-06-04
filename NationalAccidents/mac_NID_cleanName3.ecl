EXPORT mac_NID_cleanName3(DatasetIn, First_Name, Middle_Name, Last_Name, DatasetOut) := MACRO

IMPORT NID,NID_Support; 

 #uniquename(pDatasetIn)
 %pDataSetIn% := PROJECT(DatasetIn, TRANSFORM({RECORDOF(DatasetIn), STRING5 Suffix_Name},
																									SELF.Suffix_Name := '';
																									SELF := LEFT;
																									));

	#uniquename(Cleaned_Names_3)
	NID.Mac_CleanParsedNames(%pDataSetIn%, %cleaned_names_3%, First_Name, Middle_Name, Last_Name, Suffix_Name);

	#uniquename(Add_Clean_Name_3) 
	TYPEOF(DatasetIn) %add_clean_name_3%(%cleaned_names_3% L) := TRANSFORM
		SELF.Title3			:= L.cln_Title;
		SELF.FName3			:= IF(L.cln_Fname = 'UNKNOWN','',L.cln_Fname);
		SELF.MName3			:= IF(L.cln_Mname = 'UNKNOWN','',L.cln_Mname);
		SELF.LName3			:= IF(L.cln_Lname = 'UNKNOWN','',L.cln_Lname);
		SELF.Suffix3		:= L.cln_Suffix;
		SELF.NID3     := L.NID;
		SELF := L;
		SELF := [];  
	END;
	Clean_Names_3 := PROJECT(%cleaned_names_3%, %add_clean_name_3%(LEFT));

	DatasetOut := Clean_Names_3;

ENDMACRO;
