//EXPORT BWR_Monitor_Build_Dops_Deployment := '';
// THIS DEFINITION CONTAINS BWR CODE. Please COPY code out and it in a NEW Builder Window Runnable IF the monitor is not running

import dops,ut,header,Orbit3;

emailsToNotify								:= 'Sudhir.Kasavajjala@lexisnexis.com robert.berger@lexisnexis.com';
prod_version									:= dops.GetBuildVersion('LNPropertyV2FullKeys','B','N','P'); // boca, non-FCRA,production
cert_version 									:= dops.GetBuildVersion('LNPropertyV2FullKeys','B','N','C'); // cert

certAndProdVersionsAreTheSame := (prod_version=cert_version);
delta_version 								:= LN_PropertyV2_Fast.build_information(true).get_qa_version;
full_version 									:= LN_PropertyV2_Fast.build_information(false).get_qa_version;
dops_fhistory									:= dops.GetReleaseHistory('B', 'N', 'LNPropertyV2Keys')(prodversion<>'NA',updateflag[1]='F');
full_in_prod									:= (set(sort(dops_fhistory,-prodversion), prodversion)[1]);
new_full_version							:= (integer)full_version>(integer)full_in_prod;
latest_build_version 					:= if(new_full_version,full_version,delta_version);

isFast 												:= latest_build_version = delta_version;
aNewVersionIsAvailable 				:= (cert_version<>latest_build_version);
good_to_deploy_a_new_version 	:= (certAndProdVersionsAreTheSame AND aNewVersionIsAvailable);

create_orbit_entries := Sequential( if ( isFast = true,	Orbit3.proc_Orbit3_CreateBuild_AddItem('Fast Property',latest_build_version),Orbit3.proc_Orbit3_CreateBuild ('Fast Property',latest_build_version) ),
                                Orbit3.proc_Orbit3_CreateBuild('FCRA Fast Property',latest_build_version,'F'),
															if ( isFast = true,	Orbit3.proc_Orbit3_CreateBuild('Fast Property Boolean Delta',latest_build_version,'B'),
															          Sequential( Orbit3.proc_Orbit3_CreateBuild('Fast Property Boolean Full',latest_build_version,'B'),
																				         Orbit3.proc_Orbit3_CreateBuild('AVM',latest_build_version),
																								 Orbit3.proc_Orbit3_CreateBuild('FCRA_AVM',latest_build_version,'F')
																								 )
															 )
													);
                          

actionMsg 										:= if(good_to_deploy_a_new_version,'Dops should be updating... Please check Dops monitoring page...','Nothing to do. Just waiting...');

// DF-11862 - to allow continuous delta
ECLCheckFullDeployment 				:= '#workunit(\'name\', \'property.check full deploy '+full_version+'\');\n'
                                +'emailsToNotify     := \'Sudhir.Kasavajjala@lexisnexis.com, robert.berger@lexisnexis.com\';\n'
                                +'VersionDeployed    := dops.GetDeployedDatasets(\'Q\',\'B\',\'N\',\'LNPropertyV2Keys\');\n'
                                +'bversion           := set(VersionDeployed,buildversion)[1];\n'
                                +'mostcurrentlog     := sort(LN_PropertyV2_Fast.BuildLogger.file,-version)[1];\n'
                                +'newdeltaversion    := mostcurrentlog.version>\''+delta_version+'\';\n'
                                +'newdeltacomplete   := mostcurrentlog.key_build_end_date<>\'\';\n'
                                +'IsFullVersion      := \''+full_version+'\'=bversion;\n'
                                +'ReadyToDeployDelta := if(IsFullVersion and newdeltaversion and newdeltacomplete,notify(\'Ok_To_deploy_delta_version\',\'*\'));\n'
                                +'SubmitUpdateDops   := LN_PropertyV2_Fast.fn_update_dops(mostcurrentlog.version,true);\n'
                                +'LaunchCron         := sequential(readytodeploydelta,\n'
                                +'                                 output(ut.getTimeDate()[1..10]+\' \'+ut.getTimeDate()[11..],named(\'Last_Checked\')),\n'
                                +'                                 output(IsFullVersion,named(\'Full_Was_Deployed\')));\n'
                                +'LaunchEvent        := sequential(LN_PropertyV2_Fast.JobInfo.setEmailsToNotify(emailsToNotify),\n'
                                +'                                 SubmitUpdateDops,fail(\'Dops Updated With Delta From Full, Not an error\'));\n'
                                +'LaunchCron : when(cron (\'0-59/30 * * * *\'));\n'
                                +'LaunchEvent: when(event(\'Ok_To_deploy_delta_version\',\'*\'),count(1));\n';
SubmitCheckFullDeployment 		:= header.fSubmitNewWorkunit(ECLCheckFullDeployment, 'hthor');

checkIfDopsShouldBeUpdated 		:= sequential(
																		 output(cert_version,named('cert_version'))
																		,output(prod_version,named('prod_version'))
																		,output(certAndProdVersionsAreTheSame,named('certAndProdVersionsAreTheSame'))
																		,output(new_full_version,named('IsNewFullVersion'))
																		,output(latest_build_version, named('latest_build_version'))
																		,output(aNewVersionIsAvailable, named('aNewVersionIsAvailable'))
																		,output(isFast, named('latest_version_is_delta'))
																		,output(good_to_deploy_a_new_version,named('good_to_deploy_a_new_version'))
																		,output(ut.getTimeDate()[1..10]+' '+ut.getTimeDate()[11..],named('last_checked'))
																		,LN_PropertyV2_Fast.JobInfo.setEmailsToNotify(emailsToNotify)
																		,if(aNewVersionIsAvailable AND (NOT certAndProdVersionsAreTheSame),
																				sequential(
																						output('WARNING: New version is available, but CERT and PROD are not the same. New version will not be deployed')
																						,LN_PropertyV2_Fast.JobInfo.updateViaEmail('Dops deployment pending! CERT and PROD are not the same, but a new build is ready','ATTENTION!!')
																			 ))
																		,if(good_to_deploy_a_new_version,
																				if(new_full_version
																						,sequential(
																								LN_PropertyV2_Fast.fn_update_dops(latest_build_version,isFast)
																								,SubmitCheckFullDeployment,create_orbit_entries)
																						,Sequential(LN_PropertyV2_Fast.fn_update_dops(latest_build_version,isFast),create_orbit_entries)))
																		,output(actionMsg,named('actionMsg'))
															 );

// NB: the property build is looking for this monitoring workunit by JOB NAME
#workunit('name','property build dops deployment monitor');

checkIfDopsShouldBeUpdated :when(cron('12 12 * * *')); // 8:12AM EDT / 7:12AM EST (UTC -4/5)