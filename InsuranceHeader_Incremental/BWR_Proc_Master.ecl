IMPORT InsuranceHeader_Incremental,_Control;
#WORKUNIT('name','InsuranceHeader_Incremental Master');
#OPTION('multiplePersistInstances', TRUE);
versionUse := 'myversion';
InsuranceHeader_Incremental.Proc_Master(versionUse
                                        ,InsuranceHeader_Incremental.Proc_Constants.default_cluster
																				,InsuranceHeader_Incremental.Proc_Constants.default_cluster_FCRA
																				,1   // start iteration (used only for internal linking)
																				,3   // number of iterations (used only for internal linking)
																				,TRUE    // get Boca raw file (incremental- same size as full, just generated between full cycles)
																				,FALSE    // IsFullInc periodically need to be set to TRUE. will be TRUE when FUll build new records fed into ingest and only incremental corrections/suppressions
																				,TRUE     // ingest data
																				,TRUE     // build new only base
																				,TRUE     // micro mode internal linking
																				,TRUE     // update Existing base 
																				,TRUE     // update incremental base file
																				,TRUE    // Update AddrHierarchy
																				,TRUE    // Update Best Base 
																				,TRUE    // external linking incremental key build
																				,TRUE		 // FCRA build
																				,TRUE    // promote incremental keys to QA super keys 
																				) 
								   : SUCCESS(STD.System.Email.SendEmail(InsuranceHeader_Incremental.Proc_Constants.emailNotifyAll,
																												'InsuranceHeader_Incremental Master WORKUNIT ' + WORKUNIT + ' has completed',
																												'')),
										 FAILURE(STD.System.Email.SendEmail(InsuranceHeader_Incremental.Proc_Constants.emailNotify,
																												'InsuranceHeader_Incremental Master WORKUNIT ' + WORKUNIT + ' has failed',
																												FAILMESSAGE));
