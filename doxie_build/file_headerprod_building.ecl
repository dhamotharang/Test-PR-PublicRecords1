import header, lib_fileservices,_control,ut;
boolean is_hdrbuild := false;
head0 := dataset('~thor_data400::Base::HeaderProdKey_Building',header.layout_header_v2, flat);

header.Mac_File_headers(head0,is_hdrbuild,head);
 
ut.mac_suppress_by_phonetype(head,phone,st,phone_suppression,true,did);

export file_headerprod_building := doxie_build.fn_file_header_building(phone_suppression) : persist('~thor_dell400_2::persist::file_headerprod_building',_control.TargetQueue.adl_400);