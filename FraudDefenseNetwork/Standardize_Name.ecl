Export Standardize_Name(infile,first_name,middle_name,last_name,suffix_name  ,outfile) := macro

Import NID, Address; 

#uniquename(cleaned_names) 

 NID.Mac_CleanParsedNames(infile, %cleaned_names%,first_name, middle_name,last_name,suffix_name);
 
#uniquename(add_clean_name) 
  typeof(infile) %add_clean_name%(%cleaned_names% L) := TRANSFORM
	  SELF.cleaned_name.title       := L.cln_title;
	  SELF.cleaned_name.fname       := L.cln_fname;
	  SELF.cleaned_name.mname       := L.cln_mname;
	  SELF.cleaned_name.lname       := L.cln_lname;
	  SELF.cleaned_name.name_suffix := L.cln_suffix;
		Self.nid                      := L.nid;
	  Self.name_ind                 := L.name_ind;
	
	  SELF := L;
	END;
	
	outfile:= PROJECT(%cleaned_names%, %add_clean_name%(LEFT));

endmacro;
