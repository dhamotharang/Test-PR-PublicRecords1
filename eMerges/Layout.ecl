export Layout:=
  module

	export hunt_fish_out := record
			string5   title;
			string20  fname;
			string20  mname;
			string20  lname;
			string5   name_suffix;
			string10  prim_range;
			string2   predir;
			string28  prim_name;
			string4   suffix;
			string2   postdir;
			string10  unit_desig;
			string8   sec_range;
			string25  city_name;
			string2   st;
			string5   zip;
			string4   zip4;
			string3   county;
			string8   DateLicense;
			string8	  dob;
      string15 	HuntFishPerm;
      string20 	License_type_Mapped;
      string2   source_state;
			string2   HomeState;
  		string30 	occupation;
      string1   gender;
			string9   best_ssn;
			unsigned6 did;
      string2   race;
			unsigned1	zero:=0;
			string1	  blank:='';
			unsigned6 rid;
			unsigned8 persistent_record_id := 0;
	 end;
	  
		export ccw_out := record
			string5   title;
			string20  fname;
			string20  mname;
			string20  lname;
			string5   name_suffix;
			string10  prim_range;
			string2   predir;
			string28  prim_name;
			string4   suffix;
			string2   postdir;
			string10  unit_desig;
			string8   sec_range;
			string25  city_name;
			string2   st;
			string5   zip;
			string4   zip4;
			string3   county;
			string8 	unique_id;
			string8	  dob;
			string15 	CCWPermNum;
			string46	CCWPermType;
			string15 	CCWWeaponType;
      string2   source_state;
			string2   res_state;
  		string30 	occupation;
      string1   gender;
			string9   best_ssn;
			unsigned6 did_out6;
      string2   race;
			unsigned1	zero:=0;
			string1	  blank:='';
			unsigned6 rid;
			unsigned8 persistent_record_id := 0;
	 end;
end ;