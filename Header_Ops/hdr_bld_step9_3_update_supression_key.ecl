import header,doxie_build,mdr,data_services,RoxieKeybuild;
#workunit('name','Header: build pre_file_header_building key');
#OPTION ('multiplePersistInstances',FALSE);
blank_head := dataset([], header.Layout_Header_v2);
pre_file_header_building := doxie_build.fn_file_header_building(blank_head)(Header.Blocked_data_new());

k1_name := '~thor_data400::key::pre_file_header_building';

key_pre_file_header_building := index(pre_file_header_building,{pre_file_header_building.did},{pre_file_header_building},
                                 data_services.Data_location.person_header +k1_name);

build_it(string filedate) := function      
    RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(key_pre_file_header_building,k1_name,k1_name+'::'+filedate,k1);
    return k1;
end;

quick_header_for_supression := dataset(data_services.Data_location.prefix('default')+'thor_data400::base::quick_header', header.Layout_Header, thor);


full_key_and_qh := quick_header_for_supression+ pull(key_pre_file_header_building);

key_block_reference := index(full_key_and_qh,{pre_file_header_building.did},{pre_file_header_building},
                                 data_services.Data_location.person_header +k1_name);

pf := '~thor_data400::key::pre_file_header_building';
build_key(string filedatE) := sequential(
            
            build_it(filedate),
            FileServices.ClearSuperFile     (pf+'::built'                              ),
            fileservices.addsuperfile       (pf+'::built'          ,pf+'::'+filedate   )
            
            ) :success(fileservices.sendemail('Debendra.Kumar@lexisnexisrisk.com;gabriel.marcan@lexisnexisrisk.com','pre_file_header_building COMPLETED Prod:'+workunit,''))
              ,failure(fileservices.sendemail('Debendra.Kumar@lexisnexisrisk.com;gabriel.marcan@lexisnexisrisk.com','pre_file_header_building !!FAILED! Prod:'+workunit,FAILMESSAGE));

filedate := '20180724'; // RUN ON THOR (NOT ON hthor)
build_key(filedate);
/* STEP 4 build key   see W:\Workspaces\BWR_PublicRecordsHdr\hdr_bld_step9_3_update_supression_key.ecl */ /* this needs to be run afterwards */
// /* STEP 5 */ promote; // hthor /* this needs to be run afterwards */

// DO NOT USE THIS FOR "promote_key;" USE THE FOLLOWING "OTHER BWR":
// OTHER BWR: W:\Workspaces\BWR_PublicRecordsHdr\hdr_bld_step2_2_upd_suprsons.ecl
// Previous runs (document in other BWR)
// *** NOT HERE *** USE OTHER BWR *** NOT HERE *** USE OTHER BWR ***
// |SEE OTHER BWR   | NOT IN THIS BWR|OTR BWR |

//20180724 W20180907-103809
//20180522 W20180629-114846
