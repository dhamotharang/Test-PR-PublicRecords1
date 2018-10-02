//	Needed in file_liens_fcra_main
IMPORT	LiensV2_SrcInfoRpt, tools, ut;
EXPORT Files(	STRING	pFilename	=	'',
							BOOLEAN	pUseProd	=	FALSE) := MODULE
							
	EXPORT	SourceInformationReport	:=	DATASET(
																				pFilename, LiensV2_SrcInfoRpt.Layouts.rSourceInformationReport, 
																					CSV(HEADING(1),
																							SEPARATOR([',']),
																							QUOTE('\"'),
																							TERMINATOR(['\n','\r\n','\n\r']))
																			);

	EXPORT	SuppressedJurisdictions	:=	DATASET(
																				IF(pFilename='',LiensV2_SrcInfoRpt.Filenames(pUseProd:=pUseProd).Base.SuppressedJurisdictions.QA,pFilename)
																				,LiensV2_SrcInfoRpt.Layouts.rSuppressedJurisdictions,THOR,__compressed__
																			);																
END;
