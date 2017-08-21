EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;



EXPORT DO := FUNCTION

MakeSuperKeys ('~prte::key::death_master::@version@::address_table_v4');
MakeSuperKeys ('~prte::key::death_master::@version@::addr_name');
MakeSuperKeys ('~prte::key::death_master::@version@::adl_risk_table_v4');
MakeSuperKeys ('~prte::key::death_master::@version@::phone_addr');
MakeSuperKeys ('~prte::key::death_master::@version@::phone_lname');
MakeSuperKeys ('~prte::key::death_master::@version@::ssn_addr');
MakeSuperKeys ('~prte::key::death_master::@version@::ssn_name');
MakeSuperKeys ('~prte::key::death_master::@version@::ssn_table_v4_2');
MakeSuperKeys ('~prte::key::death_master::@version@::suspicious_identities');
MakeSuperKeys ('~prte::key::death_master::fcra::@version@::adl_risk_table_v4_filtered');
MakeSuperKeys ('~prte::key::death_master::fcra::@version@::ssn_table_v4_filtered');

//New Keys for Shell 5.3
MakeSuperKeys ('~prte::key::death_master::@version@::ssn_name_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::ssn_addr_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::ssn_dob_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::ssn_phone_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::phone_dob_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::addr_name_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::addr_dob_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::name_dob_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::phone_addr_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::phone_addr_header_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::phone_lname_summary');
MakeSuperKeys ('~prte::key::death_master::@version@::phone_lname_header_summary');

RETURN 'SUCCESS';

End;

End;