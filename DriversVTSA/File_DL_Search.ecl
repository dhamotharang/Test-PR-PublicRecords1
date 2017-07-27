import doxie_build, lib_fileservices, header_services, DriversV2;

rec := RECORD
	DriversV2.Layout_Drivers;	
END;


export File_DL_Search := DATASET('~thor400_92::base::scankdl::' + filedate + '::DLSearch', rec, flat);;
