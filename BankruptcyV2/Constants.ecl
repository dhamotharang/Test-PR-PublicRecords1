IMPORT	_control;
export Constants(string filedate, boolean isFCRA = false) := module
	//	Server IP to Spray from
	EXPORT	serverIP	:=	IF(	_control.thisenvironment.name='Dataland',
														_Control.IPAddress.bctlpedata12,
														_Control.IPAddress.bctlpedata10);
	
	//	Directory to Spray from
	EXPORT	Directory	:=	IF(	_control.thisenvironment.name='Dataland',
														'/data/hds_180/bkv3/daily/'+filedate+'/',
														'/data/hds_180/bkv3/daily/'+filedate+'/');
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
