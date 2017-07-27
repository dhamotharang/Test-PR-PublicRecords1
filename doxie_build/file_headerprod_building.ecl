import header, lib_fileservices;

head := dataset('~thor_data400::Base::HeaderProdKey_Building', header.Layout_Header, flat);

export file_headerprod_building := doxie_build.fn_file_header_building(head) : persist('~thor_dell400_2::persist::file_headerprod_building','thor_dell400_2');