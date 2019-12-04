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

MakeSuperKeys ('~prte::key::email_datav2::@version@::email_event_lkp');

MakeSuperKeys ('~prte::key::email_datav2::@version@::domain_lkp');

MakeSuperFiles ('~prte::Base::EmailEvent@version@');

MakeSuperFiles ('~prte::Base::DomainEvent@version@');

FileServices.CreateSuperFile ('~PRTE::IN::emailevent');

FileServices.CreateSuperFile ('~PRTE::IN::emaildomain');

RETURN 'SUCCESS';

End;

End;