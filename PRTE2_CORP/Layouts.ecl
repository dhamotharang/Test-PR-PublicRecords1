IMPORT Corp2, BIPV2;

  EXPORT Layouts := MODULE
 
  EXPORT cont_corp_key_RECORD_type :=RECORD
    STRING30 corp_key;
    STRING1 RECORD_type;
    Corp2.Layout_Corporate_Direct_Cont_Base_linkids - [corp_key,RECORD_type];
  END;
	
 EXPORT Layout_Corporate_Direct_Corp_Base :=Corp2.Layout_Corporate_Direct_Corp_Base;
 EXPORT Layout_Corporate_Direct_Cont_Base :=Corp2.Layout_Corporate_Direct_Cont_Base;
 
 EXPORT Corp_charter_layout:=RECORD
  STRING2 corp_state_origin;
  STRING32 corp_sos_charter_nbr;
  STRING30 corp_key;
 END;
 
  EXPORT Corp_Base_Layout:=RECORD
    UNSIGNED6 bdid;
    Corp2.Layout_Corporate_Direct_Corp_Base - [bdid];
    BIPV2.IDlayouts.l_xlink_ids;
    UNSIGNED8  __internal_fpos__;
    UNSIGNED8 source_rec_id;
    UNSIGNED8 append_addr1_rawaid;
    UNSIGNED8  append_addr1_aceaid;
    STRING100 corp_prep_addr1_line1;
    STRING50  corp_prep_addr1_last_line;
    UNSIGNED8 append_addr2_rawaid;
    UNSIGNED8  append_addr2_aceaid;
    STRING100 corp_prep_addr2_line1;
    STRING50  corp_prep_addr2_last_line;
    UNSIGNED8 append_ra_rawaid;
    UNSIGNED8 append_ra_aceaid;
    STRING100 ra_prep_addr_line1;
    STRING50 ra_prep_addr_last_line;
    STRING fp;
    STRING bug_num;
    INTEGER8 append_row_id;
    STRING10 cust_name;
  	String9 link_Fein;
		String8 link_Inc_Date;
  END;

  EXPORT Stock_Base_Layout:=RECORD
    Corp2.Layout_Corporate_Direct_Stock_Base;
    UNSIGNED8  __internal_fpos__;
    STRING bug_num;
    INTEGER8 append_row_id;
    STRING10 cust_name;      
  END;
				
   EXPORT Event_Base_Layout:=RECORD
    Corp2.Layout_Corp_Event_Base;
    UNSIGNED8  __internal_fpos__;
    STRING bug_num;
    INTEGER8 append_row_id;
    STRING10 cust_name;  
   END;
  
 EXPORT AR_Out_Layout :=RECORD 
  STRING30 corp_key;
  STRING1 RECORD_type;
	Corp2.Layout_Corporate_Direct_AR_Base - [corp_key,RECORD_type];
 END; 
    
  EXPORT AR_Base_Layout :=RECORD 
    Corp2.Layout_Corporate_Direct_AR_Base;
    UNSIGNED8 __internal_fpos__;
    STRING10  bug_num;
    UNSIGNED8 append_row_id;
    STRING10  cust_name;
    END;

  EXPORT Event_Out_Layout :=RECORD
    STRING30 corp_key;
    STRING1 RECORD_type;
    Corp2.Layout_Corporate_Direct_Event_Base_Bid - [bid,corp_key,RECORD_type];
  END;
	
  EXPORT Stock_Out_Layout:=RECORD
    STRING30 corp_key;
    STRING1 RECORD_type;
    Corp2.Layout_Corporate_Direct_Stock_Base_Bid - [bid,corp_key,RECORD_type];
  END;
 
  EXPORT Cont_Base_Layout :=RECORD
    Corp2.Layout_Corporate_Direct_Cont_Base_Linkids;
    UNSIGNED8 __internal_fpos__;
    UNSIGNED8 append_corp_addr_rawaid;
    UNSIGNED8 append_corp_addr_aceaid;
    STRING100 corp_prep_addr_line1;
    STRING50  corp_prep_addr_last_line;
    UNSIGNED8 append_cont_addr_rawaid;
    UNSIGNED8 append_cont_addr_aceaid;
    STRING100 cont_prep_addr_line1;
    STRING50  cont_prep_addr_last_line;
    STRING    fp;
    STRING    bug_num;
    INTEGER8  append_row_id;
    STRING10  cust_name;
    String9 link_ssn;
		String8 link_DOB;
  END;

   EXPORT Corp_bdid_Layout:=RECORD
    UNSIGNED6 bdid; 
    STRING30 corp_key;
   END;
   
   EXPORT Cont_bdid_Layout :=RECORD
    UNSIGNED6 bdid; 
    STRING30 corp_key;
   END;

   EXPORT Corp_RECORD_Key_Layout:=RECORD
    STRING30 corp_key;
    STRING1 RECORD_type;
    Corp2.Layout_Corporate_Direct_Corp_Base_Linkids - [corp_key,RECORD_type];
   END;
   
   EXPORT layout_common_with_corp :=RECORD
    UNSIGNED6 bdid := 0;  
    STRING2	  corp_inc_state;
    STRING8	  corp_inc_date;
    STRING3	  corp_forgn_state_cd;
    STRING32  corp_forgn_sos_charter_nbr;
    STRING8	  corp_forgn_date;
    STRING30  corp_key;
    STRING2	  corp_state_origin;
    STRING32  corp_orig_sos_charter_nbr;
    STRING32  corp_sos_charter_nbr;  // For application display
    STRING350 corp_legal_name;
    STRING32  corp_fed_tax_id;
    STRING32  corp_state_tax_id;
    STRING32  corp_forgn_fed_tax_id;
    STRING32  corp_forgn_state_tax_id;
    STRING100 corp_ra_name;
    STRING10  corp_addr1_prim_range;
    STRING9	  corp_ra_ssn;
    STRING8	  corp_ra_dob;
    STRING28  corp_addr1_prim_name;
    STRING8   corp_addr1_sec_range;
    STRING25  corp_addr1_p_city_name;
    STRING25  corp_addr1_v_city_name;
    STRING2   corp_addr1_state;
    STRING5   corp_addr1_zip5;
    STRING10  corp_addr2_prim_range;
    STRING28  corp_addr2_prim_name;
    STRING8   corp_addr2_sec_range;
    STRING25  corp_addr2_p_city_name;
    STRING25  corp_addr2_v_city_name;
    STRING2   corp_addr2_state;
    STRING5   corp_addr2_zip5;
    STRING10  corp_phone10;
    STRING10  corp_ra_phone10;
    STRING20  corp_ra_fname1;
    STRING20  corp_ra_mname1;
    STRING20  corp_ra_lname1;
    STRING20  corp_ra_fname2;
    STRING20  corp_ra_mname2;
    STRING20  corp_ra_lname2;
    STRING70  corp_ra_cname1;
    STRING70  corp_ra_cname2;
    STRING10  corp_ra_prim_range;
    STRING2   corp_ra_predir;
    STRING28  corp_ra_prim_name;
    STRING8   corp_ra_sec_range;
    STRING25  corp_ra_p_city_name;
    STRING25  corp_ra_v_city_name;
    STRING2   corp_ra_state;
    STRING5   corp_ra_zip5;
    STRING28 business_prim_name ;
    STRING10 business_prim_range ;
    STRING2 business_state ;
    STRING25 business_city;
    STRING8 business_sec_range;
    STRING5 business_zip ;
    STRING10 business_phone ;
    STRING350 company_name ;
    STRING32 fein;
    STRING10 person_prim_range ;
    STRING28 person_prim_name ;
    STRING25 person_city ;
    STRING5 person_zip ;
    STRING8 person_sec_range;
    STRING2 person_state ;
    STRING10 Person_phone ;
    STRING8 person_dob ;
    STRING9 person_ssn ;
    STRING20 person_fname ;
    STRING20 person_mname ;
    STRING20 person_lname ;
    UNSIGNED6 person_did;
    UNSIGNED1 zero1 := 0;
    UNSIGNED4 lookup_bits := 0;
  END;
 
  EXPORT temp_address_layout := RECORD 
    STRING70  corp_address1_line1;
    STRING70  corp_address1_line2;
    STRING70  corp_address2_line1;
    STRING70  corp_address2_line2;
    STRING70  corp_ra_address_line1;
    STRING70  corp_ra_address_line2;
    STRING70  cont_address_line1;
    STRING70  cont_address_line2;    
    UNSIGNED8 corp_row_id;
    UNSIGNED8 cont_row_id;
  END;
 
 END;