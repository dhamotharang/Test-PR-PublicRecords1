import AutokeyB2, roxiekeybuild, CanadianPhones;

export proc_fedex_build_keys(string version_date) := function
	fedex_dataset := fedex.fedex_autokey_constants.autokey_dataset;
	logical_key		:= fedex.fedex_autokey_constants.str_AutokeyLogicalName(version_date);
	super_keyname	:= fedex.fedex_autokey_constants.str_autokeyname;
	skip_set			:= fedex.fedex_autokey_constants.autokey_skip_set;
	
	AutoKeyB2.MAC_Build(fedex_dataset,
											fname,mname,lname,
											zero,
											zero,
											phone,
											prim_name,prim_range,st,v_city_name,zip5,sec_range,
											zero,
											zero,zero,zero,
											zero,zero,zero,
											zero,zero,zero,
											zero,
											did,
											last_name,
											zero,
											phone,
											prim_name,prim_range,st,v_city_name,zip5,sec_range,
											bdid,
											super_keyname,
											logical_key,
											outaction,
											false,
											skip_set,
											true,,
											true,,,zero,
											,,,,,
											CanadianPhones.MAutokey, 
											CanadianPhones.MAutokeyb)

	AutoKeyB2.MAC_AcceptSK_to_QA(super_keyname,move_qa,,fedex.fedex_autokey_constants.autokey_skip_set);
	
	RoxieKeyBuild.Mac_Daily_Email_Local('FEDEX','SUCC', version_date, send_succ_msg, RoxieKeyBuild.Email_Notification_List);
	RoxieKeyBuild.Mac_Daily_Email_Local('FEDEX','FAIL', version_date, send_fail_msg, 'kgummadi@seisint.com');
	
	update_dops := RoxieKeyBuild.updateversion('FedExKeys',version_date,'kgummadi@seisint.com');
	build_keys	:= sequential(outaction, move_qa, update_dops) : success(send_succ_msg), failure(send_fail_msg);
	 
	return 
	parallel(
		if((integer8)ut.GetDate > 20090301, output('PROC_FEDEX_BUILD_KEYS SHOULD BE RETIRED AND PROC_FEDEX_BUILD_KEYS2 SHOULD BE USED IN ITS PLACE.  SEE BUG 36091.')),
		build_keys,
		fedex.proc_fedex_build_keys2(version_date)
	);
end;