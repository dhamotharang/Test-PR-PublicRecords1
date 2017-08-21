EXPORT files_extract := MODULE

	export file_compid_extract_deletes	:=	DATASET('~thor_data400::out::death_master::compid::deletes', layouts_extract.layout_compid_extract, THOR);		

END;