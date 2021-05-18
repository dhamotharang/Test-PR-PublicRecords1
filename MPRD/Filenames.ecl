import versioncontrol,tools,MPRD;

export Filenames(string pversion = '', boolean pUseProd = false) := module
  export individual_lBaseTemplate_built  									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::individual::built';
	export individual_lBaseTemplate	       									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::individual::@version@';
	export individual_lKeyTemplate	       									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::individual::@version@';	
	export individual_lInputTemplate       									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'	 + MPRD._Dataset().name + '::individual' ;
	export individual_lInputHistTemplate   									:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::' 	 + MPRD._Dataset().name + '::individual::history';
	export individual_Base		             									:= tools.mod_FilenamesBuild(individual_lBaseTemplate, pversion);
	export individual_Input 														  	:= versioncontrol.mInputFilenameVersions(individual_lInputTemplate);

  export taxonomy_full_lu_lBaseTemplate_built 	 					:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxonomy_full_lu::built';
  export taxonomy_full_lu_lBaseTemplate        						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '::taxonomy_full_lu::@version@';
  export taxonomy_full_lu_lKeyTemplate         						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'base::' + MPRD._Dataset().name + '_keybuild::taxonomy_full_lu::@version@';      
  export taxonomy_full_lu_lInputTemplate       						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxonomy_full_lu ' ;
  export taxonomy_full_lu_lInputHistTemplate   						:= MPRD._Dataset(pUseProd).thor_cluster_files + 'in::'   + MPRD._Dataset().name + '::taxonomy_full_lu::history';
  export taxonomy_full_lu_Base                 						:= tools.mod_FilenamesBuild(taxonomy_full_lu_lBaseTemplate, pversion);
	export taxonomy_full_lu_input 													:= versioncontrol.mInputFileNameVersions(taxonomy_full_lu_lInputTemplate);
	
end;
