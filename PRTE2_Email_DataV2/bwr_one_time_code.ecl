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

   MakeSuperKeys (Constants.key_prefix + '@version@::did');
   MakeSuperKeys (Constants.key_prefix + '@version@::email_addresses');
   MakeSuperKeys (Constants.key_prefix + '@version@::payload');
  	 
   MakeSuperKeys (Constants.key_FCRA_prefix + '@version@::did');
   MakeSuperKeys (Constants.key_FCRA_prefix + '@version@::payload');
	 
	 MakeSuperKeys (Constants.key_prefix + 'autokey::@version@::address');
   MakeSuperKeys (Constants.key_prefix + 'autokey::@version@::citystname');
   MakeSuperKeys (Constants.key_prefix + 'autokey::@version@::name');
   MakeSuperKeys (Constants.key_prefix + 'autokey::@version@::ssn2');
   MakeSuperKeys (Constants.key_prefix + 'autokey::@version@::stname');
   MakeSuperKeys (Constants.key_prefix + 'autokey::@version@::zip');
	 MakeSuperKeys (Constants.key_prefix + 'autokey::@version@::payload');
	 	 
RETURN 'SUCCESS';

End;

End;