import roxiekeybuild,relocations,ut;

export proc_build_history_keys_bells_only_jtrost(string rundate) := function

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Address,'~thor_data400::key::gong_history_address_bells_only','~thor_data400::key::gong_history::'+rundate+'::address_bells_only',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Phone,'~thor_data400::key::gong_history_phone_bells_only','~thor_data400::key::gong_history::'+rundate+'::phone_bells_only',bk_phone);								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Did,'~thor_data400::key::gong_history_did_bells_only','~thor_data400::key::gong_history::'+rundate+'::did_bells_only',bk_did);								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Hhid,'~thor_data400::key::gong_history_hhid_bells_only','~thor_data400::key::gong_history::'+rundate+'::hhid_bells_only',bk_hhid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_BDID,'~thor_Data400::key::gong_hist_bdid_bells_only','~thor_data400::key::gong_history::'+rundate+'::bdid_bells_only',bk_bdid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Name,'~thor_data400::key::gong_history_name_bells_only','~thor_data400::key::gong_history::'+rundate+'::name_bells_only',bk_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_zip_name,'~thor_data400::key::gong_history_zip_name_bells_only','~thor_data400::key::gong_history::'+rundate+'::zip_name_bells_only',bk_zip_name);					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_npa_nxx_line,'~thor_data400::key::gong_history_npa_nxx_line_bells_only','~thor_data400::key::gong_history::'+rundate+'::npa_nxx_line_bells_only',bk_npa_nxx_line);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Surname,'~thor_data400::key::gong_history::qa::surnames_bells_only','~thor_data400::key::gong_history::'+rundate+'::surnames_bells_only',bk_surname);					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Relocations.key_wdtgGong,'~thor_data400::key::gong_history_wdtg_bells_only','~thor_data400::key::gong_history::'+rundate+'::wdtg_bells_only',bk_wdtg);					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_companyname,'~thor_data400::key::gong_history_companyname_bells_only','~thor_data400::key::gong_history::'+rundate+'::companyname_bells_only',bk_cmp_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_city_st_name,'~thor_data400::key::gong_history_city_st_name_bells_only','~thor_data400::key::gong_history::'+rundate+'::city_st_name_bells_only',bk_csn);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_address_bells_only','~thor_data400::key::gong_history::'+rundate+'::address',mv1_addr);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_phone_bells_only','~thor_data400::key::gong_history::'+rundate+'::phone',mv1_phone);								 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_did_bells_only','~thor_data400::key::gong_history::'+rundate+'::did',mv1_did);								 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_hhid_bells_only','~thor_data400::key::gong_history::'+rundate+'::hhid',mv1_hhid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_Data400::key::gong_hist_bdid_bells_only','~thor_data400::key::gong_history::'+rundate+'::bdid',mv1_bdid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_name_bells_only','~thor_data400::key::gong_history::'+rundate+'::name',mv1_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_zip_name_bells_only','~thor_data400::key::gong_history::'+rundate+'::zip_name',mv1_zip_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_npa_nxx_line_bells_only','~thor_data400::key::gong_history::'+rundate+'::npa_nxx_line',mv1_npa_nxx_line);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::@version@::surnames_bells_only','~thor_data400::key::gong_history::'+rundate+'::surnames',mv1_surname);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_wdtg_bells_only','~thor_data400::key::gong_history::'+rundate+'::wdtg',mv1_wdtg);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_companyname_bells_only','~thor_data400::key::gong_history::'+rundate+'::companyname',mv1_cmp_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_city_st_name_bells_only','~thor_data400::key::gong_history::'+rundate+'::city_st_name',mv1_csn);
								 
bk := parallel(bk_addr,bk_phone,bk_did,bk_hhid,bk_bdid,bk_name,bk_zip_name,bk_npa_nxx_line,bk_surname,bk_wdtg,bk_cmp_name, bk_csn);

mv1 := parallel(mv1_addr,mv1_phone,mv1_did,mv1_hhid,mv1_bdid,mv1_name,mv1_zip_name,mv1_npa_nxx_line,mv1_surname,mv1_wdtg,mv1_cmp_name,mv1_csn);

ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_address_bells_only','Q',mk_addr);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_phone_bells_only','Q',mk_phone);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_did_bells_only','Q',mk_did);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_hhid_bells_only','Q',mk_hhid);
ut.MAC_SK_Move_v2('~thor_Data400::key::gong_hist_bdid_bells_only','Q',mk_bdid);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_name_bells_only','Q',mk_name);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_zip_name_bells_only','Q',mk_zip_name);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_npa_nxx_line_bells_only','Q',mk_npa_nxx_line);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::gong_history::@version@::surnames_bells_only','Q',mk_surname);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_wdtg_bells_only','Q',mk_wdtg);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_companyname_bells_only','Q',mk_cmp_name);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_city_st_name_bells_only','Q',mk_csn);

mk := parallel(mk_addr,mk_phone,mk_did,mk_hhid,mk_bdid,mk_name,mk_zip_name,mk_npa_nxx_line,mk_surname,mk_wdtg,mk_cmp_name,mk_csn);

build_keys := sequential(bk,mv1,mk);

return build_keys;

end;