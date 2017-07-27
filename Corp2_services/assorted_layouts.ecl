export assorted_layouts := module
	

	export layout_common :=record


	string30 corp_key;
	unsigned6 bdid ;
	string28 business_prim_name ;
	string10 business_prim_range ;
	string2 business_state ;
	string25 business_city;
	string8 business_sec_range;
	string5 business_zip ;
	string10 business_phone ;
	string350 company_name ;
	string32 fein;

	string10 person_prim_range ;
	string28 person_prim_name ;
	string25 person_city ;
	string5 person_zip ;
	string8 person_sec_range;
	string2 person_state ;
	string10 Person_phone ;
	string8 person_dob ;
	string9 person_ssn ;
	string20 person_fname ;
	string20 person_mname ;
	string20 person_lname ;
	unsigned6 person_did;
	unsigned2 lookup_bits := 0;
	unsigned1 zero1 := 0;
	end;

	export layout_trades := record
	string30 corp_key;  
	string32  corp_orig_sos_charter_nbr;
	string32  corp_sos_charter_nbr;
	string2	  corp_state_origin;
	layout_corps_out;
	dataset(layout_events_out) events {maxcount(25)};
	END;

	shared layout_penalties :=record
	unsigned2 penalt_1;
	unsigned2 penalt_phone_1;
	unsigned2 penalt_company_1;
	unsigned2 penalt_addr_1;	
	unsigned2 penalt_2;
	unsigned2 penalt_phone_2;
	unsigned2 penalt_company_2;
	unsigned2 penalt_addr_2;	
	end;
			
	shared layout_name := record
	string20 cont_fname;
	string20 cont_lname;
	string20 cont_mname;
	end;

	export cont_search_children :=record
	string30 corp_key; 
	string12 did;
	layout_search_names;
	layout_penalties;
	layout_search_parties;
	layout_search_addresses;
	dataset(layout_search_title) title_description {maxcount(10)};
	dataset(layout_search_names) names {maxcount(10)};
	dataset(layout_search_addresses) addresses {maxcount(10)};
	end;
			
	export cont_search_vitals :=record
	layout_penalties;
	layout_search_names;
	layout_search_addresses;
	layout_contact_search;	
	end;
			
	export cont_search_match :=record
	string30 corp_key; 
	STRING1   record_type;
	unsigned4 dt_last_seen;
	string12 did;
	layout_penalties;
	layout_search_names;
	dataset(cont_search_vitals) contact {maxcount(50)};
	end;

	export cont_formatted :=record
	string30 corp_key; 
	STRING1   record_type;
	string12 did;
	layout_search_names;
	layout_penalties;
	dataset(layout_contact_search) contact {maxcount(50)};
	end;
			
	export cont_search_parent :=record
	string30 corp_key;
	string12 did;
	layout_penalties;
	layout_search_title;
	layout_search_names;
	layout_search_parties;
	layout_search_addresses;
	end;
	
	export corp2_batch_layout := RECORD
		string30         corp_key;  
		string32         corp_orig_sos_charter_nbr;
		string32         corp_sos_charter_nbr; 
		string2	         corp_state_origin;
		string25         corp_state_origin_decoded;
		string350        cont_1_corp_legal_name;
		string150        cont_1_desc;
		string70         cont_1_cname;
		string100        cont_1_name;
		string60         cont_1_address_type_desc;
		string75         cont_1_address1;
		string150        cont_1_phone_fax;
		string30         cont_1_addl_details;//web and email
		string350        cont_2_corp_legal_name;
		string150        cont_2_desc;
		string70         cont_2_cname;
		string100        cont_2_name;
		string60         cont_2_address_type_desc;
		string75         cont_2_address1;
		string150        cont_2_phone_fax;
		string30         cont_2_addl_details;//web and email
		string350        cont_3_corp_legal_name;
		string150        cont_3_desc;
		string70         cont_3_cname;
		string100        cont_3_name;
		string60         cont_3_address_type_desc;
		string75         cont_3_address1;
		string150        cont_3_phone_fax;
		string30         cont_3_addl_details;//web and email
    string32         cont_4_sos_charter_nbr;
		string350        cont_4_corp_legal_name;
		string150        cont_4_desc;
		string70         cont_4_cname;
		string100        cont_4_name;
		string60         cont_4_address_type_desc;
		string75         cont_4_address1;
		string150        cont_4_phone_fax;
		string30         cont_4_addl_details;//web and email
		string350        cont_5_corp_legal_name;
		string150        cont_5_desc;
  	string70         cont_5_cname;
		string100        cont_5_name;
		string60         cont_5_address_type_desc;
		string75         cont_5_address1;
		string150        cont_5_phone_fax;
		string30         cont_5_addl_details;//web and email
		string30         event_1_filing_reference_nbr;
		string3          event_1_amendment_nbr;
		string8	         event_1_filing_date;
		string60         event_1_filing_desc;
		string100        event_1_corp_nbr_withdesc;
		string10         event_1_microfilm_nbr;		
		string500        event_1_desc;
		string30         event_2_filing_reference_nbr;
		string3          event_2_amendment_nbr;
		string8	         event_2_filing_date;
		string60         event_2_filing_desc;
		string100        event_2_corp_nbr_withdesc;
		string10         event_2_microfilm_nbr;		
		string500        event_2_desc;
		string30         event_3_filing_reference_nbr;
		string3          event_3_amendment_nbr;
		string8	         event_3_filing_date;
		string60         event_3_filing_desc;
		string100        event_3_corp_nbr_withdesc;
		string10         event_3_microfilm_nbr;		
		string500        event_3_desc;
		string30         event_4_filing_reference_nbr;
		string3          event_4_amendment_nbr;
		string8	         event_4_filing_date;
		string60         event_4_filing_desc;
		string100        event_4_corp_nbr_withdesc;
		string10         event_4_microfilm_nbr;		
		string500        event_4_desc;	
		string30         event_5_filing_reference_nbr;
		string3          event_5_amendment_nbr;
		string8	         event_5_filing_date;
		string60         event_5_filing_desc;
		string100        event_5_corp_nbr_withdesc;
		string10         event_5_microfilm_nbr;		
		string500        event_5_desc;
		string250        stock_1_details1;
		string250        stock_1_details2;
		string250        stock_1_addl_info;
		string250        stock_2_details1;
		string250        stock_2_details2;
		string250        stock_2_addl_info;
		string250        stock_3_details1;
		string250        stock_3_details2;
		string250        stock_3_addl_info;
		string250        stock_4_details1;
		string250        stock_4_details2;
		string250        stock_4_addl_info;	
		string250        stock_5_details1;
		string250        stock_5_details2;
		string250        stock_5_addl_info;	
		string80         ar_1_year_type;
		string21         ar_1_cap_tax;
		string10         ar_1_microfilm_nbr;
		string350        ar_1_comment;
		string80         ar_2_year_type;
		string21         ar_2_cap_tax;
		string10         ar_2_microfilm_nbr;
		string350        ar_2_comment;
		string80         ar_3_year_type;
		string21         ar_3_cap_tax;
		string10         ar_3_microfilm_nbr;
		string350        ar_3_comment;
		string80         ar_4_year_type;
		string21         ar_4_cap_tax;
		string10         ar_4_microfilm_nbr;
		string350        ar_4_comment;
		string80         ar_5_year_type;
		string21         ar_5_cap_tax;
		string10         ar_5_microfilm_nbr;
		string350        ar_5_comment;	
		string350        corphist_1_legal_name;
		string30         corphist_1_ln_name_type_desc;
		unsigned6 			 corphist_1_DotID;
		unsigned6 			 corphist_1_EmpID;
		unsigned6 			 corphist_1_PowID;
		unsigned6 			 corphist_1_ProxID;
		unsigned6 			 corphist_1_SeleID; 
		unsigned6 			 corphist_1_OrgID;
		unsigned6 			 corphist_1_UltID;
		string60         corphist_1_address1_type_desc;
		string150        corphist_1_address1;
		string60         corphist_1_address2_type_desc; 
		string150        corphist_1_address2;
    string8	         corphist_1_filing_date;		
		string8	         corphist_1_status_date;
	  string1          corphist_1_standing;
	  string2	         corphist_1_inc_state;
   	string8	         corphist_1_inc_date;
		string60         corphist_1_forgn_state_desc;
		string32         corphist_1_fed_tax_id;
		string32         corphist_1_state_tax_id;		
		string100        corphist_1_phonefax_details;
		string75         corphist_1_webemail_info;//web and email
		string30         corphist_1_filing_reference_nbr;
		string32         corphist_1_forgn_sos_charter_nbr;
		string60         corphist_1_status_desc;
		string60         corphist_1_orig_org_structure_desc;
		string350        corphist_1_orig_bus_type_desc;
		string1					 corphist_1_for_profit_ind;
		string250        corphist_1_addl_info;
		string250        corphist_1_ra_name;//cnma/fname+mname+lname + description
		string30         corphist_1_ra_fein_ssn;
		string250        corphist_1_ra_addl_info;
		string60         corphist_1_ra_address_type_desc;
		string250        corphist_1_ra_addr1; //street,city,st,zip
		string120        corphist_1_ra_phoneFax;
		string100        corphist_1_ra_webemail_info;//web and email
		string350        corphist_2_legal_name;
		string30         corphist_2_ln_name_type_desc;
		unsigned6 			 corphist_2_DotID;
		unsigned6 			 corphist_2_EmpID;
		unsigned6 			 corphist_2_PowID;
		unsigned6 			 corphist_2_ProxID;
		unsigned6 			 corphist_2_SeleID; 
		unsigned6 			 corphist_2_OrgID;
		unsigned6 			 corphist_2_UltID;
		string60         corphist_2_address1_type_desc;
		string150        corphist_2_address1;
		string60         corphist_2_address2_type_desc; 
		string150        corphist_2_address2;
    string8	         corphist_2_filing_date;		
		string8	         corphist_2_status_date;
	  string1          corphist_2_standing;
	  string2	         corphist_2_inc_state;
   	string8	         corphist_2_inc_date;		
		string60         corphist_2_forgn_state_desc;
		string32         corphist_2_fed_tax_id;
		string32         corphist_2_state_tax_id;		
		string100        corphist_2_phonefax_details;
		string75         corphist_2_webemail_info;//web and email
		string30         corphist_2_filing_reference_nbr;
		string32         corphist_2_forgn_sos_charter_nbr;
		string60         corphist_2_status_desc;
		string60         corphist_2_orig_org_structure_desc;
		string350        corphist_2_orig_bus_type_desc;
		string1					 corphist_2_for_profit_ind;
		string250        corphist_2_addl_info;
		string250        corphist_2_ra_name;//cnma/fname+mname+lname + description
		string30         corphist_2_ra_fein_ssn;
		string250        corphist_2_ra_addl_info;
		string60         corphist_2_ra_address_type_desc;
		string250        corphist_2_ra_addr1; //street,city,st,zip
		string120        corphist_2_ra_phoneFax;
		string100        corphist_2_ra_webemail_info;//web and email
		string350        corphist_3_legal_name;
		string30         corphist_3_ln_name_type_desc;
		unsigned6 			 corphist_3_DotID;
		unsigned6 			 corphist_3_EmpID;
		unsigned6 			 corphist_3_PowID;
		unsigned6 			 corphist_3_ProxID;
		unsigned6 			 corphist_3_SeleID; 
		unsigned6 			 corphist_3_OrgID;
		unsigned6 			 corphist_3_UltID;
		string60         corphist_3_address1_type_desc;
		string150        corphist_3_address1;
		string60         corphist_3_address2_type_desc; 
		string150        corphist_3_address2;
    string8	         corphist_3_filing_date;		
		string8	         corphist_3_status_date;
	  string1          corphist_3_standing;
	  string2	         corphist_3_inc_state;
   	string8	         corphist_3_inc_date;	
		string60         corphist_3_forgn_state_desc;
		string32         corphist_3_fed_tax_id;
		string32         corphist_3_state_tax_id;		
		string100        corphist_3_phonefax_details;
		string75         corphist_3_webemail_info;//web and email
		string30         corphist_3_filing_reference_nbr;
		string32         corphist_3_forgn_sos_charter_nbr;
		string60         corphist_3_status_desc;
		string60         corphist_3_orig_org_structure_desc;
		string350        corphist_3_orig_bus_type_desc;
		string1					 corphist_3_for_profit_ind;
		string250        corphist_3_addl_info;
		string250        corphist_3_ra_name;//cnma/fname+mname+lname + description
		string30         corphist_3_ra_fein_ssn;
		string250        corphist_3_ra_addl_info;
		string60         corphist_3_ra_address_type_desc;
		string250        corphist_3_ra_addr1; //street,city,st,zip
		string120        corphist_3_ra_phoneFax;
		string100        corphist_3_ra_webemail_info;//web and email	
		string350        corphist_4_legal_name;
		string30         corphist_4_ln_name_type_desc;
		unsigned6 			 corphist_4_DotID;
		unsigned6 			 corphist_4_EmpID;
		unsigned6 			 corphist_4_PowID;
		unsigned6 			 corphist_4_ProxID;
		unsigned6 			 corphist_4_SeleID; 
		unsigned6 			 corphist_4_OrgID;
		unsigned6 			 corphist_4_UltID;
		string60         corphist_4_address1_type_desc;
		string150        corphist_4_address1;
		string60         corphist_4_address2_type_desc; 
		string150        corphist_4_address2;
    string8	         corphist_4_filing_date;		
		string8	         corphist_4_status_date;
	  string1          corphist_4_standing;
	  string2	         corphist_4_inc_state;
   	string8	         corphist_4_inc_date;	
		string60         corphist_4_forgn_state_desc;
		string32         corphist_4_fed_tax_id;
		string32         corphist_4_state_tax_id;
		string100        corphist_4_phonefax_details;
		string75         corphist_4_webemail_info;//web and email
		string30         corphist_4_filing_reference_nbr;
		string32         corphist_4_forgn_sos_charter_nbr;
		string60         corphist_4_status_desc;
		string60         corphist_4_orig_org_structure_desc;
		string350        corphist_4_orig_bus_type_desc;
		string1					 corphist_4_for_profit_ind;
		string250        corphist_4_addl_info;
		string250        corphist_4_ra_name;//cnma/fname+mname+lname + description
		string30         corphist_4_ra_fein_ssn;
		string250        corphist_4_ra_addl_info;
		string60         corphist_4_ra_address_type_desc;
		string250        corphist_4_ra_addr1; //street,city,st,zip
		string120        corphist_4_ra_phoneFax;
		string100        corphist_4_ra_webemail_info;//web and email
		string350        corphist_5_legal_name;
		string30         corphist_5_ln_name_type_desc;
		unsigned6 			 corphist_5_DotID;
		unsigned6 			 corphist_5_EmpID;
		unsigned6 			 corphist_5_PowID;
		unsigned6 			 corphist_5_ProxID;
		unsigned6 			 corphist_5_SeleID; 
		unsigned6 			 corphist_5_OrgID;
		unsigned6 			 corphist_5_UltID;
		string60         corphist_5_address1_type_desc;
		string150        corphist_5_address1;
		string60         corphist_5_address2_type_desc; 
		string150        corphist_5_address2;
    string8	         corphist_5_filing_date;		
		string8	         corphist_5_status_date;
	  string1          corphist_5_standing;
	  string2	         corphist_5_inc_state;
   	string8	         corphist_5_inc_date;		
		string60         corphist_5_forgn_state_desc;
		string32         corphist_5_fed_tax_id;
		string32         corphist_5_state_tax_id;		
		string100        corphist_5_phonefax_details;
		string75         corphist_5_webemail_info;//web and email
		string30         corphist_5_filing_reference_nbr;
		string32         corphist_5_forgn_sos_charter_nbr;
		string60         corphist_5_status_desc;
		string60         corphist_5_orig_org_structure_desc;
		string350        corphist_5_orig_bus_type_desc;
		string1					 corphist_5_for_profit_ind;
		string250        corphist_5_addl_info;
		string250        corphist_5_ra_name;//cnma/fname+mname+lname + description
		string30         corphist_5_ra_fein_ssn;
		string250        corphist_5_ra_addl_info;
		string60         corphist_5_ra_address_type_desc;
		string250        corphist_5_ra_addr1; //street,city,st,zip
		string120        corphist_5_ra_phoneFax;
		string100        corphist_5_ra_webemail_info;//web and email
		string500        tn_1_details;
		string500        tn_2_details;
		string500        tn_3_details;
		string500        tn_4_details;
		string500        tn_5_details;
		string500        tm_1_details;
		string500        tm_2_details;
		string500        tm_3_details;
		string500        tm_4_details;
		string500        tm_5_details;	
	end;
	

end;


