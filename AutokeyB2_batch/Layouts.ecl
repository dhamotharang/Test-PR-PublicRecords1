IMPORT Doxie, ut;

EXPORT Layouts := MODULE
	
	EXPORT rec_BDID_InBatch := 
		RECORD
			UNSIGNED6 bdid_value            := 0;      // For AutokeyB2/Fetch_Name_Batch, Fetch_NameWords_Batch
			STRING30  acctno                := '';
			STRING9   fein                  := '';
			STRING10  phone10               := '';
			STRING120 company_name          := '';
			STRING40  comp_name_indic_value := '';
			STRING40  comp_name_sec_value   := '';
			STRING10  prim_range            := '';
			STRING2   predir                := '';
			STRING28  prim_name             := '';
			STRING4   addr_suffix           := '';
			STRING2   postdir               := '';
			STRING10  unit_desig            := '';
			STRING8   sec_range             := '';
			STRING25  p_city_name           := '';
			STRING2   st                    := '';
			STRING5   z5                    := '';
			STRING4   zip4                  := '';
			UNSIGNED2 zipradius             :=  0;
			SET OF INTEGER zip_value        := [];	
			BOOLEAN   isCRS                 := FALSE;  // For AutokeyB2/Fetch_FEIN, AutokeyB2.Fetch_FEIN_Batch
			BOOLEAN   addr_error_value      := FALSE;  // For AutokeyB2/Fetch_StCityFLName, Fetch_StCityFLName_Batch, 
																								 //     Fetch_Zip, and Fetch_Zip_Batch	
			BOOLEAN   addr_loose            := FALSE;  // For AutokeyB2/Fetch_Address, AutokeyB2.Fetch_Address_Batch
			UNSIGNED4 lookup_value          := 0;      // 0 = no restrictions.
		END;
	
	EXPORT rec_output_BDIDs_batch := 
		RECORD
			STRING30  acctno                := '';
			UNSIGNED1 search_status         :=  0;
			STRING10  matchCode		          := '';
			doxie.Layout_ref_bdid;
		END;
		
	EXPORT rec_output_IDs_batch := 
		RECORD
			STRING30  acctno        := '';
			UNSIGNED1 search_status :=  0;
			STRING10  matchCode     := '';
			UNSIGNED6 ID            :=  0;
			BOOLEAN   isDID         := FALSE;
			BOOLEAN   isBDID        := FALSE;				
		END;
				
	// Layout BDID In-Batch inflated with parsed company name value filtered.	
	EXPORT rec_BDID_InBatch_wParsed_CN_Val_Filt := 
		RECORD
			rec_BDID_InBatch;
			INTEGER8 Sequence := 0;
			string120 company_name_val_filt  := '';
			string120 company_name_val_filt2 := '';
		END;
			
END;  // Layouts module