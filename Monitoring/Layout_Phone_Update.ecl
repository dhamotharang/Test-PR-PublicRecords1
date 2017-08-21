import standard;

export Layout_Phone_Update := record
	  string10  customer_id;          
       string30  record_id;
       string10  phone10;
       string8   phone_dt_last_seen;
	  string8   phone_dt_first_seen;
       standard.Name_Slim;
	  standard.Addr_Slim;
	  string2    phone_type;
       string1    dual_name_flag;
       string3    listing_type;
       string1    publish_code;  
       string30  carrier_name;
       string25  carrier_city;
       string2    carrier_state;
       string8    phone_version_number; 
	  unsigned1  best_phone_number;
	  unsigned1  best_phone_count;
end;