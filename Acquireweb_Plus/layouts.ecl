EXPORT layouts := MODULE
  IMPORT AID, bipv2;

	EXPORT layout_clean_name := RECORD
		STRING5 clean_title;
    STRING20 clean_fname;
    STRING20 clean_mname;
    STRING20 clean_lname;
    STRING5 clean_name_suffix;
    STRING3 clean_name_score;
	END;
	
	EXPORT layout_clean_addr := RECORD
		STRING10 clean_prim_range;
    STRING2 clean_predir;
    STRING28 clean_prim_name;
    STRING4 clean_addr_suffix;
    STRING2 clean_postdir;
    STRING10 clean_unit_desig;
    STRING8 clean_sec_range;
    STRING25 clean_p_city_name;
    STRING25 clean_v_city_name;
    STRING2 clean_st;
    STRING5 clean_zip;
    STRING4 clean_zip4;
    STRING4 clean_cart;
    STRING1 clean_cr_sort_sz;
    STRING4 clean_lot;
    STRING1 clean_lot_order;
    STRING2 clean_dbpc;
    STRING1 clean_chk_digit;
    STRING2 clean_rec_type;
    STRING5 clean_county;
    STRING10 clean_geo_lat;
    STRING11 clean_geo_long;
    STRING4 clean_msa;
    STRING7 clean_geo_blk;
    STRING1 clean_geo_match;
    STRING4 clean_err_stat;
	END;
	
//Business Build layouts	
	EXPORT Business_raw:= RECORD
	  STRING   AWID_Business;
    // STRING   B2B_Indivifual;
		STRING   FirstName;
		STRING   LastName;
		STRING   Title;
		STRING   CompanyName;
		STRING   Address1;
		STRING   Address2;
		STRING   City;
		STRING   State;
		STRING   Zip;
		STRING   Zip4;
		STRING   Email;
  END;
	
	EXPORT Acquireweb_IPAddress:=RECORD
		STRING	Zip;
		STRING	Zip4;
		STRING	IpAddress;
	END;
	
	EXPORT Business_Base:=RECORD
		unsigned6 rcid; //Used for Ingest process
	  // Information from the raw files
    STRING awid;
		STRING FirstName;
		STRING LastName;
		STRING Title;
		STRING CompanyName;
		STRING Address1;
		STRING Address2;
		STRING City;
		STRING State;
		STRING Zip;
		STRING Zip4;
	  STRING emailid;
		STRING Email;
		STRING IPAddress;
		
		// Information harvested from the DID lookup process
    UNSIGNED8 did;
    UNSIGNED8 did_score;
		UNSIGNED8 aid;
		
		// Information harvested from the NID function
    layout_clean_name - clean_name_score;
		STRING clean_cname;
		
		// information harvested from the AID lookup process
    layout_clean_addr;

    // Instance tracking fields
		STRING8 date_first_seen;
		STRING8 date_last_seen;
		STRING8 date_vendor_first_reported;
		STRING8 date_vendor_last_reported;
		BOOLEAN current_rec;
		STRING Source; //Distinguish Business(AP) from Individual(AW)
	END;
	
	EXPORT Base_w_bip	:= RECORD
		Business_Base;
		bipv2.IDlayouts.l_xlink_ids;
	END;
END;