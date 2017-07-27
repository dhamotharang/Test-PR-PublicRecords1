export layouts := 
MODULE
export layout_Names :=
record
	unsigned6 cnp_nameid;
	string250 cnp_name;
	string30 cnp_number := '';	
	string10 cnp_store_number := '';
	string10 cnp_btype := '';		
	string1	cnp_component_code := '';
	string20 cnp_lowv := '';	//low value terms that i just want to leave out
	boolean cnp_translated := false;
	integer4 cnp_classid := 0;//Can a name have more than one class?  if so, switch to bitmap	
end;
export layout_Names2 := //for intermediate processing that requires extra fields
record
	layout_Names;
	string250 cnp_pre_extraction_name := '';
	string250 cnp_name_trunc := '';
end;
export layout_Classes :=
record
	integer4 classid;
	string20 description;
end;
export layout_Words :=
record
	layout_Names.cnp_nameid;
	unsigned2 seq;
	string50 word;
	layout_names.cnp_translated;
	layout_names.cnp_component_code;
  boolean extracted_number := false;
	boolean extracted_store_number := false;
  boolean extracted_btype := false;
  boolean extracted_lowv := false;
	boolean extracted_store_prefix := false;
	boolean extracted_of_clause := false;
	layout_Names.cnp_classid;
end;
export layout_CoNameAbbrv
:=
record
	string500 from;
	string60 to;
	set of integer4 set_classes := [0];
end;
export layout_Translations
:=
record
	string50 from;
	string50 to;
	set of integer4 set_classes;
end;
export layout_Extractions
:=
record
	string50 extraction;
	set of integer4 classid;	
end;
export layout_StoreNbr
:=
record
  string250 company_name;
end;
END;

