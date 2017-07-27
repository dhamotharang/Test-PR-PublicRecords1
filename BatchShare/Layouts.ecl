
// **************************************************************************************
//    Common layouts to be used by all batch services.
// **************************************************************************************

import BatchServices, doxie;

export Layouts := module
	
	// **************************************************************************************
	//   Common input layouts. These should be the building blocks to define each batch input.
	// **************************************************************************************
  export ShareErrors := record
		string6 	err_addr 	 	:= ''; // for address cleaner error messages ONLY 
		unsigned	err_search 	:= 0;  // standard search errors; can contain ONLY standard error codes (or combination of thereof)
		integer		error_code 	:= 0;  // for any general purpose of "this" service. Can contain any value.
  end;
	
	export ShareAcct := record
		string20	acctno;
	end;

	export ShareName := record
		BatchServices.Layouts.layout_batch_common_name;		
	end;
	
	export ShareAddress := record
		string100	addr := ''; // [internal] 
		BatchServices.Layouts.layout_batch_common_address;
	end;

	export SharePII := record
		string9	ssn;
		string8 dob;
	end;
	
	export ShareDid := record
		unsigned6 did;		
	end;	
	
	export ShareBdid := record
		unsigned6 bdid;
	end;
	
	export ShareCompany := record
		ShareBdid; 
		STRING9   FEIN;
		STRING120 comp_name;	
	end;
		
	// **************************************************************************************
	//    Penalty layouts.
	// **************************************************************************************		
	export SharePenaltyAcct := record
		ShareAcct.acctno;
	end;
	
	export SharePenaltyName := record
		BatchServices.Layouts.layout_batch_common_name2;
	end;
	
	export SharePenaltyAddress := record
		BatchServices.Layouts.layout_batch_common_address2;		
	end;
	
	export ShareCommonPenalty	:= record
		SharePenaltyAcct;
		SharePenaltyName;
		SharePenaltyAddress;
	end;
	
	// **************************************************************************************
	//    Additional info.
	// **************************************************************************************		
	export ShareBest := record	
		ShareAcct.acctno;
		doxie.layout_best.did;
		string70 best_name;
		string75 best_addr;typeof(doxie.layout_best.city_name) best_city;
		typeof(doxie.layout_best.st) best_state;
		typeof(doxie.layout_best.zip) best_zip;		
		typeof(doxie.layout_best.ssn) best_ssn;		
		typeof(doxie.layout_best.dob) best_dob;				
	end;


	// **************************************************************************************
	//    Convenience layouts.
	// **************************************************************************************		

	// To be used when searching ids/fids in autokeys, header or any other search key.
	export ShareLookupId := record
		ShareAcct.acctno;
		unsigned1 search_status 	:= 0;		// from autokey get_fids (AutokeyB2_batch.Layouts.rec_output_IDs_batch)
		string10 	matchCode     	:= '';  // from autokey get_fids (AutokeyB2_batch.Layouts.rec_output_IDs_batch)
	end;
	
	export ShareAddressNCOA := record
		STRING100  	NCOA_addr1			 	:= '';// [internal] 
		STRING100  	NCOA_addr2				:= '';// [internal] 
		STRING10  	NCOA_prim_range 	:= '';
		STRING2   	NCOA_predir 			:= '';
		STRING28  	NCOA_prim_name 		:= '';
		STRING4   	NCOA_addr_suffix 	:= '';
		STRING2   	NCOA_postdir 			:= '';
		STRING10  	NCOA_unit_desig 	:= '';
		STRING8   	NCOA_sec_range 		:= '';
		STRING25  	NCOA_city 				:= '';
		STRING2   	NCOA_state 				:= '';
		STRING5   	NCOA_zip 					:= '';
		STRING6		 	MatchMoveEffDate 	:= '';		//(YYYYMM)	
		STRING18 		NCOA_county_name  := '';
	end;

	export SharePhone := record
		STRING10 phoneno;
	end;

end;