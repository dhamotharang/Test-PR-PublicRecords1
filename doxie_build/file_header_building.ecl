import header, lib_fileservices,_control,ut,AID;

head := dataset('~thor_data400::Base::HeaderKey_Building', header.Layout_Header_v2, flat);

ut.mac_suppress_by_phonetype(head,phone,st,phone_suppression,true,did);

head_bldg:=doxie_build.fn_file_header_building(phone_suppression);

header.macGetCleanAddr(head_bldg, RawAID, true, head_out); 

export file_header_building := distribute(head_out,hash(did)) : persist('~thor400_84::persist::file_header_building');
