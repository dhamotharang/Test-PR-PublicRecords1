#workunit('name', 'PRTE BBB Create All Superfiles');


MakeSupers(string name) := FUNCTION
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'qa'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'father'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'built'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'building'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'prod'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'grandfather'));
	FileServices.CreateSuperFile (RegExReplace('@version@', name, 'delete'));
	RETURN 'SUCCESS';
END;

SEQUENTIAL(

FileServices.CreateSuperFile('prte::key::bbb::member::bdid_FATHER');
	//prte::key::bbb::20191115::bdid

	//MakeSupers ('~prte::key::bbb::@version@::bdid'),
	//MakeSupers ('~prte::key::bbb::@version@::linkids'),
	MakeSupers ('~prte::key::bbb_non_member_@version@'),
	MakeSupers ('~prte::key::bbb_non_member_@version@'),
	//prte::key::bbb_non_member_BUILT
	
	//MakeSupers ('~PRTE::BASE::bbb::@version@::member'),
	//MakeSupers ('~PRTE::BASE::bbb::@version@::nonmember'),
	//FileServices.CreateSuperFile ('~PRTE::IN::bbb::member'),
	//FileServices.CreateSuperFile ('~PRTE::IN::bbb::nonmember'),
	//MakeSupers ('~PRTE::BASE::bbb::member_@version@'),
	//MakeSupers ('~PRTE::BASE::bbb::nonmember_@version@'),
	//FileServices.CreateSuperFile ('~PRTE::base::bbb::member'),
	//FileServices.CreateSuperFile ('~PRTE::base::bbb::nonmember'),
);