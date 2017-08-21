import Frandx;

EXPORT Layouts := module

	export incoming := record
		string9		fein;
		string8		incorp_date;
		unsigned4 dt_first_seen;
		unsigned4 dt_last_seen;
		unsigned4 dt_vendor_first_reported;
		unsigned4 dt_vendor_last_reported;
		string1		record_type;
		STRING6 	franchisee_id;
		STRING60 	brand_name;
		STRING6 	fruns;
		STRING60 	company_name;
		string8   dob;
		string9   ssn;
		STRING56 	exec_full_name;
		STRING50 	address1;
		STRING50 	address2;
		STRING25 	city;
		STRING2 	state;
		STRING5		zip_code;
		STRING4		zip_code4;
		STRING10	phone;				
		STRING4		phone_extension;				
		STRING10	secondary_phone;
		STRING1 	unit_flag;
		STRING2 	relationship_code;
		STRING4 	f_units;
		STRING43 	website_url;
		STRING45 	email;
		STRING30 	industry;
		STRING33 	sector;
		STRING8 	industry_type;
		STRING4 	sic_code;
		STRING8 	frn_start_date;
		STRING6 	record_id;
		string20	Unit_Flag_Exp;
		string20	Relationship_Code_Exp;
		string10	cust_name;
		string10	bug_num;
	end;	
	
	
	export base := record
		Frandx.Layouts.base;
		string10	cust_name;
		string10	bug_num;
	end;
	
	export keybuild := record
		Frandx.Layouts.Keybuild;
	end;
	
	export slim_rec := record
		frandx.layouts.base.source_rec_id;
		frandx.layouts.base.franchisee_id;
		frandx.layouts.base.fruns;
	end;
end;	
	
		