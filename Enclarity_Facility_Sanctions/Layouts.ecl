IMPORT Enclarity_Facility_Sanctions, AID, BIPV2,Address;
EXPORT Layouts := MODULE
	EXPORT input	:= MODULE
		EXPORT facility_sanctions := RECORD
			string38   	surrogate_key;           	
			string100  	prac_company1_in;        	
			string20   	prac_company1_key;       	
			string100  	prac_company1_name;      	
			string3    	prac_company1_apcfirm1;  	
			unsigned8   prac_company1_st;        	
			string10   	prac_phone1;             	
			unsigned8   prac_phone1_st;          	
			string10   	bill_phone1;             	
			unsigned8   bill_phone1_st;         	
			string10   	prac_fax1;               	
			unsigned8   prac_fax1_st;            	
			string10  	bill_fax1;               	
			unsigned8   bill_fax1_st;            	
			string48   	email_addr;              	
			unsigned8   email_addr_st;           	
			string50   	web_site;                	
			unsigned8   web_site_st;            	
			string9    	tin1;                    	
			unsigned8   tin1_st;                 	
			string25   	lic1_num_in;             	
			string2    	lic1_state;              	
			string20    lic1_num;                	
			string10   	lic1_type;               	
			string1    	lic1_status;             	
			string10    lic1_begin_date;         	
			string10    lic1_end_date;           	
			string16   	lic1_drug_schedule;      	
			unsigned8   lic1_st;                 	
			string20   	prac1_key;               	
			string50	 	prac1_primary_address;   	
			string50   	prac1_secondary_address; 	
			string28   	prac1_city;              	
			string2    	prac1_state;             	
			string5    	prac1_zip;               	
			string4    	prac1_zip4;              	
			string2    	prac1_rectype;           	
			string10   	prac1_primary_range;     	
			string2    	prac1_pre_directional;   	
			string28   	prac1_primary_name;      	
			string4    	prac1_suffix;            	
			string2    	prac1_post_directional;  	
			string10   	prac1_unit_designator;   	
			string8    	prac1_secondary_range;   	
			string9    	prac1_pobox;             	
			string9    	prac1_rrnumber;          	
			string10   	prac1_npsr;              	
			string6    	prac1_ace_stat_code;     	
			string6    	prac1_error_code;        	
			string5    	prac1_fipscode;          	
			string1    	prac1_rdi;               	
			unsigned8  	prac1_st;                	
			string20   	bill1_key;               	
			string50   	bill1_primary_address;   	
			string50   	bill1_secondary_address; 	
			string28   	bill1_city;              	
			string2    	bill1_state;             	
			string5    	bill1_zip;               	
			string4    	bill1_zip4;              	
			string2    	bill1_rectype;           	
			string10   	bill1_primary_range;     	
			string2    	bill1_pre_directional;   	
			string28   	bill1_primary_name;      	
			string4    	bill1_suffix;            	
			string2    	bill1_post_directional;  	
			string10   	bill1_unit_designator;   	
			string8    	bill1_secondary_range;   	
			string9    	bill1_pobox;             	
			string9    	bill1_rrnumber;          	
			string10   	bill1_npsr;              	
			string6    	bill1_ace_stat_code;     	
			string6    	bill1_error_code;        	
			string5    	bill1_fipscode;          	
			string1    	bill1_rdi;               	
			unsigned8   bill1_st;                	
			unsigned8 	sequence_num;            	
			string8    	project_num;             	
			string9    	filecode;                	
			string20    state_mask;              	
			string3    	dept_code;               	
			string50   	provider_id;             	
			unsigned8   provider_id_st;          	
			string10   	npi_num;                 	
			string10    npi_deact_date;          	
			unsigned8   npi_st;                  	
			string10   	medicare_fac_num;        	
			unsigned8   medicare_fac_num_st;     	
			string10   	medicaid_fac_num;        	
			unsigned8   medicaid_fac_num_st;     	
			string10   	facility_type;           	
			unsigned8   facility_type_st;        	
			string10   	taxonomy;                	
			string1    	taxonomy_primary_ind;    	
			unsigned8   taxonomy_st;             	
			string10    last_update_date;        	
			string38   	group_key;               	
			string2    	sanc1_state;             	
			string10   	sanc1_date;              	
			string10    sanc1_rein_date;         	
			string25   	sanc1_case;              	
			string50   	sanc1_source;            	
			string1000 	sanc1_complaint;         	
			unsigned8   sanc1_st;                	
			string100  	dba_in;                  	
			string20   	dba_key;                 	
			string100  	dba_name;                	
			string3    	dba_apcfirm1;            	
			unsigned8   dba_st;                  	
			string100  	bill_company1_in;        	
			string20   	bill_company1_key;       	
			string100  	bill_company1_name;      	
			string3   	bill_company1_apcfirm1;  	
			unsigned8   bill_company1_st;        	
			string10   	clia_num;                	
			string2    	clia_status_code;        	
			string1    	clia_cert_type_code;     	
			string10    clia_cert_eff_date;      	
			string10    clia_end_date;           	
			unsigned8   clia_data_st;            	
			string100  	contact_name_ef;
			string50   	contact_first_ef;	
			string50 		contact_middle_ef;  
			string50  	contact_last_ef; 
			string50   	sanc1_board_name;
			string100  	sanc1_board_type;
			string20   	sanc1_type;
			string10   	sanc1_order_date_ef;	
			string255		sanc1_description_ef;  
			string255  	sanc1_terms_ef;
			string255  	sanc1_condition_ef;
			string20   	sanc1_fine_ef;
			string30   	sanc1_case_num_ef;	
			string255		provider_status_ef;  
			string30  	added_by_ef; 
			string10 		added_date_ef;  
		END;
	END;
	
	EXPORT Appended	:= MODULE
	
		EXPORT clean_names_and_ids	:= RECORD
			unsigned1 normed_company_type;	// 1 = prac_company1, 2 = dba, 3 = bill_company1
			unsigned8 record_sequence; // used to normalize the names, at this point we aren't denormalizing, but leaving this in the base layout in case it is needed later
			string100	clean_company_name;
			unsigned6 bdid;
			unsigned1 bdid_score;
			unsigned8	lnfid;
		END;	
		
		EXPORT clean_phones	:= RECORD
			string10 clean_prac_phone1;
			string10 clean_bill_phone1;
			string10 clean_prac_fax1;
			string10 clean_bill_fax1;
		END;
	
		EXPORT clean_addresses	:= RECORD
			string10	clean_prac1_prim_range;
			string2  	clean_prac1_predir;
			string28 	clean_prac1_prim_name;
			string4  	clean_prac1_addr_suffix;
			string2  	clean_prac1_postdir;
			string10 	clean_prac1_unit_desig;
			string8  	clean_prac1_sec_range;
			string25 	clean_prac1_p_city_name;
			string25 	clean_prac1_v_city_name;
			string2  	clean_prac1_st;			
			string5  	clean_prac1_zip;		
			string4  	clean_prac1_zip4;		
			string4  	clean_prac1_cart;
			string1  	clean_prac1_cr_sort_sz;
			string4  	clean_prac1_lot;
			string1  	clean_prac1_lot_order;
			string2  	clean_prac1_dbpc;
			string1  	clean_prac1_chk_digit;  
			string2  	clean_prac1_rec_type;
			string2  	clean_prac1_fips_st:='';
			string3  	clean_prac1_fips_county:=''; 		
			string10 	clean_prac1_geo_lat;     		
			string11 	clean_prac1_geo_long;    		
			string4  	clean_prac1_msa;         		
			string7  	clean_prac1_geo_blk;     		
			string1  	clean_prac1_geo_match;
			string4  	clean_prac1_err_stat;		
			string10	clean_prac2_prim_range;
			string2  	clean_prac2_predir;
			string28 	clean_prac2_prim_name;
			string4  	clean_prac2_addr_suffix;
			string2  	clean_prac2_postdir;
			string10 	clean_prac2_unit_desig;
			string8  	clean_prac2_sec_range;
			string25 	clean_prac2_p_city_name;
			string25 	clean_prac2_v_city_name;
			string2  	clean_prac2_st;			
			string5  	clean_prac2_zip;		
			string4  	clean_prac2_zip4;		
			string4  	clean_prac2_cart;
			string1  	clean_prac2_cr_sort_sz;
			string4  	clean_prac2_lot;
			string1  	clean_prac2_lot_order;
			string2  	clean_prac2_dbpc;
			string1  	clean_prac2_chk_digit;  
			string2  	clean_prac2_rec_type;
			string2  	clean_prac2_fips_st:='';
			string3  	clean_prac2_fips_county:=''; 		
			string10 	clean_prac2_geo_lat;     		
			string11 	clean_prac2_geo_long;    		
			string4  	clean_prac2_msa;         		
			string7  	clean_prac2_geo_blk;     		
			string1  	clean_prac2_geo_match;
			string4  	clean_prac2_err_stat;
			string10	clean_bill1_prim_range;
			string2  	clean_bill1_predir;
			string28 	clean_bill1_prim_name;
			string4  	clean_bill1_addr_suffix;
			string2  	clean_bill1_postdir;
			string10 	clean_bill1_unit_desig;
			string8  	clean_bill1_sec_range;
			string25 	clean_bill1_p_city_name;
			string25 	clean_bill1_v_city_name;
			string2  	clean_bill1_st;			
			string5  	clean_bill1_zip;		
			string4  	clean_bill1_zip4;		
			string4  	clean_bill1_cart;
			string1  	clean_bill1_cr_sort_sz;
			string4  	clean_bill1_lot;
			string1  	clean_bill1_lot_order;
			string2  	clean_bill1_dbpc;
			string1  	clean_bill1_chk_digit;  
			string2  	clean_bill1_rec_type;
			string2  	clean_bill1_fips_st:='';
			string3  	clean_bill1_fips_county:=''; 		
			string10 	clean_bill1_geo_lat;     		
			string11 	clean_bill1_geo_long;    		
			string4  	clean_bill1_msa;         		
			string7  	clean_bill1_geo_blk;     		
			string1  	clean_bill1_geo_match;
			string4  	clean_bill1_err_stat;		
			string10	clean_bill2_prim_range;
			string2  	clean_bill2_predir;
			string28 	clean_bill2_prim_name;
			string4  	clean_bill2_addr_suffix;
			string2  	clean_bill2_postdir;
			string10 	clean_bill2_unit_desig;
			string8  	clean_bill2_sec_range;
			string25 	clean_bill2_p_city_name;
			string25 	clean_bill2_v_city_name;
			string2  	clean_bill2_st;			
			string5  	clean_bill2_zip;		
			string4  	clean_bill2_zip4;		
			string4  	clean_bill2_cart;
			string1  	clean_bill2_cr_sort_sz;
			string4  	clean_bill2_lot;
			string1  	clean_bill2_lot_order;
			string2  	clean_bill2_dbpc;
			string1  	clean_bill2_chk_digit;  
			string2  	clean_bill2_rec_type;
			string2  	clean_bill2_fips_st:='';
			string3  	clean_bill2_fips_county:=''; 		
			string10 	clean_bill2_geo_lat;     		
			string11 	clean_bill2_geo_long;    		
			string4  	clean_bill2_msa;         		
			string7  	clean_bill2_geo_blk;     		
			string1  	clean_bill2_geo_match;
			string4  	clean_bill2_err_stat;
			AID.Common.xAID	clean_prac1_RawAID;
			AID.Common.xAID	clean_prac2_RawAID;
			AID.Common.xAID	clean_bill1_RawAID;
			AID.Common.xAID	clean_bill2_RawAID;
			AID.Common.xAID	clean_prac1_ACEAID;
			AID.Common.xAID	clean_prac2_ACEAID;
			AID.Common.xAID	clean_bill1_ACEAID;
			AID.Common.xAID	clean_bill2_ACEAID;
		END;
	
		EXPORT clean_dates	:= RECORD
			string10    clean_lic1_begin_date;         	
			string10    clean_lic1_end_date;           	
			string10    clean_npi_deact_date;          	
			string10    clean_last_update_date;        	
			string10   	clean_sanc1_date;              	
			string10    clean_sanc1_rein_date;         	
			string10    clean_clia_cert_eff_date;      	
			string10    clean_clia_end_date;           	
			string10   	clean_sanc1_order_date_ef;	
			string10 		clean_added_date_ef;
		END;
		
		EXPORT src_and_dates	:= RECORD
			string8  	date_first_seen  := '0';
			string8  	date_last_seen :='0';
			string1  	record_type;
			string2  	src;
			unsigned6 Date_vendor_first_reported;
			unsigned6 Date_vendor_last_reported;
			unsigned8	source_rid;
			unsigned6 pid;
			string8		LN_derived_rein_date;
			boolean		LN_derived_rein_flag	:= false;	
			BIPV2.IDlayouts.l_xlink_ids;
		END;
		
		EXPORT temp_address := RECORD
			address.Layout_Clean182.prim_range;
		  address.Layout_Clean182.predir;
		  address.Layout_Clean182.prim_name;
		  address.Layout_Clean182.addr_suffix;
		  address.Layout_Clean182.postdir;
		  address.Layout_Clean182.unit_desig;
		  address.Layout_Clean182.sec_range;
		  address.Layout_Clean182.p_city_name;
		  address.Layout_Clean182.v_city_name;
		  address.Layout_Clean182.st;
		  address.Layout_Clean182.zip;
		  address.Layout_Clean182.zip4;
		  address.Layout_Clean182.cart;
		  address.Layout_Clean182.cr_sort_sz;
		  address.Layout_Clean182.lot;
		  address.Layout_Clean182.lot_order;
		  address.Layout_Clean182.dbpc;
		  address.Layout_Clean182.chk_digit;
		  address.Layout_Clean182.rec_type;
		  STRING2		fips_st:='';
		  STRING3		fips_county:='';
		  address.Layout_Clean182.geo_lat;
		  address.Layout_Clean182.geo_long;
		  address.Layout_Clean182.msa;
		  address.Layout_Clean182.geo_blk;
		  address.Layout_Clean182.geo_match;
		  address.Layout_Clean182.err_stat;
			AID.Common.xAID		RawAID;		
			AID.Common.xAID   ACEAID;
		END;
	END;
	
	EXPORT Base	:= MODULE
	
		EXPORT facility_sanctions	:= RECORD
			Input.facility_sanctions;
			unsigned level := 0; // 1 - cumulative, 2 - full refresh, 3 - full refresh with reinstatements (set by filecode)
			Appended.clean_names_and_ids;
			Appended.clean_phones;
			Appended.clean_addresses;
			Appended.clean_dates;
			Appended.src_and_dates;
		END;
	END;
END;