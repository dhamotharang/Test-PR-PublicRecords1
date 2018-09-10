import ut,roxiekeybuild, doxie_files, promotesupers,std,dops, strata,data_services;

export proc_build_keys(string version_date) := function

	pre := promotesupers.SF_MaintBuilding('~thor_data400::base::faa_airmen');

	pre2 := promotesupers.SF_MaintBuilding('~thor_data400::base::faa_aircraft_reg');

	pre3 := promotesupers.SF_MaintBuilding('~thor_data400::base::faa_airmen_certs');

	pre4 := sequential(
			 STD.File.StartSuperFileTransaction(),
			if (STD.File.GetSuperFileSubCount('~thor_Data400::base::faa_engine_info_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				STD.File.AddSuperFile('~thor_Data400::base::faa_engine_info_BUILDING','~thor_data400::base::faa_engine_info_in',0,true)),
			STD.File.FinishSuperFileTransaction()
			);
			
	pre5 := sequential(
			 STD.File.StartSuperFileTransaction(),
			if (STD.File.GetSuperFileSubCount('~thor_Data400::base::faa_aircraft_info_BUILDING') > 0,
				output('Nothing added to BUILDING Superfile'),
				STD.File.AddSuperFile('~thor_Data400::base::faa_aircraft_info_BUILDING','~thor_data400::base::faa_aircraft_info_in',0,true)),
			STD.File.FinishSuperFileTransaction()
			);

	do_airmen := if (STD.File.GetSuperFileSubName('~thor_data400::base::faa_airmen',1) = STD.File.GetSuperFileSubName('~thor_data400::base::faa_airmen_BUILT',1),
			output('BASE = BUILT, Nothing done for airmen.'),
			sequential(pre,
				proc_build_keys_bdid(version_date).a_key,
				proc_build_keys_bdid(version_date).b6_key,
				proc_build_keys_bdid(version_date).fcra_a_key,
				proc_build_keys_bdid(version_date).a,
				proc_build_keys_bdid(version_date).mv_fcra_a,
				proc_build_keys_bdid(version_date).b6,
				proc_build_keys_bdid(version_date).fcra_b6_key,
				proc_build_keys_bdid(version_date).mv_fcra_b6,
				proc_build_keys_bdid(version_date).b7_key,
				proc_build_keys_bdid(version_date).fcra_b7_key,
				proc_build_keys_bdid(version_date).b7,
				proc_build_keys_bdid(version_date).mv_fcra_b7));

	do_aircraft := if (STD.File.GetSuperFileSubName('~thor_data400::base::faa_aircraft_reg',1) = STD.File.GetSuperFileSubName('~thor_data400::base::faa_aircraft_reg_BUILT',1),
			output('BASE = BUILT, Nothing done for aircraft.'),
			sequential(pre2,
				proc_build_keys_bdid(version_date).b_key,
				proc_build_keys_bdid(version_date).b1_key,
				proc_build_keys_bdid(version_date).b2_key,
				proc_build_keys_bdid(version_date).b3_key,
				proc_build_keys_bdid(version_date).b4_key,
				proc_build_keys_bdid(version_date).d_key,
				proc_build_keys_bdid(version_date).b,
				proc_build_keys_bdid(version_date).b2,
				proc_build_keys_bdid(version_date).b3,
				proc_build_keys_bdid(version_date).b4,
				proc_build_keys_bdid(version_date).d,
				// FCRA 
				proc_build_keys_bdid(version_date).b1,
				proc_build_keys_bdid(version_date).FCRA_did_key,
				proc_build_keys_bdid(version_date).FCRA_reg_nm_key,
				proc_build_keys_bdid(version_date).fcra_b4_key, 
				proc_build_keys_bdid(version_date).mv_FCRA_did_key,
				proc_build_keys_bdid(version_date).mv_FCRA_reg_nm_key,
				proc_build_keys_bdid(version_date).mv_fcra_b4));

	do_certs := if (STD.File.GetSuperFileSubName('~thor_data400::base::faa_airmen_certs',1) = STD.File.GetSuperFileSubName('~thor_data400::base::faa_airmen_certs_BUILT',1),
			output('BASE = BUILT, Nothing done for Certs.'),
			sequential(pre3,
				proc_build_keys_bdid(version_date).b5_key,
				proc_build_keys_bdid(version_date).fcra_b5_key,
				proc_build_keys_bdid(version_date).b5,
				proc_build_keys_bdid(version_date).mv_fcra_b5));

	do_info1 := if (STD.File.GetSuperFileSubName('~thor_data400::base::faa_engine_info_IN',1) = STD.File.GetSuperFileSubName('~thor_data400::base::faa_engine_info_BUILT',1),
			output('BASE = BUILT, Nothing done for EngineInfo.'),
			sequential(pre4,
				proc_build_keys_bdid(version_date).c_key,
				proc_build_keys_bdid(version_date).c,
				proc_build_keys_bdid(version_date).FCRA_engine_key,
				proc_build_keys_bdid(version_date).mv_FCRA_engine_key));

	do_info2 := if (STD.File.GetSuperFileSubName('~thor_data400::base::faa_aircraft_info_IN',1) = STD.File.GetSuperFileSubName('~thor_data400::base::faa_aircraft_info_BUILT',1),
			output('BASE = BUILT, Nothing done for AircraftInfo.'),
			sequential(pre5,
				proc_build_keys_bdid(version_date).c2_key,
				proc_build_keys_bdid(version_date).c2,
				proc_build_keys_bdid(version_date).FCRA_aircraft_key,
				proc_build_keys_bdid(version_date).mv_FCRA_aircraft_key

				));
			
	d := promotesupers.SF_MaintBuilt('~thor_data400::base::faa_airmen');
			
	e := promotesupers.SF_MaintBuilt('~thor_data400::base::faa_aircraft_reg');

	f := promotesupers.SF_MaintBuilt('~thor_data400::base::faa_airmen_certs');

	g := promotesupers.SF_MaintBuilt('~thor_data400::base::faa_engine_info');

	h := promotesupers.SF_MaintBuilt('~thor_Data400::base::faa_aircraft_info');
	
	RoxieKeyBuild.Mac_Daily_Email_Local('FAA','SUCC',version_date,send_succ_msg,faa.Spray_Notification_Email_Address.roxie_email_list);
	RoxieKeyBuild.Mac_Daily_Email_Local('FAA','FAIL',version_date,send_fail_msg,faa.Spray_Notification_Email_Address.email_list);

	update_faa_version := dops.updateversion('FAAKeys',version_date,faa.Spray_Notification_Email_Address.email_list,,'N|BN');
	update_faa_fcra_version := dops.updateversion('FCRA_FAAKeys',version_date,faa.Spray_Notification_Email_Address.email_list,,'F');

	final := sequential(
		do_airmen,
		do_aircraft,
		do_certs,
		do_info1,
		do_info2,
		proc_build_keys_bdid(version_date).build_autokeys,
		proc_build_keys_bdid(version_date).build_airmen_autokeys,
		parallel(d,e,f,g,h),
		proc_build_keys_bdid(version_date).mv_keys,
		parallel(update_faa_version,update_faa_fcra_version),
		faa.Verify_FCRA_Deprecated_Fields ) : success(send_succ_msg), failure(send_fail_msg);
	
	return final;

end;