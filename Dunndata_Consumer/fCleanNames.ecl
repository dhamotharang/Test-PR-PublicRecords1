IMPORT Nid;
EXPORT fCleanNames(DATASET(RECORDOF(Layout_Basefile)) inFile) := FUNCTION

	Nid.Mac_CleanFullNames(inFile,inFile_CleanName,MSNAME,,,,,,,,,,,,,,,,,true,,true);
	
	// Layout_Basefile tx(DATASET(RECORDOF(inFile_CleanName)) L) := TRANSFORM
	Layout_Basefile tx(inFile_CleanName L) := TRANSFORM
		SELF.clean_name_type	:=	L.nametype;
		SELF.clean_title			:=	L.cln_title;
		SELF.clean_fname			:=	L.cln_fname;
		SELF.clean_mname			:=	L.cln_mname;
		SELF.clean_lname			:=	L.cln_lname;
		SELF.clean_suffix			:=	L.cln_suffix;
		SELF.clean_cname			:=	L.cname;
		SELF											:=	L;
		SELF											:= [];
	END;
	
	RETURN PROJECT(inFile_CleanName, tx(LEFT));
	
END;
