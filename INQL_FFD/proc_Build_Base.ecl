//Defines full build process
import _control, versioncontrol, inql_ffd;

export Build_Base(
											boolean isUpdate = true
									, 	boolean isFCRA = true
									, 	string pVersion = ''				
									) :=

module
   
	export build_base		:= Update_Base(isUpdate, isFCRA, pversion);

	VersionControl.macBuildNewLogicalFile( 
																				 Filenames(isUpdate, isFCRA, pversion).base.new	
																				,build_base
																				,Build_Base_File
																			 );
																																

	export full_build :=
												sequential(
																	 move_files(isUpdate, isFCRA, pVersion).Current_To_In_Building
																	,Build_Base_File
																	,Promote(isUpdate, isFCRA, pversion).buildfiles.New2Built
																	,Promote(isUpdate, isFCRA, pversion).buildfiles.Built2qa
																//	,move_files(isUpdate, isFCRA, pVersion).In_Building_to_Built
																	,fn_Consolidate_Input_Files(isUpdate, isFCRA, pVersion)
																	);

	export All :=
												if(VersionControl.IsValidVersion(pversion)
													,full_build
													,output('No Valid version parameter passed, skipping build')
												);

end;