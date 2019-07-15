IMPORT	FirstData;
EXPORT	Files(STRING		pFilename	=	'',
														BOOLEAN	pUseProd		=	FALSE) := MODULE

	EXPORT	file_in		:=	DATASET(IF(pFilename='',Filenames(,pUseProd).Input.Raw.Using,pFilename)
																					,layout.raw, CSV(SEPARATOR(','),HEADING(1),QUOTE('"'),TERMINATOR(['\n','\r\n'])));
 	EXPORT	file_base	:=	DATASET(IF(pFilename='',Filenames(,pUseProd).Base.firstdata.QA,pFilename)
																					,layout.base,THOR,__compressed__,OPT);

end;

