//Defines full build process
import _control, versioncontrol, inql_ffd, Scrubs_Inquiry_History;

export Build_Base(
											boolean isUpdate   = true
									, 	boolean isFCRA     = true
									, 	string  pVersion   = ''
									,   boolean isNewInput = true
									) 
									:= module
   
	export daily_base	 					 	:= Update_Base(isUpdate, isFCRA, pversion).daily_base;
	export daily_base_encrypted	 	:= Update_Base(isUpdate, isFCRA, pversion).daily_base_encrypted;
  export weekly_base 						:= Fn_UpdateWeeklyBase(pVersion).new_weekly_base;
	export weekly_base_encrypted	:= Fn_UpdateWeeklyBase(pVersion).new_weekly_base_encrypted;
	
	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(true, isFCRA, pversion).base.new	
																				,daily_base
																				,Build_Daily_Base
																			 );
  
	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(true, isFCRA, pversion,true).base.new	
																				,daily_base_encrypted
																				,Build_Daily_Base_Encrypted
																			 );	
  
	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(false, isFCRA, pversion).base.new	
																				,weekly_base
																				,Build_Weekly_Base
																			 );	
																			 
  VersionControl.macBuildNewLogicalFile( 
																				 Filenames(false, isFCRA, pversion,true ).base.new	
																				,weekly_base_encrypted
																				,Build_Weekly_Base_Encrypted
																			 );			
																			 
  buildDailyBase := sequential(move_files(isUpdate, isFCRA, pVersion).Current_To_In_Building
															,Build_Daily_Base
															,Build_Daily_Base_Encrypted
															,inql_ffd.Promote(true, isFCRA, pversion).base.new2Built
															,inql_ffd.Promote(true, isFCRA, pversion).base.Built2QA
															,inql_ffd.Promote(true, isFCRA, pversion).base_encrypted.new2Built
															,inql_ffd.Promote(true, isFCRA, pversion).base_encrypted.Built2QA
															// ,fn_Consolidate_Input_Files(isUpdate, isFCRA, pVersion)
															,move_files(isUpdate, isFCRA, pVersion).In_Building_to_Built
															);
	
  buildWeeklyBase := sequential (Build_Weekly_Base
	                              ,Build_Weekly_Base_Encrypted
																,Promote(false, isFCRA, pversion).base.New2Built
																,Promote(false, isFCRA, pversion).base.Built2qa
																,inql_ffd.Promote(false, isFCRA, pversion).base_encrypted.new2Built
															  ,inql_ffd.Promote(false, isFCRA, pversion).base_encrypted.Built2QA
	                           );
  
	export All 		:= if(isUpdate
														,buildDailyBase
														,buildWeeklyBase
											);

	
end;