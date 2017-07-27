

export Constants(string filedate, boolean isFCRA = false) := module
	// autokey
	export ak_keyname := if(isFCRA,
													BankruptcyV2.cluster + 'key::bankruptcy::autokey::fcra::',
													BankruptcyV2.cluster + 'key::bankruptcy::autokey::');
	export ak_logical := if(isFCRA,
													BankruptcyV2.cluster + 'key::bankruptcy::' + filedate + '::autokey::fcra::',
													BankruptcyV2.cluster + 'key::bankruptcy::' + filedate + '::autokey::');
	// text search
	export text_search := module
		export string stem		:= '~thor_data400::base';
		export string srcType	:= 'bankruptcyv2';
		export string qual		:= 'test';
		export string dateSegName	:= 'process-date';
		export unsigned2 alertSWDays	:= 31;
	end;
end;
