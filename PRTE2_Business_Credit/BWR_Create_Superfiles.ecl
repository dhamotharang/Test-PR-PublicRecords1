// EXPORT BWR_Create_Superfiles := 'todo';

EXPORT BWR_Create_Superfiles := MODULE

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
MakeSuperKeys('~prte::key::sbfe::@version@::individualowner');
MakeSuperKeys('~prte::key::sbfe::@version@::individualownerinformation');
MakeSuperKeys('~prte::key::sbfe::@version@::linkids');
MakeSuperKeys('~prte::key::sbfe::@version@::masteraccount');
MakeSuperKeys('~prte::key::sbfe::@version@::memberspecific');
MakeSuperKeys('~prte::key::sbfe::@version@::releasedate');
MakeSuperKeys('~prte::key::sbfe::@version@::tradeline');
MakeSuperKeys('~prte::key::sbfe::@version@::tradelineguarantor');
MakeSuperKeys('~prte::key::sbfe::@version@::bipv2_best::linkids');
MakeSuperKeys('~prte::key::sbfe::@version@::businessindustryclassification');
MakeSuperKeys('~prte::key::sbfe::@version@::businessinformation');
MakeSuperKeys('~prte::key::sbfe::@version@::businessowner');
MakeSuperKeys('~prte::key::sbfe::@version@::businessownerinformation');
MakeSuperKeys('~prte::key::sbfe::@version@::collateral');
MakeSuperKeys('~prte::key::sbfe::@version@::history');
MakeSuperKeys('~prte::key::sbfescoring::@version@::scoringindex');

 
MakeSuperKeys('~PRTE::BASE::sbfe::@version@::denormalized');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::dbtaverage');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::uniquelinkids');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::scores1');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::scores2');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::scores3');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::scores4');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::scores5');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::scores6');
MakeSuperKeys('~PRTE::BASE::sbfescoring::@version@::scores7');

FileServices.CreateSuperFile('~PRTE::IN::sbfe::denormalized');

RETURN 'SUCCESS';

End;

End;