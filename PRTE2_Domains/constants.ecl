EXPORT constants := module
	Export Base_Domains := '~prte::base::whois';
	Export IN_Domains := '~prte::in::whois';
  export KeyName_InternetServices := '~prte::key::internetservices::';
  export KeyName_WhoIs            := '~prte::key::whois::';

	export str_autokeyname								:= KeyName_InternetServices + 'autokey::';
	export ak_keyname											:= KeyName_InternetServices + '@version@::autokey::'; //used to build autokeys
	export ak_logicalname(string filedate):= KeyName_InternetServices + filedate + '::autokey::';
	export ak_QAname                      := KeyName_InternetServices + 'qa::autokey::';
	export ak_skipSet											:= ['P','Q','F','S'];
	export ak_typeStr											:= 'BC';

end;