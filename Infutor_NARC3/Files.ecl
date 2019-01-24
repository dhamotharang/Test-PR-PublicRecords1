
IMPORT	tools, ut;
							
EXPORT Files := MODULE	

	EXPORT	Input	:=  DATASET(Infutor_NARC3.Filenames().Input.consumer.Used, Infutor_NARC3.Layout_Infile, csv( separator('\t'),heading(1), terminator(['\n', '\r\n']), quote(['"'])));
	EXPORT	base	:=  DATASET(Infutor_NARC3.Filenames().base.consumer.qa, Infutor_NARC3.Layout_Basefile, THOR, OPT);
 
END;

