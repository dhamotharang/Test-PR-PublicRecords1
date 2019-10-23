IMPORT $, RoxieKeyBuild, PromoteSupers, Orbit3, STD, Data_Services;

EXPORT proc_build_all(string filedate, BOOLEAN	pUseProd	=	TRUE) := FUNCTION

	fileprefix	:= IF(pUseProd, data_services.foreign_prod, '~');

	BOOLEAN ReleaseUpdateExists			:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::update_Release'))>0;
	BOOLEAN AssignmentUpdateExists	:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::update_Assignment'))>0;
	BOOLEAN ReleaseRefreshExists		:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::refresh_Release'))>0;
	BOOLEAN AssignmentRefreshExists	:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::refresh_Assignment'))>0;
	
	//Build Assignment
	AssignmentBase := Build_Base.AssignBase;
	
	PromoteSupers.Mac_SF_BuildProcess(AssignmentBase,'~thor_data400::base::BKMortgage::Assignment',build_Assign_base,3,,true);
	
	AssignBuild	:= SEQUENTIAL(IF(AssignmentUpdateExists OR AssignmentRefreshExists, build_Assign_base, output('No Assignment Files Found'))
														);
														
		//Build Release
	ReleaseBase := Build_Base.ReleaseBase;
	
	PromoteSupers.Mac_SF_BuildProcess(ReleaseBase,'~thor_data400::base::BKMortgage::Release',build_Release_base,3,,true);
	
	ReleaseBuild	:= SEQUENTIAL(IF(ReleaseUpdateExists OR ReleaseRefreshExists, build_Release_base, output('No Release Files Found'))
															);
														
	BuildAll	:= SEQUENTIAL(AssignBuild, ReleaseBuild);
	
	RETURN BuildAll;

END;
	
	