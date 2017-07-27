import doxie_files, doxie, roxiekeybuild, ut, doxie_build, hygenics_search;

export life_eir_proc_build_fcra_keys(string filedate) := function


RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_Offenders_OffenderKey_fcra
																						,'~thor_data400::key::corrections::fcra::offenders_offenderkey_'+ doxie_build.buildstate + '_' + doxie.Version_SuperKey
																						,'~thor_data400::key::life_eir::fcra::'+filedate+'::offenders_offenderkey'
																						,bk_offender);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_Court_Offenses_fcra
																						,'~thor_data400::key::corrections::fcra::court_offenses_'+ doxie_build.buildstate + '_' + doxie.Version_SuperKey
																						,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_offenses'
																						,bk_court_offenses);
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(hygenics_search.Key_Activity_fcra
																						,'~thor_data400::key::corrections::fcra::activity_'+ doxie_build.buildstate + '_' + doxie.Version_SuperKey
																						,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_activity'
																						,bk_activity);

RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections::fcra::offenders_offenderkey_'+ doxie_build.buildstate
																		 ,'~thor_data400::key::life_eir::fcra::'+filedate+'::offenders_offenderkey'
																		 ,mv_offender);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections::fcra::court_offenses_'+ doxie_build.buildstate
																		 ,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_offenses'
																		 ,mv_court_offenses);
RoxieKeyBuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::corrections::fcra::activity_'+ doxie_build.buildstate 
																		 ,'~thor_data400::key::life_eir::fcra::'+filedate+'::court_activity'
																		 ,mv_activity);
																						
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections::fcra::offenders_offenderkey_'+ doxie_build.buildstate
													,'Q'
													,mv2QA_offender);
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections::fcra::court_offenses_'+ doxie_build.buildstate
													,'Q'
													,mv2QA_court_offenses);
RoxieKeyBuild.Mac_SK_Move('~thor_data400::key::corrections::fcra::activity_'+ doxie_build.buildstate
 													,'Q'
													,mv2QA_activity);
return sequential(
       parallel(bk_offender,
			          bk_court_offenses,
			          bk_activity
			         ),
			 parallel(mv_offender,
			          mv_court_offenses,
			          mv_activity
			         ),
			 parallel(mv2QA_offender,
			          mv2QA_court_offenses,
			          mv2QA_activity
			         )
			         );
			 

end;