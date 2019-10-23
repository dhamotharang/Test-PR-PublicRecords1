import roxiekeybuild,relocations,ut,risk_indicators, doxie;
import ut,promotesupers,RoxieKeyBuild,DayBatchEda, risk_indicators, doxie_cbrs, watchdog, strata;

//g_did := Watchdog.DID_Gong;
//ut.mac_SF_Move('~thor_data400::base::gong_did','P',mv_gong2prod);


export proc_build_history_keys(string rundate) := function
		g_did := Watchdog.DID_Gong;
		ut.mac_SF_Move('~thor_data400::base::gong_did','P',mv_gong2prod);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_Address,'~thor_data400::key::gong_history_address','~thor_data400::key::gong_history::'+rundate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_Phone,'~thor_data400::key::gong_history_phone','~thor_data400::key::gong_history::'+rundate+'::phone',bk_phone);								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_Did,'~thor_data400::key::gong_history_did','~thor_data400::key::gong_history::'+rundate+'::did',bk_did);								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_Hhid,'~thor_data400::key::gong_history_hhid','~thor_data400::key::gong_history::'+rundate+'::hhid',bk_hhid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_BDID,'~thor_Data400::key::gong_hist_bdid','~thor_data400::key::gong_history::'+rundate+'::bdid',bk_bdid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_Name,'~thor_data400::key::gong_history_name','~thor_data400::key::gong_history::'+rundate+'::name',bk_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_history_zip_name,'~thor_data400::key::gong_history_zip_name','~thor_data400::key::gong_history::'+rundate+'::zip_name',bk_zip_name);					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_history_npa_nxx_line,'~thor_data400::key::gong_history_npa_nxx_line','~thor_data400::key::gong_history::'+rundate+'::npa_nxx_line',bk_npa_nxx_line);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_Surname,'~thor_data400::key::gong_history::qa::surnames','~thor_data400::key::gong_history::'+rundate+'::surnames',bk_surname);					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_wdtgGong,'~thor_data400::key::gong_history_wdtg','~thor_data400::key::gong_history::'+rundate+'::wdtg',bk_wdtg);					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_history_companyname,'~thor_data400::key::gong_history_companyname','~thor_data400::key::gong_history::'+rundate+'::companyname',bk_cmp_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_history_city_st_name,'~thor_data400::key::gong_history_city_st_name','~thor_data400::key::gong_history::'+rundate+'::city_st_name',bk_csn);
//
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_History_CleanName,'~thor_data400::key::gong_history_cleanname','~thor_data400::key::gong_history::'+rundate+'::cleanname',bk_clnname);
//cng - bug 38567
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_history_wild_name_zip,'~thor_data400::key::gong_history_wild_name_zip','~thor_data400::key::gong_history::'+rundate+'::wild_name_zip',bk_wnzip);
// Add BIPv2 LINKID key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_history_LinkIDs.key,'~thor_data400::key::gong_history_LinkIDs','~thor_data400::key::gong_history::'+rundate+'::LinkIDs',bk_LinkIDs);
// FCRA Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_Address,'~thor_data400::key::gong_history::fcra::@version@::address','~thor_data400::key::gong_history::fcra::'+rundate+'::address',bk_fcra_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_Phone,'~thor_data400::key::gong_history::fcra::@version@::phone','~thor_data400::key::gong_history::fcra::'+rundate+'::phone',bk_fcra_phone);								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_Did,'~thor_data400::key::gong_history::fcra::@version@::did','~thor_data400::key::gong_history::fcra::'+rundate+'::did',bk_fcra_did);
/*
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_Hhid,'~thor_data400::key::gong_history::fcra::@version@::hhid','~thor_data400::key::gong_history::fcra::'+rundate+'::hhid',bk_fcra_hhid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_BDID,'~thor_Data400::key::gong_history::fcra::@version@::bdid','~thor_data400::key::gong_history::fcra::'+rundate+'::bdid',bk_fcra_bdid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_Name,'~thor_data400::key::gong_history::fcra::@version@::name','~thor_data400::key::gong_history::fcra::'+rundate+'::name',bk_fcra_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_CompanyName,'~thor_data400::key::gong_history::fcra::@version@::companyname','~thor_data400::key::gong_history::fcra::'+rundate+'::companyname',bk_fcra_companyname);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_FCRA_history_zip_name,'~thor_data400::key::gong_history::fcra::@version@::zip_name','~thor_data400::key::gong_history::fcra::'+rundate+'::zip_name',bk_fcra_zip_name);					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(key_FCRA_history_npa_nxx_line,'~thor_data400::key::gong_history::fcra::@version@::npa_nxx_line','~thor_data400::key::gong_history::fcra::'+rundate+'::npa_nxx_line',bk_fcra_npa_nxx_line);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_History_Surname,'~thor_data400::key::gong_history::fcra::@version@::surnames','~thor_data400::key::gong_history::fcra::'+rundate+'::surnames',bk_fcra_surname);					
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Relocations.key_FCRA_wdtgGong,'~thor_data400::key::gong_history::fcra::@version@::wdtg','~thor_data400::key::gong_history::fcra::'+rundate+'::wdtg',bk_fcra_wdtg);					 
*/
// moved from full keys build - needs history completed to create 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(key_did,'~thor_data400::key::gong_weekly::'+rundate+'::did','~thor_data400::key::gong_did',bk_did_curr,3);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(key_hhid,'~thor_data400::key::gong_weekly::'+rundate+'::hhid','~thor_data400::key::gong_hhid',bk_hhid_curr,3);
//RoxieKeyBuild.Mac_SK_BuildProcess_Local(risk_indicators.Key_Phone_Table_v2, '~thor_data400::key::business_header::'+rundate+'::hri::phone10_v2','~thor_data400::key::phone_table_v2',Buildkey6);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(key_cn,'~thor_data400::key::gong_weekly::'+rundate+'::cn','~thor_data400::key::gong_cn',bk_cn,3);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(key_cn_to_company,'~thor_data400::key::gong_weekly::'+rundate+'::cn_to_company','~thor_data400::key::gong_cn_to_company',bk_cn_to_company,3);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(risk_indicators.Key_Phone_Table_v2, '~thor_data400::key::business_header::'+rundate+'::hri::phone10_v2','~thor_data400::key::phone_table_v2',Buildkey6);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(risk_indicators.key_phone_table_fcra_v2 ,'~thor_data400::key::business_header::filtered::'+rundate+'::hri::phone10_v2','~thor_data400::key::phone_table_filtered_v2',BuildFCRAkey5);
// cjs
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Key_FCRA_Business_Header_Phone_Table_Filtered_V2 ,'~thor_data400::key::business_header::filtered::fcra::@version@::hri::phone10_v2','~thor_data400::key::business_header::filtered::fcra::'+rundate+'::hri::phone10_v2',Build2ndFCRAkey5);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_address','~thor_data400::key::gong_history::'+rundate+'::address',mv1_addr);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_phone','~thor_data400::key::gong_history::'+rundate+'::phone',mv1_phone);								 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_did','~thor_data400::key::gong_history::'+rundate+'::did',mv1_did);								 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_hhid','~thor_data400::key::gong_history::'+rundate+'::hhid',mv1_hhid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_Data400::key::gong_hist_bdid','~thor_data400::key::gong_history::'+rundate+'::bdid',mv1_bdid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_name','~thor_data400::key::gong_history::'+rundate+'::name',mv1_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_zip_name','~thor_data400::key::gong_history::'+rundate+'::zip_name',mv1_zip_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_npa_nxx_line','~thor_data400::key::gong_history::'+rundate+'::npa_nxx_line',mv1_npa_nxx_line);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::@version@::surnames','~thor_data400::key::gong_history::'+rundate+'::surnames',mv1_surname);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_wdtg','~thor_data400::key::gong_history::'+rundate+'::wdtg',mv1_wdtg);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_companyname','~thor_data400::key::gong_history::'+rundate+'::companyname',mv1_cmp_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_city_st_name','~thor_data400::key::gong_history::'+rundate+'::city_st_name',mv1_csn);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_wild_name_zip','~thor_data400::key::gong_history::'+rundate+'::wild_name_zip',mv1_wnzip);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_LinkIDs','~thor_data400::key::gong_history::'+rundate+'::LinkIDs',mv1_linkids);
//
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_cleanname','~thor_data400::key::gong_history::'+rundate+'::cleanname',mv1_clnname);

// moved from full keys build - needs history completed to create 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::did','~thor_data400::key::gong_did',mv_did,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::hhid','~thor_data400::key::gong_hhid',mv_hhid,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::business_header::'+rundate+'::hri::phone10_v2', '~thor_data400::key::phone_table_v2',	MoveKeyToBuilt6);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::cn','~thor_data400::key::gong_cn',mv_cn,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::cn_to_company','~thor_data400::key::gong_cn_to_company',mv_cn_to_company,3);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::business_header::filtered::'+rundate+'::hri::phone10_v2', '~thor_data400::key::phone_table_filtered_v2',	MoveFCRAKeyToBuilt5);


// cjs
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::business_header::filtered::fcra::@version@::hri::phone10_v2', '~thor_data400::key::business_header::filtered::fcra::'+rundate+'::hri::phone10_v2',	Move2ndFCRAKeyToBuilt5);
// cjs - #86951
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::address','~thor_data400::key::gong_history::fcra::'+rundate+'::address',mv1_fcra_addr);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::phone','~thor_data400::key::gong_history::fcra::'+rundate+'::phone',mv1_fcra_phone);								 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::did','~thor_data400::key::gong_history::fcra::'+rundate+'::did',mv1_fcra_did);								 
/*RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::hhid','~thor_data400::key::gong_history::fcra::'+rundate+'::hhid',mv1_fcra_hhid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_Data400::key::gong_history::fcra::@version@::bdid','~thor_data400::key::gong_history::fcra::'+rundate+'::bdid',mv1_fcra_bdid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::name','~thor_data400::key::gong_history::fcra::'+rundate+'::name',mv1_fcra_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::companyname','~thor_data400::key::gong_history::fcra::'+rundate+'::companyname',mv1_fcra_companyname);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::zip_name','~thor_data400::key::gong_history::fcra::'+rundate+'::zip_name',mv1_fcra_zip_name);					
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::npa_nxx_line','~thor_data400::key::gong_history::fcra::'+rundate+'::npa_nxx_line',mv1_fcra_npa_nxx_line);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::surnames','~thor_data400::key::gong_history::fcra::'+rundate+'::surnames',mv1_fcra_surname);					
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::fcra::@version@::wdtg','~thor_data400::key::gong_history::fcra::'+rundate+'::wdtg',mv1_fcra_wdtg);					 
*/
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_address','Q',mk_addr);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_phone','Q',mk_phone);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_did','Q',mk_did);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_hhid','Q',mk_hhid);
promotesupers.MAC_SK_Move_v2('~thor_Data400::key::gong_hist_bdid','Q',mk_bdid);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_name','Q',mk_name);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_zip_name','Q',mk_zip_name);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_npa_nxx_line','Q',mk_npa_nxx_line);
RoxieKeyBuild.MAC_SK_Move_V2('~thor_data400::key::gong_history::@version@::surnames','Q',mk_surname);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_wdtg','Q',mk_wdtg);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_companyname','Q',mk_cmp_name);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_city_st_name','Q',mk_csn);
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_wild_name_zip','Q',mk_wnzip);
//
promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_cleanname','Q',mk_clnname);

promotesupers.MAC_SK_Move_v2('~thor_data400::key::gong_history_LinkIDs','Q',mk_LinkIDs);

// moved from full keys build - needs history completed to create 
roxiekeybuild.mac_sk_move('~thor_data400::key::gong_did','Q',out1);
roxiekeybuild.mac_sk_move('~thor_data400::key::gong_hhid','Q',out2);
roxiekeybuild.mac_sk_move('~thor_data400::key::phone_table_v2','Q',MoveKeyToQA2);
roxiekeybuild.mac_sk_move('~thor_data400::key::gong_cn','Q',out12);
roxiekeybuild.mac_sk_move('~thor_data400::key::gong_cn_to_company','Q',out13);
roxiekeybuild.mac_sk_move('~thor_data400::key::phone_table_filtered_v2','Q',MoveFCRAKeyToQA3);
//cjs
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::business_header::filtered::fcra::@version@::hri::phone10_v2','Q',Move2ndFCRAKeyToQA3);
// cjs - #86951
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::address','Q',mk_fcra_addr);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::phone','Q',mk_fcra_phone);								 
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::did','Q',mk_fcra_did);								 
/*RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::hhid','Q',mk_fcra_hhid);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_Data400::key::gong_history::fcra::@version@::bdid','Q',mk_fcra_bdid);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::name','Q',mk_fcra_name);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::companyname','Q',mk_fcra_companyname);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::zip_name','Q',mk_fcra_zip_name);					
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::npa_nxx_line','Q',mk_fcra_npa_nxx_line);
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::surnames','Q',mk_fcra_surname);					
RoxieKeyBuild.MAC_SK_Move_v2('~thor_data400::key::gong_history::fcra::@version@::wdtg','Q',mk_fcra_wdtg);					 
*/

//DF-22158 - Verify deprecated fields are blank or zero
cnt_fcra_address := OUTPUT(strata.macf_pops(Key_FCRA_History_Address,,,,,,FALSE,
																													['caption_text','county_code','designation','disc_cnt18','disc_cnt6','prior_area_code',
																													 'see_also_text']));
cnt_fcra_did 			:= OUTPUT(strata.macf_pops(Key_FCRA_History_Did,,,,,,FALSE,
																													['caption_text','county_code','designation','disc_cnt18','disc_cnt6','prior_area_code',
																													 'see_also_text']));
cnt_fcra_phone		 := OUTPUT(strata.macf_pops(Key_FCRA_History_Phone,,,,,,FALSE,
																													['caption_text','county_code','designation','disc_cnt18','disc_cnt6','prior_area_code',
																													 'see_also_text']));

								 
bk := parallel(bk_addr,bk_phone,bk_did,bk_hhid,bk_bdid,bk_name,bk_clnname,bk_zip_name,bk_npa_nxx_line,bk_surname,bk_wdtg,bk_cmp_name, bk_csn, bk_wnzip, bk_did_curr, bk_hhid_curr, Buildkey6, bk_cn, bk_cn_to_company, bk_LinkIDs/*, BuildFCRAkey5*/
			,Build2ndFCRAkey5
			,bk_fcra_addr,bk_fcra_phone,bk_fcra_did
			//bk_fcra_hhid,bk_fcra_bdid,bk_fcra_name,bk_fcra_companyname,bk_fcra_zip_name,bk_fcra_npa_nxx_line,bk_fcra_surname,bk_fcra_wdtg
		);

mv1 := parallel(mv1_addr,mv1_phone,mv1_did,mv1_hhid,mv1_bdid,mv1_name,mv1_clnname,mv1_zip_name,mv1_npa_nxx_line,mv1_surname,mv1_wdtg,mv1_cmp_name,mv1_csn, mv1_wnzip, mv_did, mv_hhid, MoveKeyToBuilt6, mv_cn, mv_cn_to_company, mv1_linkids,/*MoveFCRAKeyToBuilt5,*/
			Move2ndFCRAKeyToBuilt5
			,mv1_fcra_addr,mv1_fcra_phone,mv1_fcra_did
			//mv1_fcra_hhid,mv1_fcra_bdid,mv1_fcra_name,mv1_fcra_companyname,mv1_fcra_zip_name,mv1_fcra_npa_nxx_line,mv1_fcra_surname,mv1_fcra_wdtg
			);

mk := parallel(mk_addr,mk_phone,mk_did,mk_hhid,mk_bdid,mk_name,mk_clnname,mk_zip_name,mk_npa_nxx_line,mk_surname,mk_wdtg,mk_cmp_name,mk_csn,mk_wnzip,out1,out2,MoveKeyToQA2,out12,out13,mk_LinkIDs/*,MoveFCRAKeyToQA3*/
			,Move2ndFCRAKeyToQA3
			,mk_fcra_addr,mk_fcra_phone,mk_fcra_did
			//,mk_fcra_hhid,mk_fcra_bdid,mk_fcra_name,mk_fcra_companyname,mk_fcra_zip_name,mk_fcra_npa_nxx_line,mk_fcra_surname,mk_fcra_wdtg
			);

//DF-22158 - Verify deprecated fields are blank or zero
fcra_deprecate_stats := parallel(cnt_fcra_address, cnt_fcra_did, cnt_fcra_phone);

//build_keys := sequential(g_did, mv_gong2prod, bk, mv1, mk);
build_keys := sequential(g_did, 
		mv_gong2prod,
		bk, 
		mv1, 
		mk,
		fcra_deprecate_stats
//		RoxieKeybuild.updateversion('GongKeys',rundate,'cbrodeur@seisint.com, cguyton@seisint.com,charles.salvo@lexisnexis.com')
);
		//RoxieKeyBuild.updateversion('GongKeys',rundate,'cbrodeur@seisint.com',,'N',,,'A'),
		//Gong_v2.Proc_OrbitI_CreateBuild(rundate,'nonfcra'));

return build_keys;
end;