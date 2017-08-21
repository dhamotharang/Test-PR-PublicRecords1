import _control, tools, versioncontrol;

export Filenames(string  pname    = '',
								 string  pversion = '',
								 boolean pUseProd = false
) :=
module
		export lInputTemplate				 	 := prte_bip._Dataset().thor_cluster_files + 'in::' 			+ _Dataset().name	+ '::' + pname + '::@version@' + '::data';
		export lBaseTemplate					 := prte_bip._Dataset().thor_cluster_files + 'base::' 		+ _Dataset().name + '::' + pname + '::@version@' + '::data';
		export lKeybuildTemplate			 := prte_bip._Dataset().thor_cluster_files + 'temp::' 		+ _Dataset().name + '::' + pname + '::@version@' + '::data';		

		export Input   								 :=  tools.mod_FilenamesInput(lInputTemplate,	pversion);

		export dAll_Input_filenames 	 :=  Input.dAll_filenames;
		
		export Base    								 :=  versioncontrol.mBuildFilenameVersions(lBaseTemplate,pversion);		
		export dAll_Base_filenames 		 :=  Base.dAll_filenames;						
		
		export Keybuild								 :=  versioncontrol.mBuildFilenameVersions(lKeybuildTemplate,pversion);		
		export dAll_Keybuild_filenames :=  Keybuild.dAll_filenames;						
                                                     
end;