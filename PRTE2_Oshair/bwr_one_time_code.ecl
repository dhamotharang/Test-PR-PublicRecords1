//This file was generated as a starting point only.  
//You must check and customize this process BEFORE running it.


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

MakeSuperKeys ('~prte::key::oshair::accident_@version@');
MakeSuperKeys ('~prte::key::oshair::bdid_@version@');
MakeSuperKeys ('~prte::key::oshair::hazardous_substance_@version@');
MakeSuperKeys ('~prte::key::oshair::inspection_@version@');
MakeSuperKeys ('~prte::key::oshair::linkids_@version@');
MakeSuperKeys ('~prte::key::oshair::program_@version@');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::addressb2');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::citystnameb2');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::fein2');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::nameb2');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::namewords2');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::payload');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::stnameb2');
MakeSuperKeys ('~prte::key::oshair::@version@::autokey::zipb2');
MakeSuperKeys ('~prte::key::oshair::violations_@version@');


MakeSuperFiles ('~PRTE::BASE::oshair::accident@version@');
MakeSuperFiles ('~PRTE::BASE::oshair::inspection@version@');
MakeSuperFiles ('~PRTE::BASE::oshair::violations@version@');
MakeSuperFiles ('~PRTE::BASE::oshair::substance@version@');
MakeSuperFiles ('~PRTE::BASE::oshair::program@version@');

FileServices.CreateSuperFile ('~PRTE::IN::oshair::accident');
FileServices.CreateSuperFile ('~PRTE::IN::oshair::inspection');
FileServices.CreateSuperFile ('~PRTE::IN::oshair::violations');
FileServices.CreateSuperFile ('~PRTE::IN::oshair::substance');
FileServices.CreateSuperFile ('~PRTE::IN::oshair::program');

RETURN 'SUCCESS';

End;

End;