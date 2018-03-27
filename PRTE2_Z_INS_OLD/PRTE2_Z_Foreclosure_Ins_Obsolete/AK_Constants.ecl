// just kept this old code to reference the various possible values in fc_skipSet

import	_control,ut, PRTE2,PRTE_CSV;
// Moved from PRTE2 down to PRTE2_Foreclosure

export	AK_Constants	:=       module
  export pIndexVersion  := '';
	export  cluster  := '~prte:';
	
	export	fc_keyname									:=	cluster	+	'key::foreclosure::@version@::autokey::';
	export	fc_qa_keyname								:=	cluster	+	'key::foreclosure::qa::autokey::';
	export	fc_logical(string	filedate)	:=	cluster	+	'key::foreclosure::'	+	filedate	+	'::autokey::';
	export	fc_skipSet									:=	['P','Q','B'];
					// P in this set to skip personal phones
					// Q in this set to skip business phones
					// S in this set to skip SSN
					// F in this set to skip FEIN
					// C in this set to skip ALL personal (Contact) data
					// B in this set to skip ALL Business data
					// Z in this set to skip zip
	
	
end;