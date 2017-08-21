import versioncontrol,tools, hms_SureScripts;

export Filenames_SpecCodes(string pversion = '', boolean pUseProd = false) := module
	EXPORT lSpecCodesTemplate_Built := _Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().Specialty_name + '::built';
	export lSpecCodesBaseTemplate	:= 	_Dataset(pUseProd).thor_cluster_files + 'base::' + _Dataset().Specialty_name+ '::@version@';
	export lSpecCodesInputTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().Specialty_name ;
	export lSpecCodesInputHistTemplate := _Dataset(pUseProd).thor_cluster_files + 'in::' + _Dataset().Specialty_name + '::history';
	export Base		  := tools.mod_FilenamesBuild(lSpecCodesBaseTemplate, pversion);
  
	
	export dAll_filenames :=  Base.dAll_filenames;
end;
