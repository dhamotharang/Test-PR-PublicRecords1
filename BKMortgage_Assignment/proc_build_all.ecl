IMPORT $, BKMortgage_Release, RoxieKeyBuild, PromoteSupers, Orbit3, STD, Data_Services;

EXPORT proc_build_all(string filedate, BOOLEAN	pUseProd	=	TRUE) := FUNCTION

	fileprefix	:= IF(pUseProd, data_services.foreign_prod, '~');

	BOOLEAN ReleaseUpdateExists			:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::update_Release'))>0;
	BOOLEAN AssignmentUpdateExists	:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::update_Assignment'))>0;
	BOOLEAN ReleaseRefreshExists		:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::refresh_Release'))>0;
	BOOLEAN AssignmentRefreshExists	:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::refresh_Assignment'))>0;
	
	//Build Assignment
	AssignmentUpdateBase := Build_Assignment.UpdateBase;
	
	PromoteSupers.Mac_SF_BuildProcess(AssignmentUpdateBase,'~thor_data400::base::BKMortgage::Assignment_update',build_AssignUpdate_base,3,,true);
	
	AssignmentRefreshBase	:= Build_Assignment.RefreshBase;
	
	PromoteSupers.Mac_SF_BuildProcess(AssignmentRefreshBase,'thor_data400::base::BKMortgage::Assignment_refresh',build_AssignRefresh_base,3,,true);
	
	AssignBuild	:= SEQUENTIAL(IF(AssignmentUpdateExists, build_AssignUpdate_base, output('No Assignment Update Found')),
														IF(AssignmentRefreshExists, build_AssignRefresh_base, output('No Assignment Refresh Found'))
														);
														
		//Build Release
	ReleaseUpdateBase := BKMortgage_Release.Build_Release.UpdateBase;
	
	PromoteSupers.Mac_SF_BuildProcess(ReleaseUpdateBase,'~thor_data400::base::BKMortgage::Release_update',build_ReleaseUpdate_base,3,,true);
	
	ReleaseRefreshBase	:= BKMortgage_Release.Build_Release.RefreshBase;
	
	PromoteSupers.Mac_SF_BuildProcess(ReleaseRefreshBase,'~thor_data400::base::BKMortgage::Release_refresh',build_ReleaseRefresh_base,3,,true);
	
	ReleaseBuild	:= SEQUENTIAL(IF(ReleaseUpdateExists, build_ReleaseUpdate_base, output('No Release Update Found')),
														IF(ReleaseRefreshExists, build_ReleaseRefresh_base, output('No Release Refresh Found'))
														);
														
	BuildAll	:= SEQUENTIAL(AssignBuild, ReleaseBuild);
	
	RETURN BuildAll;

END;
	
	