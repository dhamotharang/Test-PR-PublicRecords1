IMPORT RoxieKeyBuild;
EXPORT fn_update_dops(string8 process_date,boolean isFast, boolean includeBoolean = true) :=	FUNCTION
				uFlag := if(isFast,'D','F'); // DF-27847 to include only current delta and append logical file to superfle
				emails := LN_PropertyV2_Fast.JobInfo.getEmailsToNotify();
				update_dops := parallel (  
					// FULL KEYS
							 RoxieKeyBuild.updateversion('LNPropertyV2FullKeys'		 , process_date, emails,,'N',,,,,,'F')
							,RoxieKeyBuild.updateversion('FCRA_LNPropertyV2FullKeys', process_date, emails,,'F',,,,,,'F')
					// REGULAR KEYS
							,RoxieKeyBuild.updateversion('LNPropertyV2Keys'				 , process_date, emails,,'N',,,,,,uFlag)
							,RoxieKeyBuild.updateversion('FCRA_LNPropertyV2Keys'		 , process_date, emails,,'F',,,,,,uFlag)
					// BOOLEAN KEYS
							,if(includeBoolean
										,parallel(
															RoxieKeyBuild.updateversion('PropertySharedKeys'		 , process_date, emails,,'B',,,,,,uFlag)
															,if(isFast
																,RoxieKeyBuild.updateversion('LNPropertyV2DeltaKeys' , process_date, emails,,'B',,,,,,'F')
																,RoxieKeyBuild.updateversion('LNPropertyV2Keys'			 , process_date, emails,,'B',,,,,,'F')
															)
								) // end isFast
							) // end include boolean
					); // end parallel
				RETURN update_dops;
END;