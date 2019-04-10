IMPORT PRTE2_PhonesInfo;
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
MakeSuperKeys (Constants.KeyName_phones + Constants.KeyName_lerg6 + '_@version@');

// MakeSuperFiles (Constants.base_phones_ported_metadata + '@version@');
// MakeSuperFiles (Constants.base_carrier_reference + '@version@');

// MakeSuperKeys (Constants.KeyName_phones + Constants.KeyName_phones_ported_metadata + '@version@');
// MakeSuperKeys (Constants.KeyName_phones + Constants.KeyName_carrier_reference + '@version@');

RETURN 'SUCCESS';

End;

End;