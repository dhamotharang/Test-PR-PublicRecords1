EXPORT Layout_Global_Sid_Base := RECORD

	UNSIGNED4	        dt_vendor_first_reported;
	UNSIGNED4	        dt_vendor_last_reported;
	UNSIGNED4	        process_date;
	STRING1		        history_flag;								//blank: current, H: Historical
    STRING20            domain_id;                                  //Derived from input file, it can be PR, HC-HPCC, INS
    STRING1            	prof_data_only;                             //Professional Data Only, derived from input file, it can be Y or N
	SET OF UNSIGNED4	global_sids;
    UNSIGNED8           rcid;
END;