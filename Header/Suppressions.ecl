IMPORT doxie_build,mdr,data_services,RoxieKeybuild;
EXPORT Suppressions:= MODULE

EXPORT BuildNewReferenceKey(string filedate,string emailList) := FUNCTION

blank_head := dataset([], header.Layout_Header_v2);
pre_file_header_building := doxie_build.fn_file_header_building(blank_head)(Header.Blocked_data_new());

k1_name := '~thor_data400::key::pre_file_header_building';

key_pre_file_header_building := index(pre_file_header_building,{pre_file_header_building.did},{pre_file_header_building},
                                 data_services.Data_location.person_header +k1_name);

RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_pre_file_header_building,k1_name,k1_name+'::'+filedate,build_key);

quick_header_for_supression := dataset(data_services.Data_location.prefix('default')+'thor_data400::base::quick_header', header.Layout_Header, thor);


full_key_and_qh := quick_header_for_supression+ pull(key_pre_file_header_building);

key_block_reference := index(full_key_and_qh,{pre_file_header_building.did},{pre_file_header_building},
                                 data_services.Data_location.person_header +k1_name);

pf := '~thor_data400::key::pre_file_header_building';
build_it := sequential(
            
            build_key,
            FileServices.ClearSuperFile     (pf+'::built'                              ),
            fileservices.addsuperfile       (pf+'::built'          ,pf+'::'+filedate   )
            
            ) :success(fileservices.sendemail(emailList,'pre_file_header_building COMPLETED Prod:'+workunit,''))
              ,failure(fileservices.sendemail(emailList,'pre_file_header_building !!FAILED! Prod:'+workunit,FAILMESSAGE));

RETURN build_it;
END;
END;