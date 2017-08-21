IMPORT Header, Address, STD, NID, _Validate;
EXPORT fn_cleanName(DATASET(RECORDOF(Header.layout_death_master_supplemental)) supp) := FUNCTION 

	RECORDOF(supp) tPrepSupp(RECORDOF(supp) pInput) := TRANSFORM
		// Clean up middle name first
		mname_clean_null	:=	STD.Str.Filter(StringLib.StringToUpperCase(Death_Master.fn_cleanNULL(pInput.mname)),_Validate.Strings.Alpha_Upper);
		mname_clean				:=	IF(TRIM(mname_clean_null) IN ['UNKNOWN'],'',TRIM(mname_clean_null));	
		
		// Clean rest of name
		fname_clean 			:=	Death_Master.fn_cleanNULL(pInput.fname);
		lname_clean				:=	Death_Master.fn_cleanNULL(pInput.lname);
		suffix_clean			:=	Death_Master.fn_cleanNULL(pInput.name_suffix);
															
		SELF.fname  						:=	fname_clean;
		SELF.mname  						:=	mname_clean;
		SELF.lname  						:=	lname_clean;
		SELF.name_suffix  			:=	suffix_clean;
		SELF.decedent_name			:=	StringLib.StringToUpperCase(StringLib.StringCleanSpaces(
																	IF(	(TRIM(lname_clean)<>'' OR TRIM(suffix_clean)<>'') AND 
																			(TRIM(fname_clean)<>'' OR TRIM(mname_clean)<>''),
																				TRIM(lname_clean+' '+suffix_clean,LEFT,RIGHT)+', '+
																				TRIM(fname_clean+' '+mname_clean,LEFT,RIGHT),
																				IF((TRIM(lname_clean)<>'' OR TRIM(suffix_clean)<>''),
																					TRIM(lname_clean+' '+suffix_clean,LEFT,RIGHT),
																					TRIM(fname_clean+' '+mname_clean,LEFT,RIGHT)
																				)
																	)
																));
		SELF										:=	pInput;
	END;

	dPreppedSupp := PROJECT(supp,tPrepSupp(LEFT));

	Clean_Name(DATASET(RECORDOF(supp)) pInput) := FUNCTION
		NID.Mac_CleanParsedNames(pInput, cleaned_names, fname, mname, lname, name_suffix, normalizeDualNames:=FALSE);
		RETURN cleaned_names;
	END;

	Standardize_Name(DATASET(RECORDOF(supp)) pPreProcessInput) := FUNCTION

		// Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
		// this type of definition - action must precede an expression."
		dCleanedInput := Clean_Name(pPreProcessInput);
		
		RECORDOF(supp) tAddCleanName(dCleanedInput L) := TRANSFORM
			SELF.title				:=	L.cln_title;
			SELF.fname				:=	L.cln_fname;
			SELF.mname				:=	L.cln_mname;
			SELF.lname				:=	L.cln_lname;
			SELF.name_suffix	:=	L.cln_suffix;
			SELF.name_score		:=	(STRING)0;
			SELF := L;
		END;
		
		RETURN PROJECT(dCleanedInput, tAddCleanName(LEFT));

	END;

	RETURN Standardize_Name(dPreppedSupp);
	// RETURN dPreppedSupp; // Test Only
END;