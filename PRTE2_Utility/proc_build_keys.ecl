import RoxieKeyBuild,PRTE, _control, STD,prte2,tools,Doxie,AutoStandardI,AutoKeyB2, UtilFile, Autokey, ut, AutokeyB,PRTE2_Common;

EXPORT proc_build_keys(string filedate) := function


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.address,			Constants.SuperKeyName_util +'utility_address', Constants.key_prefix+filedate+'::address',key_addr);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.did,					Constants.SuperKeyName_util +'utility_did',		 	Constants.key_prefix+filedate+'::did',key_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.daily_fdid,		Constants.SuperKeyName +'daily.fdid',						Constants.key_prefix+filedate+'::daily.fid',key_daily_fid);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.daily_did,		Constants.SuperKeyName +'daily.did',						Constants.key_prefix+filedate+'::daily.did',key_daily_did);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.misc2b_hval, 	Constants.SuperKeyName_date +'hval', 						Constants.key_prefix_date+filedate+'::hval',key_hval);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_Local(Keys.LinkIds.Key,	Constants.SuperKeyName +'linkids',							Constants.key_prefix+filedate+'::linkids',key_linkids);														


RoxieKeyBuild.Mac_SK_Move_to_Built_V2(Constants.SuperKeyName_util +'utility_address',	Constants.key_prefix+filedate+'::address',mv_addr);
RoxieKeyBuild.Mac_SK_Move_to_Built_V2(Constants.SuperKeyName_util +'utility_did',			Constants.key_prefix+filedate+'::did',mv_did);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(Constants.SuperKeyName +'daily.fdid',						Constants.key_prefix+filedate+'::daily.fid',mv_daily_fid);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(Constants.SuperKeyName +'daily.did',						Constants.key_prefix+filedate+'::daily.did',mv_daily_did);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(Constants.SuperKeyName_date +'hval',						Constants.key_prefix_date+filedate+'::hval',mv_hval);
RoxieKeyBuild.Mac_SK_Move_To_Built_v2(Constants.SuperKeyName+'linkids',								Constants.key_prefix+filedate+'::linkids',mv_linkids);

build_roxie_keys :=  ordered(parallel(key_addr,key_did,key_daily_fid,key_daily_did,key_hval,key_linkids),
														 parallel(mv_addr,mv_did,mv_daily_fid,mv_daily_did,mv_hval,mv_linkids)
														);
											 
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName_util + 'utility_address',	'Q',mv_addr_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName_util + 'utility_did',			'Q',mv_did_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + 'daily.fdid',						'Q',mv_daily_fid_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + 'daily.did',						'Q',mv_daily_did_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName_date + 'hval',						'Q',mv_hval_qa,2);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName + 'linkids',							'Q',mv_linkids_qa,2);

To_qa	:=	parallel(mv_addr_qa, mv_did_qa, mv_daily_fid_qa, mv_daily_did_qa, 
									 mv_hval_qa, mv_linkids_qa
									);

build_autokeys(string filedate) := function
Mac_Build_Local(files.SearchAutokey,
							  fname,mname,lname,
								ssn,
								dob,
								phone,
								prim_name,prim_range,st,v_city_name,zip,sec_range,
								zero,
								zero,zero,zero,
								zero,zero,zero,
								zero,zero,zero,
								zero,
								fdid,
								Constants.autokeyname,filedate,act,,['-']);
												 
Autokey.MAC_AcceptSK_to_QA(Constants.autokeyname, mymove,,['-']);
 
retval := sequential(act,mymove);

return retval;

end;


// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 			:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 := OUTPUT('Skipping DOPS process');
updatedops   		 := PRTE.UpdateVersion('UtilityDailyKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');
updatedops_fcra	 := PRTE.UpdateVersion('FCRA_UtilityDailyKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','F','N');
											 
// -- Actions
buildKey	:=	ordered(
											build_roxie_keys
											,to_qa
											,build_autokeys(filedate)
										,if(not is_running_in_prod, DOPS_Comment, parallel(updatedops,updatedops_fcra))
											);
													
return	buildKey;
											 
end;