EXPORT mac_NID_cleannames(DatasetIn, DatasetOut) := MACRO

IMPORT NID; 

 #uniquename(pDatasetIn)
 %pDataSetIn% := PROJECT(DatasetIn, TRANSFORM({RECORDOF(DatasetIn), STRING5 Suffix_Name},
																									SELF.Suffix_Name := '';
																									SELF := LEFT;
																									));

	#uniquename(Cleaned_Names)
	NID.Mac_CleanParsedNames(%pDataSetIn%, %cleaned_names%, First_Name_1, Middle_Name_1, Last_Name_1, Suffix_Name);

	#uniquename(Add_Clean_Name) 
	TYPEOF(DatasetIn) %add_clean_name%(%cleaned_names% L) := TRANSFORM
		SELF.Title			:= L.cln_Title;
		SELF.Fname			:= IF(L.cln_Fname = 'UNKNOWN','',L.cln_Fname);
		SELF.Mname			:= IF(L.cln_Mname = 'UNKNOWN','',L.cln_Mname);
		SELF.Lname			:= IF(L.cln_Lname = 'UNKNOWN','',L.cln_Lname);
		SELF.Suffix		:= L.cln_Suffix;
		SELF.NID     := L.NID;
		SELF := L;
		SELF := [];  
	END;
	#uniquename(pCleanNames)
	clean_names := PROJECT(%cleaned_names%, %add_clean_name%(LEFT));
	
	#uniquename(pCleanNames)
	%pCleanNames% := PROJECT(clean_names, TRANSFORM({RECORDOF(clean_names), STRING5 Suffix_Name},
																									SELF.Suffix_Name := '';
																									SELF := LEFT;
																									));
	
	#uniquename(Cleaned_Names_2)
	NID.Mac_CleanParsedNames(%pCleanNames%, %cleaned_names_2%, First_Name_2, Middle_Name_2, Last_Name_2, Suffix_Name);

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
	clean_names_2 := PROJECT(%cleaned_names_2%, %add_clean_name_2%(LEFT));
	
	#uniquename(pCleanNames2)
	%pCleanNames2% := PROJECT(clean_names_2, TRANSFORM({RECORDOF(clean_names_2), STRING5 Suffix_Name},
																									SELF.Suffix_Name := '';
																									SELF := LEFT;
																									));

	#uniquename(Cleaned_Names_3)
	NID.Mac_CleanParsedNames(%pCleanNames2%, %cleaned_names_3%, First_Name_3, Middle_Name_3, Last_Name_3, Suffix_Name);

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
