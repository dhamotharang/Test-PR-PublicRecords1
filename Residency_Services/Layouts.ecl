IMPORT BatchServices, Batchshare;

export Layouts := module

	EXPORT Batch_in := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareName;
		BatchShare.Layouts.SharePII;   // ssn & dob
		BatchShare.Layouts.ShareAddress;
		STRING25 residency_county := '';
		STRING2	 residency_state	:= '';
		STRING10 phone 						:= '';
  END;

	EXPORT Batch_To_Model_Rec := RECORD
		UNSIGNED3  seq;                                    // deduped top4 record sequence
		BatchServices.Layouts.layout_batch_common_address; // deduped individual address
		UNSIGNED1	DL_in_cnt        						:= 0;
		UNSIGNED1	DL_out_cnt       						:= 0;
		STRING1	  DL_in_expired_flag          := '';
		STRING1	  DL_out_expired_flag         := '';
		STRING8	  DL_in_dt 									  := '';				//'YYMMDD'
		STRING8	  DL_out_dt 									:= '';
		UNSIGNED1	ProfLic_in_cnt    					:= 0;
		UNSIGNED1	ProfLic_out_cnt   					:= 0;
		UNSIGNED1	HuntFish_in_cnt   					:= 0;
		UNSIGNED1	HuntFish_out_cnt  					:= 0;
		UNSIGNED1	Utility_in_cnt    					:= 0;
		UNSIGNED1	Utility_out_cnt   					:= 0;
		UNSIGNED1	Property_in_cnt   					:= 0;
		UNSIGNED1	Property_out_cnt  					:= 0;
		UNSIGNED1	Watercraft_in_cnt 					:= 0;
		UNSIGNED1	Watercraft_out_cnt					:= 0;
		STRING1		Watercraft_in_expired_flag  := '';
		STRING1		Watercraft_out_expired_flag := '';
		STRING8		Watercraft_in_dt 						:= '';				//'YYMMDD'
		STRING8		Watercraft_out_dt 					:= '';
		UNSIGNED1	Aircraft_in_cnt      				:= 0;
		UNSIGNED1	Aircraft_out_cnt     				:= 0;
		UNSIGNED1	Bankruptcy_in_cnt    				:= 0;
		UNSIGNED1	Bankruptcy_out_cnt   				:= 0;
		UNSIGNED1	LienJudg_in_cnt      				:= 0;
		UNSIGNED1	LienJudg_out_cnt     				:= 0;
		UNSIGNED1	Foreclosure_in_cnt   				:= 0;
		UNSIGNED1	Foreclosure_out_cnt  				:= 0;
		UNSIGNED1	PAW_in_cnt           				:= 0;
		UNSIGNED1	PAW_out_cnt          				:= 0;
		UNSIGNED1	Voter_in_cnt         				:= 0;
		UNSIGNED1	Voter_out_cnt        				:= 0;
		STRING1	  Voter_in_expired_flag  			:= '';
		STRING1	  Voter_out_expired_flag			:= '';
		STRING8	  Voter_in_last 							:= '';
		STRING8	  Voter_out_last			 				:= '';
		UNSIGNED1	Phone_in_cnt        				:= 0;
		UNSIGNED1	Phone_out_cnt       				:= 0;
		UNSIGNED1	Business_in_cnt     				:= 0;
		UNSIGNED1	Business_out_cnt   					:= 0;
		UNSIGNED1	Veh_in_cnt          				:= 0;
		UNSIGNED1	Veh_out_cnt         				:= 0;
		UNSIGNED1	Homestead_in_cnt    				:= 0;
		UNSIGNED1	Homestead_out_cnt   				:= 0;
		STRING1	  Property_homestead  					  := '';
		STRING1	  IsInputAddress      					  := '';
		STRING1	  IsBestAddress       					  := '';
		String2   AddressReportingSourceIndex		  := '';   // from VOO
		String2   AddressReportingHistoryIndex	  := '';   // from VOO
		String2   AddressSearchHistoryIndex			  := '';   // from VOO
		String2   AddressUtilityHistoryIndex		  := '';   // from VOO
		String2   AddressOwnershipHistoryIndex	  := '';   // from VOO
		String2   AddressOwnerMailingAddressIndex	:= '';   // from VOO
		String2   InferredOwnershipTypeIndex		  := '';   // from VOO
		String5   OtherOwnedPropertyProximity		  := '';   // from VOO
		// v--- from/for use in Residency_Services.fn_getIID
		UNSIGNED3 numhris      := 0;
		STRING5 hrisk_1        := '';
	  STRING150 hrisk_desc_1 := '';
		STRING5 hrisk_2        := '';
	  STRING150 hrisk_desc_2 := '';
		STRING5 hrisk_3        := '';
	  STRING150 hrisk_desc_3 := '';
		STRING5 hrisk_4        := '';
	  STRING150 hrisk_desc_4 := '';
		STRING5 hrisk_5        := '';
	  STRING150 hrisk_desc_5 := '';
	END;	

	EXPORT Model_In_Layout := RECORD
		Batch_in	-	BatchShare.Layouts.ShareAddress; // address removed from here since address field
                                      // names conflict with address fields on Batch_to_Model_Rec 

		// v--- "original" passed-in customer supplied address cleaned/parsed into 
		//      standard address field names to be used in the model.
		STRING10  batch_in_prim_range;
		STRING2   batch_in_predir;
		STRING28  batch_in_prim_name;
		STRING4   batch_in_addr_suffix;
		STRING2   batch_in_postdir;
		STRING10  batch_in_unit_desig;
		STRING8   batch_in_sec_range;
		STRING25  batch_in_p_city_name;
		STRING2   batch_in_st;
		STRING5   batch_in_z5;
		STRING4   batch_in_zip4;
		STRING18 	batch_in_county_name;

		BatchShare.Layouts.ShareDID; 
		STRING1		Entity_NotFound := 'N'; // not used by model, but needed by this batch service
		Batch_To_Model_Rec; //see above
 END;

	EXPORT IntermediateData := RECORD
		Batch_in	-	BatchShare.Layouts.ShareAddress; // ShareAddress fields removed from here since names
		                                             // conflict with address fields on Batch_to_Model_Rec 
		BatchShare.Layouts.ShareDID; 
		STRING1 Entity_NotFound  := 'N';
		STRING120	address1 := ''; // needed when matching to property data
		STRING120	address2 := ''; // needed when matching to property data
		Batch_To_Model_Rec;
 END;

	EXPORT IntermediateData_ext := RECORD
	  IntermediateData; 
    UNSIGNED4 dt_last_seen := 0;
 END;

	EXPORT Int_Service_output := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		STRING25 county_name  := '';
		STRING2  st          	:= '';
		STRING1	 expired_flag := '';				
		STRING8  dt_expired   := '';
		STRING8  dt_last_seen := '';
	END;

	EXPORT Int_Service_output_addr := RECORD
		Batch_To_Model_Rec.seq;
		BatchShare.Layouts.ShareDID;
		string18 expired_flag := ''; 
		BatchShare.Layouts.ShareAddress;
	END;

	EXPORT Prop_Service_output := RECORD
		BatchShare.Layouts.ShareAcct;
		BatchShare.Layouts.ShareDID;
		Batch_To_Model_Rec.seq;
		STRING1 Homestead := '' ;
		BatchShare.Layouts.ShareAddress;
	END;
	

	EXPORT Batch_out := RECORD
		Batch_in;	
		STRING1		Insuff_Invalid_Input    := 'N';  // Y or N
		STRING1		Input_Identity_NotFound := 'N';  // Y or N
		STRING1		Residency_County_Found  := 'N';  // Y or N  //Note: field name diff than reqs
		STRING1		Residency_State_Found   := 'N';  // Y or N  //Note: field name diff than reqs
		UNSIGNED3	Confidence_Score	:= 0;          // 0-100
 		STRING2		Confidence_State  := '' ;                   //Note: field name diff than reqs
		STRING25	Confidence_County := '' ;                   //Note: field name diff than reqs
		STRING1		Assets            := '' ;       // Y or N
		STRING1		Driver_Lic        := '' ;       // Y or N
		STRING1		Hunt_Fish_Lic     := '' ;       // Y or N
		STRING1		Utilities         := '' ;       // Y or N
		STRING12	Header_DID        := '' ;                   //Note: field name diff than reqs
		STRING1		Homestead         := '' ;       // Y or N
		STRING1		Public_Records    := '' ;       // Y or N
		STRING1		Voter             := '' ;       // Y or N
		
		// v---- For future use.  Output in query, but not picked up by Kettle process
		STRING10	Lat_Conf_Addr     := '' ;
		STRING11	Long_Conf_Addr    := '' ;
		STRING5		Geocode_Conf_Addr := '' ;
	END;

END;
