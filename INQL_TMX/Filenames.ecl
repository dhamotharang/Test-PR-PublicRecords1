import versioncontrol, tools;

export Filenames(string pversion = '', boolean pUseProd = false, boolean pIsFull = false) := module

  export buildFlagFile          := _Dataset(pUseProd).thor_cluster_files + 'out::TMX_build_flag';
  export buildHistoryFlagFile   := _Dataset(pUseProd).thor_cluster_files + 'out::TMX_build_history_flag';

  export lBaseTemplate_built    := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset(pUseProd, pIsFull).name + '::built';
	export lBaseTemplate	        := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset(pUseProd, pIsFull).name + '::@version@';

	export lKeyTemplate	          := _Dataset(pUseProd).thor_cluster_files + 'key::'  + _Dataset(pUseProd, pIsFull).name + '::@version@';		
	// ORIG - export lKeyTemplate	       := _Dataset(pUseProd).thor_cluster_files + 'key::'  + _Dataset(pUseProd, pIsFull).name + '_keybuild' + '::@version@';		
  
	export lInputTemplate         := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset(pUseProd).name ;
	export lInputHistTemplate     := _Dataset(pUseProd).thor_cluster_files + 'in::'   + _Dataset(pUseProd).name + '::history';
  
	export Input		              := tools.mod_FilenamesBuild(lInputTemplate, pversion, pnGenerations:=2);
	export Base		                := tools.mod_FilenamesBuild(lBaseTemplate, pversion, pnGenerations:=2);

	export dAll_filenames         := Base.dAll_filenames	;

end;
