export layout_corp_contact_common := RECORD
	string350 corp_legal_name;
	//unsigned6 bdid := 0; 
//	string2	  corp_state_origin; //Do we need this?
	string60  corp_address1_type_desc;
	string10  corp_addr1_prim_range;
string2   corp_addr1_predir;
string28  corp_addr1_prim_name;
string4   corp_addr1_addr_suffix;
string2   corp_addr1_postdir;
string10  corp_addr1_unit_desig;
string8   corp_addr1_sec_range;
string25  corp_addr1_p_city_name;
string25  corp_addr1_v_city_name;
string2   corp_addr1_state;
string5   corp_addr1_zip5;
string4   corp_addr1_zip4;
string8   corp_address1_effective_date;

string10  corp_phone10;
string60  corp_phone_number_type_desc;
string15  corp_fax_nbr; // new
string30  corp_email_address;
string30  corp_web_address;
end;