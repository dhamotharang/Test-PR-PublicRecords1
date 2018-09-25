IMPORT _CONTROL;

/*
	IP_ADDRESS: ip address of the source & destination files
	JOBID: JobId (an unique identifier used by BatchR3 jobs)
	INPUT_FILENAME: Input File (with full path)
	OUTPUT_FILENAME: Output File (with full path)
*/

EXPORT BatchR3_AlertListService(STRING IP_ADDRESS, STRING JOBID, STRING INPUT_FILE, STRING OUTPUT_FILE) := FUNCTION

input_src_file := INPUT_FILE;
output_destination_file := OUTPUT_FILE;

service_input_filename := JOBID;
spray_dest_filename := '~thordev_socialthor_50::in::alertlist::' + service_input_filename;
service_results_out_filename := '~thordev_socialthor_50::out::social_alert_results::' + service_input_filename;
service_results_out_despray_filename := service_results_out_filename+'::despray';

service_results_file_found := fileservices.fileexists(service_results_out_filename);

spray_file_found := fileservices.fileexists(spray_dest_filename);


SPRAY_FILE := FileServices.SprayVariable(IP_ADDRESS, 
																				input_src_file, 
																				/* integer4 sourceMaxRecordSize=8192 */, 
																				/* const varstring sourceCsvSeparate='\\,' */, 
																				/* const varstring sourceCsvTerminate='\\n,\\r\\n' */,
																				/* const varstring sourceCsvQuote='\'' */, 
																				'thor100_100cert', 
																				spray_dest_filename, 
																				/* integer4 timeOut=-1 */, 
																				/* const varstring espServerIpPort=GETENV('ws_fs_server') */, 
																				/* integer4 maxConnections=-1 */, 
																				true/* boolean allowoverwrite=false */, 
																				true,
																				true);


RUN_ALERTLIST := AlertList.Alert_Network.fun_calculate_overlap(spray_dest_filename, 0, 0, FALSE, FALSE, JOBID);

//If spray file is found, then run the Alertlist service..else spray the file and then run the 
//Alertlist service
RUN_SPRAY_PROC := IF(spray_file_found, SEQUENTIAL(RUN_ALERTLIST),SEQUENTIAL(SPRAY_FILE, RUN_ALERTLIST));


//Despray the result file to ::despray
Despray_File := output(dataset(service_results_out_filename, AlertList.Files.Layout_Accurint_Social_Stats, thor),,
																	service_results_out_despray_filename, CSV(QUOTE('"')), OVERWRITE);

//Despray ::despray file to target machine
Despray_output := fileservices.Despray(service_results_out_despray_filename, 
																			 IP_ADDRESS, 
																			 output_destination_file, 
																			 /* integer4 timeOut=-1 */, 
																			 /* const varstring espServerIpPort=GETENV('ws_fs_server') */, 
																			 /* integer4 maxConnections=-1 */, 
																			 true/* boolean allowoverwrite=false */); 

//delete ::despray file to save space
Delete_Despray_File := fileservices.deletelogicalfile(service_results_out_despray_filename, true);

DESPRAY_FILES := SEQUENTIAL(Despray_File, Despray_output, Delete_Despray_File);

RUN_FULL := SEQUENTIAL(RUN_SPRAY_PROC, DESPRAY_FILES);

//If we already have a result file then use the
//results from that run...if not run the full process.
RETURN RUN_FULL;
END;

