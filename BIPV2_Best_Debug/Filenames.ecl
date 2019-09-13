IMPORT	versioncontrol;
EXPORT	Filenames(STRING	pversion	=	'',
									BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

  EXPORT  Base            :=  versioncontrol.mBuildFilenameVersions(BIPV2_Best_Debug._Constants(pUseProd).thor_cluster_files	+	'base::'	+	BIPV2_Best_Debug._Constants().name	+	'::@version@'	,pversion);
  EXPORT  dall_filenames	:=	Base.dAll_filenames;
END;