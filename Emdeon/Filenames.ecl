IMPORT versioncontrol,tools,Emdeon;

EXPORT Filenames(STRING pVersion = '', BOOLEAN pUseProd = FALSE) := MODULE

	EXPORT orig_lInputTemplate							:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::' 			+ Emdeon._Dataset().name + '::orig_consolidated';
	EXPORT orig_lConsolTemplate							:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'  		+ Emdeon._Dataset().name + '::orig_consolidated::' + pVersion;
	EXPORT raw_lInputTemplate								:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::' 			+ Emdeon._Dataset().name + '::' + pVersion;
	EXPORT orig_lInputHistTemplate					:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'			+ Emdeon._Dataset().name + '::orig_consolidated::history';

  EXPORT claims_lBaseTemplate_built				:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'base::' 		+ Emdeon._Dataset().name + '::claim_level::built';
	EXPORT claims_lBaseTemplate							:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'base::' 		+ Emdeon._Dataset().name	+ '::claim_level::@version@';
	EXPORT claims_lInputTemplate 						:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::claim_level' ;
	EXPORT claims_lInputVersionTemplate			:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name	+ '::claim_level::' + pVersion;
	EXPORT claims_lInputHistTemplate 				:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::claim_level::history';
	EXPORT claims_lInputPreTemplate 				:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name;
	EXPORT claims_lPersistTemplate 					:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'persist::' + Emdeon._Dataset().name + '::claim_level' + pVersion ;
	EXPORT claims_Base		  								:= tools.mod_FilenamesBuild(claims_lBaseTemplate, pVersion);
  
  EXPORT splits_lBaseTemplate_built				:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'base::' 		+ Emdeon._Dataset().name + '::split_level::built';
	EXPORT splits_lBaseTemplate							:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'base::' 		+ Emdeon._Dataset().name	+ '::split_level::@version@';
	EXPORT splits_lInputTemplate 						:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::split_level' ;
	EXPORT splits_lInputVersionTemplate 		:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::split_level::' + pVersion ;
	EXPORT splits_lInputHistTemplate 				:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::split_level::history';
	EXPORT splits_lPersistTemplate 					:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'persist::' + Emdeon._Dataset().name + '::split_level' + pVersion ;
	EXPORT splits_Base		  								:= tools.mod_FilenamesBuild(splits_lBaseTemplate, pVersion);
  
  EXPORT detail_lBaseTemplate_built				:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'base::' 		+ Emdeon._Dataset().name + '::detail_level::built';
	EXPORT detail_lBaseTemplate							:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'base::' 		+ Emdeon._Dataset().name + '::detail_level::@version@';
	EXPORT detail_lInputTemplate 						:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::detail_level' ;
	EXPORT detail_lInputVersionTemplate 		:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::detail_level::' + pVersion ;
	EXPORT detail_lInputHistTemplate 				:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'in::'   		+ Emdeon._Dataset().name + '::detail_level::history';
	EXPORT detail_lPersistTemplate 					:= Emdeon._Dataset(pUseProd).thor_cluster_files + 'persist::' + Emdeon._Dataset().name + '::detail_level' + pVersion ;
	EXPORT detail_Base		  								:= tools.mod_FilenamesBuild(detail_lBaseTemplate, pVersion);

END;

