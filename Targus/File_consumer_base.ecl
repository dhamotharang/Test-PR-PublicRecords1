IMPORT	Targus, ut;
	dBaseFile	:=	DATASET('~thor_data400::base::consumer_targus',targus.layout_consumer_out,FLAT);
export File_consumer_base := dBaseFile;