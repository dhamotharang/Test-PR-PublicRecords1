import RoxieKeyBuild,Suppress,ut,dops,prte,PRTE2_Common, _control;

export proc_build_keys(String pVersion) := FUNCTION

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.New_Suppression(),				'',Constants.KEY_PREFIX + pversion+'::link_type_link_id',bld_key,true);

//FCRA Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Keys.New_Suppression(true),'',Constants.KEY_PREFIX_FCRA + pversion+'::link_type_link_id',bld_key_fcra,true);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName+'link_type_link_id',						Constants.KEY_PREFIX	+	pversion	+	'::link_type_link_id',mv_built);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2(Constants.SuperKeyName_FCRA+'link_type_link_id',	Constants.KEY_PREFIX_FCRA	+pversion	+	'::link_type_link_id',mv_built_fcra);


RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName+'link_type_link_id','Q',mv_qa);
RoxieKeyBuild.Mac_SK_Move_V2(Constants.SuperKeyName_FCRA+'link_type_link_id','Q',mv_qa_fcra);


// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
is_running_in_prod 	:= PRTE2_Common.Constants.is_running_in_prod;
DOPS_Comment		 					:= OUTPUT('Skipping DOPS process');
update_dops 								:= PRTE.UpdateVersion('SuppressionKeys',pVersion,_control.MyInfo.EmailAddressNormal,'B','N','N');
update_dops_fcra 			:= PRTE.UpdateVersion('FCRA_SuppressionKeys',pVersion,_control.MyInfo.EmailAddressNormal,'B','F','N');
        										
													
RETURN Sequential(parallel(bld_key,bld_key_fcra),
																		parallel(mv_built, mv_built_fcra),
																		parallel(mv_qa, mv_qa_fcra),
																		if(not is_running_in_prod, DOPS_Comment, parallel(update_dops,update_dops_fcra))
																		);
																		

end;
