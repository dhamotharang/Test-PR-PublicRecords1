//Defines full build process
import _control, versioncontrol, inql_ffd;

export proc_Build_Base(
											boolean isUpdate = true
									, 	boolean isFCRA = true
									, 	string pVersion = ''				
									) :=

module
   
	export daily_base		:= Inql_FFD.Update_Base(isUpdate, isFCRA, pversion).daily_base; 
  
	VersionControl.macBuildNewLogicalFile( 
																				 Inql_FFD.Filenames(isUpdate, isFCRA, pversion).base.new	
																				,daily_base
																				,Build_Base_File
																			 );
	
	export base_encrypted		:= Inql_FFD.Update_Base(isUpdate, isFCRA, pversion).daily_base_encrypted;
  VersionControl.macBuildNewLogicalFile( 
																				 Inql_FFD.Filenames(isUpdate, isFCRA, pversion, true).base.new	
																				,base_encrypted
																				,Build_Base_File_Encrypted
																			 );																															

	export full_build :=
												sequential(
																	 move_files(isUpdate, isFCRA, pVersion).Current_To_In_Building
																	,Build_Base_File
																	,Build_Base_File_Encrypted
																	// ,Promote(isUpdate, isFCRA, pversion).buildfiles.New2Built
																	// ,Promote(isUpdate, isFCRA, pversion).buildfiles.Built2qa
																//	,move_files(isUpdate, isFCRA, pVersion).In_Building_to_Built
																	// ,fn_Consolidate_Input_Files(isUpdate, isFCRA, pVersion)
																	);

	export All :=
												if(VersionControl.IsValidVersion(pversion)
													,full_build
													,output('No Valid version parameter passed, skipping build')
												);

end;