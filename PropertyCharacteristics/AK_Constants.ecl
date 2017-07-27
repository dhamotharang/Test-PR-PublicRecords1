import	ut;

export	AK_Constants	:=
module

	export	cluster											:=	PropertyCharacteristics.Constants.CLUSTER;
	export	ak_keyname									:=	cluster	+	'key::propertyinfo::@version@::autokey::';
	export	ak_qa_keyname								:=	cluster	+	'key::propertyinfo::qa::autokey::';
	export	ak_logical(string	filedate)	:=	cluster	+	'key::propertyinfo::'	+	filedate	+	'::autokey::';
	
	export	ak_dataset									:=	PropertyCharacteristics.File_Property_AutoKey;
	export	ak_typeStr									:=	'\'AK\'';
	export	ak_skipSet									:=	['P','Q','S','F','B','Z'];
					// P in this set to skip personal phones
					// Q in this set to skip business phones
					// S in this set to skip SSN
					// F in this set to skip FEIN
					// C in this set to skip ALL personal (Contact) data
					// B in this set to skip ALL Business data
					// Z in this set to skip zip
end;