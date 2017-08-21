import doxie, tools;
export Rename_Gong_Keys(string keydate,
												boolean	pIsTesting = true // true - just outputs the keys; false - renames keys.
) := function

#workunit('name','Rename GongKeys keydate');

//Change date to build date to rename these keys.
all_superkeynames := DATASET([
{'~thor_200::base::gongv2_master','~thor_200::base::'+keydate+'::lss_master'},
{'~thor_data400::base::gong','~thor_200::base::lss_gong'+keydate},
{'~thor_data400::base::gong_built','~thor_200::base::lss_gong'+keydate},
{'~thor_data400::base::gong_history','~thor_200::base::gong_history'+keydate},
{'~thor_data400::key::gong_history_address_qa','~thor_data400::key::gong_history::'+keydate+'::address'},
{'~thor_data400::key::gong_history_phone_qa','~thor_data400::key::gong_history::'+keydate+'::phone'},
{'~thor_data400::key::gong_history_did_qa','~thor_data400::key::gong_history::'+keydate+'::did'},
{'~thor_data400::key::gong_history_hhid_qa','~thor_data400::key::gong_history::'+keydate+'::hhid'},
{'~thor_data400::key::gong_hist_bdid_qa','~thor_data400::key::gong_history::'+keydate+'::bdid'},
{'~thor_data400::key::gong_history_name_qa','~thor_data400::key::gong_history::'+keydate+'::name'},
{'~thor_data400::key::gong_history_zip_name_qa','~thor_data400::key::gong_history::'+keydate+'::zip_name'},
{'~thor_data400::key::gong_history_npa_nxx_line_qa','~thor_data400::key::gong_history::'+keydate+'::npa_nxx_line'},
{'~thor_data400::key::gong_history::built::surnames','~thor_data400::key::gong_history::'+keydate+'::surnames'},
{'~thor_data400::key::gong_history::qa::surnames','~thor_data400::key::gong_history::'+keydate+'::surnames'},
{'~thor_data400::key::gong_history_wdtg_qa','~thor_data400::key::gong_history::'+keydate+'::wdtg'},
{'~thor_data400::key::gong_history_companyname_qa','~thor_data400::key::gong_history::'+keydate+'::companyname'},
{'~thor_data400::key::gong_history_city_st_name_qa','~thor_data400::key::gong_history::'+keydate+'::city_st_name'},
{'~thor_data400::key::gong_history_wild_name_zip_qa','~thor_data400::key::gong_history::'+keydate+'::wild_name_zip'},

{'~thor_data400::key::gong_did_built','~thor_data400::key::gong_weekly::'+keydate+'::did'},
{'~thor_data400::key::gong_did_qa','~thor_data400::key::gong_weekly::'+keydate+'::did'},
{'~thor_data400::key::gong_bdid_qa','~thor_data400::key::gong_weekly::'+keydate+'::bdid'},
{'~thor_data400::key::gong_bdid_built','thor_data400::key::gong_weekly::'+keydate+'::bdid'},
{'~thor_data400::key::cbrs.phone10_gong_qa','~thor_data400::key::gong_weekly::'+keydate+'::cbrs.phone10_gong'},
{'~thor_data400::key::gong_address_current_qa','~thor_data400::key::gong_weekly::'+keydate+'::address_current'},
{'~thor_data400::key::gong_address_current_built','~thor_data400::key::gong_weekly::'+keydate+'::address_current'}, 
{'~thor_data400::key::gong_cn_qa','~thor_data400::key::gong_weekly::'+keydate+'::cn'},
{'~thor_data400::key::gong_cn_built','~thor_data400::key::gong_weekly::'+keydate+'::cn'},
{'~thor_data400::key::gong_cn_to_company_qa','~thor_data400::key::gong_weekly::'+keydate+'::cn_to_company'},
{'~thor_data400::key::gong_cn_to_company_built','~thor_data400::key::gong_weekly::'+keydate+'::cn_to_company'},
{'~thor_data400::key::gong_czsslf_qa','~thor_data400::key::gong_weekly::'+keydate+'::czsslf'},
{'~thor_data400::key::gong_czsslf_built','~thor_data400::key::gong_weekly::'+keydate+'::czsslf'},
{'~thor_data400::key::gong_eda_npa_nxx_line_qa','~thor_data400::key::gong_weekly::'+keydate+'::eda_npa_nxx_line'},
{'~thor_data400::key::gong_eda_npa_nxx_line_built','~thor_data400::key::gong_weekly::'+keydate+'::eda_npa_nxx_line'},
{'~thor_data400::key::gong_eda_st_bizword_city_qa','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_bizword_city'},
{'~thor_data400::key::gong_eda_st_bizword_city_built','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_bizword_city'},
{'~thor_data400::key::gong_eda_st_city_prim_name_prim_range_qa','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_city_prim_name_prim_range'},
{'~thor_data400::key::gong_eda_st_city_prim_name_prim_range_built','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_city_prim_name_prim_range'},
{'~thor_data400::key::gong_eda_st_lname_city_qa','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_lname_city'},
{'~thor_data400::key::gong_eda_st_lname_city_built','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_lname_city'},
{'~thor_data400::key::gong_eda_st_lname_fname_city_qa','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_lname_fname_city'},
{'~thor_data400::key::gong_eda_st_lname_fname_city_built','~thor_data400::key::gong_weekly::'+keydate+'::eda_st_lname_fname_city'},
{'~thor_data400::key::gong_hhid_qa','~thor_data400::key::gong_weekly::'+keydate+'::hhid'},
{'~thor_data400::key::gong_hhid_built','~thor_data400::key::gong_weekly::'+keydate+'::hhid'},
{'~thor_data400::key::gong_lczf_qa','~thor_data400::key::gong_weekly::'+keydate+'::lczf'},
{'~thor_data400::key::gong_lczf_built','~thor_data400::key::gong_weekly::'+keydate+'::lczf'},
{'~thor_data400::key::gong_phone_qa','~thor_data400::key::gong_weekly::'+keydate+'::phone'},
{'~thor_data400::key::gong_phone_built','~thor_data400::key::gong_weekly::'+keydate+'::phone'},
{'~thor_data400::key::gong_surnamecnt_qa','~thor_data400::key::gong_weekly::'+keydate+'::surnamecnt'},
{'~thor_data400::key::gong_surnamecnt_built','~thor_data400::key::gong_weekly::'+keydate+'::surnamecnt'},
{'~thor_data400::key::phone_table_filtered_v2_qa','~thor_data400::key::business_header::filtered::'+keydate+'::hri::phone10_v2'},
{'~thor_data400::key::phone_table_filtered_v2_built','~thor_data400::key::business_header::filtered::'+keydate+'::hri::phone10_v2'},
{'~thor_data400::key::phone_table_v2_qa','~thor_data400::key::business_header::'+keydate+'::hri::phone10_v2'},
{'~thor_data400::key::phone_table_v2_built','~thor_data400::key::business_header::'+keydate+'::hri::phone10_v2'},
{'~thor_data400::key::gong_history_cleanname_qa','~thor_data400::key::gong_history::'+keydate+'::cleanname'},
{'~thor_data400::key::gong_history_linkids_qa','~thor_data400::key::gong_history::'+keydate+'::linkids'},
{'~thor_data400::key::gong::qa::zip','~thor_data400::key::gong::'+keydate+'::zip'},
{'~thor_data400::key::gong::qa::npa','~thor_data400::key::gong::'+keydate+'::npa'},
{'~thor_data400::key::gong_scoring_qa','~thor_data400::key::gong_scoring::'+keydate+'::phone_nm'}
], Tools.Layout_SuperFilenames.InputLayout);

retval := tools.fun_RenameFiles(all_superkeynames, pIsTesting);
       
return retval;
end;