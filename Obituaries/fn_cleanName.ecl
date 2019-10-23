IMPORT Header, Address, ut, NID, Death_Master, STD;
EXPORT fn_cleanName(DATASET(RECORDOF(Header.Layout_Did_Death_MasterV3)) obit) := FUNCTION 

	RECORDOF(obit) tPrepObit(RECORDOF(obit) pInput) := TRANSFORM
		// Clean up middle name first
		mname_clean_null	:=	StringLib.StringToUpperCase(STD.Str.Filter(Death_Master.fn_cleanNULL(pInput.mname),'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'));
		mname_clean				:=	IF(TRIM(mname_clean_null) IN ['UNKNOWN'],'',TRIM(mname_clean_null));	
		
		// Clean rest of name
		fname_clean 			:=	Death_Master.fn_cleanNULL(pInput.fname);
		lname_clean				:=	Death_Master.fn_cleanNULL(pInput.lname);
		suffix_clean			:=	Death_Master.fn_cleanNULL(pInput.name_suffix);
															
		SELF.fname				:=	fname_clean;
		SELF.mname				:=	mname_clean;
		SELF.lname				:=	lname_clean;
		SELF.name_suffix	:=	suffix_clean;
		SELF							:=	pInput;
	END;

	dPreppedObit := PROJECT(obit,tPrepObit(LEFT));

	Clean_Name(DATASET(RECORDOF(obit)) pInput) := FUNCTION
		NID.Mac_CleanParsedNames(pInput, cleaned_names, fname, mname, lname, name_suffix, normalizeDualNames:=FALSE);
		RETURN cleaned_names;
	END;

	Standardize_Name(DATASET(RECORDOF(obit)) pPreProcessInput) := FUNCTION

		// Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
		// this type of definition - action must precede an expression."
		dCleanedInput := Clean_Name(pPreProcessInput);
		
		RECORDOF(obit) tAddCleanName(dCleanedInput L) := TRANSFORM
			SELF.fname				:=	L.cln_fname;
			SELF.mname				:=	L.cln_mname;
			SELF.lname				:=	L.cln_lname;
			SELF.name_suffix	:=	L.cln_suffix;
			SELF := L;
		END;
		
		RETURN PROJECT(dCleanedInput, tAddCleanName(LEFT));

	END;

	RETURN Standardize_Name(dPreppedObit);
END;