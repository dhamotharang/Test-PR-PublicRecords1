import doxie_build, lib_fileservices, header_services, DriversV2, Header, ut;

base := dataset('~thor_data400::base::DL2::DLSearchPlus_'+ doxie_build.buildstate, DriversV2.Layout_Drivers_Extended, flat);  //production dataset

export File_DL_Search_Extended := Header.fn_dlamxtnd(base);