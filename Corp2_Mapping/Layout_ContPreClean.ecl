export layout_contPreClean := record
			
string8   dt_first_seen;
string8   dt_last_seen;
	
string30  corp_key;
string30  corp_supp_key;
string2	  corp_vendor;
string3   corp_vendor_county;
string5   corp_vendor_subcode;
string2	  corp_state_origin;
string8	  corp_process_date;
string32  corp_orig_sos_charter_nbr;
	
string350 corp_legal_name;
	
string8	  corp_address1_type_cd;
string60  corp_address1_type_desc;
string70  corp_address1_line1;
string70  corp_address1_line2;
string70  corp_address1_line3;
string70  corp_address1_line4;
string70  corp_address1_line5;
string70  corp_address1_line6;
string8	  corp_address1_effective_date;
	
string30  corp_phone_number;
string8	  corp_phone_number_type_cd;
string60  corp_phone_number_type_desc;
string15  corp_fax_nbr;
string30  corp_email_address;
string30  corp_web_address;
	
string30  cont_filing_reference_nbr;
string8	  cont_filing_date;
string8	  cont_filing_cd;
string60  cont_filing_desc;
	
string8	  cont_type_cd;
string60  cont_type_desc;
string100 cont_name;
string60  cont_title1_desc;
string60  cont_title2_desc;
string60  cont_title3_desc;
string60  cont_title4_desc;
string60  cont_title5_desc;
string32  cont_sos_charter_nbr;
string10  cont_fein;
string9	  cont_ssn;
string8	  cont_dob;
string8   cont_status_cd;
string60  cont_status_desc;
string8	  cont_effective_date;
string1	  cont_effective_cd;
string60  cont_effective_desc;
string350 cont_addl_info;   //modified length from 100 to 350
	
string8	  cont_address_type_cd;
string60  cont_address_type_desc;
string70  cont_address_line1;
string70  cont_address_line2;
string70  cont_address_line3;
string70  cont_address_line4;
string70  cont_address_line5;
string70  cont_address_line6;
string8	  cont_address_effective_date;
string30  cont_address_county;
	
string30  cont_phone_number;
string8	  cont_phone_number_type_cd;
string60  cont_phone_number_type_desc;
string15  cont_fax_nbr;
string30  cont_email_address;
string30  cont_web_address;
end;