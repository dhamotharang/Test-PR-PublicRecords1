IMPORT Header, Address, ut, NID;
EXPORT fn_cleanName(DATASET(RECORDOF(Business_Credit.Layouts.SBFEAccountLayout)) individual) := FUNCTION 

	Clean_Name(DATASET(RECORDOF(individual)) pInput) := FUNCTION
		NID.Mac_CleanParsedNames(pInput, cleaned_names, Original_fname, Original_mname, Original_lname, Original_suffix, normalizeDualNames:=FALSE, useV2:=TRUE);
		RETURN cleaned_names;
	END;

	Standardize_Name(DATASET(RECORDOF(individual)) pPreProcessInput) := FUNCTION

		// Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
		// this type of definition - action must precede an expression."
		dCleanedInput := Clean_Name(pPreProcessInput);
		
		RECORDOF(individual) tAddCleanName(dCleanedInput L) := TRANSFORM
			SELF.Clean_title			:=	L.cln_title;
			SELF.Clean_fname			:=	L.cln_fname;
			SELF.Clean_mname			:=	L.cln_mname;
			SELF.Clean_lname			:=	L.cln_lname;
			SELF.Clean_suffix			:=	L.cln_suffix;
			SELF									:=	L;
		END;
		
		RETURN PROJECT(dCleanedInput, tAddCleanName(LEFT));

	END;

	RETURN Standardize_Name(individual);
END;