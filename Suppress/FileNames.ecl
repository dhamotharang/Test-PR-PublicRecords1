IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

	EXPORT OptOut := MODULE	
		EXPORT STRING thorCluster	:= 'thor::';
		EXPORT STRING name 					:= 'new_suppression::opt_out'; 
		EXPORT	lInputTemplate				:=	'~' + thorCluster + 'in::'		+	name	+	'::@version@::data';
		EXPORT	lBaseTemplate				:=	'~' + thorCluster + 'base::'	+	name +	'::data';

		EXPORT	Input										:=	versioncontrol.mInputFilenameVersions(lInputTemplate);
		EXPORT	Base											:=	'~' + thorCluster + 'base::'	+	name;
	END;
	
END;