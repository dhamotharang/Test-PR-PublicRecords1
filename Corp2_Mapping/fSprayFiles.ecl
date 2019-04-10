import tools, _control, corp2, std;

export fSprayFiles(
	 string		pCorpState									= ''																		//to spray a specific state, or set of states(delimited by pipes)
	,string		pversion										= ''																		//to override the version
	,boolean	pShouldIncludeLookups				= false
	,string		pSourceIP										= _Control.IPAddress.bctlpedata10
	,string		pSourceDir									= '/data/data_build_4/corporate_filings/out'
	,boolean	pOverwrite									= false
	,string		pEmailAddress								= _Control.MyInfo.emailaddressnotify
	,string		pGroupName									= tools.fun_Groupname('44')
	,boolean	pShouldClearSuperfileFirst	= true
	,boolean	pIsTesting									= false
	,boolean	pSplitEmails								= true
	,boolean	pShouldSprayZeroByteFiles		= false
	,string   pSuffix											= ''

) :=
function

	FilesToSpray 		:= Corp2_Mapping.SprayDataset(pSourceIP,pSourceDir,pCorpState,pversion,pGroupName,pSuffix);
	
	lookup_filter 	:= if(pShouldIncludeLookups = true or
												//list of states where lookups are mandatory and come in each update
												regexfind('^.*?(ak|ga|ks|mo|ms|nh|oh|pa)$',FilesToSpray.Thor_filename_template,nocase)
													,true
													,not regexfind('lookup',FilesToSpray.Thor_filename_template, nocase)
											 );
									
	lUpdateFreqency	:= if(regexfind('(daily|monthly|weekly)',pSourceDir),
											  ' ' + regexfind('(daily|monthly|weekly)'	,pSourceDir	,0) + ' ',
												' '
											 );
	
	lVersion				:= map(pversion != ''																			=> pversion,
												 regexfind('[[:digit:]]{8}[[:alpha:]]?',pSourceDir) => regexfind('[[:digit:]]{8}[[:alpha:]]?',pSourceDir	,0),
												 (string)std.date.today()
											  );
											
	lStates 				:= if(pCorpState = '','All States',regexreplace('\\|', pCorpState, ', '));

	lSprayLog		 		:= if(pCorpState = '','All_States',regexreplace('\\|', pCorpState, '_'));
	
	isKS 						:= if(regexfind('ks', pCorpState, nocase) or pCorpState = '', true, false);
									  
	return	tools.fun_Spray(FilesToSpray(lookup_filter)
												 ,'~thor_data400::spraylogs::corp2'
												 ,'~thor_data400::spraylogs::corp2::' + lVersion + '::' + lSprayLog
												 ,pOverwrite
												 ,
												 ,false
												 ,pIsTesting
												 ,corp2.Email_Notification_Lists.spray + ';' + pEmailAddress
												 ,'CorpV2 ' + stringlib.stringtouppercase(lStates) + lUpdateFreqency + lVersion
												 ,
												 ,pShouldClearSuperfileFirst
												 ,pSplitEmails
												 ,isKS //pShouldSprayZeroByteFiles
												 ,
												 ,pversion
											);

end;