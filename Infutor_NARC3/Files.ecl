
IMPORT	tools, ut;
// EXPORT Files(	STRING	pVersion	=	'',
							// BOOLEAN	pUseProd	=	FALSE) := MODULE
							
EXPORT Files := MODULE	

	EXPORT	Input	:=  DATASET(Infutor_NARC3.Filenames().Input.WithdrawnStatus.Used, Infutor_NARC3.Layout_Infile, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['"'])));
	EXPORT	base	:=  DATASET(Infutor_NARC3.Filenames().base.WithdrawnStatus.qa, Infutor_NARC3.Layout_Basefile, THOR, OPT);
 
END;


//In_federal_bureau_base := Fed_Bureau_Prisons.file_federal_bureau_base;