IMPORT _control;
EXPORT fn_SprayFiles(string version, string WU = workunit) := FUNCTION

//////** Find Files eData12 /riskwise/in
Incoming_transaction 	:= NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/riskview/sao/in/mbs/'+version,'*transaction*.txt',)(~REGEXFIND('batch', name, nocase) AND ~REGEXFIND('delta', name, nocase)));//changed
Incoming_intermediate := NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,'/data/riskview/sao/in/mbs/'+version,'*intermediate*.txt',)(~REGEXFIND('batch', name, nocase) AND ~REGEXFIND('delta', name, nocase)));//changed	 

//////** Spray Files eData12 /riskwise/sao/in
Spray_Files_intermediate(STRING filename) := FUNCTION

exist_intermediate 	:= fileservices.fileexists('~thor_data400::in::score_logs::'+wu+'.'+filename);
spray_intermediate := fileservices.sprayvariable(_control.IPAddress.bctlpedata10, '/data/riskview/sao/in/mbs/'+version+'/'+filename,500000000 ,'|\t|', '|\n','',	'thor400_44', 	'~thor_data400::in::score_logs::'+wu+'.'+filename, ,,,	true, true, true); //changed

ext := map(
										stringlib.stringfind(filename, 'fcra', 1) > 0 and  stringlib.stringfind(filename, 'intermediate', 1) > 0 => 'log_mbs_fcra_intermediate',	'log_mbs_intermediate');
																				
addsuper := fileservices.addsuperfile('~thor_data400::in::score_tracking::'+ext, '~thor_data400::in::score_logs::'+wu+'.'+filename);
movefile_intermediate := FileServices.MoveExternalFile(_control.IPAddress.bctlpedata10,'/data/riskview/sao/in/mbs/'+version+'/'+filename,'/data/riskview/out/'+wu+'.'+filename);//changed
RETURN IF(~exist_intermediate, SEQUENTIAL(spray_intermediate, addsuper));//changed
END;

Spray_Files_transaction(STRING filename) := FUNCTION

exist_transaction    := fileservices.fileexists('~thor_data400::in::score_logs::'+wu+'.'+filename);
spray_transaction   := fileservices.sprayvariable(_control.IPAddress.bctlpedata10, '/data/riskview/sao/in/mbs/'+version+'/'+filename, 500000000 ,'|\t|', '|\n','',	'thor400_44', 	'~thor_data400::in::score_logs::'+wu+'.'+filename, ,,,	true, true, true); //changed


ext := map(
										stringlib.stringfind(filename, 'fcra', 1) > 0 and stringlib.stringfind(filename, 'transaction', 1) > 0 => 'log_mbs_fcra_transaction_online', 'log_mbs_transaction_online'
								 );

addsuper := fileservices.addsuperfile('~thor_data400::in::score_tracking::'+ext, '~thor_data400::in::score_logs::'+wu+'.'+filename);
movefile_transaction   := FileServices.MoveExternalFile(_control.IPAddress.bctlpedata10,'/data/riskview/sao/in/mbs/'+version+'/'+filename,'/data/riskview/out/'+wu+'.'+filename);//changed

RETURN IF(~exist_transaction, SEQUENTIAL(spray_transaction, addsuper));//changed
END;

//////** Move Sprayed Files eData12 /riskwise/out
Outgoing := NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10, '/data/riskview/out', '*',));

//////** Delete Sprayed Files eData12 /riskwise/out
Delete_Files(STRING filename) := FUNCTION
removefile := FileServices.DeleteExternalFile(_control.IPAddress.bctlpedata10,'/data/riskview/out/'+filename);

RETURN removefile;
END;
														 
RETURN SEQUENTIAL(
					 OUTPUT(Outgoing, NAMED('files_for_deletion'));
					 NOTHOR(APPLY(Outgoing, Delete_Files(Name)));
					 OUTPUT(INCOMING_transaction, NAMED('incoming_file_list1'));//changed
					 OUTPUT(INCOMING_intermediate, NAMED('incoming_file_list2'));//changed 
					 NOTHOR(APPLY(Incoming_transaction, Spray_Files_transaction(Name)));//changed
					 NOTHOR(APPLY(Incoming_intermediate, Spray_Files_intermediate(Name)));//changed
					 OUTPUT(NOTHOR(fileservices.superfilecontents('~thor_data400::in::score_tracking::log_mbs_intermediate')), NAMED('superlist_log_mbs_intermediate'));
					 OUTPUT(NOTHOR(fileservices.superfilecontents('~thor_data400::in::score_tracking::log_mbs_fcra_intermediate')), NAMED('superlist_log_mbs_fcra_intermediate'));
					 OUTPUT(NOTHOR(fileservices.superfilecontents('~thor_data400::in::score_tracking::log_mbs_transaction_online')), NAMED('superlist_log_mbs_transaction_online'));
					 OUTPUT(NOTHOR(fileservices.superfilecontents('~thor_data400::in::score_tracking::log_mbs_fcra_transaction_online')), NAMED('superlist_log_mbs_fcra_transaction_online'));
					 OUTPUT(COUNT(score_logs.files.NonFCRA_Transaction), NAMED('CountNonFCRATransaction'));//changed
					 OUTPUT(COUNT(score_logs.files.FCRA_Transaction), NAMED('CountFCRATransaction'));//changed
					 OUTPUT(COUNT(score_logs.files.NonFCRA_Intermediate), NAMED('CountNonFCRAIntermediate'));
					 OUTPUT(COUNT(score_logs.files.FCRA_Intermediate), NAMED('CountFCRAIntermediate'));
					 OUTPUT(Outgoing, NAMED('outgoing_file_list'));
					 );
END;