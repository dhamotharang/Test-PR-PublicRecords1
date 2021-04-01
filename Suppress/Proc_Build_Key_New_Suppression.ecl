import RoxieKeyBuild,Suppress,Orbit3,ut,dops;

export Proc_Build_Key_New_Suppression(String pVersion) := 
FUNCTION

//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_New_Suppression(),'','~thor_data400::key::new_suppression::'+pversion+'::link_type_link_id',bld_key,true);

//FCRA Key
//RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_New_Suppression(true),'','~thor_data400::key::new_suppression::fcra::'+pversion+'::link_type_link_id',bld_key_fcra,true);


//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::new_suppression::@version@::link_type_link_id','~thor_data400::key::new_suppression::'+pversion+'::link_type_link_id',mv_built);
//RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::new_suppression::fcra::@version@::link_type_link_id','~thor_data400::key::new_suppression::fcra::'+pversion+'::link_type_link_id',mv_built_fcra);


//RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::new_suppression::@version@::link_type_link_id','Q',mv_qa);
//RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::new_suppression::fcra::@version@::link_type_link_id','Q',mv_qa_fcra);

//New Name
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_New_Suppression(),'','~thor_data400::key::suppression::'+pversion+'::link_type_link_id',bld_key2,true);
    //RoxieKeyBuild.MAC_build_logical(dx_Suppression.key_suppression(), , '','~thor_data400::key::suppression::'+pversion+'::link_type_link_id',bld_key2,true)
    //DF-28945 Add link_id_did key for Insurance non-FCRA environment. This key will not go to Boca Production
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Data_Key_New_Suppression_Did(),'','~thor_data400::key::suppression::'+pversion+'::link_type_did',bld_key_did,true);
    //FCRA Key
    RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_New_Suppression(true),'','~thor_data400::key::suppression::fcra::'+pversion+'::link_type_link_id',bld_key_fcra2,true);


    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::suppression::@version@::link_type_link_id','~thor_data400::key::suppression::'+pversion+'::link_type_link_id',mv_built2);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::suppression::@version@::link_type_did','~thor_data400::key::suppression::'+pversion+'::link_type_did',mv_built_did);
    RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::suppression::fcra::@version@::link_type_link_id','~thor_data400::key::suppression::fcra::'+pversion+'::link_type_link_id',mv_built_fcra2);


    RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::suppression::@version@::link_type_link_id','Q',mv_qa2);
    RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::suppression::@version@::link_type_did','Q',mv_qa_did);
    RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::suppression::fcra::@version@::link_type_link_id','Q',mv_qa_fcra2);

update_dops 					:= dops.updateversion('SuppressionKeys',pVersion,'Christopher.Brodeur@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'N|B');
update_dops_fcra := dops.updateversion('FCRA_SuppressionKeys',pVersion,'Christopher.Brodeur@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'F');
// update_idops 				:= dops.updateversion('SuppressionKeys',pVersion,'Christopher.Brodeur@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'N',,,'A');

update_orbit := sequential(Orbit3.proc_Orbit3_CreateBuild('Suppression',pVersion,'N|B'),
								Orbit3.proc_Orbit3_CreateBuild('FCRA Suppression',pVersion,'F'));
         										
validate_recs:= Suppress.fn_validate;
													
RETURN Sequential(parallel(bld_key2,bld_key_did,bld_key_fcra2),
																		parallel(mv_built2, mv_built_did, mv_built_fcra2),
																		parallel(mv_qa2, mv_qa_did, mv_qa_fcra2),
																		if(ut.Weekday((integer)pVersion[1..8]) <> 'SATURDAY' and ut.Weekday((integer)pVersion[1..8]) <> 'SUNDAY',
																		        parallel(update_dops, update_dops_fcra),
																            output('No need to update since its Saturday or Sunday')),
																						
																		if(ut.Weekday((integer)pVersion[1..8]) <> 'SATURDAY' and ut.Weekday((integer)pVersion[1..8]) <> 'SUNDAY',
																						update_orbit,/*,Suppress.Proc_OrbitI_CreateBuild(pVersion,'nonfcra')*/
																						output('No Orbit Entries Needed for weekend builds')),
																		Samples,
																	  if(ut.Weekday((integer)pVersion[1..8]) = 'SATURDAY', 
																	          validate_recs(pVersion),
																		        output('No need to run validation since its not Saturday')));

end;