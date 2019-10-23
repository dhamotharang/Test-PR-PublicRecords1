import std, Inquiry_AccLogs,RoxieKeyBuild;

export proc_BuildKeys(string pVersion = '', boolean fcra = false, boolean pDaily = true, boolean legacy = true) := function
  
  nonfcra_legacy_daily_keys_build 	:= Inquiry_AccLogs.ProcBuildKeys(pVersion);
	nonfcra_legacy_weekly_keys_build 	:= Inquiry_AccLogs.ProcBuildHistoryKeys;
	
	nonfcra_legacy_keys_build         := if(pDaily, nonfcra_legacy_daily_keys_build, nonfcra_legacy_weekly_keys_build);	
	fcra_legacy_keys_build    				:= Inquiry_AccLogs.ProcBuildFCRAKeys(pVersion);
	
	legacy_keys_build                	:= if(fcra, fcra_legacy_keys_build, nonfcra_legacy_keys_build);
  keys_build                        := if(legacy, legacy_keys_build,INQL_v2.Build_Keys(pVersion, fcra, pDaily).all);
	
  return 														sequential(
																							if(pDaily or fcra, INQL_v2.MOVE_FILES(fcra,pdaily,'Keys').Base_To_Building)
																						 ,keys_build
																						//,RoxieKeybuild.updateversion('InquiryTableUpdateKeys',pVersion,'Fernando.Incarnacao@lexisnexisrisk.com, Darren.Knowles@lexisnexisrisk.com',,'N')
																						 );
	
end;
