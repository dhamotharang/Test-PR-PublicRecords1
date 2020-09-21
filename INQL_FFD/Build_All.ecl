import versioncontrol, _control, ut, tools, std, dops, orbit3;

export Build_all(  string  pVersion   = ''   
									,boolean isFCRA     = true) := function

build_full_key := sequential  ( 
																Build_Base(false, isFCRA, pVersion).all; // update weekly base
																Build_Keys(false, isFCRA, pVersion).all; // build full keys - new
																dops.updateversion('FCRA_InquiryHistoryKeys',pVersion,INQL_FFD.Email_Notification_Lists.DopsUpdate,,'F');
																INQL_FFD.FN_Update_Orbit(pVersion).run;
																//INQL_FFD.proc_KeyDiff;
															);

build_delta_key := Sequential (
																Build_Keys(true, isFCRA, pVersion).all, // build delta keys
																Build_Strata(true, isFCRA, pVersion).all,
																dops.updateversion('FCRA_InquiryHistoryKeys',pVersion,INQL_FFD.Email_Notification_Lists.DopsUpdate,,'F',l_updateflag:='DR');
															  INQL_FFD.FN_Update_Orbit(pVersion).run;
															);

doBuildFull := _Flags().LastFullKeyVersionApproved and _Flags().timetobuildfull and _Flags().LastKeyVersionApproved;
doBuildDelta:= _Flags().LastKeyVersionApproved;

doBuild 				:= sequential (
																Build_Base(true,isFCRA,pVersion).all, // update daily base 
																if (_Flags().Weekday,  
																		Sequential (
																								if (doBuildFull
																									   ,build_full_key
																									   ,output('Full Keys will not be built - ' + Fn_Get_Current_Version.fcra_full_keys_dops_certQA + ' is still in QA or Age of Daily Base is less than 6 days ')
																									 ),
																								if (~doBuildFull and doBuildDelta
																										,build_delta_key
																										,output('Delta Keys will not be built - ' + Fn_Get_Current_Version.fcra_keys_dops_certQA + ' is still in QA')
																										)
																								)
																			,output('Keys will not be built - Today is Weekend')
																		)	
															): success(Send_Email(pversion).BuildSuccess), failure(send_email(pversion).BuildFailure);

dontBuild := Send_Email(pversion,_Flags(pversion).DontBuildMsg).DontBuild;

execute := if(_Flags(pversion).DontBuildMsg = '', doBuild, dontBuild);

return execute;

end;