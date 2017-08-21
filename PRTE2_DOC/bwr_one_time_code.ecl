//This file was generated as a starting point only.  
//You must check and customize this process BEFORE running it.


EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'built'));
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

MakeSuperKeys ('~prte::key::criminal_offenders::fcra::@version@::did');
MakeSuperKeys ('~prte::key::criminal_offenses::fcra::@version@::offender_key');
MakeSuperKeys ('~prte::key::criminal_punishment::fcra::@version@::offender_key.punishment_type');
MakeSuperKeys ('~prte::key::corrections::fcra::activity_public_@version@');
MakeSuperKeys ('~prte::key::corrections::fcra::court_offenses_public_@version@');
MakeSuperKeys ('~prte::key::corrections::fcra::offenders_offenderkey_public_@version@');
MakeSuperKeys ('~prte::key::corrections_offenders::fcra::bocashell_did_@version@');
MakeSuperKeys ('~prte::key::corrections::autokey::@version@::address');
MakeSuperKeys ('~prte::key::corrections::autokey::@version@::citystname');
MakeSuperKeys ('~prte::key::corrections::autokey::@version@::name');
MakeSuperKeys ('~prte::key::corrections::autokey::@version@::payload');
MakeSuperKeys ('~prte::key::corrections::autokey::@version@::ssn2');
MakeSuperKeys ('~prte::key::corrections::autokey::@version@::stname');
MakeSuperKeys ('~prte::key::corrections::autokey::@version@::zip');
MakeSuperKeys ('~prte::key::corrections_activity_public_@version@');
MakeSuperKeys ('~prte::key::corrections_court_offenses_public_@version@');
MakeSuperKeys ('~prte::key::corrections_fdid_public_@version@');
MakeSuperKeys ('~prte::key::corrections_offenders_casenumber_public_@version@');
MakeSuperKeys ('~prte::key::corrections_offenders_docnum_public_@version@');
MakeSuperKeys ('~prte::key::corrections_offenders_offenderkey_public_@version@');
MakeSuperKeys ('~prte::key::corrections_offenders_public_@version@');
MakeSuperKeys ('~prte::key::corrections_offenders_risk::bocashell_did_@version@');
MakeSuperKeys ('~prte::key::corrections_offenders_risk::did_public_@version@');
MakeSuperKeys ('~prte::key::corrections_offenses_public_@version@');
MakeSuperKeys ('~prte::key::corrections_publicaddress_@version@');
MakeSuperKeys ('~prte::key::corrections_publiccitystname_@version@');
MakeSuperKeys ('~prte::key::corrections_publicname_@version@');
MakeSuperKeys ('~prte::key::corrections_publicphone_@version@');
MakeSuperKeys ('~prte::key::corrections_publicssn_@version@');
MakeSuperKeys ('~prte::key::corrections_publicstname_@version@');
MakeSuperKeys ('~prte::key::corrections_publiczip_@version@');
MakeSuperKeys ('~prte::key::corrections_punishment_public_@version@');


MakeSuperFiles ('~PRTE::BASE::corrections::offenses@version@');

MakeSuperFiles ('~PRTE::BASE::corrections::court_offenses@version@');

MakeSuperFiles ('~PRTE::BASE::corrections::offenders@version@');

MakeSuperFiles ('~PRTE::BASE::corrections::punishment@version@');

MakeSuperFiles ('~PRTE::BASE::corrections::activity@version@');

FileServices.CreateSuperFile ('~PRTE::IN::corrections::offenses');

FileServices.CreateSuperFile ('~PRTE::IN::corrections::CourtOffenses');

FileServices.CreateSuperFile ('~PRTE::IN::corrections::offenders');

FileServices.CreateSuperFile ('~PRTE::IN::corrections::punishment');

FileServices.CreateSuperFile ('~PRTE::IN::corrections::activity');

RETURN 'SUCCESS';

End;

End;