//ModifiedBy:vern_p bentley
//ModifiedDate:2015-10-27T18:22:45Z
//Description:migrated from Dataland for BIPV2 Sprint 1
import BizLinkFull,tools;
#workunit('name', 'Rollback ' + BizLinkFull._Constants().name + ' Build');
pversion          := ''     ; //version of build you are rolling back
pDeleteBuildFiles	:= 	false	;	//are the build files bad(base and key files) and need to be deleted?
pIsTesting		  	:= 	true	;	//if false, will perform rollback and optional deletion.  
                              //If true, just output dataset of information gathered.
pFilter						:= 	''		;	//regex filter to use if u want to rollback only specific files/keys
sequential(
   BizLinkFull.Rollback(pversion,pDeleteBuildFiles,pIsTesting,pFilter).father2qa
	,BizLinkFull.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'BizLinkFull',tools.fun_Groupname('20')).father2qa
	,BizLinkFull.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'BizLinkFull',tools.fun_Groupname('84')).father2qa
	,BizLinkFull.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'BizLinkFull',tools.fun_Groupname('92')).father2qa
	,BizLinkFull.Rollback(pversion,pDeleteBuildFiles,pIsTesting,'BizLinkFull',tools.fun_Groupname('30')).father2qa
);

