import ut, PromoteSupers, roxiekeybuild, prte, Prte2, PRTE2_Common, _control, std, tools, strata, dops, Orbit3;


EXPORT proc_build_keys(string filedate, boolean skipDOPS=FALSE, string emailTo='') := function

is_running_in_prod 		:= PRTE2_Common.Constants.is_running_in_prod;
doDOPS 								:= is_running_in_prod AND NOT skipDOPS;

roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.bdid,'',				Constants.key_prefix+filedate+'::bdid',Key1);
roxiekeybuild.mac_sk_buildprocess_v2_local(Keys.LinkIds.Key,'', Constants.key_prefix+filedate+'::linkids',Key2);

RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.key_prefix+'@version@::bdid',			Constants.key_prefix+filedate+'::bdid',	mv_key1);
RoxieKeyBuild.Mac_SK_Move_To_Built_V2(Constants.key_prefix+'@version@::linkids',	Constants.key_prefix+filedate+'::linkids',	mv_key2);

RoxieKeyBuild.MAC_SK_Move_V2(Constants.key_prefix+'@version@::bdid',		'Q',mv_key1_qa,	2);
RoxieKeyBuild.MAC_SK_Move_V2(Constants.key_prefix+'@version@::linkids',	'Q',mv_key2_qa,	2);


//---------- making DOPS optional and only in PROD build -------------------------------													
		notifyEmail 				:= IF(emailTo<>'',emailTo,_control.MyInfo.EmailAddressNormal);
		NoUpdate 						:= OUTPUT('Skipping DOPS update because it was requested to not do it, or we are not in PROD');						
		updatedops   		 		:= PRTE.UpdateVersion('IRSKeys',filedate,notifyEmail,'B','N','N');
    PerformUpdateOrNot 	:= IF(doDOPS,sequential(updatedops),NoUpdate);
		
		key_validation :=  output(dops.ValidatePRCTFileLayout(filedate, prte2.Constants.ipaddr_prod, prte2.Constants.ipaddr_roxie_nonfcra,Constants.dops_name, 'N'), named(Constants.dops_name+'Validation'));

    updateorbit		:= Orbit3.proc_Orbit3_CreateBuild('PRTE - IRS', filedate, 'N', true, true, false, _control.MyInfo.EmailAddressNormal);  
buildKey	:=	ordered(
												parallel(Key1,Key2)
												,parallel(mv_key1,mv_key2)
												,parallel(mv_key1_qa,mv_key2_qa)
												,PerformUpdateOrNot
												,key_validation
												,updateorbit);	
										

return	buildKey;

end;




