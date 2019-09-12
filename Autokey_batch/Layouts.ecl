
IMPORT Doxie;

EXPORT Layouts := MODULE
	
	EXPORT rec_inBatchMaster := 
		RECORD
			doxie.layout_inBatchMaster;
			STRING8   date          := '';  // For VehicleV2 VIN/LicPlate
			STRING9   FEIN          := '';
			STRING120 comp_name     := '';
			STRING72  sic_code      := '';			
			STRING25  filing_number := '';  // For UCC Liens.
			STRING45  apn           := '';
			STRING5   fips_code     := '';
			UNSIGNED6 bdid			:= 0; 	// For Bankruptcy
			UNSIGNED3 score_bdid	:= 0;	// For Bankruptcy
		END;
		
	EXPORT rec_Person := 
		RECORD
			// F L A P S D
			STRING30  acctno       := '';
			STRING30  last_name    := '';
			STRING30  first_name   := '';
			STRING10  phone10      := '';				
			STRING200 addr         := '';
			STRING25  city         := '';
			STRING2   state        := '';
			STRING5   zip          := '';
			STRING30  county       := '';
			STRING12  ssn          := '';
			UNSIGNED8 dob          :=  0;
		END;
		
	EXPORT rec_Batch_Input_Record := 
		RECORD
			// F L A P S D plus Company Name and FEIN
			STRING8   LNID          := '';
			STRING30  AccountNumber := '';
			STRING50  FName         := '';
			STRING50  MName         := '';
			STRING50  LName         := '';
			STRING120 CName         := '';
			STRING16  Phone         := '';
			STRING200 Address       := '';
			STRING25  City          := '';
			STRING2   State         := '';
			STRING5   Zip           := '';
			STRING12  SSN           := '';
			STRING9   FEIN          := '';
			UNSIGNED8 DOB           :=  0;	
			STRING14  filing_number := '';  // For UCC Liens.
		END;			

	EXPORT rec_Cleaned_Input_Record :=
		RECORD
			rec_Batch_Input_Record;
			STRING10  prange_value          := '';
			STRING2   predir_value          := '';
			STRING28  pname_value           := '';
			STRING4   addr_suffix_value     := '';
			STRING2   postdir_value         := '';
			STRING8   sec_range_value       := '';
			BOOLEAN   addr_error_value      := FALSE;
		END;
		
	EXPORT rec_input_prepped_for_cleaning := 
		RECORD
			rec_Batch_Input_Record;
			STRING200 clean_address := '';
		END;		
				
	EXPORT rec_DID_InBatch := 
		RECORD
			
			STRING30  acctno                := '';
			
			// --- SYSTEM BOOLEANS ---

			BOOLEAN   addr_error_value      := FALSE;
			BOOLEAN   addr_loose            := FALSE;  
			BOOLEAN   nicknames             := FALSE;  
			BOOLEAN   phonetics             := FALSE;  
			BOOLEAN   fuzzy_ssn             := FALSE;
               
			// --- SYSTEM VALUES ---

			STRING14  did_value             := ''; 
			UNSIGNED4 lookup_value          := 0; 
			UNSIGNED4 lookup_value2         := 0;

			// --- NAME INFORMATION ---

			STRING30  fname_value           := '';
			STRING30  lname_value           := '';
			STRING30  mname_value           := '';
			STRING30  other_lname_value1    := '';
			set of string   lname_set_value        := [];
			
			STRING120 comp_name_value       := '';  // For Fetch_StCityFLName, Fetch_Zip_Batch

			// --- RELATIVES (?) INFORMATION ---

			STRING30 rel_fname_value1       := '';
			STRING30 rel_fname_value2       := '';

			// --- ADDRESS INFORMATION ---

			STRING10  prange_value          := '';
			STRING2   predir_value          := '';
			STRING28  pname_value           := '';
			STRING4   addr_suffix_value     := '';
			STRING2   postdir_value         := '';
			STRING8   sec_range_value       := '';
			         
			STRING25  city_value            := '';
			STRING25  other_city_value      := '';
			SET OF UNSIGNED4 city_codes_set := []; // Set MAXLENGTH ?
			
			STRING2   state_value           := '';
			STRING2   prev_state_val1       := '';
			STRING2   prev_state_val2       := '';
			
			STRING5   zip_val               := '';
			SET OF INTEGER zip_value        := []; // Set MAXLENGTH ?		
			string5         city_zip_value         := '';
			UNSIGNED2 zipradius_value       :=  0;

			// --- PHONE INFORMATION ---

			STRING10  phone_value           := '';

			// --- DOB INFORMATION ---

			INTEGER find_day                :=  0;
			INTEGER find_month              :=  0; 
			INTEGER find_year_high          :=  0;
			INTEGER find_year_low           :=  0;

			// --- SSN INFORMATION ---

			STRING12 ssn_value               := '';

		END;
		
		EXPORT rec_DID_OutBatch := 
			RECORD
				STRING30  acctno                := '';
				UNSIGNED1 search_status         :=  0;
				STRING10  matchCode		          := '';
				doxie.layout_references;								// unsigned6 did
			END;
		
				
	// For test harness only.	//////////////
	EXPORT rec_input_prepped_for_clean := 
		RECORD
			rec_Person;
			STRING200 clean_address := '';
		END;		
	////////////////////////////////////////
	
	
	END;	// MODULE
	
