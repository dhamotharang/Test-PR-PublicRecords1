IMPORT	tools,	BIPV2_Best;
EXPORT	Files(STRING	pversion	=	'',
							BOOLEAN	pUseProd	=	FALSE)	:=	MODULE

tools.mac_FilesBase	(filenames(pversion,pUseProd).base.bipv2_best	,BIPV2_Best.Layouts.base		,base);

END;
