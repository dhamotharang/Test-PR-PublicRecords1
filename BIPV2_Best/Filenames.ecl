import tools;
EXPORT filenames(string pversion = ''	,boolean	pUseOtherEnvironment	= false) :=
module
	export base := tools.mod_FilenamesBuild(BIPV2_Best._Constants(pUseOtherEnvironment).prefix + 'thor_data400::base::bipv2_best::@version@'	,pversion);
	export dall_filenames := base.dall_filenames;
end;
