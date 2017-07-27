import tools;
EXPORT filenames(string pversion = '') :=
module
	export base := tools.mod_FilenamesBuild('~thor_data400::base::bipv2_best::@version@'	,pversion);
	export dall_filenames := base.dall_filenames;
end;
