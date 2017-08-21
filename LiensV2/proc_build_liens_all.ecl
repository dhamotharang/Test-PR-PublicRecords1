import LiensV2,RoxieKeyBuild,orbit_report, Scrubs_LiensV2;
export proc_build_liens_all(string filedate, string emailList='')
 :=
  function

	

	// LiensV2.proc_liens_stats(filedate,zRunStatsReference)			// now a macro
		
	// Proc_Build_Keys				:= LiensV2.proc_build_liens_keys(filedate);// : success(output('Keys created successfully.'));
	// Proc_Accept_to_QA			:= LiensV2.proc_AcceptSK_ToQA;//	           : success(LiensV2.Mac_Email_Local(filedate)), failure(FileServices.sendemail('wma@seisint.com', 'LiensV2 Build Failure', failmessage));
	// Copy_FCRA_Keys := Liensv2.copy_fcra_keys(filedate);
	// proc_liensV2_Stats			:= zRunStatsReference;//					   : success(output('Stats created successfully.'));
	// new_records_sample_for_qa	:= sequential(LiensV2.New_records_sample,LiensV2.Email_notification_lists(filedate));
	// Stats_For_DR := Liensv2.Liens_Stats_Metadata;
	// Liens_dops_update := sequential(RoxieKeybuild.updateversion('Liensv2Keys',filedate,'avenkatachalam@seisint.com,skasavajjala@seisint.com'),
																	// RoxieKeybuild.updateversion('FCRA_Liensv2Keys',filedate,'avenkatachalam@seisint.com,skasavajjala@seisint.com'));
	// orbit_report.Liens_Stats(getretval);
	return sequential(
		 liensV2.proc_build_Hogan_base(filedate)
		,Liensv2.proc_build_allsources_base(filedate)
		,notify('Yogurt:LIENS BASE BUILD COMPLETE','*')
		,Scrubs_LiensV2.fn_RunScrubs(filedate,emailList)
		// ,Proc_Build_Keys
		// ,Proc_Accept_to_QA
		// ,Copy_FCRA_Keys
		// ,Liens_dops_update
		// ,new_records_sample_for_qa
		// ,proc_liensV2_Stats
		// ,Stats_For_DR
		// ,getretval
		
		
	);

  end
 ;