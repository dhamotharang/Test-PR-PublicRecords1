IMPORT Address, NID;



EXPORT Standardize_Name := module



export aircraft(DATASET(Layouts.aircraft_reg.temp) pPreProcessInput) := module

Clean_Name_Acft(DATASET(Layouts.aircraft_reg.temp) pInput) := FUNCTION

  NID.Mac_CleanFullNames(pInput, cleaned_names,fullnm);

  RETURN cleaned_names;
end;

  // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	// this type of definition - action must precede an expression."
	cleaned_input := Clean_Name_Acft(pPreProcessInput);
	
  layouts.aircraft_reg.innew add_clean_name(cleaned_input L) := TRANSFORM
	
	  SELF.clean_name.title       := IF ( L.nametype <> 'B',L.cln_title,'');
	  SELF.clean_name.fname       := IF ( L.nametype <> 'B',L.cln_fname,'');
	  SELF.clean_name.mname       := IF ( L.nametype <> 'B',L.cln_mname,'');
	  SELF.clean_name.lname       := IF ( L.nametype <> 'B',L.cln_lname,'');
	  SELF.clean_name.name_suffix := IF ( L.nametype <> 'B',L.cln_suffix,'');
		self.compname               := if( L.nametype = 'B', L.fullnm,''); 
		self.NAME                   := L.fullnm;
	
	  SELF := L;
	END;
	
	export clname :=  PROJECT(cleaned_input, add_clean_name(LEFT));

END;



export airmen(DATASET(layouts.airmen.temp) pPreProcessInput) := module

Clean_Name_Amen(DATASET(layouts.airmen.temp) pInput) := FUNCTION

  NID.Mac_CleanParsedNames(pInput, cleaned_names, orig_fname,orig_mname,orig_lname,namesuffix  );

  RETURN cleaned_names;

END;

  // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	// this type of definition - action must precede an expression."
	cleaned_input := Clean_Name_Amen(pPreProcessInput);
	
  layouts.airmen.clean add_clean_name(cleaned_input L) := TRANSFORM
	
	  SELF.clean_name.title       := IF ( L.nametype <> 'B',L.cln_title,'');
	  SELF.clean_name.fname       := IF ( L.nametype <> 'B',L.cln_fname,'');
	  SELF.clean_name.mname       := IF ( L.nametype <> 'B',L.cln_mname,'');
	  SELF.clean_name.lname       := IF ( L.nametype <> 'B',L.cln_lname,'');
	  SELF.clean_name.name_suffix := IF ( L.nametype <> 'B',L.cln_suffix,'');
	
	  SELF := L;
	END;
	
	export clname :=  PROJECT(cleaned_input, add_clean_name(LEFT));

END;

end;