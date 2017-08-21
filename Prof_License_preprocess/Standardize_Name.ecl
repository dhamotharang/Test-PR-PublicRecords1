IMPORT Address, NID, lib_stringlib;



EXPORT Standardize_Name := module



export prolic(DATASET(Layout_prolic_in_clean) pPreProcessInput) := module

Clean_Name_pl(DATASET(Layout_prolic_in_clean) pInput) := FUNCTION

  NID.Mac_CleanFullNames(pInput, cleaned_names,orig_name,includeInRepository:=false);

  RETURN cleaned_names;
end;

  // Cannot call the NID directly here, it gives an error saying "cannot associate a side effect with
	// this type of definition - action must precede an expression."
	cleaned_input := Clean_Name_pl(pPreProcessInput);
	
  Layout_prolic_in_clean add_clean_name(cleaned_input L) := TRANSFORM
   SELF.clean_name.title       := '' ;
	  SELF.clean_name.fname       := L.cln_fname;
	  SELF.clean_name.mname       := L.cln_mname;
	  SELF.clean_name.lname       := L.cln_lname;
	  SELF.clean_name.name_suffix := L.cln_suffix;

		
	  SELF := L;
	END;
	
	clname_notitle :=  PROJECT(cleaned_input, add_clean_name(LEFT));
	
	Layout_prolic_in_clean add_clean_title(clname_notitle L) := TRANSFORM
	clean_name_old :=  map ( L.name_order[1] = 'L' => Address.CleanPersonLFM73( L.orig_name ),
	                          L.name_order[1] = 'F' => Address.CleanPersonFML73( L.orig_name ),
				                                               Address.CleanPerson73( L.orig_name )
                       ); 
											 
	SELF.clean_name.title       := if ( StringLib.StringFind(clean_name_old[1..5],' ',1) <> 0 ,clean_name_old[1..StringLib.StringFind(clean_name_old[1..5],' ',1)],clean_name_old[1..5]) ;
	SELF.clean_name.name_score  := clean_name_old[71..73];

	
	SELF := L;
	END;
	
	export clname :=  PROJECT(clname_notitle, add_clean_title(LEFT));
END;


END;


