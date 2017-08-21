import ut, PromoteSupers, roxiekeybuild, prte, PRTE2_Common, _control;

EXPORT proc_build_keys(string filedate) := FUNCTION

// Roxie keys	
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.SourceRecId, 	Constants.KEY_PREFIX + 'source_rec_id', Constants.KEY_PREFIX+filedate + '::source_rec_id',key1);
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.LinkIds.Key,	Constants.KEY_PREFIX + 'linkids',				Constants.KEY_PREFIX + filedate + '::linkids',key2);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.key_prefix+'@version@::source_rec_id',Constants.KEY_PREFIX+filedate+ '::source_rec_id',	mv_key1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.key_prefix+'@version@::linkids',			Constants.KEY_PREFIX+filedate+ '::linkids',			mv_key2);

// -- Move Keys to QA
RoxieKeyBuild.MAC_SK_Move_V2(Constants.key_prefix+'@version@::source_rec_id','Q',mv_key1_qa,2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.key_prefix+'@version@::linkids',			 'Q',mv_key2_qa,2);



// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 		:= OUTPUT('Skipping DOPS process');
updatedops   		 		:= PRTE.UpdateVersion('FrandxKeys',filedate,_control.MyInfo.EmailAddressNormal,'B','N','N');

// -- Actions
buildKey	:=	ordered(
												parallel(key1,key2),
												parallel(mv_key1,mv_key2),
												parallel(mv_key1_qa,mv_key2_qa),
												if(not is_running_in_prod, DOPS_Comment, updatedops)
												);	

return	buildKey;

end;
