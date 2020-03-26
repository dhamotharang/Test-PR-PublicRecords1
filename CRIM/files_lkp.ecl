IMPORT crim, data_services;
EXPORT files_lkp := MODULE

	EXPORT	Pasco_Crim	:= dataset(data_services.foreign_prod+'thor_data400::lookup::crim::fl_pasco_statute::pasco_statutes.txt',CRIM.layout_fl_pasco.statute_lkp,flat);
	EXPORT	Pasco_Traffic   := dataset(data_services.foreign_prod+'thor_data400::lookup::crim::fl_pasco_statute::pasco_traffic_statute.txt',CRIM.layout_fl_pasco_traffic.statute_lkp,flat);
	EXPORT	Lake_Traffic	:= dataset(data_services.foreign_prod+'thor_data400::lookup::crim::fl_lake_statute::lake_traffic_statute.txt',CRIM.layout_FL_Lake_traffic.statute_lkp,flat);
	
END;