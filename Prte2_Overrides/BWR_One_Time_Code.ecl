
EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;


EXPORT DO := FUNCTION

//thor_data400::key::override::fcra::liensv2_main::qa::ffid

MakeSuperKeys ('~prte::key::override::fcra::liensv2_main::@version@::ffid');

RETURN 'SUCCESS';

End;

End;