export proc_build_history_keys(filedate,build_keys) := 
macro

#uniquename(bk_addr)
#uniquename(bk_phone)
#uniquename(bk_did)
#uniquename(bk_hhid)
#uniquename(bk_bdid)
#uniquename(bk_name)
#uniquename(bk_zip_name)
#uniquename(bk_npa_nxx_line)
#uniquename(bk_surname)
#uniquename(bk_wdtg)
#uniquename(bk_cmp_name)

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Address,
				      '~thor_data400::key::gong_history_address','~thor_data400::key::gong_history::'+filedate+'::address',%bk_addr%);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Phone,
				      '~thor_data400::key::gong_history_phone','~thor_data400::key::gong_history::'+filedate+'::phone',%bk_phone%);
								 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Did,
				      '~thor_data400::key::gong_history_did','~thor_data400::key::gong_history::'+filedate+'::did',%bk_did%);
								  
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Hhid,
				      '~thor_data400::key::gong_history_hhid','~thor_data400::key::gong_history::'+filedate+'::hhid',%bk_hhid%);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_BDID,
                          '~thor_Data400::key::gong_hist_bdid','~thor_data400::key::gong_history::'+filedate+'::bdid',%bk_bdid%);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Name,
				      '~thor_data400::key::gong_history_name','~thor_data400::key::gong_history::'+filedate+'::name',%bk_name%);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_zip_name,
                          '~thor_data400::key::gong_history_zip_name','~thor_data400::key::gong_history::'+filedate+'::zip_name',%bk_zip_name%);
					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_npa_nxx_line,
                          '~thor_data400::key::gong_history_npa_nxx_line','~thor_data400::key::gong_history::'+filedate+'::npa_nxx_line',%bk_npa_nxx_line%);

RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.Key_History_Surname,
				      '~thor_data400::key::gong_history::qa::surnames','~thor_data400::key::gong_history::'+filedate+'::surnames',%bk_surname%);
					  
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Relocations.key_wdtgGong,
				      '~thor_data400::key::gong_history_wdtg','~thor_data400::key::gong_history::'+filedate+'::wdtg',%bk_wdtg%);
					 
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(gong.key_history_companyname,
					'~thor_data400::key::gong_history_companyname','~thor_data400::key::gong_history::'+filedate+'::companyname',%bk_cmp_name%);


#uniquename(mv1_addr)
#uniquename(mv1_phone)
#uniquename(mv1_did)
#uniquename(mv1_hhid)
#uniquename(mv1_bdid)
#uniquename(mv1_name)
#uniquename(mv1_zip_name)
#uniquename(mv1_npa_nxx_line)
#uniquename(mv1_surname)
#uniquename(mv1_wdtg)
#uniquename(mv1_cmp_name)

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_address','~thor_data400::key::gong_history::'+filedate+'::address',%mv1_addr%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_phone','~thor_data400::key::gong_history::'+filedate+'::phone',%mv1_phone%);
								 
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_did','~thor_data400::key::gong_history::'+filedate+'::did',%mv1_did%);
								  
RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_hhid','~thor_data400::key::gong_history::'+filedate+'::hhid',%mv1_hhid%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_Data400::key::gong_hist_bdid','~thor_data400::key::gong_history::'+filedate+'::bdid',%mv1_bdid%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_name','~thor_data400::key::gong_history::'+filedate+'::name',%mv1_name%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_zip_name','~thor_data400::key::gong_history::'+filedate+'::zip_name',%mv1_zip_name%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_npa_nxx_line','~thor_data400::key::gong_history::'+filedate+'::npa_nxx_line',%mv1_npa_nxx_line%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history::@version@::surnames','~thor_data400::key::gong_history::'+filedate+'::surnames',%mv1_surname%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_wdtg','~thor_data400::key::gong_history::'+filedate+'::wdtg',%mv1_wdtg%);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2('~thor_data400::key::gong_history_companyname','~thor_data400::key::gong_history::'+filedate+'::companyname',%mv1_cmp_name%);
								 
#uniquename(bk)

%bk% := parallel(%bk_addr%,%bk_phone%,%bk_did%,%bk_hhid%,%bk_bdid%,%bk_name%,%bk_zip_name%,%bk_npa_nxx_line%,%bk_surname%,%bk_wdtg%,%bk_cmp_name%);

#uniquename(mv1)

%mv1% := parallel(%mv1_addr%,%mv1_phone%,%mv1_did%,%mv1_hhid%,%mv1_bdid%,%mv1_name%,%mv1_zip_name%,%mv1_npa_nxx_line%,%mv1_surname%,%mv1_wdtg%,%mv1_cmp_name%);

#uniquename(mk_addr)
#uniquename(mk_phone)
#uniquename(mk_did)
#uniquename(mk_hhid)
#uniquename(mk_bdid)
#uniquename(mk_name)
#uniquename(mk_zip_name)
#uniquename(mk_npa_nxx_line)
#uniquename(mk_surname)
#uniquename(mk_wdtg)
#uniquename(mk_cmp_name)

ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_address','Q',%mk_addr%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_phone','Q',%mk_phone%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_did','Q',%mk_did%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_hhid','Q',%mk_hhid%);
ut.MAC_SK_Move_v2('~thor_Data400::key::gong_hist_bdid','Q',%mk_bdid%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_name','Q',%mk_name%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_zip_name','Q',%mk_zip_name%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_npa_nxx_line','Q',%mk_npa_nxx_line%);
RoxieKeyBuild.MAC_SK_Move('~thor_data400::key::gong_history::@version@::surnames','Q',%mk_surname%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_wdtg','Q',%mk_wdtg%);
ut.MAC_SK_Move_v2('~thor_data400::key::gong_history_companyname','Q',%mk_cmp_name%);

#uniquename(mk)

%mk% := parallel(%mk_addr%,%mk_phone%,%mk_did%,%mk_hhid%,%mk_bdid%,%mk_name%,%mk_zip_name%,%mk_npa_nxx_line%,%mk_surname%,%mk_wdtg%,%mk_cmp_name%
//copy keys for FCRA
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','address')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','phone')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','did')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','hhid')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','bdid')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','name')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','zip_name')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','npa_nxx_line')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','surnames')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','wdtg')
			,gong.Proc_Copy_FCRA_Keys(filedate,'gong_history','companyname'));


build_keys := sequential(%bk%,%mv1%,%mk%);

endmacro;