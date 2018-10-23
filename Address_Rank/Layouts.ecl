IMPORT AddrBest, Autokey_batch, Batchshare, BatchServices, Doxie, Header;

EXPORT Layouts := MODULE	
	EXPORT Batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.SharePII; 						// i.e. ssn (no dashes), dob
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;	
		STRING10  	phone := '';		
		BatchShare.Layouts.ShareAddressNCOA - NCOA_county_name;
	END;
	
	EXPORT Address := RECORD
		BatchServices.Layouts.layout_batch_common_address - county_name;
		STRING8 		dt_first_seen			:= '';	
		STRING8 		dt_last_seen			:= '';	
	END;
		
	EXPORT Batch_out := RECORD
		BatchShare.Layouts.ShareAcct;
		UNSIGNED		error_code;
		STRING	 		error_desc;
		UNSIGNED6		did;
		STRING20		name_first;
		STRING20		name_middle;
		STRING20		name_last;
		STRING5			name_suffix;			
		STRING1 		BA_flag; 									//potential values of B=Best Address hit or ''
		STRING100  	BA_address  	 := '';
		STRING10  	BA_prim_range  := '';
		STRING2   	BA_predir      := '';
		STRING28  	BA_prim_name   := '';
		STRING4   	BA_addr_suffix := '';
		STRING2   	BA_postdir     := '';
		STRING10  	BA_unit_desig  := '';
		STRING8   	BA_sec_range   := '';
		STRING25  	BA_p_city_name := '';
		STRING2   	BA_st          := '';
		STRING5   	BA_z5          := '';
		STRING4   	BA_zip4        := '';
		STRING8 		BA_dt_first_seen	:= '';	
		STRING8 		BA_dt_last_seen		:= '';		
		STRING1 		NCOA_flag;								//potential values of N=NCOA hit or ''
		STRING100  	NCOA_address		 := '';
		STRING10  	NCOA_prim_range  := '';
		STRING2   	NCOA_predir      := '';
		STRING28  	NCOA_prim_name   := '';
		STRING4   	NCOA_addr_suffix := '';
		STRING2   	NCOA_postdir     := '';
		STRING10  	NCOA_unit_desig  := '';
		STRING8   	NCOA_sec_range   := '';
		STRING25  	NCOA_p_city_name := '';
		STRING2   	NCOA_st          := '';
		STRING5   	NCOA_z5          := '';
		STRING4   	NCOA_zip4        := '';
		STRING8 		NCOA_dt_first_seen	:= '';	
		STRING8 		NCOA_dt_last_seen		:= '';
		STRING1			college_addr;							//(Y/N)
		STRING1			business_addr;						//(Y/N)
		STRING1			rent_flag;								//(Y/N)
		STRING1			property_owner;						//(Y/N)
		STRING1			long_term_hit;						//(Y/N)
		STRING1			short_term_hit;						//(Y/N)
		STRING1			owner_occupied_hit;				//(Y/N)	
	END;
	EXPORT BatchOut_wInputEcho := RECORD
		BatchShare.Layouts.ShareAcct;
		UNSIGNED6     in_did;           
		STRING9       in_ssn;
		STRING8       in_dob;
		STRING20      in_name_first; 
		STRING20      in_name_middle;   
		STRING20      in_name_last;    
		STRING5       in_name_suffix;  
		STRING10      in_prim_range;                           
		STRING2       in_predir;                      
		STRING28      in_prim_name;                        
		STRING4       in_addr_suffix;
		STRING2       in_postdir;                
		STRING10      in_unit_desig;             
		STRING8       in_sec_range;                           
		STRING25      in_p_city_name;
		STRING2       in_st;         
		STRING5       in_z5;   
		STRING4       in_zip4;
		STRING18      in_county_name;
		STRING10      in_phone;
		STRING10      in_NCOA_prim_range;
		STRING2       in_NCOA_predir;   
		STRING28      in_NCOA_prim_name;
		STRING4       in_NCOA_addr_suffix;
		STRING2       in_NCOA_postdir; 
		STRING10      in_NCOA_unit_desig;              
		STRING8       in_NCOA_sec_range;
		STRING25      in_NCOA_city;                           
		STRING2       in_NCOA_state;                         
		STRING5       in_NCOA_zip;                     
		STRING6       in_MatchMoveEffDate;
		STRING6				AddrSearchDate;
		Batch_out - acctno;
	END;
	
	EXPORT Batch_Records := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDid;
		BatchShare.Layouts.SharePII; 						// i.e. ssn (no dashes), dob
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.ShareAddress;
		STRING6  addr_dt_last_seen;
		STRING6  addr_dt_first_seen;
	END;
	
	EXPORT bestrec	:= RECORD
		AddrBest.Layout_BestAddr.batch_out_final;
  END;
	
	EXPORT bestrec_into_interface := RECORD
	  bestrec;
		string2   addr_ind := '';
    unsigned3 dt_first_seen;
    unsigned3 dt_last_seen;
  END;

END;