import Address, NID;

Clean_Name(DATASET(Layouts.Base.Main) pInput) := FUNCTION

  NID.Mac_CleanParsedNames(pInput, cleaned_names,
	                            rawdemographicsfields.first_name, rawdemographicsfields.middle_name,
															rawdemographicsfields.last_name, rawdemographicsfields.suffix_name);

  RETURN cleaned_names;

END;

export Standardize_Name(dataset(Layouts.Base.Main) pPreProcessInput) :=
function

	cleaned_input := Clean_Name(pPreProcessInput);
	
  Layouts.Base.Main add_clean_name(cleaned_input L) := TRANSFORM
	  SELF.clean_name.title       := L.cln_title;
	  SELF.clean_name.fname       := L.cln_fname;
	  SELF.clean_name.mname       := L.cln_mname;
	  SELF.clean_name.lname       := L.cln_lname;
	  SELF.clean_name.name_suffix := L.cln_suffix;
	
	  SELF := L;
	END;
	
	return PROJECT(cleaned_input, add_clean_name(LEFT));

end;
