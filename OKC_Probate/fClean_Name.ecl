#OPTION('multiplePersistInstances',FALSE);
IMPORT ut, address,nid,OKC_Probate,BIPV2;

EXPORT fClean_Name(DATASET(RECORDOF(OKC_Probate.Layout.raw_v2)) InFile) := FUNCTION

layout_name		:= RECORD
	STRING  fname;
	STRING		lname;
	STRING		fullname;
	Layout.raw_v2;
END;

layout_name tPrepInfile(RECORDOF(InFile) L) := TRANSFORM
	 self.fname  := ut.CleanSpacesAndUpper(L.DebtorFirstName);	
  self.lname  := ut.CleanSpacesAndUpper(L.DebtorLastName);	
		self.FullName  := StringLib.StringCleanSpaces(self.lname + ' ' + self.fname);	
		SELF										:=	L;
	END;

	dPreppedInFile := PROJECT(InFile,tPrepInfile(LEFT));


//Clean name fields
CleanNames_full   := Nid.fn_CleanFullNames(dPreppedInFile,FullName,,,,,,
                                            ,,,,,,,,TRUE,FALSE,,TRUE,,useV2 := true);
Clean_Name          := PROJECT(CleanNames_full,OKC_Probate.Layout.CleanName);
/*
//Map to raw_v2 output - prepare for mapping to death_masterv3 output
Layout.raw_v2 tAddCleanName(Cln_Name L) := TRANSFORM
			SELF.title				:=	L.cln_title;
			SELF.fname				:=	L.cln_fname;
			SELF.mname				:=	L.cln_mname;
			SELF.lname				:=	L.cln_lname;
			SELF.name_suffix	:=	L.cln_suffix;
			SELF.name_score		:=	(STRING)0;
			SELF := L;
			SELF := [];
		END;
		
		Standardize_Name := PROJECT(Cln_Name, tAddCleanName(LEFT)):persist('~thor_data400::in::persist::Clean_Name');

	*/
	RETURN Clean_Name;
END;
