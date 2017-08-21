IMPORT _Control, Doxie, RoxieKeyBuild, Std, Ut;

EXPORT Proc_Build_Send_LIDB_Refresh_File(string version, const varstring eclsourceip, integer numRecs):= function

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Build New Phone File to Send Through the Gateway/////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	//Create new LIDB send file
	lidb_send 				:= Map_LIDB_Send_Refresh_File(version, numRecs);
	
	//Add new send records to LIDB send history file
	lidb_send_history := lidb_send + PhonesInfo.File_LIDB.Send_History;

	outputSendHistory := output(lidb_send_history,,PhonesInfo.File_LIDB.Send_File_Path+'_history_'+version,__compressed__,overwrite);
	moveSendHistory		:= STD.File.PromoteSuperFileList([PhonesInfo.File_LIDB.Send_File_Path+'_history',
																											PhonesInfo.File_LIDB.Send_File_Path+'_history_father'],
																											PhonesInfo.File_LIDB.Send_File_Path+'_history_'+version, true);																		

	//Deduped new send records by phone to ensure only 1 record per TN is sent to AT&T
	ds_lidb_send			:= dataset('~thor_data400::persist::lidb_send_file_chosen', PhonesInfo.Layout_common.lidbSendHistory, flat); 	
	dd_lidb_send			:= project(ds_lidb_send,PhonesInfo.Layout_common.lidbSend);	
	
	send_file_name		:= PhonesInfo.File_LIDB.Send_File_Path+'::TO_ATT_PHONES_'+version+'.txt';
	outputSendFile		:= output(dd_lidb_send,,send_file_name, csv(heading(0), terminator('\n'), separator('\t')), __compressed__,overwrite);
	moveSendFile			:= STD.File.PromoteSuperFileList([PhonesInfo.File_LIDB.Send_File_Path,
																											PhonesInfo.File_LIDB.Send_File_Path+'_father',
																											PhonesInfo.File_LIDB.Send_File_Path+'_grandfather'],
																											send_file_name, true);																		

	despraySendFile		:= FileServices.DeSpray(send_file_name,
																				    eclsourceip,
																				    '/data/data_999/phones/lidb_response/file_sent/'+version+'/TO_ATT_PHONES_'+version+'.txt',
																				    ,
																				    ,
																				    ,
																				    TRUE
																				    );
	
	doAll							:= sequential(outputSendHistory,
	                                moveSendHistory,
																	outputSendFile,
																	moveSendFile,
																	despraySendFile):
																	Success(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Send LIDB Refresh Build Succeeded', workunit + ': Build complete.  Deduped send input file desprayed.')),
																	Failure(FileServices.SendEmail(_control.MyInfo.EmailAddressNotify + ';gregory.rose@lexisnexisrisk.com' + ';darren.knowles@lexisnexisrisk.com', 'PhonesInfo Send LIDB Refresh Build Failed', workunit + '\n' + FAILMESSAGE));

	return doAll;

end;