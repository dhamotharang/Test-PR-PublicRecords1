import	_control,ut, PRTE2,PRTE_CSV;
export	AK_Constants	:=       module

  export pIndexVersion  := '';

	export  cluster  := '~prte:';

	
	export	MAX_COUNT_PROP_CHAR	:=	85;
	
	export	ak_keyname									:=	cluster	+	'key::custtest::propertybluebook::@version@::autokey::';
	export	ak_qa_keyname								:=	cluster	+	'key::custtest::propertybluebook::qa::autokey::';
	export	ak_logical(string	filedate)	:=	cluster	+	'key::custtest::propertybluebook::'	+	filedate	+	'::autokey::';

	export	ak_typeStr									:=	'\'AK\'';
	export	ak_skipSet									:=	['P','Q','B'];

					// P in this set to skip personal phones
					// Q in this set to skip business phones
					// S in this set to skip SSN
					// F in this set to skip FEIN
					// C in this set to skip ALL personal (Contact) data
					// B in this set to skip ALL Business data
					// Z in this set to skip zip
	
	export	fc_keyname									:=	cluster	+	'key::foreclosure::@version@::autokey::';
	export	fc_qa_keyname								:=	cluster	+	'key::foreclosure::qa::autokey::';
	export	fc_logical(string	filedate)	:=	cluster	+	'key::foreclosure::'	+	filedate	+	'::autokey::';
	export	fc_skipSet									:=	['P','Q','B'];
	
	export	ln_keyname									:=	cluster	+	'key::custtest::ln_propertyv2::@version@::autokey::';
	export	ln_qa_keyname								:=	cluster	+	'key::custtest::ln_propertyv2::qa::autokey::';
	export	ln_logical(string	filedate)	:=	cluster	+	'key::custtest::ln_propertyv2::'	+	filedate	+	'::autokey::';
	export	ln_skipSet									:=	['P','Q','B'];
	
	
end;