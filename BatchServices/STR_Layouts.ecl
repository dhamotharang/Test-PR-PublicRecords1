import Autokey_batch, doxie;

EXPORT STR_Layouts := 
MODULE
		EXPORT batch_in := Record
			Autokey_batch.Layouts.rec_inBatchMaster.acctno;
			string100 addr 						:= '';
			Autokey_batch.Layouts.rec_inBatchMaster.prim_range;
			Autokey_batch.Layouts.rec_inBatchMaster.predir;
			Autokey_batch.Layouts.rec_inBatchMaster.prim_name;
			Autokey_batch.Layouts.rec_inBatchMaster.addr_suffix;
			Autokey_batch.Layouts.rec_inBatchMaster.postdir;
			Autokey_batch.Layouts.rec_inBatchMaster.unit_desig;
			Autokey_batch.Layouts.rec_inBatchMaster.sec_range;
			Autokey_batch.Layouts.rec_inBatchMaster.p_city_name;
			Autokey_batch.Layouts.rec_inBatchMaster.st;
			Autokey_batch.Layouts.rec_inBatchMaster.z5;
			Autokey_batch.Layouts.rec_inBatchMaster.zip4;
			Autokey_batch.Layouts.rec_inBatchMaster.apn;
			string20	owner1_first 		:= '';
			string20	owner1_middle 	:= '';
			string20	owner1_last 		:= '';
			string5		owner1_suffix		:= '';
			string20	owner2_first 		:= '';
			string20	owner2_middle 	:= '';
			string20	owner2_last 		:= '';
			string5		owner2_suffix		:= '';
			string4 	year						:= '';
			string2		years_to_search := '';
		END;
		EXPORT batch_out := Record
			Autokey_batch.Layouts.rec_inBatchMaster.acctno;
			string3					file_split_flag;
			string2					overall_hit_flag;			
			unsigned6				did;
			string1 				current_address;
			string1					LNMatchesOwner_flag; // Y/N - last name matches property current or previous owner
			string2					BA_hit_flag;	
			string20				BA_first_name;
			string20				BA_middle_name;
			string20				BA_last_name;	
			string5					BA_name_suffix;
			string8					BA_dt_first_seen;
			string8					BA_dt_last_seen;
			string2					DL_hit_flag;		
			string20				DL_first_name;
			string20				DL_middle_name;
			string20				DL_last_name;
			string5					DL_name_suffix;
			string8					DL_first_lic_issue_dt_seen; 
			string8					DL_last_lic_issue_dt_seen; 
			string8					DL_last_expiration_dt_seen; 
			string2					MVR_hit_flag;					
			string20				MVR_reg_first_name;
			string20				MVR_reg_middle_name;
			string20				MVR_reg_last_name;	
			string5					MVR_reg_name_suffix;
			string8					MVR_first_renewal_dt_seen; 
			string8					MVR_last_renewal_dt_seen; 
			string8					MVR_last_expiration_dt_seen; 
			string2					Voter_hit_flag;		
			string20				Voter_first_name;
			string20				Voter_middle_name;
			string20				Voter_last_name;	
			string5					Voter_name_suffix;
			string8					Voter_last_vote_dt;		
			string75        best_addr;
			string25  			best_addr_city;
			string2   			best_addr_st; 
			string10   			best_addr_zip; 
			string8					best_addr_dt_first_seen;
			string8					best_addr_dt_last_seen;
			string8					sale_date;		
			string11				sale_amount;
			string4					tax_year;		
			string11				assessed_value;	
			unsigned6 			owner1_did;		
			unsigned6 			owner1_bdid;		
			string1					owner1_is_business;
			string70      	owner1_name;
			string10				owner1_ssn;
			string75        owner1_addr;
			string25  			owner1_addr_city;
			string2   			owner1_addr_st; 
			string10   			owner1_addr_zip; 
			string8					owner1_first_seen; 
			string8					owner1_last_seen;  
			unsigned6 			owner2_did;	
			unsigned6 			owner2_bdid;	
			string1					owner2_is_business;
			string70				owner2_name;
			string10				owner2_ssn;		
			string75        owner2_addr;
			string25  			owner2_addr_city;
			string2   			owner2_addr_st; 
			string10   			owner2_addr_zip; 
			string8					owner2_first_seen; 
			string8					owner2_last_seen;			
			string70  			parcelID_addr;
			string25				parcelID_addr_city;
			string2					parcelID_addr_st;
			string10				parcelID_addr_zip;
			integer 				error_code;
			boolean 				apnSearch; // [internal]
		END;		
		EXPORT batch_in_ready := Record
			batch_in - [addr, year, years_to_search];
			boolean 	apnSearch := false;
			string5		county := '';
			unsigned3	search_year_since	:= 0;
			unsigned3	search_year_until	:= 0;	
			string2 	drop_ind := '';
			boolean 	missing_sec_range := false;
			integer   error_code;
		END;
		EXPORT property_owner := record
			Autokey_batch.Layouts.rec_inBatchMaster.acctno;
			unsigned6 			owner_did;
			string9					owner_ssn;	
			string20				owner_fname;
			string20				owner_mname;
			string20				owner_lname;	
			string5					owner_suffix;
			unsigned6 			owner_bdid;
			string70				owner_cname;	
			boolean					is_seller;
			string8 				sortby_date 		:= '';
			string75        owner_addr 			:= '';
			string25  			owner_addr_city := '';
			string2   			owner_addr_st 	:= '';
			string10   			owner_addr_zip 	:= '';
			unsigned3				owner_dt_first_seen := 0;
			unsigned3				owner_dt_last_seen 	:= 0;
		END;
		EXPORT Working_Property := record
			batch_in_ready;
			dataset(property_owner)	owners;
			string11				assessed_value;		
			string8					sale_date;		
			string11				sale_amount;
			string4					tax_year;		
			string8 				sortby_date;
			string12  			ln_fares_id;
			string3 				document_type_code;
			string1  				fares_refi_flag;
			unsigned2 			penalt;
			string1					rec_type; 
			string1					party_type;
			boolean					multipleApnLocation;
		END;					
		EXPORT Working_Flat := record
			batch_in_ready;
			string25				vin;
			unsigned2 			penalt;
			string12  			ln_fares_id;
			batch_out - [acctno, current_address, error_code, apnSearch]; 
			boolean					current_address;
			unsigned6				did2;
			string20				MVR_reg2_first_name;
			string20				MVR_reg2_middle_name;
			string20				MVR_reg2_last_name;	
			string5					MVR_reg2_name_suffix;
			boolean 				hasOwnerInfo;
			boolean 				isOwner;
			boolean					isPreviousOwner;
			boolean					isDeceased;
		END;	
		EXPORT Best_Plus	:= record
			doxie.layout_best;
			unsigned3	addr_dt_first_seen;
			boolean		isDeceased;
		END;
		EXPORT Layout_SplitFlags := record
			Autokey_batch.Layouts.rec_inBatchMaster.acctno;
			string3	file_split_flag;	
			dataset({string2 hf;}) hitflags;  // each overall hit flag for a given acctno.
		END;
END;