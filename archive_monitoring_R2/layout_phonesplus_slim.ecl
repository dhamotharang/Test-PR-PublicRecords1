import standard;

export layout_phonesplus_slim := record
       string10     customer_id;          
       string30     record_id;
       unsigned6 	did;
	  string10 	phone10;
       standard.Name_Slim;
	  standard.Addr_Slim;
	  unsigned1    best_phone_number;
	  string8      phone_version_number; 
	  string2      phone_type;
       string8      phone_dt_last_seen;
	  string8      phone_dt_first_seen;
	  string1		glb_dppa_flag;
	  string9      in_ssn;
end;