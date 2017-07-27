import RoxieKeybuild,misc2,idl_header;
export Mac_Utility_Daily_Spray(sourceIP,sourcefile,filedate,group_name='\'thor400_92\'',email_target='\' \'') := 
macro
	#uniquename(spray_utils)
	#uniquename(super_utils)
	#uniquename(recordsize)
	#uniquename(fullfile)
	#uniquename(daily)
	#uniquename(basefile)
	#uniquename(daily_utils)
	#uniquename(daily_clean)
	#uniquename(daily_utils_clean_workphone)
	#uniquename(daily_utils_clean_phone)
	#uniquename(daily_utils_clean_phone0)
	#uniquename(clean_phone)
	#uniquename(baseout)
    #uniquename(ignore_compare)
	#uniquename(daily_canadian)
    #uniquename(daily_canadian_clean)


	#workunit('name','Utility Daily Spray '+filedate);
  #stored('fail_switch', false);
	
	//source file changed to source data "exch2seisint.filedate.Z" in '/eq_utils_build/eq_utils/archive instead of .d00 file.
	%recordsize% :=470;
    %spray_utils% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::eq_utils_raw_'+filedate ,-1,,,true,true);
	%daily_utils% := dataset('~thor_data400::in::eq_utils_raw_'+filedate, UtilFile.layout_util.daily_in, flat);
    %daily_clean% := UtilFile.map_util_daily(%daily_utils%).util_daily_clean;
	header.MAC_555_phones(%daily_clean%, work_phone, %daily_utils_clean_workphone%);
	header.MAC_555_phones(%daily_utils_clean_workphone%, phone, %daily_utils_clean_phone0%);
    ut.mac_flipnames(%daily_utils_clean_phone0%,fname,mname,lname,%daily_utils_clean_phone%);
	%clean_phone% := output(%daily_utils_clean_phone%,,'~thor_data400::in::eq_utils_cleanphone_'+filedate,__compressed__,overwrite);
    %daily_canadian% := UtilFile.map_util_daily(%daily_utils%).util_daily_canadian;
	%daily_canadian_clean% := output(%daily_canadian%,,'~thor_data400::in::eq_utils_canadian_'+filedate,__compressed__,overwrite);
	%super_utils% := sequential(
									FileServices.AddSuperFile('~thor_data400::base::utility_file', '~thor_data400::in::eq_utils_cleanphone_'+filedate), 
									FileServices.AddSuperFile('~thor_data400::in::utility::sprayed::daily', '~thor_data400::in::eq_utils_cleanphone_'+filedate),
								    FileServices.AddSuperFile('~thor_data400::base::utility_canadian_file', '~thor_data400::in::eq_utils_canadian_'+filedate),
									FileServices.AddSuperFile('~thor_data400::in::utility::full_daily', '~thor_data400::in::eq_utils_cleanphone_'+filedate)
								); 

	#uniquename(send_succ_msg)
	#uniquename(send_fail_msg)

	RoxieKeyBuild.Mac_Daily_Email_Local('UTIL','SUCC', filedate, %send_succ_msg%,if(email_target<>' ',email_target,UtilFile.Spray_Notification_Email_Address));
	RoxieKeyBuild.Mac_Daily_Email_Local('UTIL','FAIL', filedate, %send_fail_msg%,if(email_target<>' ',email_target,'kgummadi@seisint.com;skasavajjala@seisint.com;jfreibaum@seisint.com;wma@seisint.com'));

	//Add DID to daily file then move into did superfile for keys
	#uniquename(did_daily)
	%did_daily% := output(UtilFile.Daily_with_did,,'~thor_data400::in::utility::'+filedate+'::daily_did',overwrite);
	#uniquename(add_daily)
	%add_daily% := fileservices.addsuperfile('~thor_data400::in::utility::daily_did','~thor_data400::in::utility::'+filedate+'::daily_did');
	#uniquename(clear_daily)
	%clear_daily% := sequential(FileServices.ClearSuperFile('~thor_data400::in::utility::father::daily',true),
						FileServices.AddSuperFile('~thor_data400::in::utility::father::daily', '~thor_data400::in::utility::sprayed::daily',, true),
						FileServices.ClearSuperFile('~thor_data400::in::utility::sprayed::daily'));
   
   	//reDID if the prod header version is newer than the last utility
    boolean isnewheader := ut.IsNewProdHeaderVersion('Utility');
	#uniquename(util_redid)
	%util_redid% := utilfile.utility_DID(filedate);
	#uniquename(util_daily_redid)
	%util_daily_redid% := utilfile.daily_reDID(filedate);
	//keep the existing file and add daily did file if the prod header version is older than the last utility
	#uniquename(add_daily_did)
	%add_daily_did% := fileservices.addsuperfile('~thor_data400::base::utility_DID','~thor_data400::in::utility::'+filedate+'::daily_did');
	#uniquename(add_daily_did_to_daily_redid)
	%add_daily_did_to_daily_redid% := fileservices.addsuperfile('~thor_data400::base::utility::daily_redid','~thor_data400::in::utility::'+filedate+'::daily_did');
	#uniquename(run_redid)
	%run_redid% := if(isnewheader, %util_redid%, %add_daily_did%);
	#uniquename(run_daily_redid)
	%run_daily_redid% := if(isnewheader, %util_daily_redid%, %add_daily_did_to_daily_redid%);
	//update utility flag file
	#uniquename(util_headerVer_update)
    %util_headerVer_update% := if(isnewheader,ut.PostDID_HeaderVer_Update('Utility'),output('No re-did')); 
    #uniquename(build_util_keys)
	%build_util_keys% := utilfile.proc_build_util_keys(filedate);
	#uniquename(build_util_bus_base)
	%build_util_bus_base% := utilfile.build_util_bus_base(filedate).all;
	#uniquename(build_util_bus_keys)
	%build_util_bus_keys% := utilfile.proc_build_util_bus_keys(filedate);
	#uniquename(accept_keys)
	%accept_keys% := utilfile.Proc_AcceptSK_toQA;
	#uniquename(updatedops)
	%updatedops% := RoxieKeyBuild.updateversion('UtilityDailyKeys',filedate,'jfreibaum@seisint.com');
    
	#uniquename(despraydaily) 
	%despraydaily% := utilfile.pro_monitor().util_despray ; 
	
	%ignore_compare% :=true;
	// if file exists with filedate and is in superfile skip the whole job

	#uniquename(do_despray)
	%do_despray% := misc2.fn_do_both(filedate,%ignore_compare%);
	
	#uniquename(do_build_roxie)
     %do_build_roxie% := misc2.fn_build_roxie_key(filedate);
	 #uniquename(build_misc2b)
	 #uniquename(move_tobuilt_misc2b)
	 #uniquename(move_toqa_misc2b)
	 #uniquename(do_build_hval)
     RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(misc2.key_misc2b_hval,'~thor_data400::key::misc2b::hval','~thor_data400::key::misc2b::'+filedate+'::hval',%build_misc2b%,true);
     RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::misc2b::hval','~thor_data400::key::misc2b::'+filedate+'::hval',%move_tobuilt_misc2b%);
     RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::misc2b::hval','Q',%move_toqa_misc2b%);

     %do_build_hval% := sequential(%build_misc2b%,%move_tobuilt_misc2b%,%move_toqa_misc2b%);
	 #uniquename(build_DateCorrect)
	 #uniquename(move_tobuilt_DateCorrect)
	 #uniquename(move_toqa_DateCorrect)
	 #uniquename(do_build_datecorrect)

	RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(misc2.key_DateCorrect_hval,'~thor_data400::key::DateCorrect::hval','~thor_data400::key::DateCorrect::'+filedate+'::hval',%build_DateCorrect%,true);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::DateCorrect::hval','~thor_data400::key::DateCorrect::'+filedate+'::hval',%move_tobuilt_DateCorrect%);
    RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::DateCorrect::hval','Q',%move_toqa_DateCorrect%);

    %do_build_datecorrect% := sequential(%build_DateCorrect%, %move_tobuilt_DateCorrect%, %move_toqa_DateCorrect%);
	 
	 #uniquename(util_daily_stats)
     %util_daily_stats% := UtilFile.Out_Base_Dev_Stats(filedate);
        #uniquename(out_daily_samples)
	%out_daily_samples% := UtilFile.out_util_samples(filedate);

sequential(%spray_utils%,%clean_phone%,%daily_canadian_clean%,%super_utils%,%did_daily%,%add_daily%,%clear_daily%,%run_redid%,%run_daily_redid%,%util_headerVer_update%,
          %build_util_keys%,%build_util_bus_base%,%build_util_bus_keys%,%accept_keys%,
		  %despraydaily%,%do_despray%,%do_build_roxie%,%do_build_hval%,%do_build_datecorrect%,%util_daily_stats%,%out_daily_samples%,%updatedops%) 
	 : success(%send_succ_msg%),
		 failure(%send_fail_msg%);

endmacro;