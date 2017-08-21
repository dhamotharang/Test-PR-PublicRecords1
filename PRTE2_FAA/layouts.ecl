import faa, BIPV2;

EXPORT layouts := module

	export airmen := record
		FAA.layout_airmen_data_out - [source]; 
		unsigned6 airmen_id;    				// sequence number
		unsigned8 __internal_fpos__;
		unsigned8 persistent_record_id;
		unsigned6 did;									// only exist in key
		string2   source;
		string50  cust_name;
		string10	bug_name;
		string8		link_dob;
	end;
	
	export airmen_certificate := record
		faa.layout_airmen_certificate_out;
		unsigned6 uid;									// only exist in key
		unsigned8 __internal_fpos__;
		string50  cust_name;
		string10	bug_name;
	end;

	export aircraft_registration := record
		faa.layout_aircraft_registration_out;
		unsigned6 aircraft_id;	  			// sequence number
		unsigned8	persistent_record_id;
		unsigned8 __internal_fpos__;
		unsigned6 did;  								// only exist in key
		unsigned6 bd;   								// only exist in key
		string50  cust_name;
		string10	bug_name;
		string9   link_fein;
		string8		link_inc_date;
		string8   link_dob;
	end;
	
  export base_airmen_cert := record
		faa.layout_airmen_certificate_out;
		string50  cust_name;
		string10	bug_name;
	end;	
	
	export Search_Airmen := record
		unsigned6 airmen_id;
		faa.layout_airmen_Persistent_ID;
		string50  cust_name;
		string10	bug_name;
		string8		link_dob;
	end;
	
	
	export Search_Aircraft := record
		unsigned6 aircraft_id;
	  faa.layout_aircraft_registration_out_slim;
		unsigned8	source_rec_id;
		unsigned8	persistent_record_id;
	  BIPV2.IDlayouts.l_xlink_ids;
		unsigned8 __internal_fpos__;
		string50  cust_name;
		string10	bug_name;
		string9   link_fein;
		string8		link_inc_date;
		string8   link_dob;
	end;
	
	export Common_Aircraft_Airmen := record
		faa.layout_common_aircraft_airman_cert;
	end;
	
	export autokey_airmen := record
		FAA.layout_airmen_data_out - [source];
		unsigned6 	airmen_id 	:= 0;
		unsigned1 	zero				:= 0;
		string1 		blank				:= '';
		unsigned6 	did_out6 		:= 0;
	end;
	
		
	export header_aircraft_plus :=  record
		faa.layout_aircraft_registration_out;
		UNSIGNED8 __fpos { VIRTUAL (fileposition)};
	end;	
	
	export header_airmen := record
		faa.layout_airmen_data_out;
  end;	
	
	export Search_Airmen_slim := record
		Search_Airmen - [cust_name,bug_name,link_dob];
		end;

	export Search_Aircraft_slim := record
		Search_Aircraft - [source_rec_id,__internal_fpos__,cust_name,bug_name,link_fein,link_inc_date,link_dob];
		end;
		
export Search_Aircraft_linkids := record
		Search_Aircraft - [aircraft_id,persistent_record_id,cust_name,bug_name,__internal_fpos__,link_fein,link_inc_date,link_dob];
		end;		
END;	
