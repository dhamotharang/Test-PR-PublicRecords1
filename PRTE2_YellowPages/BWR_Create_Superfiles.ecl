#workunit('name', 'PRTE YellowPages Create All Superfiles');

DeleteSupers(string name) := FUNCTION
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'built'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'building'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'prod'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'qa_grandfather'));
	FileServices.DeleteSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;


MakeSupers(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'building'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'prod'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa_grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;

SEQUENTIAL(
	
	FileServices.DeleteLogicalFile('~prte::in::yellowpages'),
	FileServices.DeleteLogicalFile('~prte::base::yellowpages'),
	DeleteSupers('~prte::base::yellowpages_@version@'),
	DeleteSupers('~prte::key::yellowpages::bdid_@version@'),
	DeleteSupers('~prte::key::yellowpages::linkids_@version@'),
	DeleteSupers('~prte::key::yellowpages::phone_@version@'),
	FileServices.CreateSuperFile('~prte::in::yellowpages'),
	FileServices.CreateSuperFile('~prte::base::yellowpages'),
	MakeSupers('~prte::base::yellowpages_@version@'),
	MakeSupers('~prte::key::yellowpages::bdid_@version@'),
	MakeSupers('~prte::key::yellowpages::linkids_@version@'),
	MakeSupers('~prte::key::yellowpages::phone_@version@'),	
);