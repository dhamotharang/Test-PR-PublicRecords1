import Gong,Gong_v2,doxie_files, ut, doxie,RoxieKeyBuild,DayBatchEda,EDA_VIA_XML,risk_indicators,doxie_cbrs,relocations;

export proc_build_keys_history_jtrost(string rundate) := function

// -- Build Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.Key_History_Address,Gong_v2.thor_cluster+'key::gongv2_history_address',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::address',bk_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.Key_History_Phone,Gong_v2.thor_cluster+'key::gongv2_history_phone',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::phone',bk_phone);								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.Key_History_Did,Gong_v2.thor_cluster+'key::gongv2_history_did',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::did',bk_did);								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.Key_History_Hhid,Gong_v2.thor_cluster+'key::gongv2_history_hhid',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::hhid',bk_hhid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.Key_History_BDID,Gong_v2.thor_cluster+'key::gongv2_hist_bdid',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::bdid',bk_bdid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.Key_History_Name,Gong_v2.thor_cluster+'key::gongv2_history_name',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::name',bk_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.key_history_zip_name,Gong_v2.thor_cluster+'key::gongv2_history_zip_name',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::zip_name',bk_zip_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.key_history_npa_nxx_line,Gong_v2.thor_cluster+'key::gongv2_history_npa_nxx_line',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::npa_nxx_line',bk_npa_nxx_line);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.Key_History_Surname,Gong_v2.thor_cluster+'key::gongv2_history::qa::surname',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::surname',bk_surname);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(relocations.Key_wdtgGong_v2,Gong_v2.thor_cluster+'key::gongv2_history_wdtg',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::wdtg',bk_wdtg);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong_v2.key_history_companyname,Gong_v2.thor_cluster+'key::gongv2_history_companyname',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::companyname',bk_cmp_name);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_tablev2,Gong_v2.thor_cluster+'key::phone_tablev2',Gong_v2.thor_cluster+'key::business_header::'+rundate+'::v2_hri::phone10',bk_phonetbl);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_table_gongv2,Gong_v2.thor_cluster+'key::phone_table_gongv2',Gong_v2.thor_cluster+'key::business_header::'+rundate+'::gongv2_hri::phone10',bk_phonetblv2);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_table_filteredv2,Gong_v2.thor_cluster+'key::phone_table_filteredv2',Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::v2_hri::phone10',bk_phonetblf);										  
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(risk_indicators.key_phone_table_filtered_gongv2,Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2',Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::gongv2_hri::phone10',bk_phonetblfv2);
//--------------------------------------------------
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(doxie_cbrs.key_phone_gongv2,Gong_v2.thor_cluster+'key::cbrs_gongv2.phone10',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::cbrs.phone10',bk_cbrs);

// -- Move Keys to Built
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_address',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::address',mv2blt_addr);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_phone',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::phone',mv2blt_phone);							 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_did',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::did',mv2blt_did);								  
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_hhid',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::hhid',mv2blt_hhid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_hist_bdid',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::bdid',mv2blt_bdid);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_name',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::name',mv2blt_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_zip_name',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::zip_name',mv2blt_zip_name);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_npa_nxx_line',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::npa_nxx_line',mv2blt_npa_nxx_line);					  
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_surname',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::surname',mv2blt_surname);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_wdtg',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::wdtg',mv2blt_wdtg);					  
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Gong_v2.thor_cluster+'key::gongv2_history_companyname',Gong_v2.thor_cluster+'key::gongv2_history::'+rundate+'::companyname',mv2blt_cmp_name);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_tablev2',Gong_v2.thor_cluster+'key::business_header::'+rundate+'::v2_hri::phone10',mv2blt_phonetbl);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2',Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::gongv2_hri::phone10',mv2blt_phonetblf);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_table_gongv2',Gong_v2.thor_cluster+'key::business_header::'+rundate+'::gongv2_hri::phone10',mv2blt_phonetblv2);
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2',Gong_v2.thor_cluster+'key::business_header::filtered::'+rundate+'::gongv2_hri::phone10',mv2blt_phonetblfv2);
//--------------------------------------------------
Roxiekeybuild.Mac_SK_Move_to_Built_v2(Gong_v2.thor_cluster+'key::cbrs_gongv2.phone10',Gong_v2.thor_cluster+'key::gongv2_weekly::'+rundate+'::cbrs.phone10',mv2blt_cbrs);

// -- Move Keys to QA
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_address','Q',mv2qa_addr);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_phone','Q',mv2qa_phone);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_did','Q',mv2qa_did);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_hhid','Q',mv2qa_hhid);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_hist_bdid','Q',mv2qa_bdid);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_name','Q',mv2qa_name);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_zip_name','Q',mv2qa_zip_name);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_npa_nxx_line','Q',mv2qa_npa_nxx_line);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_surname','Q',mv2qa_surname);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_wdtg','Q',mv2qa_wdtg);
ut.MAC_SK_Move_v2(Gong_v2.thor_cluster+'key::gongv2_history_companyname','Q',mv2qa_cmp_name);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_tablev2','Q',mv2qa_phonetbl);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_table_filteredv2','Q',mv2qa_phonetblf);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_table_gongv2','Q',mv2qa_phonetblv2);
ut.mac_sk_move(Gong_v2.thor_cluster+'key::phone_table_filtered_gongv2','Q',mv2qa_phonetblfv2);
//--------------------------------------------------
ut.mac_sk_move(Gong_v2.thor_cluster+'key::cbrs_gongv2.phone10','Q',mv2qa_cbrs);

bk:=	  parallel(
			     bk_addr
				,bk_phone
				,bk_did
				,bk_hhid
				,bk_bdid
				,bk_name
				,bk_zip_name
				,bk_npa_nxx_line
				,bk_surname
				,bk_wdtg
				,bk_cmp_name
				,bk_phonetbl
				,bk_phonetblv2
				,bk_phonetblf
				,bk_phonetblfv2
				,bk_cbrs
				);
mv2blt:=  parallel(
				 mv2blt_addr
				,mv2blt_phone
				,mv2blt_did
				,mv2blt_hhid
				,mv2blt_bdid
				,mv2blt_name
				,mv2blt_zip_name
				,mv2blt_npa_nxx_line
				,mv2blt_surname
				,mv2blt_wdtg
				,mv2blt_cmp_name
				,mv2blt_phonetbl
				,mv2blt_phonetblv2
				,mv2blt_phonetblf
				,mv2blt_phonetblfv2
				,mv2blt_cbrs
				);

mv2qa:=	  parallel(
				 mv2qa_addr
				,mv2qa_phone
				,mv2qa_did
				,mv2qa_hhid
				,mv2qa_bdid
				,mv2qa_name
				,mv2qa_zip_name
				,mv2qa_npa_nxx_line
				,mv2qa_surname
				,mv2qa_wdtg
				,mv2qa_cmp_name
				,mv2qa_phonetbl
				,mv2qa_phonetblv2
				,mv2qa_phonetblf
				,mv2qa_phonetblfv2
				,mv2qa_cbrs
				//copy keys for FCRA
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','address')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','phone')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','did')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','hhid')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','bdid')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','name')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','zip_name')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','npa_nxx_line')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','surname')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','wdtg')
				,gong_v2.Proc_Copy_FCRA_Keys(rundate,'gongv2_history','companyname'));
				

outfile := sequential(bk,mv2blt,mv2qa);

return outfile;

end;