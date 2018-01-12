import std, Hygenics_Soff;

df 	:= Hygenics_Soff.File_Accurint_In;
df2 := Hygenics_Soff.File_Accurint_Search_In;

	layout_common_person into(df L) := transform
		self.person_id 				:= L.seisint_primary_key[5..];
		self.record_type 			:= '';
		self.title 					:= '';
		self.reg_county 			:= L.registration_county;
		self.phone10 				:= '';
		self.process_date 			:= (STRING8)Std.Date.Today();
		self.minor_victim 			:= L.victim_minor_1;
	//	self.dc := L.doc_number;
		self.date_address_added 	:= L.reg_date_1;
		self.resident_Or_temp 		:= L.registration_type;
		self.status 				:= L.offender_status;
		self.did 					:= '';
		self.score 					:= '';
		self.ssn_appended 			:= '';
		self.rawaid 				:= 0;
		self.curr_incar_flag 		:= '';
		self.curr_parole_flag 		:= '';
		self.curr_probation_flag 	:= '';
		self 						:= L;
	end;

o1 := project(df,into(LEFT));

	o1 getdid(o1 L, df2 R) := transform
		self.did 			:= R.did;
		self.score 			:= R.did_score;
		self.ssn_appended 	:= R.ssn_appended;
		self.prim_range 	:= R.prim_range;
		self.predir 		:= R.predir;
		self.prim_name 		:= R.prim_name;
		self.addr_suffix 	:= R.addr_suffix;
		self.postdir 		:= R.postdir;
		self.unit_desig 	:= R.unit_desig;
		self.sec_range 		:= R.sec_range;
		self.p_city_name 	:= R.p_city_name;
		self.v_city_name 	:= R.v_city_name;
		self.st 			:= R.st;
		self.zip5 			:= R.zip;
		self.zip4 			:= R.zip4;
		self.geo_lat 		:= R.geo_lat;
		self.geo_long 		:= R.geo_long;
		self.geo_match 		:= R.geo_match;
		self.rawaid 		:= r.rawaid;
		self.lname 			:= r.lname;
		self.mname 			:= r.mname;
		self.fname 			:= r.fname;
		self.name_suffix 	:= r.name_suffix;
		self.record_type 	:= r.rec_type;
		// Added the following two values - bug 22000 ver. by CNG
		self.name_type 		:= r.name_type;
		self.nid					:= r.nid;
		self.ntype				:= r.ntype;
		self.nindicator		:= r.nindicator;
    self.offender_persistent_id := r.offender_persistent_id;
		self.dob 			:= r.dob;
		self 				:= L;
	end;

// Join the primary file with the search file
o2 :=join(o1
         ,df2
		 ,left.seisint_primary_key = right.seisint_primary_key
		 ,getdid(LEFT,RIGHT)
		 ,hash
		 ,left outer);

// Only keep the data when there is some kind of name
o3 := o1(   lname       <> '' 
         or mname       <> '' 
		 or fname       <> '' 
		 or name_suffix <> '');


	o3 get_new_recs(o3 L) := transform
		self := L;
	end;

o4 := join(o3, df2
		  ,left.seisint_primary_key                      		= right.seisint_primary_key 
	       and stringlib.StringToUpperCase(left.lname)       	= stringlib.StringToUpperCase(right.lname) 
	       and stringlib.StringToUpperCase(left.mname)       	= stringlib.StringToUpperCase(right.mname) 
	       and stringlib.StringToUpperCase(left.fname)      	 = stringlib.StringToUpperCase(right.fname) 
	       and stringlib.StringToUpperCase(left.name_suffix) 	= stringlib.StringToUpperCase(right.name_suffix)
	      ,get_new_recs(left)
		  ,hash
		  ,left only);

srt_df2 := sort(df2, seisint_primary_key, -(unsigned2)did_score);
dep_df2 := dedup(srt_df2, seisint_primary_key);

	o4 get_new_names(o4 L, dep_df2 R) := transform
		self.did 			:= R.did;
		self.score 			:= R.did_score;
		self.ssn_appended 	:= R.ssn_appended;
		self.prim_range 	:= R.prim_range;
		self.predir 		:= R.predir;
		self.prim_name 		:= R.prim_name;
		self.addr_suffix 	:= R.addr_suffix;
		self.postdir 		:= R.postdir;
		self.unit_desig 	:= R.unit_desig;
		self.sec_range 		:= R.sec_range;
		self.p_city_name 	:= R.p_city_name;
		self.v_city_name 	:= R.v_city_name;
		self.st 			:= R.st;
		self.zip5 			:= R.zip;
		self.zip4 			:= R.zip4;
		self.geo_lat 		:= R.geo_lat;
		self.geo_long 		:= R.geo_long;
		self.geo_match 		:= R.geo_match;
		self.rawaid 		:= r.rawaid;
		self.lname 			:= stringlib.StringToUpperCase(L.lname);
		self.mname 			:= stringlib.StringToUpperCase(L.mname);
		self.fname 			:= stringlib.StringToUpperCase(L.fname);
		self.name_suffix 	:= stringlib.StringToUpperCase(L.name_suffix);
		self 				:= L;
	end;

o5 := join(o4
          ,dep_df2
		  ,left.seisint_primary_key = right.seisint_primary_key
		  ,get_new_names(left, right)
		  ,hash
		  ,left outer);
		  
concat_file := o2 + o5 : persist('~thor_data400::Persist::hd::Accurint_Person_As_Common');

export Mapping_Accurint_Person_As_Common := concat_file;