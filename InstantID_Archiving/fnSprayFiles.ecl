///////** If restarting before deletion happens please pass the previous workunit through as the WU.

IMPORT _control;

EXPORT fnSprayFiles(string WU = workunit) := FUNCTION

//////** Find Files bctlpedata10 /riskwise/in

pIncoming := NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,
														 '/data/riskview/in',
														 '*txt',)(REGEXFIND('^delta', name, nocase)));
														 
Incoming := PROJECT(pIncoming, TRANSFORM({RECORDOF(pIncoming), UNSIGNED seq}, SELF.seq := COUNTER, SELF := LEFT));
														 
//////** Spray Files bctlpedata10 /riskwise/in

Spray_Files(STRING filename, UNSIGNED seq) := FUNCTION

exist := fileservices.fileexists('~thor_data400::in::instantid_archive::'+wu+'.'+filename+'_'+(STRING)seq);

cluster := IF(STRINGLIB.STRINGTOUPPERCASE(_control.ThisEnvironment.name) = 'DATALAND', 'thor50_dev02', 'thor400_44');

spray := fileservices.sprayvariable(_control.IPAddress.bctlpedata10, 
																		'/data/riskview/in/'+filename, 
																		/*integer4 sourceMaxRecordSize=8192*/, 
																		'~~', 
																		'~~^~~', 
																		/*const varstring sourceCsvQuote='\''*/, 
																		cluster, 
																		'~thor_data400::in::instantid_archive::'+wu+'.'+filename+'_'+(STRING)seq, 
																		/*integer4 timeOut=-1*/, 
																		/*const varstring espServerIpPort=GETENV('ws_fs_server')*/, 
																		/*integer4 maxConnections=-1*/, 
																		true, 
																		true,
																		true); 

ext := map( stringlib.stringfind(filename, 'delta_flexid_delta_key_riskindicator_', 1) > 0 => 'delta_risk_flexid_concatenated',
					  stringlib.stringfind(filename, 'delta_flexid_delta_key_model_', 1) > 0  => 'delta_model_flexid_concatenated',
					  stringlib.stringfind(filename, 'delta_flexid_delta_key_modelriskindicator_', 1) > 0  => 'delta_modelrisk_flexid_concatenated',
					  stringlib.stringfind(filename, 'delta_flexid_delta_report_', 1) > 0 => 'delta_report_flexid_concatenated',
					  stringlib.stringfind(filename, 'delta_flexid_delta_key_2', 1) > 0  => 'delta_key_flexid_concatenated',
						
					  stringlib.stringfind(filename, 'delta_iidi_delta_key_fieldverification_', 1) > 0 => 'delta_verification_instantidi_concatenated',
					  stringlib.stringfind(filename, 'delta_iidi_delta_key_riskindicator_', 1) > 0 => 'delta_risk_instantidi_concatenated',
					  stringlib.stringfind(filename, 'delta_iidi_delta_report_', 1) > 0 => 'delta_report_instantidi_concatenated',
					  stringlib.stringfind(filename, 'delta_iidi_delta_key_2', 1) > 0  => 'delta_key_instantidi_concatenated',
						
					  stringlib.stringfind(filename, 'delta_iid_delta_key_model_', 1) > 0  => 'delta_model_instantid_concatenated',
					  stringlib.stringfind(filename, 'delta_iid_delta_key_modelriskindicator_', 1) > 0 => 'delta_modelrisk_instantid_concatenated',
					  stringlib.stringfind(filename, 'delta_iid_delta_key_modelriskindex_', 1) > 0 => 'delta_index_instantid_concatenated',
					  stringlib.stringfind(filename, 'delta_iid_delta_key_riskindicator_', 1) > 0 => 'delta_risk_instantid_concatenated',
					  stringlib.stringfind(filename, 'delta_iid_delta_key_2', 1) > 0  => 'delta_key_instantid_concatenated',
					  stringlib.stringfind(filename, 'delta_iid_delta_report_', 1) > 0 => 'delta_report_instantid_concatenated',
					  stringlib.stringfind(filename, 'delta_iid_delta_key_redflags_', 1) > 0 => 'delta_redflags_instantid_concatenated',
						
					  // stringlib.stringfind(filename, 'delta_iid_delta_key_modelriskindex_', 1) > 0 => 'delta_modelriskindex_instantid',
						'unknown');
																				
addsuper := fileservices.addsuperfile('~thor_data400::in::instantid_archive::'+ext, '~thor_data400::in::instantid_archive::'+wu+'.'+filename+'_'+(STRING)seq);

createsuper := IF(~fileservices.fileexists('~thor_data400::in::instantid_archive::'+ext), 
									 fileservices.createsuperfile('~thor_data400::in::instantid_archive::'+ext));

movefile := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', 
										FileServices.MoveExternalFile(_control.IPAddress.bctlpedata10,'/data/riskview/in/'+filename, '/data/riskview/out/delta/'+wu+'.'+filename));

RETURN IF(~exist, SEQUENTIAL(createsuper, spray, addsuper, movefile));
END;


//////** Move Sprayed Files bctlpedata10 /riskwise/out

Outgoing := NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,
														 '/data/riskview/out/delta',
														 '*txt',));

//////** Delete Sprayed Files bctlpedata10 /riskwise/out

Delete_Files(STRING filename) := FUNCTION

removefile := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', 
										FileServices.DeleteExternalFile(_control.IPAddress.bctlpedata10,'/data/riskview/out/delta/'+filename));

RETURN removefile;
END;
														 
RETURN SEQUENTIAL(
					 OUTPUT(Outgoing, NAMED('files_for_deletion_online'));
					 NOTHOR(APPLY(Outgoing, Delete_Files(Name)));
					 OUTPUT(INCOMING, NAMED('incoming_file_list_online'));
					 NOTHOR(APPLY(Incoming, Spray_Files(Name, seq)));
					 OUTPUT(NOTHOR(fileservices.superfilecontents('~thor_data400::in::instantid_archive::unknown')), NAMED('unmatched_files_online'));
					 OUTPUT(Outgoing, NAMED('outgoing_file_list_online'));
					 );
END;