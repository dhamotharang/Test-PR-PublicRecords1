//This file was generated as a starting point only.  
//You must check and customize this process BEFORE running it.


EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'built'));
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

MakeSuperKeys (Constants.ak_keyname + 'address');
MakeSuperKeys (Constants.ak_keyname + 'addressb');
MakeSuperKeys (Constants.ak_keyname + 'addressb2');
MakeSuperKesy (Constants.ak_keyname + 'citystname');
MakeSuperKeys (Constants.ak_keyname + 'citystnameb2');
MakeSuperKeys (Constants.ak_keyname + 'fein');
MakeSuperKeys (Constants.ak_keyname + 'fein2');
MakeSuperKeys (Constants.ak_keyname + 'name');
MakeSuperKeys (Constants.ak_keyname + 'nameb2');
MakeSuperKeys (Constants.ak_keyname + 'namewords2');
MakeSuperKeys (Constants.ak_keyname + 'payload');
MakeSuperKeys (Constants.ak_keyname + 'stname');
MakeSuperKeys (Constants.ak_keyname + 'stnameb2');
MakeSuperKeys (Constants.ak_keyname + 'zip');
MakeSuperKeys (Constants.ak_keyname + 'zipb2');
MakeSuperKeys (Constants.ak_keyname + 'phone');
MakeSuperKeys (Constants.ak_keyname + 'phone2');
MakeSuperKeys (Constants.ak_keyname + 'phoneb2');
MakeSuperKeys (Constants.ak_keyname + 'ssn');
MakeSuperKeys (Constants.ak_keyname + 'ssn2');

MakeSuperKeys (Constants.KeyName_Workers_Compensation + '@version@::bdid');
MakeSuperKeys (Constants.KeyName_Workers_Compensation + '@version@::linkids');


MakeSuperFiles (Constants.base_workers_compensation + '@version@');

FileServices.CreateSuperFile (Constants.in_workers_compensation);

RETURN 'SUCCESS';

End;

End;