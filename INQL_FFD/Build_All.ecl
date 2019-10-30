import versioncontrol, _control, ut, tools, std, dops;

export Build_all(  		string  pVersion   = ''   
									, 	boolean isFCRA     = true) := function

build_full_key := sequential(  	Build_Base(false, isFCRA, pVersion).all; // update weekly base
																Build_Keys(false, isFCRA, pVersion).all; // build full keys - new
																dops.updateversion('FCRA_InquiryHistoryKeys',pVersion,INQL_FFD.Email_Notification_Lists.DopsUpdate,,'F')
															);

build_delta_key  := Sequential (
																Build_Keys(true, isFCRA, pVersion).all, // build delta keys
																Build_Strata(true, isFCRA, pVersion).all,
																dops.updateversion('FCRA_InquiryHistoryKeys',pVersion,INQL_FFD.Email_Notification_Lists.DopsUpdate,,'F',l_updateflag:='DR')
															);

doBuild 				 := sequential(
																Build_Base(true,isFCRA,pVersion).all, // update daily base 
																if (_Flags().Weekday,  
																		Sequential (
																								if (_Flags().LastFullKeyVersionApproved and count(_Flags().versionsInDailyBase) >= 6 
																									   ,build_full_key
																									   ,output('Full Keys will not be built - ' + Fn_Get_Current_Version.fcra_full_keys_dops_certQA + ' is still in QA or Age of Daily Base is less than 6 days ')
																									 ),
																								if (_Flags().LastKeyVersionApproved
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