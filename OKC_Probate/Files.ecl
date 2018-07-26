IMPORT	OKC_Probate,	Header;
EXPORT	Files(	STRING		pFilename	=	'',
														BOOLEAN	pUseProd		=	FALSE) := MODULE

	EXPORT	file_in			:=	DATASET(IF(pFilename='',Filenames(,pUseProd).Input.Raw.Using,pFilename)
																					,layout.raw, CSV(SEPARATOR(','),HEADING(0),QUOTE('"'),TERMINATOR('\r\n')));

	EXPORT	file_base	:=	DATASET(IF(pFilename='',Filenames(,pUseProd).Base.okcprobate.QA,pFilename)
																					,layout.base_raw,THOR,__compressed__,OPT);

	EXPORT	file_deathmasterv3	:=	DATASET(IF(pFilename='',Filenames(,pUseProd).Out.deathmasterv3.QA,pFilename)
																														,header.Layout_Did_Death_MasterV3,THOR,__compressed__,OPT);
 
end;

