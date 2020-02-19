import RoxieKeyBuild,Suppress,Orbit3,ut,dops, Orbit3Insurance;

export Proc_Build_Key_New_Suppression_Opt_Out(String pVersion) := 
FUNCTION

//CCPA-120 - Add Opt Out key to Suppression dataset
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_OptOutSrc_Bld(),'','~thor::key::new_suppression::'+pversion+'::opt_out',bld_optout_key,true);

//CCPA-120 - Add FCRA Opt Out key to Suppression dataset
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(Suppress.Key_OptOutSrc_Bld(true),'','~thor::key::new_suppression::fcra::'+pversion+'::opt_out',bld_optout_key_fcra,true);


RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::key::new_suppression::@version@::opt_out','~thor::key::new_suppression::'+pversion+'::opt_out',mv_built_optout);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor::key::new_suppression::fcra::@version@::opt_out','~thor::key::new_suppression::fcra::'+pversion+'::opt_out',mv_built_optout_fcra);


RoxieKeyBuild.Mac_SK_Move_V2('~thor::key::new_suppression::@version@::opt_out','Q',mv_qa_optout);
RoxieKeyBuild.Mac_SK_Move_V2('~thor::key::new_suppression::fcra::@version@::opt_out','Q',mv_qa_optout_fcra);

update_dops 	    := dops.updateversion('SuppressOptOutKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'N|B');
update_dops_fcra    := dops.updateversion('FCRA_SuppressOptOutKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'F');
update_idops 		:= dops.updateversion('SuppressOptOutKeys',pVersion,'christopher.brodeur@lexisnexisrisk.com,Abednego.Escobal@lexisnexisrisk.com',,'N',,,'A');

create_build        := Orbit3.proc_Orbit3_CreateBuild('Suppression Opt Out',pVersion,'N|B');
create_build_fcra   := Orbit3.proc_Orbit3_CreateBuild('FCRA Suppression Opt Out',pVersion,'F');

create_build_ins	:=  Orbit3Insurance.Proc_Orbit3I_CreateBuild ('Suppression Opt Out',pVersion,'N',
                                         'christopher.brodeur@lexisnexisrisk.com,DataDevelopment-Ins@lexisnexis.com,InsDataOps@risk.lexisnexis.com');
													
RETURN Sequential(  parallel(bld_optout_key,bld_optout_key_fcra),
				    parallel(mv_built_optout, mv_built_optout_fcra),
				    parallel(mv_qa_optout, mv_qa_optout_fcra),
					parallel(update_dops, /* DF-26984 update_dops_fcra,*/ update_idops),
					if( ut.Weekday((integer)pVersion[1..8]) <> 'SATURDAY' and ut.Weekday((integer)pVersion[1..8]) <> 'SUNDAY',
					    parallel(create_build,/*create_build_fcra,*/ create_build_ins),
						output('No Orbit Entries Needed for weekend builds'))
                 );

end;