IMPORT Address, NID;



EXPORT Standardize_Name := module

  // An executive decision was made to consider Unclassifed and Invalid names as company names
  shared business_flags := ['B', 'U', 'I'];

  export InsiderFF(DATASET(Vickers.Layouts_raw.common_FF_clean) pPreProcessInput) := module

    Clean_Name_InsiderFF(DATASET(Vickers.Layouts_raw.common_FF_clean) pInput) := FUNCTION

      NID.Mac_CleanFullNames(pInput, cleaned_names,filer_name);

      RETURN cleaned_names;
    end;

    // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	  // this type of definition - action must precede an expression."
	  cleaned_input := Clean_Name_InsiderFF(pPreProcessInput);
	
    Vickers.Layouts_raw.common_FF_clean add_clean_name(cleaned_input L) := TRANSFORM
	
	    SELF.clean_name.title       := IF ( L.nametype NOT IN business_flags,L.cln_title,'');
	    SELF.clean_name.fname       := IF ( L.nametype NOT IN business_flags,L.cln_fname,'');
	    SELF.clean_name.mname       := IF ( L.nametype NOT IN business_flags,L.cln_mname,'');
	    SELF.clean_name.lname       := IF ( L.nametype NOT IN business_flags,L.cln_lname,'');
	    SELF.clean_name.name_suffix := IF ( L.nametype NOT IN business_flags,L.cln_suffix,'');
	
	    SELF := L;
	  END;
	
	  export clname :=  PROJECT(cleaned_input, add_clean_name(LEFT));

  END;  //End InsiderFF module



  export cln_13d13g(DATASET(Vickers.Layouts_raw.Layout_13D13G_clean) pPreProcessInput) := module

    Clean_Signer_Name(DATASET(Vickers.Layouts_raw.Layout_13D13G_clean) pInput) := FUNCTION

      NID.Mac_CleanFullNames(pInput, cleaned_names,signer_name);

      RETURN cleaned_names;

    END;



    // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	  // this type of definition - action must precede an expression."
	  cln_sig_input := Clean_Signer_Name(pPreProcessInput);
	

	
    Vickers.Layouts_raw.Layout_13D13G_clean add_clean_sig(cln_sig_input L) := TRANSFORM
	
	    SELF.clean_signer_name.title       := IF ( L.nametype NOT IN business_flags,L.cln_title,'');
	    SELF.clean_signer_name.fname       := IF ( L.nametype NOT IN business_flags,L.cln_fname,'');
	    SELF.clean_signer_name.mname       := IF ( L.nametype NOT IN business_flags,L.cln_mname,'');
	    SELF.clean_signer_name.lname       := IF ( L.nametype NOT IN business_flags,L.cln_lname,'');
	    SELF.clean_signer_name.name_suffix := IF ( L.nametype NOT IN business_flags,L.cln_suffix,'');
	
	    SELF := L;
	  END;
	
	  clsigout :=  PROJECT(cln_sig_input, add_clean_sig(LEFT));
	 
	  Clean_contact_Name(DATASET(Vickers.Layouts_raw.Layout_13D13G_clean) pInput) := FUNCTION

      NID.Mac_CleanFullNames(pInput, cleaned_names,contact_name);

      RETURN cleaned_names;

    END;

	 
	  cln_contact_input := Clean_contact_Name(clsigout);
	 
	  Vickers.Layouts_raw.Layout_13D13G_clean add_clean_contact(cln_contact_input L) := TRANSFORM
	
	    SELF.clean_contact_name.title       := IF ( L.nametype NOT IN business_flags,L.cln_title,'');
	    SELF.clean_contact_name.fname       := IF ( L.nametype NOT IN business_flags,L.cln_fname,'');
	    SELF.clean_contact_name.mname       := IF ( L.nametype NOT IN business_flags,L.cln_mname,'');
	    SELF.clean_contact_name.lname       := IF ( L.nametype NOT IN business_flags,L.cln_lname,'');
	    SELF.clean_contact_name.name_suffix := IF ( L.nametype NOT IN business_flags,L.cln_suffix,'');
	
	    SELF := L;
	  END;
	
	  clcontactout :=  PROJECT(cln_contact_input, add_clean_contact(LEFT));
	 
	  Clean_filer_Name(DATASET(Vickers.Layouts_raw.Layout_13D13G_clean) pInput) := FUNCTION

      NID.Mac_CleanFullNames(pInput, cleaned_names,filer_name);

      RETURN cleaned_names;

    END;
	 
	 
	  cln_filer_input := Clean_filer_Name(clcontactout);
	 
	  Vickers.Layouts_raw.Layout_13D13G_clean add_clean_filer(cln_filer_input L) := TRANSFORM
	
	    SELF.clean_filer_name.title       := IF ( L.nametype NOT IN business_flags,L.cln_title,'');
	    SELF.clean_filer_name.fname       := IF ( L.nametype NOT IN business_flags,L.cln_fname,'');
	    SELF.clean_filer_name.mname       := IF ( L.nametype NOT IN business_flags,L.cln_mname,'');
	    SELF.clean_filer_name.lname       := IF ( L.nametype NOT IN business_flags,L.cln_lname,'');
	    SELF.clean_filer_name.name_suffix := IF ( L.nametype NOT IN business_flags,L.cln_suffix,'');
	
	    SELF := L;
	  END;
	
	  export cln_all :=  PROJECT(cln_filer_input, add_clean_filer(LEFT));
	 
	 

  END;  //End cln_13d13g module

end; //End Standardize_Name