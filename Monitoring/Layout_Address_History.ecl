import standard;

export Layout_Address_History := record
	  string10  customer_id;          
       string30  record_id;
	  standard.Addr_Slim;
       string6   addr_dt_last_seen;
	  string6   addr_dt_first_seen; 
	  string2   src;
	  unsigned1 best_address_count;
	  standard.Name_Slim;
       string8   addr_version_number;
end;