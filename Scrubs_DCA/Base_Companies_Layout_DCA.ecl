import Scrubs_DCA, DCAV2, AID,address,dca,standard,bipv2;
	
	EXPORT Base_Companies_Layout_DCA := record
			unsigned6   							src_rid	:= 0;
			unsigned6   							rid;
			unsigned6   							bdid;
			unsigned1   							bdid_score;
			BIPV2.IDlayouts.l_xlink_ids;
			unsigned4   							date_first_seen;
			unsigned4   							date_last_seen;
			unsigned4   							date_vendor_first_reported;
			unsigned4   							date_vendor_last_reported;
			AID.Common.xAID						physical_RawAID;
			AID.Common.xAID						physical_AceAID;
			AID.Common.xAID						mailing_RawAID;
			AID.Common.xAID						mailing_AceAID;
			unsigned1   							record_type; 
			string6   								file_type;
			unsigned3   							lncaGID;
			unsigned3   							lncaGHID;
			unsigned2   							lncaIID;

			string9   								rawfields_Enterprise_num;
			string9   				 				rawfields_Parent_Enterprise_number;  
			string9   				 				rawfields_Ultimate_Enterprise_number;  
			string70   								rawfields_Company_Type;   				  
			string150   							rawfields_Name;   				 
			string150   							rawfields_Note;   				 
			string2   				 				rawfields_Level;   				   				
			string9   				 				rawfields_Root;   				   				
			string4   				 				rawfields_Sub;   				   				 
			string150   							rawfields_Parent_Name;   				 
			string15   								rawfields_Parent_Number;   				  
			string150   							rawfields_JV_Parent1;   				  
			string15   								rawfields_JV1_num;   				   				
			string150   							rawfields_JV_Parent2;   				  
			string15   								rawfields_JV2_num;   				  
			
			string30   								rawfields_address1_PO_Box_Bldg;   				   				
			string70									rawfields_address1_Street;   				  
			string70   								rawfields_address1_Foreign_PO;   				  
			string80   								rawfields_address1_Misc__adr;   				  
			string15   								rawfields_address1_Postal_Code_1;   				  
			string30   								rawfields_address1_City;   				   				
			string2   				 				rawfields_address1_State;   				   				
			string15   								rawfields_address1_Zip;   				  
			string20   								rawfields_address1_Province;   				  
			string15   								rawfields_address1_Postal_Code_2;   				   				
			string30   								rawfields_address1_Country;   				  
			string15   								rawfields_address1_Postal_Code_3;   				  
			
			string50   								rawfields_Phone;   				  
			string50   								rawfields_Fax;   				   				
			string50   								rawfields_Telex;   				  
			string120  								rawfields_E_mail;   				  
			string120  								rawfields_URL;   				  
			
			string30   								rawfields_address2_PO_Box_Bldg;   				   				
			string70   								rawfields_address2_Street;   				  
			string70   								rawfields_address2_Foreign_PO;   				  
			string80   								rawfields_address2_Misc__adr;   				  
			string15   								rawfields_address2_Postal_Code_1;   				  
			string30   								rawfields_address2_City;   				   				
			string2   				 				rawfields_address2_State;   				   				
			string15   								rawfields_address2_Zip;   				  
			string20   								rawfields_address2_Province;   				  
			string15   								rawfields_address2_Postal_Code_2;   				   				
			string30   								rawfields_address2_Country;   				  
			string15   								rawfields_address2_Postal_Code_3;   				 
			
			string2   				 				rawfields_Incorp;   				   				 
			string5   				 				rawfields_percent_owned;   				   				
			string12   								rawfields_Earnings ;   				  
			string12   								rawfields_Sales;   				  
			string50   								rawfields_Sales_Desc;   				   				
			string12   								rawfields_Assets;   				  
			string12   								rawfields_Liabilities;   				  
			string12   								rawfields_Net_Worth;   				  
			string6   				 				rawfields_FYE;   				   				 
			string9   				 				rawfields_EMP_NUM;   				   				
			string1   				 				rawfields_DoesImport;   				   				
			string50   								rawfields_DoesExport;   				   				
			string4000 								rawfields_Bus_Desc ;   				
			string30   								rawfields_Sic1;   				   				
			string150  								rawfields_Text1;   				  
			string30   								rawfields_Sic2;   				   				
			string150  								rawfields_Text2;   				   				
			string30   								rawfields_Sic3;   				   				
			string150  								rawfields_Text3;   				  
			string30   								rawfields_Sic4;   				   				
			string150  								rawfields_Text4;   				   				
			string30   								rawfields_Sic5;   				   				
			string150  								rawfields_Text5;   				  
			string30   								rawfields_Sic6;   				   				
			string150  								rawfields_Text6;   				   				
			string30   								rawfields_Sic7;   				   				
			string150  								rawfields_Text7;   				  
			string30   								rawfields_Sic8;   				   				
			string150  								rawfields_Text8;   				   				
			string30   								rawfields_Sic9;   				   				
			string150  								rawfields_Text9;   				  
			string30   								rawfields_Sic10;   				   				
			string150  								rawfields_Text10;   				   				
			string20   								rawfields_Ticker_Symbol;   				  
			string450  								rawfields_Exchange1;   				   				 
			string450  								rawfields_Exchange2;   				   				
			string450  								rawfields_Exchange3;   				   				
			string450  								rawfields_Exchange4;   				   				
			string450  								rawfields_Exchange5;   				   				 
			string450  								rawfields_Exchange6;   				   				
			string450  								rawfields_Exchange7;   				   				
			string450  								rawfields_Exchange8;   				   				
			string450  								rawfields_Exchange9;   				   				 
			string450  								rawfields_Exchange10;   				   				
			string450  								rawfields_Exchange11;   				   				
			string450  								rawfields_Exchange12;   				   				
			string450  								rawfields_Exchange13;   				   				 
			string450  								rawfields_Exchange14;   				   				
			string450  								rawfields_Exchange15;   				   				
			string450  								rawfields_Exchange16;   				   				
			string450  								rawfields_Exchange17;   				   				 
			string450  								rawfields_Exchange18;   				   				
			string450  								rawfields_Exchange19;
			string450  								rawfields_Exchange20;   				   				
			string4000 								rawfields_Extended_Profile; 
			string60   								rawfields_CBSA;
			string5000 								rawfields_Competitors;
			string7   				 				rawfields_Naics1;
			string150  								rawfields_Naics_Text1; 
			string7   				 				rawfields_Naics2;
			string150  								rawfields_Naics_Text2;
			string7   				 				rawfields_Naics3;
			string150  								rawfields_Naics_Text3; 
			string7   				 				rawfields_Naics4;
			string150  								rawfields_Naics_Text4;
			string7   				 				rawfields_Naics5;
			string150  								rawfields_Naics_Text5; 
			string7   				 				rawfields_Naics6;
			string150  								rawfields_Naics_Text6;
			string7   				 				rawfields_Naics7;
			string150  								rawfields_Naics_Text7; 
			string7   				 				rawfields_Naics8;
			string150  								rawfields_Naics_Text8;
			string7   								rawfields_Naics9;
			string150  								rawfields_Naics_Text9; 
			string7   				 				rawfields_Naics10;
			string150  								rawfields_Naics_Text10;
			string8		 								rawfields_Update_Date;
			
			string12									killreport_company_id;
			string150									killreport_company_name;
			string1										killreport_is_major_us_stk;
			string2 									killreport_comp_type;
			string100									killreport_kill_reason;
			string10									killreport_kill_date_raw;
			string8										killreport_kill_date_clean;
			string20									killreport_kill_reason_clean;
			string9										killreport_kill_enterprise_nbr;
			string8										killreport_filedate;
			
			string25 									mergeracquis_MnA_Type;
			string9  									mergeracquis_MnA_Status;
			string3 									mergeracquis_Status_Marked_in_dB;
			string150									mergeracquis_Target_Company;
			string300									mergeracquis_What_Happened;
			string15 									mergeracquis_MnA_Amount_Offered;
			string9  									mergeracquis_MnA_Close_Date;
			string20 									mergeracquis_LexisNexis_Posting_Date;
			string10 									mergeracquis_Editorial_Comments;
			string20 									mergeracquis_Last_Change_Date;
			string9  									mergeracquis_Updated_By;
			string9										mergeracquis_target_enterprise_nbr;
			string9 									mergeracquis_buyer1_enterprise_nbr;
			string9 									mergeracquis_buyer2_enterprise_nbr;
			string9 									mergeracquis_buyer3_enterprise_nbr;
			string9										mergeracquis_seller1_enterprise_nbr;
			string9										mergeracquis_seller2_enterprise_nbr;
			string9										mergeracquis_seller3_enterprise_nbr;
			string8										mergeracquis_MnA_Close_Date_clean;
			string8										mergeracquis_LN_Posting_Date_clean;
			string8										mergeracquis_Last_Change_Date_clean;
			string8										mergeracquis_filedate;
			
			string10   								physical_address_prim_range; 	// [1..10]
			string2   				 				physical_address_predir;			// [11..12]
			string28   								physical_address_prim_name;		// [13..40]
			string4   				 				physical_address_addr_suffix; // [41..44]
			string2   				 				physical_address_postdir;			// [45..46]
			string10   								physical_address_unit_desig;	// [47..56]
			string8   				 				physical_address_sec_range;		// [57..64]
			string25   								physical_address_p_city_name;	// [65..89]
			string25   								physical_address_v_city_name; // [90..114]
			string2   				 				physical_address_st;					// [115..116]
			string5   				 				physical_address_zip;					// [117..121]
			string4   				 				physical_address_zip4;				// [122..125]
			string4   				 				physical_address_cart;				// [126..129]
			string1   				 				physical_address_cr_sort_sz;	// [130]
			string4   				 				physical_address_lot;					// [131..134]
			string1   				 				physical_address_lot_order;		// [135]
			string2   							  physical_address_dbpc;				// [136..137]
			string1   				 				physical_address_chk_digit;		// [138]
			string2   				 				physical_address_rec_type;		// [139..140]
			string2   				 				physical_address_fips_state;	// [141..142]
			string3   				 				physical_address_fips_county;	// [143..145]
			string10   								physical_address_geo_lat;			// [146..155]
			string11   								physical_address_geo_long;		// [156..166]
			string4   				 				physical_address_msa;					// [167..170]
			string7   				 				physical_address_geo_blk;			// [171..177]
			string1   				 				physical_address_geo_match;		// [178]
			string4   				 				physical_address_err_stat;		// [179..182]

		  string10   								mailing_address_prim_range; 	// [1..10]
			string2   				 				mailing_address_predir;				// [11..12]
			string28   								mailing_address_prim_name;		// [13..40]
			string4   				 				mailing_address_addr_suffix; 	// [41..44]
			string2   				 				mailing_address_postdir;			// [45..46]
			string10   								mailing_address_unit_desig;		// [47..56]
			string8   				 				mailing_address_sec_range;		// [57..64]
			string25   								mailing_address_p_city_name;	// [65..89]
			string25   								mailing_address_v_city_name; 	// [90..114]
			string2   				 				mailing_address_st;						// [115..116]
			string5   				 				mailing_address_zip;					// [117..121]
			string4   				 				mailing_address_zip4;					// [122..125]
			string4   				 				mailing_address_cart;					// [126..129]
			string1   				 				mailing_address_cr_sort_sz;		// [130]
			string4   				 				mailing_address_lot;					// [131..134]
			string1   				 				mailing_address_lot_order;		// [135]
			string2   				 				mailing_address_dbpc;					// [136..137]
			string1   				 				mailing_address_chk_digit;		// [138]
			string2   				 				mailing_address_rec_type;			// [139..140]
			string2   				 				mailing_address_fips_state;		// [141..142]
			string3   				 				mailing_address_fips_county;	// [143..145]
			string10   								mailing_address_geo_lat;			// [146..155]
			string11   								mailing_address_geo_long;			// [156..166]
			string4   								mailing_address_msa;					// [167..170]
			string7   				 				mailing_address_geo_blk;			// [171..177]
			string1   				 				mailing_address_geo_match;		// [178]
			string4   				 				mailing_address_err_stat;			// [179..182]
			
			string10   								clean_phones_Phone;   				  
			string10   								clean_phones_Fax;   				   				
			string10   								clean_phones_Telex;   				 
			
			string8   								clean_dates_update_date;   				  
		END;

