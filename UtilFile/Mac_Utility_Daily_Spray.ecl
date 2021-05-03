﻿/*2015-05-29T23:55:02Z (Wendy Ma_prod)
skip adding daily canadian file to the superfile if it is empty
*/
import RoxieKeybuild,misc2,idl_header,header,Orbit3,ut;
export Mac_Utility_Daily_Spray(sourceIP,sourcefile,filedate,group_name='\'thor400_44\'',email_target='\' \'') := 
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

  #workunit('protect',true);
	#workunit('priority','high');
	#workunit('priority',14);
	//#OPTION('allowedClusters', 'thor400_44,thor400_20');
	#option ('multiplePersistInstances',FALSE);
	#workunit('name','Yogurt:Utility Daily Spray '+filedate);
  #stored('fail_switch', false);
	
	//source file changed to source data "exch2seisint.filedate.Z" in '/eq_utils_build/eq_utils/archive instead of .d00 file.
	#if(utilfile.mod_newlayout.constant_usenewlayout)
	%recordsize% := 466;
	%spray_utils% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::eq_utils_new_'+filedate ,-1,,,true,true);
	%daily_utils% := dataset(data_services.foreign_prod + 'thor_data400::in::eq_utils_new_'+filedate, UtilFile.layout_util.daily_in_new, flat);
	%daily_clean% := UtilFile.map_util_daily_new(%daily_utils%).util_daily_clean;
	#else
	%recordsize% := 470;
	%spray_utils% := FileServices.SprayFixed(sourceIP,sourcefile, %recordsize%, group_name,'~thor_data400::in::eq_utils_raw_'+filedate ,-1,,,true,true);
	%daily_utils% := dataset('~thor_data400::in::eq_utils_raw_'+filedate, UtilFile.layout_util.daily_in, flat);
	 %daily_clean% := UtilFile.map_util_daily(%daily_utils%).util_daily_clean;
	#end
	header.MAC_555_phones(%daily_clean%, work_phone, %daily_utils_clean_workphone%);
	header.MAC_555_phones(%daily_utils_clean_workphone%, phone, %daily_utils_clean_phone0%);
    ut.mac_flipnames(%daily_utils_clean_phone0%,fname,mname,lname,%daily_utils_clean_phone%);
	
	#uniquename(send_succ_msg)
	#uniquename(send_fail_msg)

	RoxieKeyBuild.Mac_Daily_Email_Local('UTIL','SUCC', filedate, %send_succ_msg%,if(email_target<>' ',email_target,UtilFile.Spray_Notification_Email_Address));
	RoxieKeyBuild.Mac_Daily_Email_Local('UTIL','FAIL', filedate, %send_fail_msg%,if(email_target<>' ',email_target,UtilFile.Spray_Notification_Email_Address));

	//Add DID to daily file then move into did superfile for keys
	#uniquename(did_daily)
	%did_daily% := sequential(output(UtilFile.Daily_with_did(%daily_utils_clean_phone%).base,,'~thor_data400::in::eq_utils_cleanphone_'+filedate,overwrite, __Compressed__),

	output(UtilFile.Daily_with_did(%daily_utils_clean_phone%).did,,'~thor_data400::in::utility::'+filedate+'::daily_did',overwrite, __Compressed__));
	 
	%super_utils% := sequential(
	                if(utilfile.mod_newlayout.constant_usenewlayout,FileServices.AddSuperFile('~thor_data400::in::utility::full_daily_new', '~thor_data400::in::eq_utils_new_'+filedate),
									output('switch to old layout'));
								  FileServices.AddSuperFile('~thor_data400::base::utility_file', '~thor_data400::in::eq_utils_cleanphone_'+filedate), 
									FileServices.AddSuperFile('~thor_data400::in::utility::sprayed::daily', '~thor_data400::in::eq_utils_cleanphone_'+filedate),
									FileServices.AddSuperFile('~thor_data400::in::utility::full_daily', '~thor_data400::in::eq_utils_cleanphone_'+filedate)
								); 

	#uniquename(add_daily)
	%add_daily% := fileservices.addsuperfile('~thor_data400::in::utility::daily_did','~thor_data400::in::utility::'+filedate+'::daily_did');
	#uniquename(clear_daily)
	%clear_daily% := sequential(FileServices.RemoveOwnedSubFiles('~thor_data400::in::utility::father::daily',true),
															FileServices.ClearSuperFile('~thor_data400::in::utility::father::daily'),
						FileServices.AddSuperFile('~thor_data400::in::utility::father::daily', '~thor_data400::in::utility::sprayed::daily',, true),
						FileServices.RemoveOwnedSubFiles('~thor_data400::in::utility::sprayed::daily'),
						FileServices.ClearSuperFile('~thor_data400::in::utility::sprayed::daily'));
   
   //reDID and update phonetype file on Sunday
	pBuildType	:=	IF(ut.weekday((integer)filedate[1..8]) = 'SUNDAY',
			       utilfile.Constants.buildType.FullBuild,
			       utilfile.Constants.buildType.Daily);					 
  boolean isDelta		:=	pBuildType=utilfile.Constants.buildType.Daily;	
	#uniquename(util_redid)
	%util_redid% := utilfile.utility_DID(filedate);	
	#uniquename(util_daily_redid)
	%util_daily_redid% := utilfile.daily_reDID(filedate);
	//keep the existing file and add daily did file in delta build 
	#uniquename(add_daily_did)
	%add_daily_did% := fileservices.addsuperfile('~thor_data400::base::utility_DID','~thor_data400::in::utility::'+filedate+'::daily_did');
  #uniquename(add_daily_did_to_daily_redid)
	%add_daily_did_to_daily_redid% := fileservices.addsuperfile('~thor_data400::base::utility::daily_redid','~thor_data400::in::utility::'+filedate+'::daily_did');
	#uniquename(run_redid)
	%run_redid% := if(~isDelta, sequential(%util_redid%,%util_daily_redid%),sequential(%add_daily_did%,%add_daily_did_to_daily_redid%));
	#uniquename(build_phonetype)
	%build_phonetype% := if(~isDelta, utilfile.proc_build_phonetype(filedate), output('no_phonetype_update_in_deltabuild'));
	#uniquename(build_util_bus_base)
	%build_util_bus_base% := utilfile.build_util_bus_base(filedate).all;
	#uniquename(build_util_keys)
	%build_util_keys% := utilfile.proc_build_keys(filedate,isDelta);	
	#uniquename(updatedops)
	pUpdateFlag		:=	IF(isDelta,'D','F');
	%updatedops% := RoxieKeyBuild.updateversion('UtilityDailyKeys',filedate,'Sudhir.Kasavajjala@lexisnexisrisk.com',,'N',,updateflag:=pUpdateFlag); 
  #uniquename(updatefcradops)
	%updatefcradops% := RoxieKeyBuild.updateversion('UtilityhvalKeys',filedate,'Sudhir.Kasavajjala@lexisnexisrisk.com',,'N|F');
	
	#uniquename(despraydaily) 
	%despraydaily% := utilfile.pro_monitor().util_despray ; 
	
	%ignore_compare% :=true;
	// if file exists with filedate and is in superfile skip the whole job

	 #uniquename(build_misc2b)
	 #uniquename(move_tobuilt_misc2b)
	 #uniquename(move_toqa_misc2b)
	 #uniquename(do_build_hval)
     RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(misc2.key_misc2b_hval,'~thor_data400::key::misc2b::hval','~thor_data400::key::misc2b::'+filedate+'::hval',%build_misc2b%,true);
     RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::misc2b::hval','~thor_data400::key::misc2b::'+filedate+'::hval',%move_tobuilt_misc2b%);
     RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::misc2b::hval','Q',%move_toqa_misc2b%);

     %do_build_hval% := sequential(%build_misc2b%, %move_tobuilt_misc2b%, %move_toqa_misc2b%);
	 #uniquename(build_DateCorrect)
	 #uniquename(move_tobuilt_DateCorrect)
	 #uniquename(move_toqa_DateCorrect)
	 #uniquename(do_build_datecorrect)

	RoxieKeybuild.Mac_SK_BuildProcess_v2_Local(misc2.key_DateCorrect_hval,'~thor_data400::key::DateCorrect::hval','~thor_data400::key::DateCorrect::'+filedate+'::hval',%build_DateCorrect%,true);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::DateCorrect::hval','~thor_data400::key::DateCorrect::'+filedate+'::hval',%move_tobuilt_DateCorrect%);
    RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::DateCorrect::hval','Q',%move_toqa_DateCorrect%);

    %do_build_datecorrect% := sequential(%build_DateCorrect%, %move_tobuilt_DateCorrect%, %move_toqa_DateCorrect%);
	
///////////SCRUBS REPORTS//////////////
	  #uniquename(util_didScrubsReport)
	  %util_didScrubsReport% := UtilFile.UtilDid_Scrubs(filedate,'Wenhong.Ma@lexisnexisrisk.com,Gabriel.Marcan@lexisnexisrisk.com');
	  
///////////SCRUBS REPORTS//////////////
	
	#uniquename(util_daily_stats)
		// modified so that the last thing this build does is submit strata so that the build can finish correctly if strata fails
		   %util_daily_stats% := output(_control.fSubmitNewWorkunit('#workunit(\'name\',\'Utility Strata - '+filedate+'\');\r\n'+
       'UtilFile.Out_Base_Dev_Stats(\''+filedate+'\');\r\n'
       ,std.system.job.target())); 

            #uniquename(out_daily_samples_util_type_1)
					  #uniquename(out_daily_samples_util_type_2)
						#uniquename(out_daily_samples_util_type_3)

//	%out_daily_samples% := UtilFile.out_util_samples(filedate);
	%out_daily_samples_util_type_1% := UtilFile.out_samples_util_type(filedate, '1');
	%out_daily_samples_util_type_2% := UtilFile.out_samples_util_type(filedate, '2');
	%out_daily_samples_util_type_3% := UtilFile.out_samples_util_type(filedate, '3');
	
	#uniquename(orbit_non_fcra)
	#uniquename(orbit_fcra)
	%orbit_non_fcra% := if(ut.Weekday((integer)filedate) <> 'SATURDAY'
											,Orbit3.proc_Orbit3_CreateBuild ( 'Utility',filedate,'N')
											,output('No Orbit Entries Needed for weekend builds'));
	%orbit_fcra% := if(ut.Weekday((integer)filedate) <> 'SATURDAY' and ut.Weekday((integer)filedate) <> 'SUNDAY'
											,Orbit3.proc_Orbit3_CreateBuild ( 'FCRA_Utility',filedate,'F')
											,output('No Orbit Entries Needed for weekend builds'));
 /*Scrubs Alerts and Reports*/					


 sequential(%spray_utils%, %did_daily%,%super_utils%,%util_didScrubsReport%,
					%out_daily_samples_util_type_1%,%out_daily_samples_util_type_2%,%out_daily_samples_util_type_3%,
					%add_daily%, %clear_daily%, %run_redid%, %build_phonetype%,%build_util_bus_base%,%build_util_keys%, 
					%despraydaily%, %do_build_hval%, %do_build_datecorrect%,%updatedops%, %updatefcradops%,
			    %orbit_non_fcra%, %orbit_fcra%,%util_daily_stats%)
	 : success(%send_succ_msg%),
		 failure(%send_fail_msg%);

endmacro;
