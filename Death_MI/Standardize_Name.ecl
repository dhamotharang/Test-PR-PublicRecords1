IMPORT Address, NID;

BaseExtra_Rec := RECORD
	Layouts.Base;
	STRING name_suffix := '';
END;

Clean_Name(DATASET(BaseExtra_Rec) pInput) := FUNCTION

  NID.Mac_CleanParsedNames(pInput, cleaned_names, fname, mname, lname, name_suffix);

  RETURN cleaned_names;

END;

EXPORT Standardize_Name(DATASET(Layouts.Base) pPreProcessInput) := FUNCTION

	input_with_name_suffix := PROJECT(pPreProcessInput, BaseExtra_Rec);

  // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	// this type of definition - action must precede an expression."
	cleaned_input := Clean_Name(input_with_name_suffix);
	
  Layouts.Base add_clean_name(cleaned_input L) := TRANSFORM
	  SELF.clean_name.title       := L.cln_title;
	  SELF.clean_name.fname       := L.cln_fname;
	  SELF.clean_name.mname       := L.cln_mname;
	  SELF.clean_name.lname       := L.cln_lname;
	  SELF.clean_name.name_suffix := L.cln_suffix;
	
	  SELF := L;
	END;
	
	RETURN PROJECT(cleaned_input, add_clean_name(LEFT));

END;
