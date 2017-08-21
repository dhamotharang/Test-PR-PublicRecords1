import ut,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs, gong_v2, watchdog, gong_platinum;

#workunit('priority','high');
#workunit('priority',09);



export proc_build_full_keys_jtrost := function

lstUpdateNo   := fileservices.GetSuperFileSubCount(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2') : global; 
lstUpdateName := fileservices.GetSuperFileSubName(Gong_v2.thor_cluster+'base::gongv2_daily_additions_building2',lstUpdateNo) : global;
rundate   := stringlib.stringfilter(lstUpdateName,'0123456789')[4..11] : global;

Gong_SuperKeyName	:= '~thor_data400::key::Gong::@version@::'; // created during the introduction of bug 75617
Gong_BaseKeyName	:= '~thor_data400::key::Gong::'+rundate ;

pre1 := ut.SF_MaintBuilding('~thor_data400::base::gong');

RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_bdid,'~thor_data400::key::gong_weekly::'+rundate+'::bdid','~thor_data400::key::gong_bdid',bk_bdid,4);								 
RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.Key_gong_phone,'~thor_data400::key::gong_weekly::'+rundate+'::phone','~thor_data400::key::gong_phone',bk_phone,4);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.key_gong_batch_czsslf,'~thor_data400::key::gong_weekly::'+rundate+'::czsslf','~thor_data400::key::gong_czsslf',bk_czsslf,4);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(DayBatchEda.key_gong_batch_lczf,'~thor_data400::key::gong_weekly::'+rundate+'::lczf','~thor_data400::key::gong_lczf',bk_lczf,4);											
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_npa_nxx_line,'~thor_data400::key::gong_weekly::'+rundate+'::eda_npa_nxx_line','~thor_data400::key::gong_eda_npa_nxx_line',bk_npa_nxx_line,4);		
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_lname_city,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_lname_city','~thor_data400::key::gong_eda_st_lname_city',bk_st_lname_city,4);			
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_lname_fname_city,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_lname_fname_city','~thor_data400::key::gong_eda_st_lname_fname_city',bk_st_lname_fname_city,4);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_bizword_city,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_bizword_city','~thor_data400::key::gong_eda_st_bizword_city',bk_st_bizword_city,4);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(EDA_VIA_XML.Key_st_city_prim_name_prim_range,'~thor_data400::key::gong_weekly::'+rundate+'::eda_st_city_prim_name_prim_range','~thor_data400::key::gong_eda_st_city_prim_name_prim_range',bk_st_city_prim_name_prim_range,4);
RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.key_address_current,'~thor_data400::key::gong_weekly::'+rundate+'::address_current','~thor_data400::key::gong_address_current',bk_addr_curr,4);									
/* //////Bug: #53260 - new roxie key for surname counts in apple app */
RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong.Key_SurnameCount,'~thor_data400::key::gong_weekly::'+rundate+'::surnamecnt','~thor_data400::key::gong_surnamecnt',bk_srnmct,4);										 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_cbrs.key_phone_gong, '~thor_data400::key::cbrs.phone10_gong','~thor_data400::key::gong_weekly::'+rundate+'::cbrs.phone10_gong',kpg);
/* /////Build keys Bug 75617					 */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Gong.key_zip,Gong_SuperKeyName+'zip',Gong_BaseKeyName+'::zip',Gong_zip_key);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Gong.key_npa,Gong_SuperKeyName+'npa',Gong_BaseKeyName+'::npa',Gong_npa_key);											
/* /////Build keys Bug 95514					 */		
RoxieKeyBuild.Mac_SK_BuildProcess_Local(gong_platinum.Key_GongScoringAttributes,'~thor_data400::key::gong_scoring::'+rundate+'::phone_nm', '~thor_data400::key::gong_scoring',bk_ph_scoring,4);
				 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::bdid','~thor_data400::key::gong_bdid',mv_bdid,4);								 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::phone','~thor_data400::key::gong_phone',mv_phone,4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::czsslf','~thor_data400::key::gong_czsslf',mv_czsslf,4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::lczf','~thor_data400::key::gong_lczf',mv_lczf,4);											 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::eda_npa_nxx_line','~thor_data400::key::gong_eda_npa_nxx_line',mv_npa_nxx_line,4);					 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::eda_st_lname_city','~thor_data400::key::gong_eda_st_lname_city',mv_st_lname_city,4);					 
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::eda_st_lname_fname_city','~thor_data400::key::gong_eda_st_lname_fname_city',mv_st_lname_fname_city,4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::eda_st_bizword_city','~thor_data400::key::gong_eda_st_bizword_city',mv_st_bizword_city,4);
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::eda_st_city_prim_name_prim_range','~thor_data400::key::gong_eda_st_city_prim_name_prim_range',mv_st_city_prim_name_prim_range,4);	
/* //////Bug: #53260 - new roxie key for surname counts in apple app */
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::surnamecnt','~thor_data400::key::gong_surnamecnt',mv_srnmct,4);				 
/* //////Bug: #      - new by Vladamir */
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_weekly::'+rundate+'::address_current','~thor_data400::key::gong_address_current',mv_addr_curr,4);									
RoxieKeyBuild.Mac_SK_Move_To_Built_v2('~thor_data400::key::cbrs.phone10_gong','~thor_data400::key::gong_weekly::'+rundate+'::cbrs.phone10_gong',kpg1);
/* //////Move keys to build Bug 75617	 */
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_SuperKeyName+'zip',Gong_BaseKeyName+'::zip',mv_Gong_zip_key);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_SuperKeyName+'npa',Gong_BaseKeyName+'::npa',mv_Gong_npa_key);
/* /////Build keys Bug 95514					 */		
RoxieKeyBuild.Mac_SK_Move_To_Built('~thor_data400::key::gong_scoring::'+rundate+'::phone_nm', '~thor_data400::key::gong_scoring',mv_ph_scoring,4);


full1 := if (fileservices.getsuperfilesubname('~thor_data400::base::gong',1) =      
fileservices.getsuperfilesubname('~thor_data400::base::gong_built',1),
		   output('base file BASE = BUILT, Nothing done.'),
		   sequential(
								parallel(
								bk_bdid,
								bk_phone,
								bk_czsslf,
								bk_lczf,
								bk_npa_nxx_line,
								bk_st_lname_city,
								bk_st_lname_fname_city,
								bk_st_bizword_city,
								bk_st_city_prim_name_prim_range,
								kpg,
								bk_addr_curr,
								bk_srnmct,
								Gong_zip_key,
								Gong_npa_key,	
								bk_ph_scoring
								),
			parallel(			
								mv_bdid,
								mv_phone,
								mv_czsslf,
								mv_lczf,
								mv_npa_nxx_line,
								mv_st_lname_city,
								mv_st_lname_fname_city,
								mv_st_bizword_city,
								mv_st_city_prim_name_prim_range,
								kpg1,
								mv_addr_curr,
								mv_srnmct,
								mv_Gong_zip_key,
								mv_Gong_npa_key,
								mv_ph_scoring
								)));
		   
post1 := ut.SF_MaintBuilt('~thor_data400::base::gong');

ut.mac_sk_move('~thor_data400::key::gong_bdid','Q',out0);
ut.mac_sk_move('~thor_data400::key::gong_phone','Q',out4);
ut.mac_sk_move('~thor_data400::key::gong_czsslf','Q',out5);
ut.mac_sk_move('~thor_data400::key::gong_lczf','Q',out6);
ut.mac_sk_move('~thor_data400::key::gong_eda_npa_nxx_line','Q',out7);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_city','Q',out8);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_lname_fname_city','Q',out9);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_bizword_city','Q',out10);
ut.mac_sk_move('~thor_data400::key::gong_eda_st_city_prim_name_prim_range','Q',out11);
ut.MAC_SK_Move_v2('~thor_data400::key::cbrs.phone10_gong','Q', kpg2);
ut.mac_sk_move('~thor_data400::key::gong_surnamecnt','Q',out_srnmct);
ut.mac_sk_move('~thor_data400::key::gong_address_current','Q',out14);
// Move keys to QA Bug 75617
RoxieKeyBuild.MAC_SK_Move_V2(Gong_SuperKeyName+'zip','Q',mv_Gong_zip_key_qa);
RoxieKeyBuild.MAC_SK_Move_V2(Gong_SuperKeyName+'npa','Q',mv_Gong_npa_key_qa);

// Move keys to QA Bug 95514
ut.mac_sk_move('~thor_data400::key::gong_scoring','Q',out15);

move1 := parallel(out0, out4, out5, out6, out7, out8, out9, out10, out11, out14, out15,out_srnmct, kpg2, mv_Gong_zip_key_qa, mv_Gong_npa_key_qa);

build_keys := sequential(pre1,full1,post1,move1
					)
					: SUCCESS(FileServices.SendEmail('QualityAssurance@seisint.com,christopher.brodeur@lexisnexis.com, intel357@bellsouth.net, cguyton@seisint.com', 'GONG - GongKeys Weekly Complete', thorlib.wuid() + ' Version: ' + rundate)),
					  Failure(FileServices.SendEmail('Afterhourssupport@seisint.com, cbrodeur@seisint.com, cguyton@seisint.com, cnguyton@tmo.blackberry.net, intel357@bellsouth.net, chuck.salvo@gmail.com', 'GONG-EDA GongKeys Weekly Failure', thorlib.wuid() + '\n' + FAILMESSAGE));

return build_keys;

end;