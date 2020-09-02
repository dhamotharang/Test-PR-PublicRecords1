IMPORT dx_Header;

export constants := module

export ssn_indicators := dx_header.Constants.ssn_indicators;

export no_longer_reported := dx_header.Constants.no_longer_reported;

export compound_names := module

	export delims 					:= ' \'-/&;,=[]()';
	// need to escape '[]() so it can be used with regexfind
	export esc_delims 			:= ' \\\'-/&;,=\\[\\]\\(\\)';
	export digits						:= '0123456789';
	export invalid_names 		:= ['OF', 'INC', 'ASS', 'AVE', 'OLD', 'OUR', 'EST', 'SPA', 'AUTO', 'EXPO', 'PROPERTIES', 'SON', 'SONS', 'INT']; //'CONSTRUCTION, etc.
	export exclusion_names 	:= ['AKA', 'DEL', 'VAN', 'ABU', 'BEN', 'ALI', 'WON', 'VON', 'DER', 'DES', 'DON', 'LOS', 'DOS'];
	export nbr_parts 				:= 4;

end;

export checkRNA := true; //TODO: used on a query side only

export QH_start_rid := dx_header.Constants.QH_start_rid;

// rids for external sources to the header (sources used in header keys only) start at 800,000,000,000 minus number of external source
// records (5B max) and end at 800,000,000,000.  Sequencing is top bound because bottom (header max rid)
// is not know at the time of source build.
export external_sources_end_rid := 800000000000; //not used
export EN_start_rid:=900000000000;

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

  // defines permissions required for accessing individual best record or fields
  //TODO: not used
  EXPORT PERM_TYPE := ENUM(unsigned1,
    d2c                      = 1b,      //infutor
    marketing                = 10b,     //marketing
    marketing_noneq          = 100b     //marketing_noneq
   );

END;
