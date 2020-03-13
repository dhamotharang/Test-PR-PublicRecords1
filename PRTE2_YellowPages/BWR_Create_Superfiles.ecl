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
	/*
	FileServices.DeleteLogicalFile('~prte::in::yellowpages'),
	FileServices.DeleteLogicalFile('~prte::base::yellowpages'),
	DeleteSupers('~prte::base::yellowpages_@version@'),	
	DeleteSupers('~prte::key::yellowpages::@version@::addr'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::address'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::addressb2'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::citystname'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::citystnameb2'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::name'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::nameb2'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::namewords2'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::payload'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::phone2'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::phoneb2'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::stname'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::stnameb2'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::zip'),
	DeleteSupers('~prte::key::yellowpages::@version@::autokey::zipb2'),
	DeleteSupers('~prte::key::yellowpages::@version@::bdid'),	
	DeleteSupers('~prte::key::yellowpages::@version@::linkids'),
	DeleteSupers('~prte::key::yellowpages::@version@::phone'),
	*/
	//prte::key::yellowpages::bdid_QA_GRANDFATHER
	DeleteSupers('~prte::key::yellowpages::QA::bdid_@version@'),
	DeleteSupers('~prte::key::yellowpages::QA::linkids_@version@'),
	DeleteSupers('~prte::key::yellowpages::QA::phone_@version@'),

	DeleteSupers('~prte::key::yellowpages::bdid_QA_@version@'),
	DeleteSupers('~prte::key::yellowpages::linkids_QA_@version@'),
	DeleteSupers('~prte::key::yellowpages::phone_QA_@version@'),
	/*
	FileServices.CreateSuperFile('~prte::in::yellowpages'),
	FileServices.CreateSuperFile('~prte::base::yellowpages'),
	MakeSupers('~prte::base::yellowpages_@version@'),	
	MakeSupers('~prte::key::yellowpages::@version@::addr'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::address'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::addressb2'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::citystname'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::citystnameb2'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::name'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::nameb2'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::namewords2'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::payload'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::phone2'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::phoneb2'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::stname'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::stnameb2'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::zip'),
	MakeSupers('~prte::key::yellowpages::@version@::autokey::zipb2'),
	MakeSupers('~prte::key::yellowpages::@version@::bdid'),	
	MakeSupers('~prte::key::yellowpages::@version@::linkids'),
	MakeSupers('~prte::key::yellowpages::@version@::phone'),
	*/
	MakeSupers('~prte::key::yellowpages::QA::bdid_@version@'),
	MakeSupers('~prte::key::yellowpages::QA::linkids_@version@'),
	MakeSupers('~prte::key::yellowpages::QA::phone_@version@'),

	MakeSupers('~prte::key::yellowpages::bdid_QA_@version@'),
	MakeSupers('~prte::key::yellowpages::linkids_QA_@version@'),
	MakeSupers('~prte::key::yellowpages::phone_QA_@version@'),
);