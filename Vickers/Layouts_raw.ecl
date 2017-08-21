import lib_StringLib,Address;
EXPORT Layouts_raw := module

//Insider Raw Layouts

export Insider_Filing := record                     
  string form_id;          
  string row_nbr;          
  string cusip;            
  string filer_id;         
  string relationship;     
  string trans_date_from;  
  string trans_date_to;    
  string trans_amt;        
  string market_value;     
  string trans_amt_type;   
  string dollar_type;      
  string trans_type;       
  string trans_price_from; 
  string trans_price_to;   
  string amt_owned;        
  string owned_type;       
  string form_type;        
  string broker_code;      
  string date_entered;     
  string upd_date;         
end;    

export Insider_Filer := record
  string filer_id;
  string filer_name;
  string street;
  string street2;
  string city;
  string state;
  string province;
  string country;
  string zip_code;
  string zip_code4;
end;
 
export common_FF_clean := record
  string20 form_id;
  string3 row_nbr;
  string15 cusip;
  string15 filer_id;
  string70 filer_name;
  string70 street;
  string50 street2;
  string50 city;
  string2 state;
  string2 province;
  string5 country;
  string80 country_desc;
  string15 zip_code;
  string4 zip_code4;
  string5 relationship_code;
  string80 relationship_desc;
  string20 relationship_alpha;
  string8 trans_date_from;
  string8 trans_date_to;
  string15 trans_amt;
  string15 market_value;
  string5 trans_amt_type;
  string5 dollar_type;
  string80 dollar_type_desc;
  string20 dollar_type_alpha;
  string5 trans_type;
  string80 trans_type_desc;
  string20 trans_type_alpha;
  string50 trans_type_desc2;
  string15 trans_price_from;
  string15 trans_price_to;
  string15 amt_owned;
  string5 owned_type;
  string5 form_type;
  string80 form_type_desc;
  string20 form_type_alpha;
  string50 form_type_desc2;
  string5 broker_code;
  string8 date_entered;
  string8 upd_date;
	UNSIGNED8 raw_aid ;
	UNSIGNED8 ace_aid ;
	Address.Layout_Clean182_fips clean_address;
  Address.Layout_Clean_Name    clean_name;
	string2 crlf;
end;

/*
export common_FF_clean := record
  string20 form_id;
  string3 row_nbr;
  string15 cusip;
  string15 filer_id;
  string70 filer_name;
  string70 street;
  string50 street2;
  string50 city;
  string2 state;
  string2 province;
  string5 country;
  string80 country_desc;
  string15 zip_code;
  string4 zip_code4;
  string5 relationship_code;
  string80 relationship_desc;
  string20 relationship_alpha;
  string8 trans_date_from;
  string8 trans_date_to;
  string15 trans_amt;
  string15 market_value;
  string5 trans_amt_type;
  string5 dollar_type;
  string80 dollar_type_desc;
  string20 dollar_type_alpha;
  string5 trans_type;
  string80 trans_type_desc;
  string20 trans_type_alpha;
  string50 trans_type_desc2;
  string15 trans_price_from;
  string15 trans_price_to;
  string15 amt_owned;
  string5 owned_type;
  string5 form_type;
  string80 form_type_desc;
  string20 form_type_alpha;
  string50 form_type_desc2;
  string5 broker_code;
  string8 date_entered;
  string8 upd_date;
	UNSIGNED8 raw_aid ;
	UNSIGNED8 ace_aid ;
	Address.Layout_Clean182_fips clean_address;
  Address.Layout_Clean_Name    clean_name;
	string2 crlf;
end;
*/


//13D13G Layouts
dstring(string del) := TYPE  
export integer physicallength(string s) := lib_StringLib.StringLib.StringFind(s,del,1)+length(del)-1;
export string load(string s) := s[1..lib_StringLib.StringLib.StringFind(s,del,1)-1];
export string store(string s) := s + del;
export integer maxlength(string s) := 99999;
END;

export r13d13g	:=
record
  dstring('|') form_id;
  dstring('|') cusip;
  dstring('|') amend_nbr;
  dstring('|') form_type;
  dstring('|') signer_title;
  dstring('|') signer_name;
  dstring('|') contact_name;
  dstring('|') contact_title;
  dstring('|') contact_street;
  dstring('|') contact_street2;
  dstring('|') contact_city;
  dstring('|') contact_state;
  dstring('|') contact_zip;
  dstring('|') contact_zip4;
  dstring('|') contact_phone;
  dstring('|') contact_province;
  dstring('|') contact_country;
  dstring('|') filer_id;
  dstring('|') filer_name;
  dstring('|') trans_date_from;
  dstring('|') trans_date_to;
  dstring('|') trans_amount;
  dstring('|') trans_type;
  dstring('|') amount_owned;
  dstring('|') sole_vote;
  dstring('|') sole_disp;
  dstring('|') shared_vote;
  dstring('|') shared_disp;
  dstring('|') percent_share_out;
  dstring('|') reporter_type;
  dstring('|') comment;
  dstring('|') summary_text;
  dstring('|') filing_date;
  dstring('|') entered_date;
  dstring('\r\n') upd_date;
end;



export Layout_13D13G:= record
  string form_id;
  string cusip;
  string amend_nbr;
  string form_type;
  string signer_title;
  string signer_name;
  string contact_name;
  string contact_title;
  string contact_street;
  string contact_street2;
  string contact_city;
  string contact_state;
  string contact_zip;
  string contact_zip4;
  string contact_phone;
  string contact_province;
  string contact_country;
  string filer_id;
  string filer_name;
  string trans_date_from;
  string trans_date_to;
  string trans_amount;
  string trans_type;
  string amount_owned;
  string sole_vote;
  string sole_disp;
  string shared_vote;
  string shared_disp;
  string percent_share_out;
  string reporter_type;
  string comment;
  string summary_text;
  string filing_date;
  string entered_date;
  string upd_date;
end;

export Layout_13D13G_clean := record
  string18 form_id;
  string9 cusip;
  string4 amend_nbr;
  string2 form_type;
  string80 form_type_desc;
  string30 form_type_alpha;
  string50 form_type_desc2;
  string30 signer_title;
  string49 signer_name;
  string50 contact_name;
  string30 contact_title;
  string50 contact_street;
  string37 contact_street2;
  string40 contact_city;
  string2 contact_state;
  string10 contact_zip;
  string4 contact_zip4;
  string20 contact_phone;
  string2 contact_province;
  string150 contact_province_desc;
  string3 contact_country;
  string80 contact_country_desc;
  string6 filer_id;
  string70 filer_name;
  string8 trans_date_from;
  string8 trans_date_to;
  string10 trans_amount;
  string2 trans_type;
  string80 trans_type_desc;
  string20 trans_type_alpha;
  string50 trans_type_desc2;
  string11 amount_owned;
  string11 sole_vote;
  string11 sole_disp;
  string15 shared_vote;
  string15 shared_disp;
  string6 percent_share_out;
  string35 reporter_type;
  string80 reporter_type_desc;
  string255 comment;
  string3000 summary_text;
  string19 filing_date;
  string8 entered_date;
  string8 upd_date;
	UNSIGNED8 raw_aid ;
	UNSIGNED8 ace_aid ;
	Address.Layout_Clean182_fips clean_contact_address;
  Address.Layout_Clean_Name    clean_signer_name;
	Address.Layout_Clean_Name    clean_contact_name;
  Address.Layout_Clean_Name    clean_filer_name;
  string1 lf;
end;



export Layout_Common_all := 
record                   
  string20 form_id;      
  string15 filer_id;     
  string6 file_type;     
  string15 cusip;        
  string70 issuer_name;  
  string10 ticker;       
  string75 company_name; 
  string5 name_prefix;   
  string20 name_first;   
  string20 name_middle;  
  string20 name_last;    
  string5 name_suffix;   
  string3 name_score;    
  string10 prim_range;   
  string2 predir;        
  string28 prim_name;    
  string4 addr_suffix;   
  string2 postdir;       
  string10 unit_desig;   
  string8 sec_range;     
  string25 p_city_name;  
  string25 v_city_name;  
  string2 st;            
  string5 zip;           
  string4 zip4;          
string1 lf;              
                         
end;                     

//Security Layouts

export Layout_Security := 
record
  string cusip;
  string issuer_name;
  string issuer_desc;
  string ticker;
  string exchange_code;
  string sec_type;
  string foreign_code;
  string sic_code;
  string active_code;
end;



end;