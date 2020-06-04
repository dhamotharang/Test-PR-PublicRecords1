EXPORT mac_NID_cleanName2(DatasetIn, First_Name, Middle_Name, Last_Name, DatasetOut) := MACRO

IMPORT NID,NID_Support; 

 #uniquename(pDatasetIn)
 %pDataSetIn% := PROJECT(DatasetIn, TRANSFORM({RECORDOF(DatasetIn), STRING5 Suffix_Name},
																									SELF.Suffix_Name := '';
																									SELF := LEFT;
																									));

	#uniquename(Cleaned_Names_2)
	NID.Mac_CleanParsedNames(%pDataSetIn%, %cleaned_names_2%, First_Name, Middle_Name, Last_Name, Suffix_Name);

	#uniquename(Add_Clean_Name_2) 
	TYPEOF(DatasetIn) %add_clean_name_2%(%cleaned_names_2% L) := TRANSFORM
		SELF.Title2			:= L.cln_Title;
		SELF.FName2			:= IF(L.cln_Fname = 'UNKNOWN','',L.cln_Fname);
		SELF.MName2			:= IF(L.cln_Mname = 'UNKNOWN','',L.cln_Mname);
		SELF.LName2			:= IF(L.cln_Lname = 'UNKNOWN','',L.cln_Lname);
		SELF.Suffix2		:= L.cln_Suffix;
		SELF.NID2     := L.NID;
		SELF := L;
		SELF := [];  
	END;
	Clean_Names_2 := PROJECT(%cleaned_names_2%, %add_clean_name_2%(LEFT));

	DatasetOut := Clean_Names_2;

ENDMACRO;
