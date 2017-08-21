import ut, PromoteSupers, roxiekeybuild, prte, PRTE2_Common, _control;

EXPORT proc_build_keys(string filedate) := FUNCTION

roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.bdid,'',				Constants.key_prefix+filedate+'::bdid',Key1);
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.LinkIds.Key,'', Constants.key_prefix+filedate+'::linkids',Key2);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.key_prefix+'@version@::bdid',			Constants.key_prefix+filedate+'::bdid',	mv_key1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.key_prefix+'@version@::linkids',	Constants.key_prefix+filedate+'::linkids',	mv_key2);

RoxieKeyBuild.MAC_SK_Move_V2(Constants.key_prefix+'@version@::bdid',		'Q',mv_key1_qa,	2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.key_prefix+'@version@::linkids',	'Q',mv_key2_qa,	2);

// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 		:= OUTPUT('Skipping DOPS process');
updatedops   		 		:= PRTE.UpdateVersion('IRSKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');

// -- Actions
buildKey	:=	ordered(
												parallel(Key1,Key2)
												,parallel(mv_key1,mv_key2)
												,parallel(mv_key1_qa,mv_key2_qa)
												,if(not is_running_in_prod, DOPS_Comment, updatedops)
											 );	

return	buildKey;

end;




