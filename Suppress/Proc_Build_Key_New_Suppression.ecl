import RoxieKeyBuild,Suppress,Orbit3,ut,dops;

export Proc_Build_Key_New_Suppression(String pVersion) := 
FUNCTION

RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_New_Suppression(),'','~thor_data400::key::new_suppression::'+pversion+'::link_type_link_id',bld_key,true);

//FCRA Key
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_New_Suppression(true),'','~thor_data400::key::new_suppression::fcra::'+pversion+'::link_type_link_id',bld_key_fcra,true);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::new_suppression::@version@::link_type_link_id','~thor_data400::key::new_suppression::'+pversion+'::link_type_link_id',mv_built);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::new_suppression::fcra::@version@::link_type_link_id','~thor_data400::key::new_suppression::fcra::'+pversion+'::link_type_link_id',mv_built_fcra);


RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::new_suppression::@version@::link_type_link_id','Q',mv_qa);
RoxieKeyBuild.Mac_SK_Move_V2('~thor_data400::key::new_suppression::fcra::@version@::link_type_link_id','Q',mv_qa_fcra);

update_dops 					:= dops.updateversion('SuppressionKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com',,'N|F|B');
update_dops_fcra := dops.updateversion('FCRA_SuppressionKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com',,'F');
update_idops 				:= dops.updateversion('SuppressionKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com',,'N',,,'A');

create_build := Orbit3.proc_Orbit3_CreateBuild('Suppressions',pVersion,'N|B|F');
         										
													
RETURN Sequential(parallel(bld_key,bld_key_fcra),
																		parallel(mv_built, mv_built_fcra),
																		parallel(mv_qa, mv_qa_fcra),
																		parallel(update_dops, update_dops_fcra),
																		Samples,
																	if(ut.Weekday((integer)pVersion[1..8]) <> 'SATURDAY' and ut.Weekday((integer)pVersion[1..8]) <> 'SUNDAY',
																						create_build,/*,update_idops,Suppress.Proc_OrbitI_CreateBuild(pVersion,'nonfcra')*/
																						output('No Orbit Entries Needed for weekend builds')));

end;