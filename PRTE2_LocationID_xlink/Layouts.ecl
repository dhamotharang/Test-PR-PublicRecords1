EXPORT Layouts := module

export key_loc_id_map:= RECORD
 unsigned6 locid;
  unsigned8 cleanaid;
  unsigned8 rawaid;
  string80 line1;
  string60 linelast;
  unsigned8 __internal_fpos__;
 END;


	export Key_meow := 			RECORD
		unsigned6 locid;
		string2 	source;
		unsigned8 source_record_id;
		unsigned6 rid;
		unsigned8 aid;
		string8 	dateseenfirst;
		string8 	dateseenlast;
		string10 	prim_range;
		string2 	predir;
		string28 	prim_name;
		string4 	addr_suffix;
		string2 	postdir;
		string10 	unit_desig;
		string8 	sec_range;
		string25 	v_city_name;
		string2 	st;
		string5 	zip5;
		string4 	zip4;
		string2 	dbpc;
		string2 	rec_type;
		string4 	err_stat;
		unsigned8 cntprimname;
		string28 	prim_name_normalized;
		string4 	predir_derived;
		string28	prim_name_derived;
		string4 	addr_suffix_derived;
		string10 	prim_range_derived;
		unsigned6 primnameinzipcnt;
		set of string numbers;
		string8 sec_range_derived;
  // unsigned8 __internal_fpos__;
 END;

	export key_refs_statecity := RECORD
		string25 	v_city_name;
		string2  	st;
		string10 	prim_range;
		string28	 prim_name_derived;
		string8 	sec_range;
		string2 	predir;
		string2 	postdir;
		string4 	addr_suffix_derived;
		unsigned6 locid;
		string10 	unit_desig;
		string4 	err_stat;
		integer2 	v_city_name_weight100;
		integer2	st_weight100;
		integer2 	prim_range_weight100;
		integer2 	prim_name_derived_weight100;
		integer2 	sec_range_weight100;
		integer2 	predir_weight100;
		integer2 	postdir_weight100;
		integer2 	addr_suffix_derived_weight100;
		integer2 	unit_desig_weight100;
		integer2 	err_stat_weight100;
		// unsigned8 __internal_fpos__;
 END;
 
	export key_refs_zip := RECORD
		string5 	zip5;
		string10 	prim_range;
		string28 	prim_name_derived;
		string8 	sec_range;
		string2 	predir;
		string2 	postdir;
		string4 	addr_suffix_derived;
		unsigned6 locid;
		string10 	unit_desig;
		string4 	err_stat;
		integer2 	zip5_weight100;
		integer2 	zip5_zipradius_weight100;
		integer2 	prim_range_weight100;
		integer2 	prim_name_derived_weight100;
		integer2 	sec_range_weight100;
		integer2 	predir_weight100;
		integer2 	postdir_weight100;
		integer2 	addr_suffix_derived_weight100;
		integer2 	unit_desig_weight100;
		integer2 	err_stat_weight100;
  // unsigned8 __internal_fpos__;
 END;
	
	export key_words := RECORD
		string30 	word;
		unsigned8 cnt;
		unsigned8 t_cnt;
		unsigned4 id;
		real8 		field_specificity;
  // unsigned8 __internal_fpos__;
 END;
 
 
	export key_sup_rid := { unsigned6 rid, unsigned6 locid };
	
	export key_refs := RECORD
		unsigned4 word_id;
		unsigned2 field;
		unsigned6 uid;
		// unsigned8 __internal_fpos__;
 END;
	
end;	