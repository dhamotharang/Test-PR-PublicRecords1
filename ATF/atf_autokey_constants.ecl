IMPORT ut, Data_Services;
export atf_autokey_constants(string filedate='') := module
export str_autokeyname := Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::autokey::';
export ak_keyname	:= Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::autokey::@version@::';
export ak_logical	:= Data_Services.Data_location.Prefix('ATF')+'thor_data400::key::atf::firearms::'+filedate+'::autokey::';
export ak_dataset	:=  ATF.file_atf_firearms_autokey; //ATF.searchFileATF;/*ATF.file_firearms_explosives_keybase;*/
export ak_skipSet	:= ['P','Q','F'];
export ak_typeStr	:= 'BC';

export str_autokeyname_fcra := data_services.data_location.prefix('ATF') + 'thor_data400::key::atf::firearms::fcra::autokey::';
export ak_keyname_fcra	:= data_services.data_location.prefix('ATF') + 'thor_data400::key::atf::firearms::fcra::@version@::autokey::';
export ak_logical_fcra	:= '~thor_data400::key::atf::firearms::fcra::'+filedate+'::autokey::';
export ak_dataset_fcra	:=  ATF.file_atf_firearms_autokey; // there are no fcra restrictions

end;
