
IMPORT Autokey, Autokey_batch, Doxie, ut;

EXPORT Transforms := MODULE

	// Used by Autokey_batch.Get_DIDs_Batch()
	//    20100713 -- Added middle name to transform
	EXPORT Autokey_batch.Layouts.rec_DID_InBatch xfm_convert_for_getting_DIDs(Autokey_batch.Layouts.rec_Cleaned_Input_Record l) := 
		TRANSFORM
			SELF.acctno            := l.AccountNumber;
			SELF.lname_value       := l.LName;
			SELF.fname_value       := l.FName;			
			SELF.mname_value       := l.MName;
			SELF.city_value        := l.City;			
			SELF.city_codes_set    := doxie.Make_CityCodes(l.City).rox + ut.ZipToCities(l.Zip).set_codes;			
			SELF.state_value       := l.State;
			SELF.zip_val           := l.Zip;
			SELF.phone_value       := l.Phone;
			SELF.find_day          :=  doxie.DOBTools(l.DOB).find_day;
			SELF.find_month        :=  doxie.DOBTools(l.DOB).find_month;
			SELF.find_year_high    :=  doxie.DOBTools(l.DOB).find_year_high(0);
			SELF.find_year_low     :=  doxie.DOBTools(l.DOB).find_year_low(0);		
			SELF.ssn_value         := l.SSN;
			SELF                   := l;
		END;		
	
	// Per Batch Ops, formerly we assumed that the Company Name and FEIN values may be found in the Last Name and SSN 
	// fields, respectively. However, this is no longer the case, so the conditional statements are commented out.
	// TODO: remove the commented out code altogether once this stricter transform definition is put in production
	// and there are no requests to change it back.
	//
	// Used by AutokeyB2_batch.Get_IDs_Batch().
	EXPORT Autokey_batch.Layouts.rec_Cleaned_Input_Record xfm_to_Cleaned_Input_Record(Autokey_batch.Layouts.rec_inBatchMaster l) :=
		TRANSFORM
			SELF.LNID              := (STRING8)l.seq;
			SELF.AccountNumber     := l.acctno;
			SELF.FName             := StringLib.StringToUpperCase(l.name_first);
			SELF.LName             := StringLib.StringToUpperCase(l.name_last);
			SELF.MName             := StringLib.StringToUpperCase(l.name_middle);
			SELF.CName             := StringLib.StringToUpperCase(l.comp_name); // IF( TRIM(l.comp_name) = '' AND TRIM(l.name_first) = '', StringLib.StringToUpperCase(l.name_last), StringLib.StringToUpperCase(l.comp_name) ); 	
			SELF.Phone             := IF( LENGTH(TRIM(l.homephone)) > 0, l.homephone, l.workphone );
			SELF.Address           := '';
			SELF.City              := StringLib.StringToUpperCase(l.p_city_name);
			SELF.State             := StringLib.StringToUpperCase(l.st);
			SELF.Zip               := StringLib.StringToUpperCase(l.z5);
			SELF.SSN               := StringLib.StringFilter(l.ssn, '0123456789');
			SELF.FEIN              := StringLib.StringToUpperCase(l.FEIN); // IF( TRIM(l.comp_name) = '' AND TRIM(l.name_first) = '' AND TRIM(l.FEIN) = '', StringLib.StringToUpperCase(l.SSN), StringLib.StringToUpperCase(l.FEIN) );					
			SELF.DOB               := (UNSIGNED8)l.dob;							
			SELF.prange_value      := StringLib.StringToUpperCase(l.prim_range);
			SELF.predir_value      := StringLib.StringToUpperCase(l.predir);
			SELF.pname_value       := ut.StripOrdinal( StringLib.StringToUpperCase(l.prim_name) );
			SELF.addr_suffix_value := StringLib.StringToUpperCase(l.addr_suffix);
			SELF.postdir_value     := StringLib.StringToUpperCase(l.postdir);
			SELF.sec_range_value   := StringLib.StringToUpperCase(l.sec_range);
			SELF.addr_error_value  := TRIM(l.prim_name) = '' OR (TRIM(l.z5) = '' AND ( TRIM(l.p_city_name) = '' OR TRIM(l.st) = '' ));		
			SELF                   := l;
		END;


	// ===========================================================================================================

		
	// ------------------ Address Transforms. For test harness and/or canned records. Not prod. ------------------

	EXPORT Autokey_batch.Layouts.rec_input_prepped_for_cleaning xfm_preclean_batch(Autokey_batch.Layouts.rec_Batch_Input_Record l) := 
		TRANSFORM
			SELF := l;
			SELF.clean_address := doxie.cleanaddress182( l.Address, TRIM(l.City) + ' ' + TRIM(l.State) + ' ' + TRIM(l.Zip) );
		END;
						
	EXPORT Autokey_batch.Layouts.rec_Cleaned_Input_Record xfm_clean_batch(Autokey_batch.Layouts.rec_input_prepped_for_cleaning l) := 
		TRANSFORM
				// ( Note: The fields that follow are what are returned from the batch server.)
			SELF.prange_value      := l.clean_address[1..10];
			SELF.predir_value      := l.clean_address[11..12];
			SELF.pname_value       := l.clean_address[13..40];
			SELF.addr_suffix_value := l.clean_address[41..44];
			SELF.postdir_value     := l.clean_address[45..46];
			SELF.sec_range_value   := l.clean_address[57..64];
			SELF.City              := l.clean_address[90..114];
			SELF.State             := l.clean_address[115..116];
			SELF.Zip               := l.clean_address[117..121];
			SELF.addr_error_value  := l.clean_address[179..180]='E3' OR l.clean_address[179..182] IN ['E500','E502'];
			SELF                   := l;
		END;
			
	EXPORT Autokey_batch.Layouts.rec_input_prepped_for_clean xfm_prep_for_clean(Autokey_batch.Layouts.rec_Person l) := 
		TRANSFORM
			SELF := l;
			SELF.clean_address := doxie.cleanaddress182( l.addr, TRIM(l.city) + ' ' + TRIM(l.state) + ' ' + TRIM(l.zip) );
		END;
		
	EXPORT Autokey_batch.Layouts.rec_DID_InBatch xfm_clean_batch_input(Autokey_batch.Layouts.rec_input_prepped_for_clean l) := 
		TRANSFORM
		
			SELF.lname_value       := l.last_name;
			SELF.fname_value       := l.first_name;			
			
				// ( Note: The address fields that follow are what are returned from the batch server.)
			SELF.prange_value      := l.clean_address[1..10];
			SELF.predir_value      := l.clean_address[11..12];
			SELF.pname_value       := l.clean_address[13..40];
			SELF.addr_suffix_value := l.clean_address[41..44];
			SELF.postdir_value     := l.clean_address[45..46];
			SELF.sec_range_value   := l.clean_address[57..64];
			SELF.city_value        := l.clean_address[90..114];
			
			SELF.city_codes_set    := doxie.Make_CityCodes(l.clean_address[90..114]).rox + ut.ZipToCities(l.clean_address[117..121]).set_codes;
			
			SELF.state_value       := l.clean_address[115..116];
			SELF.zip_val           := l.clean_address[117..121];
			SELF.addr_error_value  := l.clean_address[179..180]='E3' OR l.clean_address[179..182] IN ['E500','E502'];
			
			SELF.phone_value       := l.phone10;
			
			SELF.find_day          :=  doxie.DOBTools(l.dob).find_day;
			SELF.find_month        :=  doxie.DOBTools(l.dob).find_month;
			SELF.find_year_high    :=  doxie.DOBTools(l.dob).find_year_high(0);
			SELF.find_year_low     :=  doxie.DOBTools(l.dob).find_year_low(0);		
			
			SELF.ssn_value         := l.ssn;
			
			SELF                   := l;
		END;		
		
	EXPORT Autokey_batch.Layouts.rec_inBatchMaster xfm_to_inBatchMaster(Autokey_batch.Layouts.rec_Cleaned_Input_Record l) :=	
		TRANSFORM
			SELF.seq         := (UNSIGNED8)l.LNID;
			SELF.acctno      := l.AccountNumber;
			SELF.name_first  := l.FName;
			SELF.name_last   := l.LName;
			SELF.name_middle := l.MNAme;
			SELF.homephone   := l.Phone;
			SELF.p_city_name := l.City;
			SELF.st          := l.State;
			SELF.z5          := l.Zip;
			SELF.ssn         := IF( LENGTH(l.SSN) > 0, l.SSN, l.FEIN );
			SELF.dob         := (STRING8)l.DOB;							
			SELF.prim_range  := l.prange_value;
			SELF.predir      := l.predir_value;
			SELF.prim_name   := l.pname_value;
			SELF.addr_suffix := l.addr_suffix_value;
			SELF.postdir     := l.postdir_value;
			SELF.sec_range   := l.sec_range_value;
			SELF.FEIN        := l.FEIN;
			SELF.comp_name   := l.CName;
		END;		

	// ------------------ End Address Transforms for test harness and/or canned records. ------------------
			
	// ------------------------------------ Likely unused transforms. ------------------------------------
	
	// ***** Error-checking transforms. ***** 
	
	EXPORT Autokey_batch.Layouts.rec_Batch_Input_Record xfm_fill_in_empty_cname_and_fein(Autokey_batch.Layouts.rec_Batch_Input_Record l) :=
		TRANSFORM
			SELF.CName := IF( l.CName = '', l.LName, l.CName );
			SELF.FEIN  := IF( l.FEIN = '',  l.SSN,   l.FEIN );
			SELF := l;
		END;
		
	// ***** Suppression Transforms. *****
	
	EXPORT Autokey_batch.Layouts.rec_DID_InBatch xfm_Remove_CityStateZip(Autokey_batch.Layouts.rec_DID_InBatch l) := 
		TRANSFORM
			SELF.city_value  := '';
			SELF.state_value := '';
			SELF.zip_val     := '';
			SELF.zip_value   := [];
			SELF             := l;
		END;	
		
	EXPORT Autokey_batch.Layouts.rec_DID_InBatch xfm_Remove_CityZip(Autokey_batch.Layouts.rec_DID_InBatch l) := 
		TRANSFORM
			SELF.city_value  := '';
			SELF.zip_val     := '';
			SELF.zip_value   := [];				
			SELF             := l;
		END;				
		
	EXPORT Autokey_batch.Layouts.rec_DID_InBatch xfm_Remove_PrimName(Autokey_batch.Layouts.rec_DID_InBatch l) := 
		TRANSFORM
			SELF.pname_value := '';
			SELF             := l;
		END;		

	EXPORT Autokey_batch.Layouts.rec_DID_InBatch xfm_add_zip_set(Autokey_batch.Layouts.rec_DID_InBatch l) :=
		TRANSFORM
			SELF.zip_value := ut.fn_GetZipSet(l.city_value, l.state_value, l.zip_val,	'', ziplib.CityToZip5(l.state_value, l.city_value), l.zipradius_value);
			SELF           := l;
		END;
		
	// For non-batch:
	EXPORT Autokey.layout_fetch xfm_for_single_trans_output(Autokey_batch.Layouts.rec_DID_OutBatch l) :=
		TRANSFORM
			SELF.did        := l.did;
			SELF.error_code := l.search_status;
		END;

	// ------------------------------------ End likely unused transforms. ------------------------------------
								
END;
