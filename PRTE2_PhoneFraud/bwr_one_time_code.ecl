IMPORT PRTE2_PhoneFraud;
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

//MakeSuperKeys (Constants.KeyName_phonefraud_otp + '_@version@');
//MakeSuperKeys (Constants.KeyName_phonefraud_spoofing + '_@version@');

MakeSuperFiles (Constants.base_phonefraud_otp + '@version@');
MakeSuperFiles (Constants.base_phonefraud_spoofing + '@version@');


RETURN 'SUCCESS';

End;

End;