EXPORT layouts := MODULE
	
	IMPORT AID;
	
	EXPORT V12_epostal_in := RECORD
		string	sequence;
		string	first_name;
		string	last_name;
		string	address_1;
		string	address_2;
		string	city;
		string	state;
		string	zip_code;
		string	email;
	END;

	EXPORT V12_ezip_in := RECORD
		string	sequence;
		string	first_name;
		string	last_name;
		string	city;
		string	state;
		string	zip_code;
		string	email;
	END;	

	EXPORT V12_optout_in := RECORD	
		string	email;
	END;
	
	EXPORT V12_hb_in := RECORD	
		string	email;
	END;
	
	EXPORT V12_base	:=	RECORD
		V12_epostal_in; //ezip input files are project into the epostal layout
		
		//Flag to indicate if the email address is on the optout or hard bounce list
		boolean		optout;
		boolean		hardbounce;
		
		unsigned8	persistent_record_id := 0;	//unique record identifier
		
		//DID fields
		unsigned8 DID;
		unsigned8 DID_Score;

		//Clean name fields
		string5		clean_title;
    string20	clean_fname;
    string20	clean_mname;
    string20	clean_lname;
    string5		clean_name_suffix;
    string3		clean_name_score;
		
		//AID Fields
		AID.Common.xAID	RawAID;
		string77	Append_Prep_Address_Situs;
		string54	Append_Prep_Address_Last_Situs;
		
		//Clean address fields
		string10	clean_prim_range;
    string2		clean_predir;
    string28	clean_prim_name;
    string4		clean_addr_suffix;
    string2		clean_postdir;
    string10	clean_unit_desig;
    string8		clean_sec_range;
    string25	clean_p_city_name;
    string25	clean_v_city_name;
    string2		clean_st;
    string5		clean_zip;
    string4		clean_zip4;
    string4		clean_cart;
    string1		clean_cr_sort_sz;
    string4		clean_lot;
    string1		clean_lot_order;
    string2		clean_dbpc;
    string1		clean_chk_digit;
    string2		clean_rec_type;
    string5		clean_county;
    string10	clean_geo_lat;
    string11	clean_geo_long;
    string4		clean_msa;
    string7		clean_geo_blk;
    string1		clean_geo_match;
    string4		clean_err_stat;
		
		// Instance tracking fields
		string8		process_date;
		string8		date_first_seen;
		string8		date_last_seen;
		string8		date_vendor_first_reported;
		string8		date_vendor_last_reported;
		boolean 	current_rec; //Added to distinguish historical records(with hb and optout) from new full file replacement
	END;
	
END;	