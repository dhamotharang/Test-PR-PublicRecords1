Import paw, Standard, prte2;
EXPORT Layouts := module

	// EXPORT Layout_Base := {paw.Layout.Employment_Out_BIPv2,string50 domain} ;
	EXPORT Layout_Base := {paw.Layout.Employment_Out_BIPv2,
																								string50 domain,
																								string10 cust_name,
																								string10 bug_num,
																								string8		link_dob,
																								string9		link_ssn,	
																								string9		link_fein,	
																								string8		link_inc_date	
																								};
	
	EXPORT Employment_Out_BIPv2 := paw.Layout.Employment_Out_BIPv2;
	
	EXPORT Employment_Out := paw.layout.Employment_Out;
	EXPORT AutoKeyLayout := record
		Employment_Out.company_name	; 	
		Employment_Out.contact_id	;
		Employment_Out.ssn			;
		Employment_Out.company_fein	;
		Employment_Out.company_phone	;
		Employment_Out.did			;
		Employment_Out.phone			;
		Employment_Out.bdid			;
		Standard.L_Address.base Bus_addr   	;
		Standard.L_Address.base person_addr	;
		standard.name person_name			;
		unsigned1 zero 					:= 0;
		prte2.Layouts.deflt_cpa;
	end;
	
	EXPORT layout_paw_companyname_domain := RECORD
		string50 domain;
		string120 company_name;
		string1 domain_type;
		real8 ratio;
		unsigned8 __internal_fpos__;
	END;
	 
	EXPORT Employment_Out_old := paw.Layout.Employment_Out_old; 
	
	EXPORT Layout_In := RECORD
		unsigned6 contact_id;
		unsigned6 did;
		unsigned6 bdid;
		string9 ssn;
		string3 score;
		string120 company_name;
		string10 company_prim_range;
		string2 company_predir;
		string28 company_prim_name;
		string4 company_addr_suffix;
		string2 company_postdir;
		string5 company_unit_desig;
		string8 company_sec_range;
		string25 company_city;
		string2 company_state;
		string5 company_zip;
		string4 company_zip4;
		QSTRING35 		company_title		;   // Title of Contact at Company if available
		QSTRING35 		company_department := '';
		string10 company_phone;
		string9 company_fein;
		string5 title;
		string20 fname;
		string20 mname;
		string20 lname;
		string5 name_suffix;
		string10 prim_range;
		string2 predir;
		string28 prim_name;
		string4 addr_suffix;
		string2 postdir;
		string10 unit_desig;
		string8 sec_range;
		string25 city;
		string2 state;
		string5 zip;
		string4 zip4;
		string3 county;
		string4 msa;
		string10 geo_lat;
		string11 geo_long;
		string10 phone;
		string60 email_address;
		string8 dt_first_seen;
		string8 dt_last_seen;
		string1 record_type;
		string1 active_phone_flag;
		string1 glb;
		string2 source;
		string2 dppa_state;
		string3 old_score;
		unsigned6 source_count;
		unsigned1 dead_flag;
		string10 company_status;
		unsigned6 dotid;
		unsigned2 dotscore;
		unsigned2 dotweight;
		unsigned6 empid;
		unsigned2 empscore;
		unsigned2 empweight;
		unsigned6 powid;
		unsigned2 powscore;
		unsigned2 powweight;
		unsigned6 proxid;
		unsigned2 proxscore;
		unsigned2 proxweight;
		unsigned6 seleid;
		unsigned2 selescore;
		unsigned2 seleweight;
		unsigned6 orgid;
		unsigned2 orgscore;
		unsigned2 orgweight;
		unsigned6 ultid;
		unsigned2 ultscore;
		unsigned2 ultweight;
		string10 cust_name;
		string10 	bug_num;
		string8		link_dob;
		string9		link_ssn;	
		string9		link_fein;	
		string8		link_inc_date;	
		string5		name_format;	
		string50	raw_indv_name;	
		string40	raw_company_addr1;	
		string30	raw_company_addr2;
	END;

END;