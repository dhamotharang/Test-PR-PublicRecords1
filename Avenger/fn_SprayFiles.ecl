///////** If restarting before deletion happens please pass the previous workunit through as the WU.

IMPORT _control;
EXPORT fn_SprayFiles(string WU = workunit) := FUNCTION

//////** Find Files eData12 /hds_180/avenger_load/irm/daily/
Incoming_IDM_transaction 	:= NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/hds_180/avenger_load/irm/daily/','*txt',)(REGEXFIND('^IRM', name, nocase)));//changed

//////** Spray Files eData12 /hds_180/avenger_load/irm/daily/
Spray_Files_IDM(STRING filename) := FUNCTION

exist_IDM 	:= fileservices.fileexists('~thor_data400::in::avenger::idm::'+wu+'.'+filename);
spray_IDM   := fileservices.sprayvariable(_control.IPAddress.bctlpedata10, 
																		'/data/hds_180/avenger_load/irm/daily/'+filename, 
																		/*integer4 sourceMaxRecordSize=8192*/, 
																		'~|~', 
																		, 
																		/*const varstring sourceCsvQuote='\''*/, 
																		'thor400_44', 
																		'~thor_data400::in::avenger::idm::'+wu+'.'+filename, 
																		/*integer4 timeOut=-1*/, 
																		/*const varstring espServerIpPort=GETENV('ws_fs_server')*/, 
																		/*integer4 maxConnections=-1*/, 
																		true, 
																		true,
																		true); 
																				
addsuper := fileservices.addsuperfile('~thor_data400::in::avenger::IDM::quiz', '~thor_data400::in::avenger::IDM::'+wu+'.'+filename);
movefile_IDM := FileServices.MoveExternalFile(_control.IPAddress.bctlpedata10,'/data/hds_180/avenger_load/irm/daily/'+filename,'/data/hds_180/avenger_load/irm/done/'+wu+'.'+filename);//changed
RETURN IF(~exist_IDM, SEQUENTIAL(spray_IDM, addsuper, movefile_IDM));//changed
END;

//////** Move Sprayed Files eData12 /riskwise/out
Outgoing := NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10, '/data/hds_180/avenger_load/irm/done/', '*',));

//////** Delete Sprayed Files eData12 /riskwise/out
Delete_Files(STRING filename) := FUNCTION
removefile := FileServices.DeleteExternalFile(_control.IPAddress.bctlpedata10,'/data/hds_180/avenger_load/irm/done/'+filename);

RETURN removefile;
END;
														 
RETURN SEQUENTIAL(
					// OUTPUT(Outgoing, NAMED('files_for_deletion'));
					// NOTHOR(APPLY(Outgoing, Delete_Files(Name)));
					 OUTPUT(Incoming_IDM_transaction, NAMED('incoming_IDM_file_list'));//changed
					 NOTHOR(APPLY(Incoming_IDM_transaction, Spray_Files_IDM(Name)));//changed
					 OUTPUT(NOTHOR(fileservices.superfilecontents('~thor_data400::in::avenger::IDM::quiz')), NAMED('superlist_log_IDM_quiz'));
					 OUTPUT(COUNT(avenger.file_in.quiz), NAMED('CountIDMDailyQuiz'));//changed
					// OUTPUT(Outgoing, NAMED('outgoing_file_list'));
					 );
END;