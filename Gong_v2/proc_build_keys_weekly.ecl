import Gong_v2,doxie_files, ut, doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,fair_isaac;

export proc_build_keys_weekly(rundate,outfile) := macro

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////

#uniquename(bk_did)
#uniquename(bk_bdid)
#uniquename(bk_hhid)
#uniquename(bk_addr)
#uniquename(bk_phone)
#uniquename(bk_czsslf)
#uniquename(bk_lczf)
#uniquename(bk_npa_nxx_line)
#uniquename(bk_st_lname_city)
#uniquename(bk_st_lname_fname_city)
#uniquename(bk_st_bizword_city)
#uniquename(bk_st_city_prim_name_prim_range)
#uniquename(bk_cbrs)
#uniquename(bk_phonetbl)
#uniquename(bk_phonetblf)
#uniquename(bk_phonetblv2)
#uniquename(bk_phonetblfv2)
			
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_did
										  ,Gong_v2.thor_cluster+'key::gongv2_did'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::did'
										  ,%bk_did%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_bdid
										  ,Gong_v2.thor_cluster+'key::gongv2_bdid'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::bdid'
										  ,%bk_bdid%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_hhid
										  ,Gong_v2.thor_cluster+'key::gongv2_hhid'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::hhid'
										  ,%bk_hhid%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(gong_v2.key_address
										  ,Gong_v2.thor_cluster+'key::gongv2_address'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::address'
										  ,%bk_addr%);
//--------------------------------------------------
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchEda.Key_gongv2_phone
										  ,Gong_v2.thor_cluster+'key::gongv2_phone'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::phone'
										  ,%bk_phone%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchEda.key_gongv2_batch_czsslf
										  ,Gong_v2.thor_cluster+'key::gongv2_czsslf'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::czsslf'
										  ,%bk_czsslf%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(DayBatchEda.key_gongv2_batch_lczf
										  ,Gong_v2.thor_cluster+'key::gongv2_lczf'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::lczf'
										  ,%bk_lczf%);								 
//--------------------------------------------------
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_npa_nxx_linev2
										  ,Gong_v2.thor_cluster+'key::gongv2_eda_npa_nxx_line'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_npa_nxx_line'
										  ,%bk_npa_nxx_line%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_lname_cityv2
										  ,Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_city'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_city'
										  ,%bk_st_lname_city%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_lname_fname_cityv2
										  ,Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_fname_city'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_fname_city'
										  ,%bk_st_lname_fname_city%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_bizword_cityv2
										  ,Gong_v2.thor_cluster+'key::gongv2_eda_st_bizword_city'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_bizword_city'
										  ,%bk_st_bizword_city%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(EDA_VIA_XML.Key_st_city_prim_name_prim_rangev2
										  ,Gong_v2.thor_cluster+'key::gongv2_eda_st_city_prim_name_prim_range'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_city_prim_name_prim_range'
										  ,%bk_st_city_prim_name_prim_range%);
//--------------------------------------------------
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_tablev2
										  ,Gong_v2.thor_cluster+'key::phone_tablev2'
										  ,Gong_v2.thor_cluster+'key::business_header::'+rundate+'::v2_hri::phone10'										  
										  ,%bk_phonetbl%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_table_gongv2
										  ,Gong_v2.thor_cluster+'key::phone_table_gongv2'
										  ,Gong_v2.thor_cluster+'key::business_header::'+rundate+'::gongv2_hri::phone10'
										  ,%bk_phonetblv2%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_table_filteredv2
										  ,Gong_v2.thor_cluster+'key::phone_table_filteredv2'
										  ,Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::v2_hri::phone10'										  
										  ,%bk_phonetblf%);										  
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_table_filtered_gongv2
										  ,Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2'
										  ,Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::gongv2_hri::phone10'
										  ,%bk_phonetblfv2%);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_cbrs.key_phone_gongv2
										  ,Gong_v2.thor_cluster+'key::cbrs_gongv2.phone10'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::cbrs.phone10'
										  ,%bk_cbrs%);

													  
/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

#uniquename(mv2blt_did)
#uniquename(mv2blt_bdid)
#uniquename(mv2blt_hhid)
#uniquename(mv2blt_addr)
#uniquename(mv2blt_phone)
#uniquename(mv2blt_czsslf)
#uniquename(mv2blt_lczf)
#uniquename(mv2blt_npa_nxx_line)
#uniquename(mv2blt_st_lname_city)
#uniquename(mv2blt_st_lname_fname_city)
#uniquename(mv2blt_st_bizword_city)
#uniquename(mv2blt_st_city_prim_name_prim_range)
#uniquename(mv2blt_cbrs)
#uniquename(mv2blt_phonetbl)
#uniquename(mv2blt_phonetblf)
#uniquename(mv2blt_phonetblv2)
#uniquename(mv2blt_phonetblfv2)

Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_did'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::did'
										  ,%mv2blt_did%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_bdid'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::bdid'
										  ,%mv2blt_bdid%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_hhid'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::hhid'
										  ,%mv2blt_hhid%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_address'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::address'
										  ,%mv2blt_addr%);
//--------------------------------------------------
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_phone'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::phone'
										  ,%mv2blt_phone%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_czsslf'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::czsslf'
										  ,%mv2blt_czsslf%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_lczf'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::lczf'
										  ,%mv2blt_lczf%);								 
//--------------------------------------------------
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_npa_nxx_line'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_npa_nxx_line'
										  ,%mv2blt_npa_nxx_line%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_city'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_city'
										  ,%mv2blt_st_lname_city%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_fname_city'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_lname_fname_city'
										  ,%mv2blt_st_lname_fname_city%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_bizword_city'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_bizword_city'
										  ,%mv2blt_st_bizword_city%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::gongv2_eda_st_city_prim_name_prim_range'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::eda_st_city_prim_name_prim_range'
										  ,%mv2blt_st_city_prim_name_prim_range%);
//--------------------------------------------------
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_tablev2'
										  ,Gong_v2.thor_cluster+'key::business_header::'+rundate+'::v2_hri::phone10'
										  ,%mv2blt_phonetbl%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2'
										  ,Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::gongv2_hri::phone10'
										  ,%mv2blt_phonetblf%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_table_gongv2'
										  ,Gong_v2.thor_cluster+'key::business_header::'+rundate+'::gongv2_hri::phone10'
										  ,%mv2blt_phonetblv2%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2'
										  ,Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::gongv2_hri::phone10'
										  ,%mv2blt_phonetblfv2%);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::cbrs_gongv2.phone10'
										  ,Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::cbrs.phone10'
										  ,%mv2blt_cbrs%);
/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

#uniquename(mv2qa_did)
#uniquename(mv2qa_bdid)
#uniquename(mv2qa_hhid)
#uniquename(mv2qa_addr)
#uniquename(mv2qa_phone)
#uniquename(mv2qa_czsslf)
#uniquename(mv2qa_lczf)
#uniquename(mv2qa_npa_nxx_line)
#uniquename(mv2qa_st_lname_city)
#uniquename(mv2qa_st_lname_fname_city)
#uniquename(mv2qa_st_bizword_city)
#uniquename(mv2qa_st_city_prim_name_prim_range)
#uniquename(mv2qa_cbrs)
#uniquename(mv2qa_phonetbl)
#uniquename(mv2qa_phonetblf)
#uniquename(mv2qa_phonetblv2)
#uniquename(mv2qa_phonetblfv2)

ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_did'
										  ,'Q'
										  ,%mv2qa_did%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_bdid'
										  ,'Q'
										  ,%mv2qa_bdid%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_hhid'
										  ,'Q'
										  ,%mv2qa_hhid%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_address'
										  ,'Q'
										  ,%mv2qa_addr%);
//--------------------------------------------------
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_phone'
										  ,'Q'
										  ,%mv2qa_phone%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_czsslf'
										  ,'Q'
										  ,%mv2qa_czsslf%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_lczf'
										  ,'Q'
										  ,%mv2qa_lczf%);								 
//--------------------------------------------------
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_npa_nxx_line'
										  ,'Q'
										  ,%mv2qa_npa_nxx_line%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_city'
										  ,'Q'
										  ,%mv2qa_st_lname_city%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_lname_fname_city'
										  ,'Q'
										  ,%mv2qa_st_lname_fname_city%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_bizword_city'
										  ,'Q'
										  ,%mv2qa_st_bizword_city%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::gongv2_eda_st_city_prim_name_prim_range'
										  ,'Q'
										  ,%mv2qa_st_city_prim_name_prim_range%);
//--------------------------------------------------
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_tablev2'
										  ,'Q'
										  ,%mv2qa_phonetbl%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_table_filteredv2'
										  ,'Q'
										  ,%mv2qa_phonetblf%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_table_gongv2'
										  ,'Q'
										  ,%mv2qa_phonetblv2%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2'
										  ,'Q'
										  ,%mv2qa_phonetblfv2%);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::cbrs_gongv2.phone10'
										  ,'Q'
										  ,%mv2qa_cbrs%);
										  
/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

#uniquename(bk)
#uniquename(mv2blt)
#uniquename(mv2qa)

%bk% := 
	parallel(
			 %bk_did%
			,%bk_bdid%
		    ,%bk_hhid%
			,%bk_addr%
			,%bk_phone%
			,%bk_czsslf%
			,%bk_lczf%
			,%bk_npa_nxx_line%
			,%bk_st_lname_city%
			,%bk_st_lname_fname_city%
			,%bk_st_bizword_city%
			,%bk_st_city_prim_name_prim_range%
			,%bk_phonetbl%
			,%bk_phonetblv2%
			,%bk_phonetblf%
			,%bk_phonetblfv2%
			,%bk_cbrs%
			);
%mv2blt%:=
	parallel(
			 %mv2blt_did%
			,%mv2blt_bdid%
		    ,%mv2blt_hhid%
			,%mv2blt_addr%
			,%mv2blt_phone%
			,%mv2blt_czsslf%
			,%mv2blt_lczf%
			,%mv2blt_npa_nxx_line%
			,%mv2blt_st_lname_city%
			,%mv2blt_st_lname_fname_city%
			,%mv2blt_st_bizword_city%
			,%mv2blt_st_city_prim_name_prim_range%
			,%mv2blt_phonetbl%
			,%mv2blt_phonetblv2%
			,%mv2blt_phonetblf%
			,%mv2blt_phonetblfv2%
			,%mv2blt_cbrs%
			);
			
%mv2qa%:=
	parallel( %mv2qa_did%
			,%mv2qa_bdid%
		    ,%mv2qa_hhid%
			,%mv2qa_addr%
			,%mv2qa_phone%
			,%mv2qa_czsslf%
			,%mv2qa_lczf%
			,%mv2qa_npa_nxx_line%
			,%mv2qa_st_lname_city%
			,%mv2qa_st_lname_fname_city%
			,%mv2qa_st_bizword_city%
			,%mv2qa_st_city_prim_name_prim_range%
			,%mv2qa_phonetbl%
			,%mv2qa_phonetblv2%
			,%mv2qa_phonetblf%
			,%mv2qa_phonetblfv2%
			,%mv2qa_cbrs%
			);

outfile := 
	sequential(
			%bk%
			,%mv2blt%
			,%mv2qa%
			);

endmacro;


 
 
 
