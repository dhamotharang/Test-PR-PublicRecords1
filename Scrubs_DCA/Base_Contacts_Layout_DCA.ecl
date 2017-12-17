import Scrubs_DCA, DCAV2, AID,address,dca,standard,bipv2;
	
	EXPORT Base_Contacts_Layout_DCA := record
		  unsigned6														rid;
			unsigned6														did;
			unsigned1														did_score;
			unsigned6														bdid;
			unsigned1														bdid_score;
			BIPV2.IDlayouts.l_xlink_ids;
			unsigned4   												date_first_seen;
			unsigned4   												date_last_seen;
			unsigned4   												date_vendor_first_reported;
			unsigned4   												date_vendor_last_reported;
			AID.Common.xAID											physical_RawAID;
			AID.Common.xAID											physical_AceAID;
			AID.Common.xAID											mailing_RawAID;
			AID.Common.xAID											mailing_AceAID;
			unsigned1  													record_type; 
			string6															file_type;
			unsigned3														lncaGID;
			unsigned3														lncaGHID;
			unsigned2														lncaIID;
			string9		 													rawfields_Enterprise_num;
			string2    													rawfields_Level;      
			string150  													rawfields_Name;    
			string30   													rawfields_address1_PO_Box_Bldg;      
			string70   													rawfields_address1_Street;     
			string70   													rawfields_address1_Foreign_PO;     
			string80   													rawfields_address1_Misc__adr;     
			string15   													rawfields_address1_Postal_Code_1;     
			string30   													rawfields_address1_City;      
			string2    													rawfields_address1_State;      
			string15   													rawfields_address1_Zip;     
			string20   													rawfields_address1_Province;     
			string15   													rawfields_address1_Postal_Code_2;      
			string30   													rawfields_address1_Country;     
			string15   													rawfields_address1_Postal_Code_3;     
			string50   													rawfields_Phone;     
			string50   													rawfields_Fax;      
			string50   													rawfields_Telex;     
			
			string30   													rawfields_address2_PO_Box_Bldg;      
			string70   													rawfields_address2_Street;     
			string70   													rawfields_address2_Foreign_PO;     
			string80   													rawfields_address2_Misc__adr;     
			string15   													rawfields_address2_Postal_Code_1;     
			string30   													rawfields_address2_City;      
			string2    													rawfields_address2_State;      
			string15   													rawfields_address2_Zip;     
			string20   													rawfields_address2_Province;     
			string15   													rawfields_address2_Postal_Code_2;      
			string30   													rawfields_address2_Country;     
			string15   													rawfields_address2_Postal_Code_3;    
			
			string200  													rawfields_executive_Name;     
			string65   													rawfields_executive_Title;     
			string3    													rawfields_executive_code; 
			
			string8		 													rawfields_Update_Date;
			
			string4															birth_year;
			string9															human_link_id;
			string6															gender;
			
			string5  														clean_name_title;
			string20 														clean_name_fname;
			string20 														clean_name_mname;
			string20 														clean_name_lname;
			string5  														clean_name_name_suffix;
			string3  														clean_name_name_score;
			
			string10   													physical_address_prim_range; 	// [1..10]
			string2   				 									physical_address_predir;			// [11..12]
			string28   													physical_address_prim_name;		// [13..40]
			string4   				 									physical_address_addr_suffix; // [41..44]
			string2   				 									physical_address_postdir;			// [45..46]
			string10   													physical_address_unit_desig;	// [47..56]
			string8   				 									physical_address_sec_range;		// [57..64]
			string25   													physical_address_p_city_name;	// [65..89]
			string25   													physical_address_v_city_name; // [90..114]
			string2   				 									physical_address_st;					// [115..116]
			string5   				 									physical_address_zip;					// [117..121]
			string4   				 									physical_address_zip4;				// [122..125]
			string4   				 									physical_address_cart;				// [126..129]
			string1   				 									physical_address_cr_sort_sz;	// [130]
			string4   				 									physical_address_lot;					// [131..134]
			string1   				 									physical_address_lot_order;		// [135]
			string2   							  					physical_address_dbpc;				// [136..137]
			string1   				 									physical_address_chk_digit;		// [138]
			string2   				 									physical_address_rec_type;		// [139..140]
			string2   				 									physical_address_fips_state;	// [141..142]
			string3   				 									physical_address_fips_county;	// [143..145]
			string10   													physical_address_geo_lat;			// [146..155]
			string11   													physical_address_geo_long;		// [156..166]
			string4   				 									physical_address_msa;					// [167..170]
			string7   				 									physical_address_geo_blk;			// [171..177]
			string1   				 									physical_address_geo_match;		// [178]
			string4   				 									physical_address_err_stat;		// [179..182]

		  string10   													mailing_address_prim_range; 	// [1..10]
			string2   				 									mailing_address_predir;				// [11..12]
			string28   													mailing_address_prim_name;		// [13..40]
			string4   				 									mailing_address_addr_suffix; 	// [41..44]
			string2   				 									mailing_address_postdir;			// [45..46]
			string10   													mailing_address_unit_desig;		// [47..56]
			string8   				 									mailing_address_sec_range;		// [57..64]
			string25   													mailing_address_p_city_name;	// [65..89]
			string25   													mailing_address_v_city_name; 	// [90..114]
			string2   				 									mailing_address_st;						// [115..116]
			string5   				 									mailing_address_zip;					// [117..121]
			string4   				 									mailing_address_zip4;					// [122..125]
			string4   				 									mailing_address_cart;					// [126..129]
			string1   				 									mailing_address_cr_sort_sz;		// [130]
			string4   				 									mailing_address_lot;					// [131..134]
			string1   				 									mailing_address_lot_order;		// [135]
			string2   				 									mailing_address_dbpc;					// [136..137]
			string1   				 									mailing_address_chk_digit;		// [138]
			string2   				 									mailing_address_rec_type;			// [139..140]
			string2   				 									mailing_address_fips_state;		// [141..142]
			string3   				 									mailing_address_fips_county;	// [143..145]
			string10   													mailing_address_geo_lat;			// [146..155]
			string11   													mailing_address_geo_long;			// [156..166]
			string4   													mailing_address_msa;					// [167..170]
			string7   				 									mailing_address_geo_blk;			// [171..177]
			string1   				 									mailing_address_geo_match;		// [178]
			string4   				 									mailing_address_err_stat;			// [179..182]
						
			string10   													clean_phones_Phone;     
			string10   													clean_phones_Fax;      
			string10   													clean_phones_Telex;   
		END;

