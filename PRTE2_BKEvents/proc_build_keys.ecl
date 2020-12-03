import RoxieKeyBuild,PRTE, _control, STD,prte2,tools, prte2_Common, dops;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := FUNCTION
is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 								:= is_running_in_prod AND NOT skipDOPS;


// Roxie keys	
//	abbreviated case number keys				
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.courtcode_casenumber(),					Constants.KEY_PREFIX + 'courtcode.casenumber.caseId.payload', Constants.KEY_PREFIX+filedate + '::courtcode.casenumber.caseId.payload',nonfcrakey);
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.courtcode_casenumber(true),			Constants.KEY_PREFIX_FCRA +'courtcode.casenumber.caseId.payload' ,		Constants.KEY_PREFIX_FCRA+filedate+ '::courtcode.casenumber.caseId.payload',fcrakey);

//	full case number keys				
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.courtcode_fullcasenumber(),			Constants.KEY_PREFIX + 'courtcode.fullcasenumber.caseId.payload',		Constants.KEY_PREFIX + filedate + '::courtcode.fullcasenumber.caseId.payload',nonfcrafullkey);
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.courtcode_fullcasenumber(true),	Constants.KEY_PREFIX_FCRA + 'courtcode.fullcasenumber.caseId.payload',	Constants.KEY_PREFIX_FCRA + filedate + '::courtcode.fullcasenumber.caseId.payload',fcrafullkey);


RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+ 'courtcode.casenumber.caseId.payload',					Constants.KEY_PREFIX+filedate+ '::courtcode.casenumber.caseId.payload'	,					mv_nonfcra);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+ 'courtcode.casenumber.caseId.payload',			Constants.KEY_PREFIX_FCRA+filedate+ '::courtcode.casenumber.caseId.payload',			mv_fcra);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName+ 'courtcode.fullcasenumber.caseId.payload',			Constants.KEY_PREFIX+filedate+ '::courtcode.fullcasenumber.caseId.payload',				mv_nonfcrafull);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.SuperKeyName_FCRA+ 'courtcode.fullcasenumber.caseId.payload',	Constants.KEY_PREFIX_FCRA+filedate+ '::courtcode.fullcasenumber.caseId.payload',	mv_fcrafull);



// -- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+ 'courtcode.casenumber.caseId.payload',					'Q',mv_nonfcra_qa,		2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_FCRA+ 'courtcode.casenumber.caseId.payload',		'Q',mv_fcra_qa,				2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+ 'courtcode.fullcasenumber.caseId.payload',			'Q',mv_nonfcrafull_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_FCRA+ 'courtcode.fullcasenumber.caseId.payload','Q',mv_fcrafull_qa,		2);



// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 

	notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
	NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');		
	updatedops   		 		:= PRTE.UpdateVersion(constants.dops_name,filedate,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='N',l_includeboolean := 'N');
	update_fcra_dops   		 		:= PRTE.UpdateVersion(constants.dops_fcra_name,filedate,_control.MyInfo.EmailAddressNormal,l_inloc:='B',l_inenvment:='F',l_includeboolean := 'N');
	
  PerformUpdateOrNot 	:= IF(doDOPS,parallel(updatedops,update_fcra_dops),NoUpdate);
	
	key_validations :=  parallel(output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation')),
                   output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_fcra,Constants.dops_fcra_name, 'F'), named(Constants.dops_fcra_name+'Validation')));	
 
		
// -- Actions
buildKey	:=	sequential(
												parallel(nonfcrakey,fcrakey,nonfcrafullkey,fcrafullkey),
												parallel(mv_nonfcra,mv_fcra,mv_nonfcrafull,mv_fcrafull),
												parallel(mv_nonfcra_qa,mv_fcra_qa,mv_nonfcrafull_qa,mv_fcrafull_qa),
												copy_seeds(filedate),
												key_validations,
											  PerformUpdateOrNot
												);	

return	buildKey;

end;

