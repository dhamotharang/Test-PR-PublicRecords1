import fieldstats,ut,business_header,roxiekeybuild,STRATA,_control;

export proc_build_all(string filedate) := function
 
	atf.mac_atf_spray('edata10','/prod_data_build_13/production_data/atf/out/atf_firearms_explosives.d00',filedate,prespray);
	prebuild_spray := prespray : success(output('Pre-build Spray completed.'));
  
	df := atf.firearms_explosives_did_ssn();

	ut.MAC_SF_BuildProcess(df,'~thor_data400::base::atf_firearms_explosives',b,3,,true)
	build_process := b : success(output('Build of Base ATF file complete.'));

	build_keys := atf.proc_build_keys_new(filedate) : success(output('Build of Thor keys complete.'));

	RoxieKeyBuild.Mac_Daily_Email_Local('ATF','SUCC',filedate,send_succ_msg,Spray_Notification_Email_Address);
	RoxieKeyBuild.Mac_Daily_Email_Local('ATF','FAIL',filedate,send_fail_msg,Spray_Notification_Email_Address);

	ds := dataset('~thor_data400::base::atf_firearms_explosives', ATF.layout_firearms_explosives_out_BIP, flat);
	base_rec_count := output(count(ds), NAMED('Record_Count'));
	base_rec_count_with_did := output(count(ds((integer)DID_out > 0)), NAMED('Record_Count_With_DID'));
	base_rec_count_with_bdid := output(count(ds((integer)bdid > 0)), NAMED('Record_Count_With_BDID'));
	base_rec_count_with_both := output(count(ds((integer)bdid > 0 and (integer)DID_out > 0)), NAMED('Record_Count_With_Both'));
	base_rec_count_with_ssn := output(count(ds(best_ssn != '')), NAMED('Record_Count_With_ssn'));
	date_stats := Query_State_Date_Stats;

 	STRATA.CreateAsHeaderStats(ATF.ATF_as_header(ATF.file_firearms_explosives_base_BIP),
														 'Federal Explosives & Firearms',
														 'data',
														 filedate,
														 '',
														 runAsHeaderStats
														);
   
	 
	 return sequential(prebuild_spray
	                  ,build_process
										,build_keys
										,base_rec_count
										,base_rec_count_with_did
										,base_rec_count_with_bdid
										,base_rec_count_with_both
										,base_rec_count_with_ssn
										,date_stats
										,atf.Out_Base_Stats_Population(filedate)
										,runAsHeaderStats
										);
end;