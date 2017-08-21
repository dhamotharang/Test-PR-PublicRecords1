
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

MakeSuperKeys ('~prte::key::corp2::@version@::ar::corp_key.record_type');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::address');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::addressb2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::citystname');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::citystnameb2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::fein2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::name');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::nameb2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::namewords2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::payload');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::phone2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::phoneb2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::ssn2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::stname');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::stnameb2');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::zip');
MakeSuperKeys ('~prte::key::corp2::@version@::autokey::zipb2');
MakeSuperKeys ('~prte::key::corp2::@version@::cont::bdid');
MakeSuperKeys ('~prte::key::corp2::@version@::cont::corp_key.record_type');
MakeSuperKeys ('~prte::key::corp2::@version@::cont::did');
MakeSuperKeys ('~prte::key::corp2::@version@::corp::bdid');
MakeSuperKeys ('~prte::key::corp2::@version@::corp::bdid.pl');
MakeSuperKeys ('~prte::key::corp2::@version@::corp::corp_key.record_type');
MakeSuperKeys ('~prte::key::corp2::@version@::corp::linkids');
MakeSuperKeys ('~prte::key::corp2::@version@::corp::st.charter_number');
MakeSuperKeys ('~prte::key::corp2::@version@::event::corp_key.record_type');
MakeSuperKeys ('~prte::key::corp2::@version@::stock::corp_key.record_type');


MakeSuperFiles ('~PRTE::BASE::corp2::ar@version@');

MakeSuperFiles ('~PRTE::BASE::corp2::cont@version@');

MakeSuperFiles ('~PRTE::BASE::corp2::corp@version@');

MakeSuperFiles ('~PRTE::BASE::corp2::event@version@');

MakeSuperFiles ('~PRTE::BASE::corp2::stock@version@');

FileServices.CreateSuperFile ('~PRTE::IN::corp2::ar');

FileServices.CreateSuperFile ('~PRTE::IN::corp2::cont');

FileServices.CreateSuperFile ('~PRTE::IN::corp2::corp');

FileServices.CreateSuperFile ('~PRTE::IN::corp2::event');

FileServices.CreateSuperFile ('~PRTE::IN::corp2::stock');

RETURN 'SUCCESS';

End;

End;