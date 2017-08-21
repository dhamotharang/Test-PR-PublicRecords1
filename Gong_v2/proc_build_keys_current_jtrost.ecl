import Gong_v2,doxie_files, ut, doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,fair_isaac;

export proc_build_keys_current_jtrost(string rundate) := function

// -- Build Keys			
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_did,Gong_v2.thor_cluster+'key::gongv2_did',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::did',bk_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_bdid,Gong_v2.thor_cluster+'key::gongv2_bdid',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::bdid',bk_bdid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_hhid,Gong_v2.thor_cluster+'key::gongv2_hhid',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::hhid',bk_hhid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_address,Gong_v2.thor_cluster+'key::gongv2_address',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::address',bk_addr);
//--------------------------------------------------
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchEda.Key_gongv2_phone,Gong_v2.thor_cluster+'key::gongv2_phone',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::phone',bk_phone);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchEda.key_gongv2_batch_czsslf,Gong_v2.thor_cluster+'key::gongv2_czsslf',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::czsslf',bk_czsslf);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchEda.key_gongv2_batch_lczf,Gong_v2.thor_cluster+'key::gongv2_lczf',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::lczf',bk_lczf);								 
//--------------------------------------------------
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_npa_nxx_linev2,Gong_v2.thor_cluster+'key::gongv2_eda_npa_nxx_line',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_npa_nxx_line',bk_npa_nxx_line);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_lname_cityv2,Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_city',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_city',bk_st_lname_city);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_lname_fname_cityv2,Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_fname_city',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_fname_city',bk_st_lname_fname_city);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_bizword_cityv2,Gong_v2.thor_cluster+'key::gongv2_eda_st_bizword_city',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_bizword_city',bk_st_bizword_city);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_city_prim_name_prim_rangev2,Gong_v2.thor_cluster+'key::gongv2_eda_st_city_prim_name_prim_range',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_city_prim_name_prim_range',bk_st_city_prim_name_prim_range);
													  
// -- Move Keys to Built
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_did',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::did',mv2blt_did);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_bdid',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::bdid',mv2blt_bdid);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_hhid',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::hhid',mv2blt_hhid);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_address',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::address',mv2blt_addr);
//--------------------------------------------------
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_phone',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::phone',mv2blt_phone);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_czsslf',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::czsslf',mv2blt_czsslf);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_lczf',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::lczf',mv2blt_lczf);								 
//--------------------------------------------------
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_npa_nxx_line',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_npa_nxx_line',mv2blt_npa_nxx_line);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_city',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_city',mv2blt_st_lname_city);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_fname_city',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_fname_city',mv2blt_st_lname_fname_city);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_bizword_city',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_bizword_city',mv2blt_st_bizword_city);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_city_prim_name_prim_range',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_city_prim_name_prim_range',mv2blt_st_city_prim_name_prim_range);

// -- Move Keys to QA
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_did','Q',mv2qa_did);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_bdid','Q',mv2qa_bdid);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_hhid','Q',mv2qa_hhid);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_address','Q',mv2qa_addr);
//--------------------------------------------------
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_phone','Q',mv2qa_phone);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_czsslf','Q',mv2qa_czsslf);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_lczf','Q',mv2qa_lczf);								 
//--------------------------------------------------
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_npa_nxx_line','Q',mv2qa_npa_nxx_line);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_city','Q',mv2qa_st_lname_city);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_fname_city','Q',mv2qa_st_lname_fname_city);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_bizword_city','Q',mv2qa_st_bizword_city);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_city_prim_name_prim_range','Q',mv2qa_st_city_prim_name_prim_range);

bk := 
	parallel(
			 bk_did
			,bk_bdid
		    ,bk_hhid
			,bk_addr
			,bk_phone
			,bk_czsslf
			,bk_lczf
			,bk_npa_nxx_line
			,bk_st_lname_city
			,bk_st_lname_fname_city
			,bk_st_bizword_city
			,bk_st_city_prim_name_prim_range
			);
mv2blt:=
	parallel(
			 mv2blt_did
			,mv2blt_bdid
		    ,mv2blt_hhid
			,mv2blt_addr
			,mv2blt_phone
			,mv2blt_czsslf
			,mv2blt_lczf
			,mv2blt_npa_nxx_line
			,mv2blt_st_lname_city
			,mv2blt_st_lname_fname_city
			,mv2blt_st_bizword_city
			,mv2blt_st_city_prim_name_prim_range
			);
			
mv2qa:=
	parallel( mv2qa_did
			,mv2qa_bdid
		    ,mv2qa_hhid
			,mv2qa_addr
			,mv2qa_phone
			,mv2qa_czsslf
			,mv2qa_lczf
			,mv2qa_npa_nxx_line
			,mv2qa_st_lname_city
			,mv2qa_st_lname_fname_city
			,mv2qa_st_bizword_city
			,mv2qa_st_city_prim_name_prim_range
			);

outfile := 
	sequential(
			bk
			,mv2blt
			,mv2qa
			);

return outfile;

end;