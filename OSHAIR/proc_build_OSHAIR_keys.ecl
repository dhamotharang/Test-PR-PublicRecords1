import Address,doxie_files, ut, doxie, autokey,OSHAIR, RoxieKeyBuild;

export proc_build_OSHAIR_keys(string filedate) := FUNCTION

/////////////////////////////////////////////////////////////////////////////////
// -- Build Keys
/////////////////////////////////////////////////////////////////////////////////
/* Build the DID key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_BDID
																					 ,'~thor_data400::key::oshair::bdid'
																					 ,'~thor_data400::key::oshair::'+filedate+'::bdid'
																					 ,bk_bdid);
											
/* Build the LINKIDS key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_LinkIds.Key
                                           ,'~thor_data400::key::oshair::linkids'
																					 ,'~thor_data400::key::oshair::'+filedate+'::linkids'
																					 ,bk_linkids);
											
/* Build the Inspection key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local( OSHAIR.Key_OSHAIR_inspection
																						,'~thor_data400::key::oshair::inspection'
																						,'~thor_data400::key::oshair::'+filedate+'::inspection'
																						,bk_pyld_insp);
/* Build the Program key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_program
																					 ,'~thor_data400::key::oshair::program'
																					 ,'~thor_data400::key::oshair::'+filedate+'::program'
																					 ,bk_pyld_pgm);
/* Build the Related Activity key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_related_activity
																					 ,'~thor_data400::key::oshair::related_activity'
																					 ,'~thor_data400::key::oshair::'+filedate+'::related_activity'
																					 ,bk_pyld_rel_act);
/* Build the Optional Information key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_optional_info
																					 ,'~thor_data400::key::oshair::optional_info'
																					 ,'~thor_data400::key::oshair::'+filedate+'::optional_info'
																					 ,bk_pyld_opt_info);
/* Build the Violations key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_violations
																					 ,'~thor_data400::key::oshair::violations'
																					 ,'~thor_data400::key::oshair::'+filedate+'::violations'
																					 ,bk_pyld_viol);
/* Build the Hazardous Substance key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_hazardous_substance
																					 ,'~thor_data400::key::oshair::hazardous_substance'
																					 ,'~thor_data400::key::oshair::'+filedate+'::hazardous_substance'
																					 ,bk_pyld_haz_sub);
/* Build the Accident key */
RoxieKeyBuild.Mac_SK_BuildProcess_v2_local(OSHAIR.Key_OSHAIR_accident
																					 ,'~thor_data400::key::oshair::accident'
																					 ,'~thor_data400::key::oshair::'+filedate+'::accident'
																					 ,bk_pyld_acc);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to Built
/////////////////////////////////////////////////////////////////////////////////

Roxiekeybuild.Mac_SK_Move_to_Built_v2( '~thor_data400::key::oshair::bdid'
																			 ,'~thor_data400::key::oshair::'+filedate+'::bdid'
																			 ,mv2blt_bdid);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::linkids'
																			 ,'~thor_data400::key::oshair::'+filedate+'::linkids'
																			 ,mv2blt_linkids);									 
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::inspection'
                                      ,'~thor_data400::key::oshair::'+filedate+'::inspection'
																			,mv2blt_insp);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::program'
																			 ,'~thor_data400::key::oshair::'+filedate+'::program'
																			 ,mv2blt_pgm);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::related_activity'
                                      ,'~thor_data400::key::oshair::'+filedate+'::related_activity'
																			,mv2blt_rel_act);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::optional_info'
                                      ,'~thor_data400::key::oshair::'+filedate+'::optional_info'
																		  ,mv2blt_opt_info);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::violations'
                                      ,'~thor_data400::key::oshair::'+filedate+'::violations'
																			,mv2blt_viol);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::hazardous_substance'
                                      ,'~thor_data400::key::oshair::'+filedate+'::hazardous_substance'
																		  ,mv2blt_haz_sub);
Roxiekeybuild.Mac_SK_Move_to_Built_v2('~thor_data400::key::oshair::accident'
                                      ,'~thor_data400::key::oshair::'+filedate+'::accident'
																			,mv2blt_acc);

/////////////////////////////////////////////////////////////////////////////////
// -- Move Keys to QA
/////////////////////////////////////////////////////////////////////////////////

RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::bdid','Q',mv2qa_bdid);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::linkids','Q',mv2qa_linkids);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::inspection','Q',mv2qa_insp);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::program','Q',mv2qa_pgm);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::related_activity','Q',mv2qa_rel_act);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::optional_info','Q',mv2qa_opt_info);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::violations','Q',mv2qa_viol);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::hazardous_substance','Q',mv2qa_haz_sub);
RoxieKeyBuild.mac_sk_move('~thor_data400::key::oshair::accident','Q',mv2qa_acc);

/////////////////////////////////////////////////////////////////////////////////
// -- Build Autokeys
/////////////////////////////////////////////////////////////////////////////////

build_autokeys := OSHAIR.proc_build_autokeys(filedate);

/////////////////////////////////////////////////////////////////////////////////
// -- EMAIL ROXIE KEY COMPLETION NOTIFICATION 
/////////////////////////////////////////////////////////////////////////////////

// emailN := fileservices.sendemail('ehamel@seisint.com ',
emailN := fileservices.sendemail('RoxieBuilds@seisint.com ; ehamel@seisint.com ',
								 
								'OSHAIR: BUILD SUCCESS '+ filedate ,
								'keys: 1) thor_data400::key::oshair::QA::autokey::addressb2(thor_data400::key::oshair::'+ filedate +'::autokey::addressb2),\n' +
								'      2) thor_data400::key::oshair::QA::autokey::citystnameb2(thor_data400::key::oshair::'+ filedate +'::autokey::citystnameb2),\n' +
								'      3) thor_data400::key::oshair::QA::autokey::fein2(thor_data400::key::oshair::'+ filedate +'::autokey::fein2),\n' +
								'      4) thor_data400::key::oshair::QA::autokey::nameb2(thor_data400::key::oshair::'+ filedate +'::autokey::nameb2),\n' +
								'      5) thor_data400::key::oshair::QA::autokey::namewords2(thor_data400::key::oshair::'+ filedate +'::autokey::namewords2),\n' +
								'      6) thor_data400::key::oshair::QA::autokey::payload(thor_data400::key::oshair::'+ filedate +'::autokey::payload),\n' +
								'      7) thor_data400::key::oshair::QA::autokey::stnameb2(thor_data400::key::oshair::'+ filedate +'::autokey::stnameb2),\n' +
								'      8) thor_data400::key::oshair::QA::autokey::zipb2(thor_data400::key::oshair::'+ filedate +'::autokey::zipb2),\n' +
								'      9) thor_data400::key::oshair::bdid_qa(thor_data400::key::oshair::'+ filedate +'::bdid),\n' +
								'     10) thor_data400::key::oshair::linkids_qa(thor_data400::key::oshair::'+ filedate +'::linkids),\n' +
								'     11) thor_data400::key::oshair::accident_qa(thor_data400::key::oshair::'+ filedate +'::accident),\n' +
								'     12) thor_data400::key::oshair::hazardous_substance_qa(thor_data400::key::oshair::'+ filedate +'::hazardous_substance),\n' +
						    '     13) thor_data400::key::oshair::inspection_qa(thor_data400::key::oshair::'+ filedate +'::inspection),\n' +
								'     14) thor_data400::key::oshair::optional_info_qa(thor_data400::key::oshair::'+ filedate +'::optional_info),\n' +
								'     15) thor_data400::key::oshair::program_qa(thor_data400::key::oshair::'+ filedate +'::program),\n' +
								'     16) thor_data400::key::oshair::related_activity_qa(thor_data400::key::oshair::'+ filedate +'::),\n' +
								'     17) thor_data400::key::oshair::violations_qa(thor_data400::key::oshair::'+ filedate +'::violations),\n' +
								'         have been built and ready to be deployed to QA.'); 
			

/////////////////////////////////////////////////////////////////////////////////
// -- Actions
/////////////////////////////////////////////////////////////////////////////////

build_keys := sequential(// Build the keys
													parallel(bk_bdid
																	 ,bk_linkids
																	 ,bk_pyld_insp
																	 ,bk_pyld_pgm
																	 ,bk_pyld_rel_act
																	 ,bk_pyld_opt_info
																	 ,bk_pyld_viol
																	 ,bk_pyld_haz_sub
																	 ,bk_pyld_acc),
													// Move the keys to built
													parallel(mv2blt_bdid
																	 ,mv2blt_linkids
																	 ,mv2blt_insp
																	 ,mv2blt_pgm
																	 ,mv2blt_rel_act
																	 ,mv2blt_opt_info
																	 ,mv2blt_viol
																	 ,mv2blt_haz_sub
																	 ,mv2blt_acc),
													  // Move the keys to qa
														parallel(mv2qa_bdid
																		 ,mv2qa_linkids
																		 ,mv2qa_insp
																		 ,mv2qa_pgm
																		 ,mv2qa_rel_act
																		 ,mv2qa_opt_info
																		 ,mv2qa_viol
																		 ,mv2qa_haz_sub
																		 ,mv2qa_acc),
													 // Build the autokeys
														build_autokeys
		                 );


return parallel(build_keys
							  ,emailN);

end;


 
 
 
 