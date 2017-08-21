import doxie, standard;

export Layout_Address_Update := record
       string10  customer_id;          
       string30  record_id;
       standard.Addr_Slim;
       string6   addr_dt_last_seen;
	  string6   addr_dt_first_seen; 
	  string2   src;
       standard.Name_Slim;
       string8   addr_version_number;
	  string8   phone_version_number;
	  unsigned1 best_phone_number;
	  boolean   phone_level_ta;
	  boolean   phone_level_tb;
	  boolean   phone_level_td;
	  boolean   phone_level_tg;
	  unsigned6 did;
	  unsigned1 best_address_count;
	  unsigned1 name_score := 0;
	  unsigned1 ssn_score := 0;
end;