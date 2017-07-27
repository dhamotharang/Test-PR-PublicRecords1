import versioncontrol,tools;

export Filenames(string pversion = '', boolean pUseProd = false) := module
  export lBaseTemplate_built := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::built';
	export lBaseTemplate	:= 	_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::@version@';
	export lKeyTemplate	  := 	_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::@version@';		
	export lInputLtTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::lt';
	export lInputPdTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::pd';
	export lInputLtHistTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::lt_history';
	export lInputPdHistTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::pd_history';
	export Base		  := tools.mod_FilenamesBuild(lBaseTemplate, pversion);
  
	
	export dAll_filenames :=
		   Base.dAll_filenames		 
	;


end;
