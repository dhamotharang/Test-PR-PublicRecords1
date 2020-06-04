//Defines full build process
import _control, versioncontrol, inql_ffd, Scrubs_Inquiry_History;

export Build_Base(
											boolean isUpdate   = true
									, 	boolean isFCRA     = true
									, 	string  pVersion   = ''
									,   boolean isNewInput = true
									) 
									:= module
   
	export daily_base	 := Update_Base(isUpdate, isFCRA, pversion);
  export weekly_base := Fn_UpdateWeeklyBase(pVersion);
	export legacy_base := Fn_BuildFCRALegacyBase(pVersion);
	
	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(true, isFCRA, pversion).base.new	
																				,daily_base
																				,Build_Daily_Base
																			 );
	
  VersionControl.macBuildNewLogicalFile( 
																				 Filenames(false, isFCRA, pversion).base.new	
																				,weekly_base
																				,Build_Weekly_Base
																			 );	
																			 
	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(false, isFCRA, pversion).base.new	
																				,legacy_base
																				,Build_Legacy_Base
																			 );	
																			 
  buildDailyBase := sequential(move_files(isUpdate, isFCRA, pVersion).Current_To_In_Building
															,Build_Daily_Base
															,Promote(true, isFCRA, pversion).buildfiles.New2Built
															,Promote(true, isFCRA, pversion).buildfiles.Built2qa
															,fn_Consolidate_Input_Files(isUpdate, isFCRA, pVersion)
															,move_files(isUpdate, isFCRA, pVersion).In_Building_to_Built
															);
	
  buildWeeklyBase := sequential (Build_Weekly_Base
																,Promote(false, isFCRA, pversion).buildfiles.New2Built
																,Promote(false, isFCRA, pversion).buildfiles.Built2qa
	                           );
														 
	buildLegacyBase := sequential(
															 Build_Legacy_Base
															,Promote(false, isFCRA, pversion).buildfiles.New2Built
															,Promote(false, isFCRA, pversion).buildfiles.Built2qa
															);
		
	export All 		:= if (isNewInput
													,	if(isUpdate
																	,buildDailyBase
																	,buildWeeklyBase
															 )
													, buildLegacyBase
											);

	
end;