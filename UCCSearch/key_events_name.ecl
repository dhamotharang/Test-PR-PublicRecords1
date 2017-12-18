
import data_services;


base_file_1 := UCCSearch.File_In_Events(trim(ucc_vendor,left,right)!='');


export key_events_name := index(base_file_1,{ucc_vendor},{base_file_1},data_services.data_location.prefix() + 'thor_dell400_2::key::ucc_vendor_all');

