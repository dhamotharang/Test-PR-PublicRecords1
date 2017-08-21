import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module
  export lBaseTemplate_built := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::built';
	export lBaseTemplate	:= 	_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::@version@';
	export lKeyTemplate	  := 	_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::@version@';	
	export lInputTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name ;
	export lInputHistTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::history';	
	export Base		  := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
	//EXPORT Base_SpecCodes := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::built';
	
	export dAll_filenames :=  Base.dAll_filenames;
end;
