IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT	lInputTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'in::'			+	_Dataset().name	+	'::@version@::data';
	EXPORT	lBaseTemplate	:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name +	'::data';

	EXPORT	Input						:=	versioncontrol.mInputFilenameVersions(lInputTemplate);
	EXPORT	Base							:=	_Dataset(pUseProd).thor_cluster_files	+	'base::'	+	_Dataset().name;

END;
