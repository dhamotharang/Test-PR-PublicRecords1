import RoxieKeyBuild,PRTE, _control, STD,prte2,tools, PRTE2_Common, strata;

EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function
is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 								:= is_running_in_prod AND NOT skipDOPS;
		
//Foreclosures Keys
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_did(), 					Constants.key_prefix + 'did',							Constants.key_prefix+filedate+ '::did',							do1);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.key_email_address,	Constants.key_prefix + 'email_addresses',	Constants.key_prefix+filedate+ '::email_addresses',	do2);

//FCRA Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.key_did(true),			Constants.key_prefix + 'did',							Constants.key_prefix_fcra+filedate+'::did',					fcra_do1);
build_roxie_keys	:=	parallel(	do1, do2, fcra_do1);


// Move keys to built superfile
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+'did',							Constants.key_prefix+filedate+'::did',							mv1);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+'email_addresses',	Constants.key_prefix+filedate+'::email_addresses',	mv2);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_fcra+'did',				Constants.key_prefix_fcra+filedate+'::did',					fcra_mv1);

Move_keys	:=	parallel(	mv1, mv2, fcra_mv1);


// Move keys to QA superfile
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'did',							'Q',mv_qa1,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName+'email_addresses',	'Q',mv_qa2,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.SuperKeyName_fcra+'did',					'Q',fcra_mv_qa1,2);


To_qa	:=	parallel(mv_qa1, mv_qa2, fcra_mv_qa1);

// -- Build Autokeys
build_autokeys 	:= Keys.autokeys(filedate);

//DF-22112 FCRA Consumer Data Field Depreciation
cnt_email_data_fcra := OUTPUT(strata.macf_pops(Keys.key_did(true),,,,,,FALSE,['orig_ip']), named('CNT_EMAIL_DATA_FCRA'));


//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('EmailDataKeys',filedate,notifyEmail,'B','N','N');
		updatedops_fcra  		:= PRTE.UpdateVersion('FCRA_EmailDataKeys',filedate,notifyEmail,'B','F','N');
		PerformUpdateOrNot 	:= IF(doDOPS,parallel(updatedops,updatedops_fcra),NoUpdate);
//--------------------------------------------------------------------------------------


// -- Actions
buildKey	:=	sequential(
												build_roxie_keys
												,Move_keys
												,to_qa
												,build_autokeys
												,cnt_email_data_fcra
												,PerformUpdateOrNot
												);	

return	buildKey;

end;
