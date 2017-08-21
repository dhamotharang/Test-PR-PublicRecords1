IMPORT BIPV2, AID;
EXPORT Layout_BK := MODULE
  EXPORT Delete_Nod  := RECORD
	STRING5    fips_cd;
	STRING20    Pid;
	STRING15    NOD_Source;
	STRING6    Delete_Flag := '';
	STRING8    ln_filedate;
	END;
	
	EXPORT Delete_Reo  := RECORD
	STRING5    fips_cd;
	STRING20    Pid;
	STRING6    Delete_Flag := '';
	STRING8    ln_filedate;
	END;
	
  EXPORT reo_raw := RECORD
	STRING5     fips_cd;
	STRING60    prop_full_addr;
	STRING30    prop_addr_city;
	STRING2     prop_addr_state;
	STRING5     prop_addr_zip5;
	STRING4     prop_addr_zip4;
	STRING4     prop_addr_unit_type;	
	STRING11    prop_addr_unit_no;
	STRING13    prop_addr_house_no;
	STRING2     prop_addr_predir;
	STRING40    prop_addr_street;
	STRING4     prop_addr_suffix;
	STRING2     prop_addr_postdir;
	STRING4     prop_addr_carrier_rt;
	STRING8     recording_date;
	STRING10    recording_book_num;
	STRING10    recording_page_num;
	STRING20    recording_doc_num;
	STRING2     doc_type_cd;
	STRING45    APN;
	STRING1     multi_APN;
	STRING2     partial_interest_trans;
	STRING40    seller1_fname;
	STRING40    seller1_lname;
	STRING2     seller1_id;
	STRING40    seller2_fname;
	STRING40    seller2_lname;
	STRING40    buyer1_fname;
	STRING40    buyer1_lname;
	STRING2     buyer1_id_cd;
	STRING40    buyer2_fname;
	STRING40    buyer2_lname;
	STRING2     buyer_vesting_cd;
	STRING19    concurrent_doc_num;
	STRING30    buyer_mail_city;
	STRING2     buyer_mail_state;
	STRING5     buyer_mail_zip5;
	STRING4     buyer_mail_zip4;
	STRING2     legal_lot_cd;
	STRING10    legal_lot_num;
	STRING7     legal_block;
	STRING7     legal_section;
	STRING7     legal_district;
	STRING7     legal_land_lot;
	STRING6     legal_unit;
	STRING30    legacl_city;
	STRING50    legal_subdivision;
	STRING7     legal_phase_num;
	STRING10    legal_tract_num;
	STRING100   legal_brief_desc;
	STRING30    Legal_Township;
	STRING20    recorder_map_ref;
	STRING1     prop_buyer_mail_addr_cd;
	STRING3     property_use_cd;
	STRING8     orig_contract_date;
	STRING10    sales_price;
	STRING1     sales_price_cd;
	STRING7     city_xfer_tax;
	STRING7     county_xfer_tax;
	STRING7     total_xfer_tax;
	STRING40    concurrent_lender_name;
	STRING1     concurrent_lender_type;
	STRING10    concurrent_loan_amt;
	STRING1     concurrent_loan_type;
	STRING4     concurrent_type_fin;
	STRING4     concurrent_interest_rate;
	STRING8     concurrent_due_dt;
	STRING10    concurrent_2nd_loan_amt;
	STRING60    buyer_mail_full_addr;
	STRING4     buyer_mail_unit_type;
	STRING11    buyer_mail_unit_no;
	STRING10    lps_internal_pid;
	STRING40    buyer_mail_careof;
	STRING28    title_co_name;
	STRING1     legal_desc_cd;
	STRING1     adj_rate_rider;
	STRING15    adj_rate_index;
	STRING4     change_index;
	STRING1     rate_change_freq;
	STRING4     int_rate_ngt;
	STRING4     int_rate_nlt;
	STRING4     max_int_rate;
	STRING2     int_only_period;
	STRING1     fixed_rate_rider;
	STRING2     first_chg_dt_yy;
	STRING4     first_chg_dt_mmdd;
	STRING1     prepayment_rider;
	STRING2     prepayment_term;
	STRING4     asses_land_use;
	STRING1     res_indicator;
	STRING1     construction_loan;
	STRING1     inter_family;
	STRING1     cash_purchase;
	STRING1     stand_alone_refi;
	STRING1     equity_credit_line;
	STRING1     reo_flag;
	STRING1     DistressedSaleFlag;
	END;
  
	EXPORT nod_raw := RECORD
	STRING35    src_county;
	STRING2     src_state;
	STRING5     fips_cd;
	STRING2     doc_type;
	STRING8     recording_dt;
	STRING20    recording_doc_num;
	STRING10    book_number;
	STRING10    page_number;
	STRING30    loan_number;
	STRING15    trustee_sale_number;
	STRING40    case_number;
	STRING8     orig_contract_date;
	STRING9     unpaid_balance;
	STRING9     past_due_amt;
	STRING8     as_of_dt;
	STRING40    contact_Fname;
	STRING40    contact_Lname;
	STRING40    attention_to;
	STRING60    contact_mail_full_addr;
	STRING11    contact_mail_unit;
	STRING30    contact_mail_city;
	STRING2     contact_mail_state;
	STRING5     contact_mail_zip5;
	STRING4     contact_mail_zip4;
	STRING14    contact_telephone;
	STRING8     due_date;
	STRING40    trustee_fname;
	STRING40    trustee_lname;
	STRING60    trustee_mail_full_addr;
	STRING11    trustee_mail_unit;
	STRING30    trustee_mail_city;
	STRING2     trustee_mail_state;
	STRING5     trustee_mail_zip5;
	STRING4     trustee_mail_zip4;
	STRING12    trustee_telephone;
	STRING40    borrower1_fname;
	STRING40    borrower1_lname;
	STRING2     borrower1_id_cd;
	STRING40    borrower2_fname;
	STRING40    borrower2_lname;
	STRING2     borrower2_id_cd;
	STRING40    orig_lender_name;
	STRING1     orig_lender_type;
	STRING40    curr_lender_name;
	STRING1     curr_lender_type;
	STRING1     mers_indicator;
	STRING8     loan_recording_date;
	STRING20    loan_doc_num;
	STRING10    loan_book;
	STRING10    loan_page;
	STRING9     orig_loan_amt;
	STRING10    legal_lot_num;
	STRING7     legal_block;
	STRING50    legal_subdivision_name;
	STRING100   legal_brief_desc;
	STRING8     auction_date;
	STRING5     auction_time;
	STRING60    auction_location;
	STRING11    auction_min_bid_amt;
	STRING40    trustee_mail_careof;
	STRING1     property_addr_cd;
	STRING30    auction_city;
	STRING8     original_nod_recording_date;
	STRING20    original_nod_doc_num;
	STRING10    original_nod_book;
	STRING10    original_nod_page;
	STRING45    nod_apn;
	STRING60    property_full_addr;
	STRING4     prop_addr_unit_type;
	STRING11    prop_addr_unit_no;
	STRING30    prop_addr_city;
	STRING2     prop_addr_state;
	STRING5     prop_addr_zip5;
	STRING4     prop_addr_zip4;
	STRING45    APN;
	STRING10    sam_pid;
	STRING10    deed_pid;
	STRING10    lps_internal_pid;
	STRING1     nod_source;
 END;
 
  EXPORT reo  := RECORD
	STRING70 foreclosure_id;
	STRING8 ln_filedate := ''; 
	STRING6 Delete_Flag;
	STRING30 bk_infile_type := '';	
  REO_raw;
	END;
	
	EXPORT nod  := RECORD
	STRING70 foreclosure_id;
	STRING8 ln_filedate := '';
	STRING6 Delete_Flag;
	STRING30 bk_infile_type := '';	
	NOD_raw;
	END;

// EXPORT rowID_Reo  := RECORD
			// integer8  append_row_ID := 0;			
			// REO;
// END; 
 
 
// EXPORT rowID_Nod  := RECORD
			// integer8  append_row_ID := 0;			
			// nod;
// END;
 
 
EXPORT Norm_Names_reo := RECORD
  STRING100   NAME_FULL;
	STRING30    Name_First;
	STRING30    Name_Last;
	STRING15    Name_Type; 
	STRING15    TYPE_CODE;
	STRING100   Company_Name;
	Reo;
END;
	
EXPORT Norm_Names_nod := RECORD
  STRING100   NAME_FULL;
	STRING30    Name_First;
	STRING30    Name_Last;
	STRING15    Name_Type; 
	STRING15    TYPE_CODE;
	STRING100   Company_Name;
	Nod;
END;		 

EXPORT Norm_Addr_REO := RECORD
	STRING100 Orig_Address;
	STRING25  Orig_City;
	STRING2   Orig_State;
	STRING5   Orig_Zip5;
	STRING4   Orig_Zip4;	
  STRING15  AddrType;
	Norm_Names_REO;
END;

EXPORT Norm_Addr_NOD := RECORD
	STRING100 Orig_Address;
	STRING25  Orig_Unit;
	STRING25  Orig_City;
	STRING2   Orig_State;
	STRING5   Orig_Zip5;
	STRING4   Orig_Zip4;
  STRING15  AddrType;
	Norm_Names_nod;
END; 
 
export ClnName_REO:= record
	STRING20  pdid := '';
	STRING20  pfrd_address_ind:='';
	UNSIGNED8 rawAid := 0;
  UNSIGNED8 nid := 0;
	STRING25 		cln_title := '';
	STRING30  	cln_fname := '';
	STRING30  	cln_mname := '';
	STRING30  	cln_lname := '';
	STRING5 		cln_suffix := '';
	STRING25		cln_title2 := '';
	STRING30  	cln_fname2 := '';
	STRING30  	cln_mname2 := '';
	STRING30  	cln_lname2 := '';
	STRING5   	cln_suffix2 := '';
  UNSIGNED8  name_ind := 0;
  UNSIGNED8  persistent_record_id := 0;
	STRING100   cname := '';
	Norm_Addr_REO;
	BIPV2.IDlayouts.l_xlink_ids;	
end;
 
EXPORT  ClnName_NOD:= RECORD
	STRING20  pdid := '';
	STRING20  pfrd_address_ind:='';
	UNSIGNED8 rawAid := 0;
  UNSIGNED8 nid := 0;
	STRING25 		cln_title := '';
	STRING30  	cln_fname := '';
	STRING30  	cln_mname := '';
	STRING30  	cln_lname := '';
	STRING5 		cln_suffix := '';
	STRING25		cln_title2 := '';
	STRING30  	cln_fname2 := '';
	STRING30  	cln_mname2 := '';
	STRING30  	cln_lname2 := '';
	STRING5   	cln_suffix2 := '';
  UNSIGNED8  name_ind := 0;
  UNSIGNED8  persistent_record_id := 0;
	STRING100   cname := '';
	Norm_Addr_NOD;
	BIPV2.IDlayouts.l_xlink_ids;	
end;
 
EXPORT ClnAddr_Reo		:= RECORD
	 UNSIGNED8   rawaidin;
/* AID fields */
   UNSIGNED8  cleanaid;
   STRING1		addresstype;
   STRING10		prim_range;
   STRING2		predir;
   STRING28		prim_name;
   STRING4		addr_suffix;
   STRING2		postdir;
   STRING10		unit_desig;
   STRING8		sec_range;
   STRING25		p_city_name;
   STRING25		v_city_name;
   STRING2		st;
   STRING5		zip;
   STRING4		zip4;
   STRING4		cart;
   STRING1		cr_sort_sz;
   STRING4		lot;
   STRING1		lot_order;
   STRING2		dbpc;
   STRING1		chk_digit;
   STRING2		rec_type;
   STRING5		county;
   STRING10		geo_lat;
   STRING11		geo_long;
   STRING4		msa;
   STRING7		geo_blk;
   STRING1		geo_match;
   STRING4		err_stat;
   ClnName_REO;	 
END;


EXPORT ClnAddr_nod		:= RECORD
	 UNSIGNED8   rawaidin;
/* AID fields */
   UNSIGNED8 cleanaid;
   STRING5		addresstype;
   STRING10		prim_range;
   STRING2		predir;
   STRING28		prim_name;
   STRING4		addr_suffix;
   STRING2		postdir;
   STRING10		unit_desig;
   STRING8		sec_range;
   STRING25		p_city_name;
   STRING25		v_city_name;
   STRING2		st;
   STRING5		zip;
   STRING6		zip4;
   STRING6		cart;
   STRING1		cr_sort_sz;
   STRING4		lot;
   STRING1		lot_order;
   STRING2		dbpc;
   STRING1		chk_digit;
   STRING2		rec_type;
   STRING5		county;
   STRING10		geo_lat;
   STRING11		geo_long;
   STRING4		msa;
   STRING7		geo_blk;
   STRING1		geo_match;
   STRING4		err_stat;
   ClnName_NOD;
END;

EXPORT did_reo := RECORD
   UNSIGNED6  did := 0;
	 ClnAddr_Reo;
	 END;

EXPORT did_nod := RECORD
   UNSIGNED6  did := 0;
	 ClnAddr_nod;
	 END;

EXPORT did_reo_plus := RECORD
      bipv2.IDlayouts.l_xlink_ids;
      did_reo;
		END;		
EXPORT did_nod_plus := RECORD
      bipv2.IDlayouts.l_xlink_ids;
      did_nod;
		END;
		
EXPORT base_nod  := record 
   STRING19 create_dte;
	 STRING19 last_upd_dte;
	 STRING19 stamp_dte;
	 STRING8 date_first_seen;
	 STRING8 date_last_seen;
	 STRING8 date_vendor_first_reported;
	 STRING8 date_vendor_last_reported;
	 STRING8 process_date;
   STRING25 src;
	 STRING25 record_id;
   did_nod_plus;
end;

export base_reo  := record
   STRING19 create_dte;
	 STRING19 last_upd_dte;
	 STRING19 stamp_dte;
	 STRING8 date_first_seen;
	 STRING8 date_last_seen;
	 STRING8 date_vendor_first_reported;
	 STRING8 date_vendor_last_reported;
	 STRING8 process_date;
   STRING25 src;
	 STRING25 record_id;
   did_reo_plus;
end;
END;		