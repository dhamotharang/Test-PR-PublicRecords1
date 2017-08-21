IMPORT Address, NID;

BaseExtra_Rec := RECORD
	Layouts.Base;
	STRING complete_name;
END;

Clean_Name(DATASET(BaseExtra_Rec) pInput) := FUNCTION

  NID.Mac_CleanFullNames(pInput, cleaned_names, complete_name);

  RETURN cleaned_names;

END;

EXPORT Standardize_Name(DATASET(Layouts.Base) pPreProcessInput) := FUNCTION

  miPreProcessInput := pPreProcessInput(customer_id = _Constants().mi_cust_id);
	ilPreProcessInput := pPreProcessInput(customer_id = _Constants().il_cust_id);

	BaseExtra_Rec add_complete_name(Layouts.Base L) := TRANSFORM
    SELF.complete_name := IF(L.company_name = '',
		                         TRIM(L.name_first_middle + ' ' + L.name_last + ' ' + L.name_suffix),
														 '');

    SELF := L;
  END;

	input_with_complete_name := PROJECT(miPreProcessInput, add_complete_name(LEFT));

  // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	// this type of definition - action must precede an expression."
	cleaned_input := Clean_Name(input_with_complete_name);

  // Logic added to the transform to take care of those names the NID can't currently handle.
	// "Bad" types will now be forced into the clean fields.  Hopefully, a better fix through the NID
	// or another utility will take care of this hack in the future. (7/30/14)
  Layouts.Base add_clean_name(cleaned_input L) := TRANSFORM
	  is_blank         := L.nametype = '';
		// If the clean name portions are blank, it's not recognized as a person
		force_fake_clean := L.cln_fname = '' AND NOT(is_blank);

    // Only the first, last, and suffix need to be force-assigned... the others will either come in
		// with a proper value or be null on their own from the NID.
	  SELF.clean_name.title       := L.cln_title;
	  SELF.clean_name.fname       := IF(force_fake_clean, L.name_first_middle, L.cln_fname);
	  SELF.clean_name.mname       := L.cln_mname;
	  SELF.clean_name.lname       := IF(force_fake_clean, L.name_last, L.cln_lname);
	  SELF.clean_name.name_suffix := IF(force_fake_clean, L.name_suffix, L.cln_suffix);

	  SELF := L;
	END;

  // Requirements dictate that the names from the vendor are not to be cleaned at all.  So, we
	// simply pass the information to the clean fields to be used by query, etc.
  Layouts.Base add_clean_il_name(Layouts.Base L) := TRANSFORM
	  SELF.clean_name.fname       := L.name_first;
	  SELF.clean_name.mname       := L.name_middle;
	  SELF.clean_name.lname       := L.name_last;
	  SELF.clean_name.name_suffix := L.name_suffix;

	  SELF := L;
	END;

	MI := PROJECT(cleaned_input, add_clean_name(LEFT));
	IL := PROJECT(ilPreProcessInput, add_clean_il_name(LEFT));

  RETURN MI + IL;

END;
