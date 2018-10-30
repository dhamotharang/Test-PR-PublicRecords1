export constants := module

export ssn_indicators := module

	export is_partial := 1b;
	export is_itin    := 10b;
	export is_666     := 100b;
	export is_eae     := 1000b;
	export is_advertising := 10000b;
	export is_woolworth   := 100000b;
	export is_invalid_area := 1000000b;
	export is_invalid_group := 10000000b;
	export area_group_not_issued := 100000000b;
	export is_invalid_serial := 1000000000b;

end;

export no_longer_reported := module
													// 								   en			eq 			
													//                 xnadsp  xnadsp					
													// rrrrrrrrrrrrrrrr000000rr000000rr
	// *** Experian
	export did_not_in_en		:= 00000000000000001000000000000000b; // 32768
	export name_not_in_en		:= 00000000000000000100000000000000b; // 16384
	export addr_not_in_en		:= 00000000000000000010000000000000b; //  8192
	export dob_not_in_en		:= 00000000000000000001000000000000b; //  4096
	export ssn_not_in_en		:= 00000000000000000000100000000000b; //  2048
	export phone_not_in_en		:= 00000000000000000000010000000000b; //  1024
	export lname_not_in_en		:= 00000000000000000000001000000000b; //  1024
	// *** Equifax
	export did_not_in_eq		:= 00000000000000000000000010000000b; //   128
	export name_not_in_eq		:= 00000000000000000000000001000000b;
	export addr_not_in_eq		:= 00000000000000000000000000100000b; //    32
	export dob_not_in_eq		:= 00000000000000000000000000010000b;
	export ssn_not_in_eq		:= 00000000000000000000000000001000b; //     8
	export phone_not_in_eq		:= 00000000000000000000000000000100b;
	export lname_not_in_eq		:= 00000000000000000000000000000010b;
	// *** Transunion #74029
	export did_not_in_tn		:= 00000000100000000000000000000000b; //   
	export name_not_in_tn		:= 00000000010000000000000000000000b;
	export addr_not_in_tn		:= 00000000001000000000000000000000b; //   
	export dob_not_in_tn		:= 00000000000100000000000000000000b;
	export ssn_not_in_tn		:= 00000000000010000000000000000000b; //   
	export phone_not_in_tn		:= 00000000000001000000000000000000b;
	export lname_not_in_tn		:= 00000000000000100000000000000000b;
end;

export compound_names := module

	export delims 					:= ' \'-/&;,=[]()';     
	// need to escape '[]() so it can be used with regexfind
	export esc_delims 			:= ' \\\'-/&;,=\\[\\]\\(\\)';
	export digits						:= '0123456789';
	export invalid_names 		:= ['OF', 'INC', 'ASS', 'AVE', 'OLD', 'OUR', 'EST', 'SPA', 'AUTO', 'EXPO', 'PROPERTIES', 'SON', 'SONS', 'INT']; //'CONSTRUCTION, etc.
	export exclusion_names 	:= ['AKA', 'DEL', 'VAN', 'ABU', 'BEN', 'ALI', 'WON', 'VON', 'DER', 'DES', 'DON', 'LOS', 'DOS'];
	export nbr_parts 				:= 4;	

end;
export checkRNA := true; // there are additional glb and dppa restrictions for Relatives, Neighbors, and Associates

 // QH (quick header) AKA: FH (Fast Header) is merged with full header at query time.  Max rid in header today is less than 200,000,000,000.
 // therefore, starting QH rids at 999,999,999,999 to avoid rid collissions
 export QH_start_rid := 999999999999;
 // rids for external sources to the header (sources used in header keys only) start at 800,000,000,000 minus number of external source
 // records (5B max) and end at 800,000,000,000.  Sequencing is top bound because bottom (header max rid)
 // is not know at the time of source build.
 export external_sources_end_rid := 800000000000;

 export EN_start_rid := 900000000000;

  // LexID types
  EXPORT DidType := MODULE
    export string DEAD     := 'DEAD';
    export string NOISE    := 'NOISE';
    export string H_MERGE  := 'H_MERGE';
    export string C_MERGE  := 'C_MERGE';
    export string INACTIVE := 'INACTIVE';
    export string AMBIG    := 'AMBIG';
    export string NO_SSN   := 'NO_SSN';
    export string CORE     := 'CORE';
  END;

 EXPORT current_resident := 'CURR_RES';

end;
