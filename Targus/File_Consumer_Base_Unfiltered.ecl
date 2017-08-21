IMPORT	Targus, ut;
	dBaseFile	:=	DATASET('~thor_data400::base::consumer_targus_unfiltered',targus.layout_consumer_out_unfiltered,FLAT);
export File_Consumer_Base_Unfiltered := dBaseFile;