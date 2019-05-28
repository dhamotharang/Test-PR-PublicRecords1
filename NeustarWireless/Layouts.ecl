IMPORT NID, Address, AID;

EXPORT Layouts := MODULE
		//NOTE:  If layout changes, change NeustarWireless.Constants.SprayRecordSize
		EXPORT Raw_In := RECORD
			string	  phone; 				//Mobile Telephone number for the individual
			string	  fname; 				//First name of the individual 
			string  	mname; 				//One position alphabetic middle initial 
			string	  lname; 				//Last name of the individual 
			string	 	salutation; 	//vendor calls this prefix, but it clashes with a SALT reserved word, so had to change	
			string  	suffix;  
			string  	gender; 			//gender
			string	  dob; 					//Date of Birth of the Individual
			string	  house; 				//House number
			string  	pre_dir; 			//Street pre direction: N, S, E, W, NE, SW, etc.
			string	  street; 			//Street name or PO Box ###, or RR ### Box ###, or HC ### Box ###
			string	 	street_type; 	//e.g..  ST, AVE, PL, BLVD, PKWY, etc.
			string  	post_dir; 		//Street post direction: N, S, E, W, NE, etc.
			string  	apt_type; 		//Apt. v. Ste.
			string  	apt_nbr; 			//Apt. # or  Suite #
			string  	zip; 					//5 digit zip code
			string  	plus4; 				//Four-Position numeric Zip+4, Zip Code extension
			string  	dpc; 					//Delivery Point Code with Check Degit
			string  	z4_type; 			//Address Type for given Zip+4, Blank = Z4 type could not be determined, F = Firm, G = General Delivery, H = High-Rise, P = PO Box, R = Rural Route, S = Street
			string  	crte; 				//Carrier Route
			string	  city; 				//As listed in USPS Publication 26, Directory of Post Offices. Post Office name in excess of 28 positions have been abbreviated by USPS
			string  	state; 				//2 Character representation of State
			string	 	dpvcmra; 			//DPV Commercial Mail Receiving Code
			string  	dpvconf; 			//DPV Validation Code
			string  	fips_state; 	//The standardized two digit numberic FIPS State Indentification Code
			string  	fips_county; 	//The standardized 3 digit numberic FIPS County Indentification Code
			string  	census_tract;
			string  	census_block_group; 
			string  	cbsa; 				//Core Based Statistical Area Code
			string  	match_code; 	//General Address Return Code
			string	  latitude; 	
			string	  longitude; 	
			string		email; 				//E-mail address for listing, not currently populated
			string	  filler1; 
			string		filler2; 
			string	 	verified; 				//A = Name, Address, Phone, B = Phone, Name, C = Phones, Address, D = Name, Address, E = Not enough corroborating sources to determine match
			string  	activity_status; 	//Indication of the last time the phone was used to make a call, A1 - Active for 1 month or less, A2 - Active monthly for 2 months, A3 - Active monthly for 3 months, A4 - Active monthly for 4-6 months, A5 - Active monthly for 7-9 months, A6 - Active monthly for 10-11 months, A7 - Active for 12 months or longer, I1 - Inactive for 1 month or less, I2 - Inactive monthly for 2 months, I3 - Inactive monthly for 3 months, I4 - Inactive monthly for 4-6 months, I5 - Inactive monthly for 7-9 months, I6 - Inactive monthly for 10-11 months, I7 - Inactive monthly for 12 months or longer, U  - Status Unknown
			string  	prepaid; 					//Indicates a prepaid mobile device
			string  	cord_cutter; 			//Flag for high likelihood of a Mobile Phone only consumer
		END;
		
	EXPORT Base	:= MODULE
	
		EXPORT Main := RECORD
			//raw fields in optimized layout			
			string10 	phone; 		
			string150 fname; 		
			string1  	mname; 				
			string150 lname; 				
			string5  	salutation; 	
			string3  	suffix;  
			string1  	gender; 			
			string8 	dob; 					
			string10  house; 				
			string2  	pre_dir; 			
			string28  street; 			
			string4  	street_type; 	
			string2  	post_dir; 		
			string4  	apt_type; 		
			string8  	apt_nbr; 			
			string5		zip; 					
			string4		plus4; 				
			string1		dpc; 					
			string1  	z4_type; 			
			string4  	crte; 				
			string28  city; 				
			string2  	state; 				
			string1  	dpvcmra; 			
			string1  	dpvconf; 			
			string2		fips_state; 	
			string3		fips_county; 	
			string6 	census_tract;
			string1   census_block_group; 
			string5	 	cbsa; 				
			string3  	match_code; 	
			real8     latitude; 	
			real8     longitude; 	
			string100 email; 				
			string1  	verified; 				
			string2  	activity_status; 	
			string1  	prepaid; 					
			string1  	cord_cutter; 			
			
			string75 	raw_file_name;
			unsigned6 rcid; //Used for Ingest process
			string2 	source; //MDR.sourceTools.src_NeustarWireless 'N2'
  		unsigned8	persistent_record_id := 0;	
			
			string8 cln_dob;
			
			//DID fields
			unsigned8 did 						:= 0;
			unsigned8 did_score 			:= 0;
			unsigned2 xadl2_weight		:= 0;
			unsigned2 xadl2_score 		:= 0;
			unsigned4 xadl2_keys_used	:= 0; 
			unsigned2 xadl2_distance	:= 0; 
			string20  xadl2_matches		:= ''; 

			//AID Fields
			string	append_prep_address_1;
			string	append_prep_address_2;
			AID.Common.xAID	RawAID;
			AID.Common.xAID	AceAID;
			address.Layout_Clean182  clean_address; 	//clean address fields
			
			//clean name fields (relevant fields from NID.Layout_V2
			string append_prep_name;
			NID.Common.xNID	NID 	:= 0;
			unsigned2		name_ind 	:= 0;
			string1			NameType;
			string5			cln_title;
			string20		cln_fname;
			string20		cln_mname;
			string20		cln_lname;
			string5			cln_suffix;
			string150		cln_fullname;
			
			// Instance tracking fields
			unsigned4		process_date;
			unsigned4   process_time;
			unsigned4		date_vendor_first_reported;
			unsigned4		date_vendor_last_reported;
			boolean 		current_rec;
			unsigned1 	ingest_tpe; // __tpe field returned by the ingest process
			
		END;
		
		EXPORT Activity_Status := RECORD
			string10  	phone;
			string2  		activity_status;
			string75 		raw_file_name;
			unsigned6 	rcid; 	//Used for Ingest process
			string2 		source; //MDR.sourceTools.src_NeustarWireless 'N2'
  		unsigned8		persistent_record_id := 0;	
		
			// Instance tracking fields
			unsigned4		process_date;
			unsigned4   process_time;
			unsigned4		date_vendor_first_reported;
			unsigned4		date_vendor_last_reported;
			boolean 		current_rec;
			unsigned1 	ingest_tpe; // __tpe field returned by the ingest process
		END;		
		
	END;

	

END;