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
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::address');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::citystname');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::name');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::payload');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::ssn2');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::stname');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::uberrefs');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::uberwords');
MakeSuperKeys ('~prte::key::dl2::autokey::@version@::zip');
MakeSuperKeys ('~prte::key::dl2::@version@::accident_dlcp_key');
MakeSuperKeys ('~prte::key::dl2::@version@::conviction_dlcp_key');
MakeSuperKeys ('~prte::key::dl2::@version@::dl_did_public');
MakeSuperKeys ('~prte::key::dl2::@version@::dl_indicatives_public');
MakeSuperKeys ('~prte::key::dl2::@version@::dl_number_public');
MakeSuperKeys ('~prte::key::dl2::@version@::dl_seq');
MakeSuperKeys ('~prte::key::dl2::@version@::dr_info_dlcp_key');
MakeSuperKeys ('~prte::key::dl2::@version@::fra_insur_dlcp_key');
MakeSuperKeys ('~prte::key::dl2::@version@::suspension_dlcp_key');
MakeSuperKeys ('~prte::data::dl2::wildcard_@version@');

FileServices.CreateSuperFile ('~PRTE::IN::dl2::Drvlic');
MakeSuperFiles ('~PRTE::BASE::dl2::Drvlic@version@');

FileServices.CreateSuperFile ('~PRTE::IN::DL2::CP_FRA_INSURANCE');
MakeSuperFiles ('~PRTE::BASE::DL2::CP_FRA_INSURANCE@version@');

FileServices.CreateSuperFile ('~PRTE::IN::DL2::CP_SUSPENSIONS');
MakeSuperFiles ('~PRTE::BASE::DL2::CP_SUSPENSIONS@version@');

FileServices.CreateSuperFile ('~PRTE::IN::DL2::CP_CONVICTIONS');
MakeSuperFiles ('~PRTE::BASE::DL2::CP_CONVICTIONS@version@');

FileServices.CreateSuperFile ('~PRTE::IN::DL2::CP_ACCIDENTS');
MakeSuperFiles ('~PRTE::BASE::DL2::CP_ACCIDENTS@version@');

FileServices.CreateSuperFile ('~PRTE::IN::DL2::CP_DR_INFO');
MakeSuperFiles ('~PRTE::BASE::DL2::CP_DR_INFO@version@');

FileServices.CreateSuperFile ('~prte::data::dl2::wildcard');

RETURN 'SUCCESS';

End;

End;