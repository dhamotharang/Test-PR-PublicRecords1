import Address, BIPV2;

EXPORT Layouts := module

	export Input := module
	
		export sprayed :=  record
			qstring120 	name;
			string50 		c_last_name;
			string50 		c_first_name;
			string15 		c_middle_name;
			string4 		c_suffix_name;
			string2 		subject_identifier;
			string1 		subject_name_type;
			unsigned6 	cnp_nameid;
			string120 	cnp_name;
			string30 		cnp_number;
			string10 		cnp_store_number;
			string10 		cnp_btype;
			string20 		cnp_lowv;
			boolean 		cnp_translated;
			integer4 		cnp_classid;
			string2 		address_ind;
			string10 		prim_range;
			string2 		predir;
			string28 		prim_name;
			string4 		addr_suffix;
			string2 		postdir;
			string10 		unit_desig;
			string2 		record_type;
			string8 		sec_range;
			string30 		city;
			string2 		st;
			string5 		zip;
			string4 		zip4;
			string6 		addr_err_code;
			string25 		policy_no;
			string2 		policy_type;
			string10 		phone;
			string9 		tax_id;
			string9 		ssn;
			string1 		sex;
			string25 		driver_license_no;
			string2 		driver_license_state;
			unsigned4 	dob;
			string5 		customer_no;
			string6 		ambest_no;
			string20 		claim_no;
			string8 		claim_date;
			string8 		policy_eff_date;
			string9 		duns_no;
			string9 		austin_tetra_no;
			string9 		experian_bin;
			unsigned8 	rid;
			unsigned8 	ccid;
			unsigned8 	unique_id;
			unsigned8		source_rid;
			unsigned8		header_rid;
			string1 		delete_flag;
			unsigned6   did;                   //We are now receiving "did" as unsigned6 - DF-27723
			integer2    xlink_weight;          //Insurance added field due to CPPA - DF-26077
			unsigned2   xlink_score;           //Insurance added field due to CPPA - DF-26077
			integer1    xlink_distance;        //Insurance added field due to CPPA - DF-26077
			unsigned6 	dotid;
			unsigned6 	empid;
			unsigned6 	powid;
			unsigned6 	proxid;
			unsigned6 	seleid;
			unsigned6 	orgid;
			unsigned6 	ultid;
      unsigned4   global_sid;            //Insurance added field due to CPPA - DF-26077
      unsigned8   record_sid;            //Insurance added field due to CPPA - DF-26077
      unsigned8   aid;                   //Insurance added field due to CPPA - DF-26077
      unsigned2   dali;                  //Insurance added field due to CPPA - DF-26077
      unsigned6   locid;                 //Insurance added field due to CPPA - DF-26077
      unsigned8   nid;                   //Insurance added field due to CPPA - DF-26077
		end;
		
		export sprayed_slim := record
			sprayed - [did, dotid, empid, powid, proxid, seleid, orgid, ultid];
		end;
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Base Layouts
	////////////////////////////////////////////////////////////////////////
	export Base :=
	record
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6												Bdid												:= 0;
		unsigned1												bdid_score									:= 0;		
		unsigned6												did													:= 0;
		unsigned1												did_score										:= 0;
		unsigned4 											dt_first_seen								:= 0;
		unsigned4 											dt_last_seen								:= 0;
		unsigned4 											dt_vendor_first_reported		:= 0;
		unsigned4 											dt_vendor_last_reported			:= 0;
		string1													record_type									:='';
					
		Input.sprayed_slim																							;
		string120 											business_name										;
		Address.Layout_Clean_Name				clean_Name											;
		Address.Layout_Clean182_fips    clean_addr											;
		unsigned8												raw_aid											:= 0;
		unsigned8												ace_aid										 	:= 0;
		string100												prep_addr_line1						 	:='';
		string50												prep_addr_line_last				 	:='';		
	end;
	
	////////////////////////////////////////////////////////////////////////
	// -- Keybuild Layouts
	////////////////////////////////////////////////////////////////////////
	export Keybuild :=
	record
		BIPV2.IDlayouts.l_xlink_ids;
		unsigned6														Bdid										:= 0;
		unsigned1														bdid_score							:= 0;
		unsigned6														did											:= 0;
		unsigned1														did_score								:= 0;
		unsigned4 													dt_first_seen								;
		unsigned4 													dt_last_seen								;
		unsigned4 													dt_vendor_first_reported		;
		unsigned4 													dt_vendor_last_reported			;
		string1															record_type									;
		
		Input.sprayed_slim																							;
		string120 													business_name								;
		Address.Layout_Clean_Name					 	clean_Name									;
		Address.Layout_Clean182_fips   			clean_addr									;
		unsigned8														raw_aid									:= 0;
		unsigned8														ace_aid								 	:= 0;
		string100														prep_addr_line1				 	:='';
		string50														prep_addr_line_last		 	:='';	
	end;
	
	
	////////////////////////////////////////////////////////////////////////
	// -- Temporary Layouts for processing
	////////////////////////////////////////////////////////////////////////
	export Temporary := module
	
		export StandardizeInput :=
	  record
			unsigned4 											dt_first_seen							:= 0;
			unsigned4 											dt_last_seen							:= 0;
			unsigned4 											dt_vendor_first_reported	:= 0;
			unsigned4 											dt_vendor_last_reported		:= 0;
			Input.sprayed_slim																						;
			string120 											business_name							:='';
			Address.Layout_Clean_Name				clean_Name										;
			Address.Layout_Clean182_fips   	clean_addr										;
			unsigned8												raw_aid										:= 0;
			unsigned8												ace_aid								 		:= 0;
			string100												prep_addr_line1				 		:='';
			string50												prep_addr_line_last		 		:='';	
	  end;
		
	  export DidSlim := 
	  record
			unsigned8		unique_id				;
			string20 		fname						;
			string20 		mname						;
			string20 		lname						;
			string5  		name_suffix		  ;
			string10  	prim_range			;
			string28		prim_name				;
			string8			sec_range			 	;
			string5			zip5						;
			string2			state						;
			string10		phone						;
			string9 		ssn							;
			unsigned4 	dob							;
			unsigned6		did					:= 0;
			unsigned1		did_score		:= 0;
	  end;

	  export BdidSlim := 
	  record
			unsigned8		unique_id					;
			string100 	business_name			;
			string10  	prim_range				;
			string28		prim_name					;
			string5			zip5							;
			string8			sec_range					;
			string25 		p_City_name				;   		// City
			string2			state		 					;
			string10		phone		  		    ;
			string20 		fname							;
			string20 		mname							;
			string20 		lname							;
			string9 		tax_id						;
			unsigned6		bdid					:= 0;
			unsigned1		bdid_score		:= 0;
			BIPV2.IDlayouts.l_xlink_ids		;
	  end;
		
	  export UniqueId := 
		record
 		  unsigned8		unique_id	;
		  Base									;
		end;
		end;
end;