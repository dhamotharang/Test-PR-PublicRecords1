import RoxieKeyBuild,PRTE, _control, STD,prte2,tools;

EXPORT proc_build_keys(string filedate) := FUNCTION


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
updatedops   		 := PRTE.UpdateVersion('BKEventsKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
updatedops_fcra  := PRTE.UpdateVersion('FCRA_BKEventsKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');



// -- Actions
buildKey	:=	sequential(
												parallel(nonfcrakey,fcrakey,nonfcrafullkey,fcrafullkey),
												parallel(mv_nonfcra,mv_fcra,mv_nonfcrafull,mv_fcrafull),
												parallel(mv_nonfcra_qa,mv_fcra_qa,mv_nonfcrafull_qa,mv_fcrafull_qa),
												 parallel(updatedops,updatedops_fcra)
												);	

return	buildKey;

end;

