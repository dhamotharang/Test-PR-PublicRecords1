IMPORT $, RoxieKeyBuild, PromoteSupers, Orbit3, STD, Data_Services;

EXPORT proc_build_all(string filedate, BOOLEAN	pUseProd	=	FALSE) := FUNCTION

	fileprefix	:= IF(pUseProd, data_services.foreign_prod, '~');

	BOOLEAN ReleaseUpdateExists			:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::update_Release'))>0;
	BOOLEAN AssignmentUpdateExists	:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::update_Assignment'))>0;
	BOOLEAN ReleaseRefreshExists		:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::refresh_Release'))>0;
	BOOLEAN AssignmentRefreshExists	:=	NOTHOR(STD.File.GetSuperFileSubCount(fileprefix + 'thor_data400::in::BKMortgage::refresh_Assignment'))>0;
	
	//Build Assignment
	AssignmentBase := Build_Base.AssignBase;
	
	PromoteSupers.Mac_SF_BuildProcess(AssignmentBase,'~thor_data400::base::BKMortgage::Assignment',build_Assign_base,3,,true);
	
	AssignPopulationStats	:= BKMortgage.Strata_Population_Stats_Assignment(filedate);
	
	AssignBuild	:= SEQUENTIAL(IF(AssignmentUpdateExists OR AssignmentRefreshExists, 
															SEQUENTIAL(BKMortgage.Fn_AssignRaw_scrubs(BKMortgage.Files().Assignment_Infile, filedate, Email_List),
															build_Assign_base,
															AssignPopulationStats),
															output('No Assignment Files Found'))
														);
														
		//Build Release
	ReleaseBase := Build_Base.ReleaseBase;
	
	PromoteSupers.Mac_SF_BuildProcess(ReleaseBase,'~thor_data400::base::BKMortgage::Release',build_Release_base,3,,true);
	
	ReleasePopulationStats	:= BKMortgage.Strata_Population_Stats_Release(filedate);
	
	ReleaseBuild	:= SEQUENTIAL(IF(ReleaseUpdateExists OR ReleaseRefreshExists,
																SEQUENTIAL(BKMortgage.Fn_ReleaseRaw_scrubs(BKMortgage.Files().Release_Infile,filedate, Email_List),
																build_Release_base,
																ReleasePopulationStats),
																output('No Release Files Found'))
															);
														
	orbit_update := sequential(Orbit3.Proc_Orbit3_CreateBuild('Black Knight Mortgage',filedate,is_npf := true));
	
	BuildAll	:= SEQUENTIAL(AssignBuild, ReleaseBuild, orbit_update);
	
	RETURN BuildAll;

END;
	
	