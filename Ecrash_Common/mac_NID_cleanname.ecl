EXPORT mac_NID_cleanName(DatasetIn, First_Name, Middle_Name, Last_Name, DatasetOut) := MACRO

IMPORT NID,NID_Support; 

 #uniquename(pDatasetIn)
 %pDataSetIn% := PROJECT(DatasetIn, TRANSFORM({RECORDOF(DatasetIn), STRING5 Suffix_Name},
																									SELF.Suffix_Name := '';
																									SELF := LEFT;
																									));

	#uniquename(Cleaned_Names)
	NID.Mac_CleanParsedNames(%pDataSetIn%, %cleaned_names%, First_Name, Middle_Name, Last_Name, Suffix_Name);

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
	Clean_Names := PROJECT(%cleaned_names%, %add_clean_name%(LEFT));

	DatasetOut := Clean_Names;

ENDMACRO;
