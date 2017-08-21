import doxie_build, lib_fileservices, header_services, DriversV2, Header, ut;

base := dataset('~thor_data400::base::DL2::DLSearch_'+ doxie_build.buildstate, DriversV2.Layout_Drivers, flat);  //production dataset

export File_DL_Search := Header.fn_dlam(base);
