
EXPORT BWR_ONE_TIME_CODE := MODULE

SHARED MakeSuperKeys(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'),,true);
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'),,true);
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'),,true);
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'),,true);
	RETURN 'SUCCESS';
END;

EXPORT DO := FUNCTION


MakeSuperKeys ('~prte::key::searchtool::@version@::dtc');
MakeSuperKeys ('~prte::key::searchtool::@version@::business_bdid');
MakeSuperKeys ('~prte::key::searchtool::@version@::combined_biz_bdid');
MakeSuperKeys ('~prte::key::searchtool::@version@::people');
MakeSuperKeys ('~prte::key::searchtool::@version@::business_linkids');
MakeSuperKeys ('~prte::key::searchtool::@version@::combined_biz_linkids');
MakeSuperKeys ('~prte::key::searchtool::@version@::business_address');

RETURN 'SUCCESS';

End;

End;