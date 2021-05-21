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

  MakeSuperKeys ('~prte::key::phones_transaction_@version@');
 
  MakeSuperKeys  ('~prte::key::phones_type_@version@');
 
  MakeSuperFiles ('~prte::base::metadata_trans@version@');
 
  MakeSuperFiles ('~prte::base::metadata_type@version@');
 
  FileServices.CreateSuperFile ('~prte::in::met::metadata_trans');

  FileServices.CreateSuperFile ('~prte::in::met::metadata_type');

RETURN 'SUCCESS';

End;

End;