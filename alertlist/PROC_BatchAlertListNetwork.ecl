#WORKUNIT('name','Batch Alert List Network')

IMPORT _CONTROL;

EXPORT PROC_BatchAlertListNetwork(STRING WU = WORKUNIT) := FUNCTION

OrigForeignFile := SORT(fileservices.RemoteDirectory(_control.IPAddress.edata12,
														 '/hds_2/alertlist/in',
														 '*',
														 /*boolean sub=false*/), modified)(~regexfind('^W201', name))[1].name;

TagFile := FileServices.MoveExternalFile(_control.IPAddress.edata12,'/hds_2/alertlist/in/'+OrigForeignFile,'/hds_2/alertlist/in/'+WU+'.'+OrigForeignFile);

ForeignFile := SORT(fileservices.RemoteDirectory(_control.IPAddress.edata12,
														 '/hds_2/alertlist/in',
														 '*',
														 /*boolean sub=false*/), modified)(regexfind(WU, name))[1].name : INDEPENDENT;

ForeignFilesSprayed := SORT(fileservices.RemoteDirectory(_control.IPAddress.edata12,
														 '/hds_2/alertlist/sprayed',
														 '*',
														 /*boolean sub=false*/), modified);

FileFound := fileservices.fileexists(AlertList.constants.prefix + 'in::alertlist::' + ForeignFile);

SprayFile := FileServices.SprayVariable(_control.IPAddress.edata12, 
																				'/hds_2/alertlist/in/'+ForeignFile, 
																				/* integer4 sourceMaxRecordSize=8192 */, 
																				/* const varstring sourceCsvSeparate='\\,' */, 
																				/* const varstring sourceCsvTerminate='\\n,\\r\\n' */, 
																				/* const varstring sourceCsvQuote='\'' */, 
																				'dev_socialthor_50', 
																				AlertList.constants.prefix + 'in::alertlist::'+ForeignFile, 
																				/* integer4 timeOut=-1 */, 
																				/* const varstring espServerIpPort=GETENV('ws_fs_server') */, 
																				/* integer4 maxConnections=-1 */, 
																				/* boolean allowoverwrite=false */, 
																				true,
																				true);

FileSpraySuccess := fileservices.fileexists(AlertList.constants.prefix + 'in::alertlist::' + ForeignFile);

AddToSuper := IF(FileSpraySuccess,
								 fileservices.addsuperfile(alertlist.constants.prefix + 'in::alertlist::batch_input', AlertList.constants.prefix + 'in::alertlist::' + ForeignFile));

MoveForeignFile := IF(FileSpraySuccess, 
											FileServices.MoveExternalFile(_control.IPAddress.edata12,'/hds_2/alertlist/in/'+ForeignFile,'/hds_2/alertlist/sprayed/'+ForeignFile), 
											SEQUENTIAL(OUTPUT('Spray Failed'),
																 fileservices.sendemail('cecelie.reid@lexisnexis.com, jo.prichard@lexisnexis.com', 'Alert List - Spray Failed - ' + WU,
																												WU + '\n\n' + failmessage + '\n\nhttp://10.239.227.24:8010/')));

//step 1 - spray
SPRAY_FILES := SEQUENTIAL(TagFile,
															 OUTPUT(ForeignFile, NAMED('FileSprayedForProcessing')), 
															 SprayFile, 
															 AddToSuper, 
															 MoveForeignFile, 
															 OUTPUT(fileservices.superfilecontents(alertlist.constants.prefix + 'in::alertlist::batch_input'), NAMED('InputSuperFileContents'), ALL),
															 OUTPUT(ForeignFilesSprayed, NAMED('Edata12Hds2AlertListSprayedContents'), ALL));

//step 2 - run alert find						 
RUN_ALERTLIST := AlertList.Alert_Network.fun_calculate_overlap(AlertList.constants.prefix + 'in::alertlist::' + ForeignFile, 0, 0, FALSE);

//step 3 - despray results

Despray_File := output(dataset('~thordev_socialthor_50::out::social_alert_results::'+ForeignFile, AlertList.Files.Layout_Accurint_Social_Stats, thor),,
																	'~thordev_socialthor_50::out::social_alert_results::'+ForeignFile+'::despray', csv);

Despray := fileservices.Despray('~thordev_socialthor_50::out::social_alert_results::'+ForeignFile+'::despray', 
																			 _control.IPAddress.edata12, 
																			 '/hds_2/alertlist/out/'+ForeignFile, 
																			 /* integer4 timeOut=-1 */, 
																			 /* const varstring espServerIpPort=GETENV('ws_fs_server') */, 
																			 /* integer4 maxConnections=-1 */, 
																			 /* boolean allowoverwrite=false */); 
																			 
Despray_Email := fileservices.sendemail('cecelie.reid@lexisnexis.com, jo.prichard@lexisnexis.com', 'Alert List - Despray Complete - ' + ForeignFile,
																												WU + '\n\n' + ForeignFile + ' results successfully desprayed to eData12 /hds_2/alertlist/out/');
																												
Delete_Despray_File := fileservices.deletelogicalfile('~thordev_socialthor_50::out::social_alert_results::'+ForeignFile+'::despray', true);

DESPRAY_FILES := SEQUENTIAL(Despray_File, Despray, Despray_Email, Delete_Despray_File);

RETURN IF(OrigForeignFile <> '',
										SEQUENTIAL(SPRAY_FILES, RUN_ALERTLIST, DESPRAY_FILES));
// RETURN OUTPUT(OrigForeignFile);
END;
