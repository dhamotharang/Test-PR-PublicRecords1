import BIPV2_Build,BIPV2,tools;


pversion          := BIPV2.Keysuffix     ; //version of build you are rolling back
pDeleteBuildFiles	:= 	true	;	//are the build files bad(base and key files) and need to be deleted?
pIsTesting		  	:= 	true	;	//if false, will perform rollback and optional deletion.  
                              //If true, just output dataset of information gathered.
pFilter						:= 	''		;	//regex filter to use if u want to rollback only specific files/keys

#workunit('name', 'Rollback ' + BIPV2_Build._Constants().name + ' Build ' + pversion);


sequential(
   BIPV2_Build.Rollback(pversion,pDeleteBuildFiles,pIsTesting,pFilter).clearbuilt;
//	,BIPV2_Build.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'bizlinkfull',tools.fun_Groupname('20')).father2qa
//	,BIPV2_Build.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'bizlinkfull',tools.fun_Groupname('30')).father2qa
//	,BIPV2_Build.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'bizlinkfull',tools.fun_Groupname('60')).father2qa
//	,BIPV2_Build.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'bizlinkfull',tools.fun_Groupname('44')).father2qa
);
