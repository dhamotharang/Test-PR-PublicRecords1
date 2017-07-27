IMPORT versioncontrol,tools;

EXPORT Filenames(string pversion = '', boolean pUseProd = false) := module

  
	EXPORT trgtharv_lInputTemplate 						:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::trgt_harv_results::' + pVersion;
	EXPORT trgtharv_lInputHistTemplate 				:= _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().name + '::history';

	EXPORT koptrgtharv_lBaseTemplate_built 			:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '::trgt_harv_results::built';
	EXPORT koptrgtharv_lBaseTemplate							:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name+ '::trgt_harv_results::@version@';
	EXPORT koptrgtharv_lKeyTemplate	  					:= _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().name + '_keybuild' + '::trgt_harv_results::@version@';
	
	EXPORT koptrgtharv_Base		  								:= tools.mod_FilenamesBuild(koptrgtharv_lBaseTemplate, pversion);
	
	EXPORT dAll_filenames := koptrgtharv_Base.dAll_filenames;

END;
