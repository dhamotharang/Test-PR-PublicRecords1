IMPORT versioncontrol,tools,hxmx;

EXPORT Filenames(STRING pVersion = '', BOOLEAN pUseProd = FALSE) := MODULE
  EXPORT hx_lBaseTemplate_built				:= hxmx._Dataset(pUseProd).thor_cluster_files + 'base::' + hxmx._Dataset().name + '::hx_level::built';
	EXPORT hx_lBaseTemplate							:= hxmx._Dataset(pUseProd).thor_cluster_files + 'base::' + hxmx._Dataset().name	+ '::hx_level::@version@';
	EXPORT hx_lInputTemplate 						:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'   + hxmx._Dataset().name + '::hx_level' ;
	EXPORT hx_lInputHistTemplate 				:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'   + hxmx._Dataset().name + '::hx_level::history';
	EXPORT hx_lDeleteTemplate 					:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'   + hxmx._Dataset().name + '::hx_level::delete';
	EXPORT hx_lPersistTemplate 					:= hxmx._Dataset(pUseProd).thor_cluster_files + 'persist::'   + hxmx._Dataset().name + '::hx_level::' + pVersion;
	EXPORT hx_Base		  								:= tools.mod_FilenamesBuild(hx_lBaseTemplate, pVersion);

  EXPORT mx_lBaseTemplate_built				:= hxmx._Dataset(pUseProd).thor_cluster_files + 'base::' + hxmx._Dataset().name + '::mx_level::built';
	EXPORT mx_lBaseTemplate							:= hxmx._Dataset(pUseProd).thor_cluster_files + 'base::' + hxmx._Dataset().name	+ '::mx_level::@version@';
	EXPORT mx_lInputTemplate 						:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'   + hxmx._Dataset().name + '::mx_level' ;
	EXPORT mx_lInputHistTemplate 				:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'   + hxmx._Dataset().name + '::mx_level::history';
	EXPORT mx_lDeleteTemplate 					:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'   + hxmx._Dataset().name + '::mx_level::delete';
	EXPORT mx_lPersistTemplate 					:= hxmx._Dataset(pUseProd).thor_cluster_files + 'persist::'   + hxmx._Dataset().name + '::mx_level::' + pVersion;
	EXPORT mx_Base		  								:= tools.mod_FilenamesBuild(mx_lBaseTemplate, pVersion);

	EXPORT hx_consol_lInputTemplate			:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::' 	+ hxmx._Dataset().name + '::hx_consolidated';
	EXPORT hx_consol_lConsolTemplate		:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'  + hxmx._Dataset().name + '::hx_consolidated::' + pVersion;
	EXPORT hx_consol_lInputHistTemplate	:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'  + hxmx._Dataset().name + '::hx_consolidated::history';
	EXPORT hx_consol_lInputHistDelete		:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'  + hxmx._Dataset().name + '::hx_consolidated::history_delete';

	EXPORT mx_consol_lInputTemplate			:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::' 	+ hxmx._Dataset().name + '::mx_consolidated';
	EXPORT mx_consol_lConsolTemplate		:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'  + hxmx._Dataset().name + '::mx_consolidated::' + pVersion;
	EXPORT mx_consol_lInputHistTemplate	:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'  + hxmx._Dataset().name + '::mx_consolidated::history';
	EXPORT mx_consol_lInputHistDelete		:= hxmx._Dataset(pUseProd).thor_cluster_files + 'in::'  + hxmx._Dataset().name + '::mx_consolidated::history_delete';

END;
