IMPORT CMS_AddOn, tools;

EXPORT Filenames(STRING  pversion = '',
                 BOOLEAN pUseProd = FALSE) := MODULE

  EXPORT lBaseTemplate_built := CMS_AddOn._Dataset(pUseProd).thor_cluster_files + 'base::' + CMS_AddOn._Dataset().name + '::built::REF_ADD_ON_PROC_CD';
	EXPORT lBaseTemplate	     := CMS_AddOn._Dataset(pUseProd).thor_cluster_files + 'base::' + CMS_AddOn._Dataset().name+ '::@version@::REF_ADD_ON_PROC_CD';
	EXPORT lInputTemplate      := CMS_AddOn._Dataset(pUseProd).thor_cluster_files + 'in::' + CMS_AddOn._Dataset().name + IF(pversion != '', '::' + pversion, '') + '::data';
	EXPORT lInputHistTemplate  := CMS_AddOn._Dataset(pUseProd).thor_cluster_files + 'in::' + CMS_AddOn._Dataset().name + '::data::history';
	EXPORT Base                := tools.mod_FilenamesBuild(lBaseTemplate, pversion);

	EXPORT base_dAll_filenames := Base.dAll_filenames;

END;
