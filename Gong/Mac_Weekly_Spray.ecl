export Mac_Weekly_Spray(sourceIP,sourcefile,filedate,build_header_key='false',group_name= '') := 
macro
#uniquename(spray_first)
#uniquename(clear_super)
#uniquename(add_super)
#uniquename(clear_father)
#uniquename(add_father)
#uniquename(last_step)
#uniquename(clear_adds)
#uniquename(clear_deletes)
#uniquename(clear_add_key_hhid)
#uniquename(clear_add_key_did)
#uniquename(clear_add_key_addr)
#uniquename(clear_add_key_phone)
#uniquename(clear_add_key_czsslf)
#uniquename(clear_add_key_lczf)
#uniquename(clear_eda_key1)
#uniquename(clear_eda_key2)
#uniquename(clear_eda_key3)
#uniquename(clear_eda_key4)
#uniquename(clear_eda_key5)
#uniquename(clear_remove_key)
#uniquename(spray_actions)
#uniquename(chk_spray)
#uniquename(send_mail)
#uniquename(recordsize)
#uniquename(do_all)
#uniquename(do_partial)

#workunit('name','Gong Weekly Spray '+filedate);
#option('sortindexpayload',false);
%recordsize%:=845;

%spray_first% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::gong_'+filedate ,-1,,,true,true);
%clear_father% := fileservices.clearsuperfile('~thor_data400::base::gong_father');
%add_father% := fileservices.addsuperfile('~thor_data400::base::gong_father','~thor_data400::base::gong',,true);
%clear_super% := fileservices.clearsuperfile('~thor_data400::base::gong');
%add_super% := fileservices.addsuperfile('~thor_data400::base::gong','~thor_data400::in::gong_'+filedate);
ut.Mac_SF_Clear('~thor_data400::BASE::gong_daily_additions', %clear_adds%);
ut.Mac_SF_Clear('~thor_data400::BASE::gong_daily_deletions', %clear_deletes%);
ut.Mac_SK_Clear('~thor_data400::key::gong_address_add',%clear_add_key_addr%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_did_add',%clear_add_key_did%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_hhid_add',%clear_add_key_hhid%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_phone_add',%clear_add_key_phone%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_czsslf_add',%clear_add_key_czsslf%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_lczf_add',%clear_add_key_lczf%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_eda_npa_nxx_line_add',%clear_eda_key1%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_eda_st_bizword_city_add',%clear_eda_key2%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_eda_st_city_prim_name_prim_range_add',%clear_eda_key3%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_eda_st_lname_city_add',%clear_eda_key4%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_eda_st_lname_fname_city_add',%clear_eda_key5%,4);
ut.Mac_SK_Clear('~thor_data400::key::gong_remove',%clear_remove_key%,4);

gong.MAC_Merge_Current(filedate,%do_all%,,'Y')
gong.MAC_Merge_Current(filedate,%do_partial%)

%spray_actions% := sequential(%spray_first%,%clear_father%,%add_father%,%clear_super%,%add_super%,
                              parallel(%clear_adds%,%clear_deletes%,
						         %clear_add_key_addr%,%clear_add_key_did%,
							    %clear_add_key_hhid%,%clear_add_key_phone%,
							    %clear_add_key_czsslf%,%clear_add_key_lczf%,
							    %clear_eda_key1%,%clear_eda_key2%,
							    %clear_eda_key3%,%clear_eda_key4%,
							    %clear_eda_key5%,%clear_remove_key%));

%last_step% := 
  if(Fileservices.FileExists('~thor_data400::temp::gong_history_redid'), 
	sequential(
          %do_all%, 
		Fileservices.deletelogicalfile('~thor_data400::temp::gong_history_redid')
		),
//	     %do_partial%); changed so that it will reDID regardless but will remove file if it exists
	     %do_all%);

	

#uniquename(send_succ_msg)
#uniquename(send_fail_msg)
#uniquename(email_send_list)
#uniquename(email_fail_list)

%email_send_list% := 'jtolbert@seisint.com;mluber@seisint.com;dqi@seisint.com;Roxiebuilds@seisint.com;vniemela@seisint.com;tgibson@seisint.com';
%email_fail_list% := 'AVenkatachalam@seisint.com;jtolbert@seisint.com;mluber@seisint.com;dqi@seisint.com;vniemela@seisint.com;tgibson@seisint.com';

RoxieKeyBuild.Mac_Daily_Email_Local('GONG WEEKLY','SUCC', filedate, %send_succ_msg%,%email_send_list%);
RoxieKeyBuild.Mac_Daily_Email_Local('GONG WEEKLY','FAIL', filedate, %send_fail_msg%,%email_fail_list%);

#uniquename(build_full_keys)
#uniquename(build_history_keys)

gong.proc_build_full_keys(filedate,%build_full_keys%);
gong.proc_build_history_keys(filedate,%build_history_keys%);

#uniquename(build_dummy_daily)
%build_dummy_daily% := gong.proc_daily_dummy_keys;

sequential(%spray_actions%,%last_step%,
		 #if(build_header_key)
			doxie_build.Proc_Daily_Header_Key, 
		 #end
		 %build_full_keys%,
		 %build_history_keys%,
		// %build_dummy_daily%
		 ) :
		 //,gong.proc_test_cases) :
		 success(%send_succ_msg%),
		 failure(%send_fail_msg%);

endmacro;