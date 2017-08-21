IMPORT _control, ut;

EXPORT fnSprayFilesBatch(string WU = workunit) := FUNCTION

//////** Find Files bctlpedata10 /riskwise/in

pIncoming := NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,
														 //'/data/riskview/in/batch_qa',
														 '/data/riskview/in/batch_prod',
														 '*dat',)(REGEXFIND('delta', name, nocase)));
														 
Incoming := PROJECT(pIncoming, TRANSFORM({RECORDOF(pIncoming), UNSIGNED seq}, SELF.seq := COUNTER, SELF := LEFT));
					
cluster := IF(STRINGLIB.STRINGTOUPPERCASE(_control.ThisEnvironment.name) = 'DATALAND', 'thor50_dev02', 'thor400_44');
														 
//////** Spray Files bctlpedata10 /riskwise/in

Spray_Files(STRING filename, UNSIGNED seq) := FUNCTION

exist := fileservices.fileexists('~thor_data400::in::instantid_archive::'+wu+'.'+filename+'_'+(STRING)seq);

spray := fileservices.sprayvariable(_control.IPAddress.bctlpedata10, 
																		//'/data/riskview/in/batch_qa/'+filename,
																		'/data/riskview/in/batch_prod/'+filename,
																	  60000, 
																		'|', 
																		'\\n,\\r\\n', 
																		/*const varstring sourceCsvQuote='\''*/, 
																		cluster, 
																		'~thor_data400::in::instantid_archive::' + wu + '.' + filename+'_'+(STRING)seq, 
																		/*integer4 timeOut=-1*/, 
																		/*const varstring espServerIpPort=GETENV('ws_fs_server')*/, 
																		/*integer4 maxConnections=-1*/, 
																		true, 
																		true,
																		true); 
																		
ext := map( stringlib.stringfind(filename, 'flexid_delta_key_riskindicator.', 1) > 0 => 'delta_risk_flexid_batch',
					  stringlib.stringfind(filename, 'flexid_delta_key.', 1) > 0   => 'delta_key_flexid_batch',
					  stringlib.stringfind(filename, 'flexid_delta_key_model.', 1) > 0 => 'delta_model_flexid_batch',
						stringlib.stringfind(filename, 'flexid_delta_key_modelriskindicator.', 1) > 0 => 'delta_modelriskindicator_flexid_batch',			  
						stringlib.stringfind(filename, 'flexid_delta_report.', 1) > 0  => 'delta_report_flexid_batch',
			
					  stringlib.stringfind(filename, 'ciid_delta_key.dat', 1) > 0  => 'delta_key_ciid',
					  stringlib.stringfind(filename, 'ciid_delta_key_model.dat', 1) > 0  => 'delta_model_ciid',
					  stringlib.stringfind(filename, 'ciid_delta_key_modelriskindicator', 1) > 0 => 'delta_modelriskindicator_ciid',
						stringlib.stringfind(filename, 'ciid_delta_key_modelriskindex', 1) > 0 => 'delta_modelriskindex_ciid',			  
						stringlib.stringfind(filename, 'ciid_delta_key_riskindicator.', 1) > 0 => 'delta_risk_ciid',
					  stringlib.stringfind(filename, 'ciid_delta_report', 1) > 0 => 'delta_report_ciid',
					  stringlib.stringfind(filename, 'ciid_delta_key_redflags', 1) > 0 => 'delta_redflags_ciid',
										
						'unknown');
																				
addsuper := fileservices.addsuperfile('~thor_data400::in::instantid_archive::'+ext, '~thor_data400::in::instantid_archive::'+wu+'.'+filename+'_'+(STRING)seq);

createsuper := IF(~fileservices.fileexists('~thor_data400::in::instantid_archive::'+ext), 
									 fileservices.createsuperfile('~thor_data400::in::instantid_archive::'+ext));

movefile := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', 
										FileServices.MoveExternalFile(_control.IPAddress.bctlpedata10,	'/data/riskview/in/batch_prod/'+filename,'/data/riskview/out/batch/'+wu+'.'+filename));

RETURN IF(~exist, SEQUENTIAL(createsuper, spray, addsuper, movefile));
END;

//////** Move Sprayed Files bctlpedata10 /riskwise/out

Outgoing := NOTHOR(fileservices.RemoteDirectory(_control.IPAddress.bctlpedata10,
														 '/data/riskview/out/batch',
														 '*dat',));

//////** Delete Sprayed Files bctlpedata10 /riskwise/out

Delete_Files(STRING filename) := FUNCTION

removefile := IF(_Control.ThisEnvironment.Name = 'Prod_Thor', 
										FileServices.DeleteExternalFile(_control.IPAddress.bctlpedata10,'/data/riskview/out/batch/'+filename));

RETURN removefile;
END;
														 
RETURN SEQUENTIAL(
				   OUTPUT(Outgoing, NAMED('files_for_deletion'));
					 NOTHOR(APPLY(Outgoing, Delete_Files(Name)));
					 OUTPUT(INCOMING, NAMED('incoming_file_list'));
					 NOTHOR(APPLY(Incoming, Spray_Files(Name, Seq)));
					 OUTPUT(NOTHOR(fileservices.superfilecontents('~thor_data400::in::instantid_archive::unknown')), NAMED('unmatched_files_batch'));
					 OUTPUT(Outgoing, NAMED('outgoing_file_list'));
					 );
END;