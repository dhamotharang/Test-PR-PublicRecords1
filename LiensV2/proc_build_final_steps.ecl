
export proc_build_final_steps(filedate)
 :=
  macro
	import LiensV2,RoxieKeyBuild,orbit_report;

	LiensV2.proc_liens_stats(filedate,zRunStatsReference);			// now a macro
	new_records_sample_for_qa	:= sequential(LiensV2.New_records_sample(filedate),LiensV2.Email_notification_lists(filedate));
	Stats_For_DR := Liensv2.Liens_Stats_Metadata;
	orbit_report.Liens_Stats(getretval);
	sequential(
		 // Proc_Build_Hogan_Base
		// ,Proc_Build_Base
		// ,notify('LIENS BASE BUILD COMPLETE','*')
		// ,Proc_Build_Keys
		// ,Proc_Accept_to_QA
		//Liensv2.copy_fcra_keys(filedate)
		new_records_sample_for_qa
		,zRunStatsReference
		,Stats_For_DR
		,getretval
		
		
	) : WHEN(event('Yogurt:LIENS BASE BUILD COMPLETE','*'), count(1));

  endmacro
 ;