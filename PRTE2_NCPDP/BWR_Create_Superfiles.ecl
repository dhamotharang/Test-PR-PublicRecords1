
EXPORT BWR_Create_Superfiles := MODULE

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

//contlegalmail
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::address');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::addressb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::citystname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::citystnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::fein2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::name');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::nameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::namewords2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::payload');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::phone2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::phoneb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::ssn2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::stname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::stnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::zip');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalmail::@version@::zipb2');


//contlegalPhys
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::address');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::addressb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::citystname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::citystnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::fein2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::name');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::nameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::namewords2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::payload');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::phone2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::phoneb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::ssn2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::stname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::stnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::zip');
MakeSuperKeys ('~prte::key::ncpdp::autokey::contlegalphys::@version@::zipb2');

//DBAMail
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::address');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::addressb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::citystname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::citystnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::fein2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::name');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::nameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::namewords2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::payload');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::phone2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::phoneb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::ssn2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::stname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::stnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::zip');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbamail::@version@::zipb2');

//DBAPhys
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::address');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::addressb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::citystname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::citystnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::fein2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::name');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::nameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::namewords2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::payload');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::phone2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::phoneb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::ssn2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::stname');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::stnameb2');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::zip');
MakeSuperKeys ('~prte::key::ncpdp::autokey::dbaphys::@version@::zipb2');


//Roxie Keys
MakeSuperKeys ('~prte::key::ncpdp::@version@::bdid');
MakeSuperKeys ('~prte::key::ncpdp::@version@::dea');
MakeSuperKeys ('~prte::key::ncpdp::@version@::did');
MakeSuperKeys ('~prte::key::ncpdp::@version@::fein');
MakeSuperKeys ('~prte::key::ncpdp::@version@::linkids');
MakeSuperKeys ('~prte::key::ncpdp::@version@::lnpid');
MakeSuperKeys ('~prte::key::ncpdp::@version@::ncpdp_id');
MakeSuperKeys ('~prte::key::ncpdp::@version@::npi');
MakeSuperKeys ('~prte::key::ncpdp::@version@::sln_state');


MakeSuperFiles ('~PRTE::BASE::ncpdp@version@');

FileServices.CreateSuperFile ('~PRTE::IN::ncpdp');

RETURN 'SUCCESS';

End;

End;