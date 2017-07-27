
// Adapted from zz_TLeonard.ErrGen

EXPORT errorcodes := MODULE

	export _codes := module
		// See: doxie.ErrorCodes
		export unsigned2 NO_RECORDS					:= 10;
		export unsigned2 SEARCH_TOO_BROAD		:= 11;
		export unsigned2 TOO_MANY_SUBJECTS	:= 203;
		export unsigned2 INSUFFICIENT_INPUT	:= 301;
		export unsigned2 LEADING_REQUIRED		:= 302;
		export unsigned2 INVALID_INPUT  		:= 303;
		export unsigned2 LEXID_FAIL      		:= 307;
		export unsigned2 INCOMPLETE_ADDR		:= 310;
		export unsigned2 HIGH_POP_ADDR			:= 311;
		export unsigned2 NEED_DPPA					:= 2;
		export unsigned2 NEED_UID						:= 3;
		export unsigned2 NEED_ST_NUM				:= 23;
		export unsigned2 SOAP_ERR						:= 100;
		export unsigned2 CONFIG_ERR					:= 101;
	end;
	
	export _msgs(integer c, string suffix='') := function
		prefix := CASE(c,
			// was doxie.ErrorCodes
			_codes.NO_RECORDS						=> 'No records found',
			_codes.SEARCH_TOO_BROAD			=> 'Search is too broad',
			_codes.TOO_MANY_SUBJECTS		=> 'Too many subjects found',
			_codes.INSUFFICIENT_INPUT		=> 'Insufficient input',
			_codes.LEADING_REQUIRED  		=> 'At least three leading characters required',
			_codes.INVALID_INPUT    		=> 'Invalid input',
			_codes.LEXID_FAIL       		=> 'LexID was found but failed validation',
			_codes.INCOMPLETE_ADDR  		=> 'Incomplete Address',
			_codes.HIGH_POP_ADDR  			=> 'Highly populated address',
			_codes.NEED_DPPA						=> 'Need DPPA rights to see vehicle and dl data',
			_codes.NEED_UID							=> 'Reports must supply DID, BDID, Unique Identifier, or ST + Vehicle Number',
			_codes.NEED_ST_NUM   				=> 'License State and Number are both required for the search',
			_codes.SOAP_ERR							=> 'Soap connection error',
			_codes.CONFIG_ERR						=> 'Invalid Configuration',
			''
		);
		return if(suffix='', prefix, trim(prefix) + ' - ' + suffix);
	end;
	
END;