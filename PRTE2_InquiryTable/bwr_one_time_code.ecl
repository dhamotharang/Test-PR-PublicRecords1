EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;

SHARED MakeSuperFiles(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, '_delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, ''));
	RETURN 'SUCCESS';
END;

EXPORT DO := FUNCTION

  
	MakeSuperKeys('~prte::key::inquiry_table::linkids_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::fein_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::did_@version@');
  MakeSuperKeys('~prte::key::inquiry_table::address_@version@');
  MakeSuperKeys('~prte::key::inquiry_table::phone_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::email_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::ssn_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::transaction_id_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::ipaddr_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::name_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::billgroups_did_@version@');
	
	MakeSuperKeys('~prte::key::inquiry_table::fcra::address_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::fcra::did_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::fcra::ssn_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::fcra::phone_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::fcra::industry_use_vertical_login_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::fcra::billgroups_did_@version@');
	MakeSuperKeys('~prte::key::inquiry_table::fcra::industry_use_vertical_@version@');
	
					
  MakeSuperFiles ('~PRTE::BASE::inquiry@version@');
 
	FileServices.CreateSuperFile ('~prte::in::inquiry::persons_1');

  FileServices.CreateSuperFile ('~prte::in::inquiry::business_1');
	
	FileServices.CreateSuperFile ('~prte::in::inquiry::business_2');


RETURN 'SUCCESS';

End;

End;