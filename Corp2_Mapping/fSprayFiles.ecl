import Versioncontrol, _control, corp2, ut;

export fSprayFiles(
	 string		pCorpState									= ''																		//to spray a specific state, or set of states(delimited by pipes)
	,string		pversion										= ''																		//to override the version
	,boolean	pShouldIncludeLookups				= false
	,string		pSourceIP										= 'edata10'
	,string		pSourceDir									= '/data_build_4/corporate_filings/out'
	,boolean	pOverwrite									= false
	,string		pEmailAddress								= _control.MyInfo.emailaddressnotify
	,string		pGroupName									= versioncontrol.Groupname('92')
	,boolean	pShouldClearSuperfileFirst	= true
	,boolean	pIsTesting									= false
	,boolean	pSplitEmails								= true
	,boolean	pShouldSprayZeroByteFiles		= false

) :=
function

	FilesToSpray := SprayDataset(pSourceIP,pSourceDir,pCorpState,pversion,pGroupName);
	
	lookup_filter := if(	pShouldIncludeLookups = true 
													//list of states where lookups are mandatory and come in each update
											or regexfind('^.*?(ak|ga|ks|mo|ms|ne|nh|oh|pa)$'	, FilesToSpray.Thor_filename_template, nocase)
											,true
											,not regexfind('lookup'				, FilesToSpray.Thor_filename_template, nocase)
									);
									
	lUpdateFreqency	:= if(regexfind('(daily|monthly|weekly)'	,pSourceDir)
												,' ' + regexfind('(daily|monthly|weekly)'	,pSourceDir	,0) + ' '
												,' '
											);
	
	lVersion				:= map(pversion != ''																			=> pversion
												,regexfind('[[:digit:]]{8}[[:alpha:]]?',pSourceDir) => regexfind('[[:digit:]]{8}[[:alpha:]]?',pSourceDir	,0)
												,ut.GetDate
											);
											
	lCorpState := if(pCorpState = ''
										,'All States'
										,regexreplace('\\|', pCorpState, ', ')
								);

	lCorpStates_for_spray_log := if(pCorpState = ''
										,'All_States'
										,regexreplace('\\|', pCorpState, '_')
								);
	isks := if(regexfind('ks', pCorpState, nocase) or pCorpState = '', true, false);
	
	return 
		VersionControl.fSprayInputFiles(
			 FilesToSpray(lookup_filter)
			,'~thor_data400::spraylogs::corp2'
			,'~thor_data400::spraylogs::corp2::' + lVersion + '::' + lCorpStates_for_spray_log
			,pOverwrite,,false,pIsTesting
			,corp2.Email_Notification_Lists.spray + ';' + pEmailAddress
			,'CorpV2 ' + stringlib.stringtouppercase(lCorpState) + lUpdateFreqency + lVersion
			,,pShouldClearSuperfileFirst
			,pSplitEmails
			,isks
	);

end;