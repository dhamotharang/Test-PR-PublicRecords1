
IMPORT	tools, ut;
EXPORT Files(	STRING	pFilename	=	'',
							BOOLEAN	pUseProd	=	FALSE) := MODULE

	EXPORT	Input_Raw	:=  DATASET(Infutor_NARC3.Filenames().Input.Sprayed, Infutor_NARC3.Layout_Infile, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['"'])));
	EXPORT	base				:=  DATASET(Infutor_NARC3.Filenames().Base.qa, Infutor_NARC3.Layout_Basefile, THOR, OPT);

END;


