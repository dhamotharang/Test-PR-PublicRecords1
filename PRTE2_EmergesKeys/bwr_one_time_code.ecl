


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

MakeSuperKeys ('~prte::key::ccw::@version@::autokey::address');
MakeSuperKeys ('~prte::key::ccw::@version@::autokey::citystname');
MakeSuperKeys ('~prte::key::ccw::@version@::autokey::name');
MakeSuperKeys ('~prte::key::ccw::@version@::autokey::payload');
MakeSuperKeys ('~prte::key::ccw::@version@::autokey::ssn2');
MakeSuperKeys ('~prte::key::ccw::@version@::autokey::stname');
MakeSuperKeys ('~prte::key::ccw::@version@::autokey::zip');
MakeSuperKeys ('~prte::key::ccw::@version@::did');
MakeSuperKeys ('~prte::key::ccw::@version@::rid');
MakeSuperKeys ('~prte::key::ccw_doxie_did_@version@');
MakeSuperKeys ('~prte::key::hunters_doxie_did_@version@');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::autokey::address');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::autokey::citystname');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::autokey::name');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::autokey::payload');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::autokey::ssn2');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::autokey::stname');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::autokey::zip');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::did');
MakeSuperKeys ('~prte::key::hunting_fishing::@version@::rid');
MakeSuperKeys ('~prte::key::ccw::fcra::@version@::did');
MakeSuperKeys ('~prte::key::ccw::fcra::@version@::rid');
MakeSuperKeys ('~prte::key::ccw_doxie_did_fcra_@version@');
MakeSuperKeys ('~prte::key::hunters_doxie_did_fcra_@version@');
MakeSuperKeys ('~prte::key::hunting_fishing::fcra::@version@::did');
MakeSuperKeys ('~prte::key::hunting_fishing::fcra::@version@::rid');


MakeSuperFiles ('~PRTE::BASE::CCW::hunting_fishing@version@');

MakeSuperFiles ('~PRTE::BASE::CCW::ccw@version@');

FileServices.CreateSuperFile ('~PRTE::IN::CCW::hunting_fishing');

FileServices.CreateSuperFile ('~PRTE::IN::CCW::ccw');

RETURN 'SUCCESS';

End;

End;