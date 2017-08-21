#workunit('name', 'Thor Monitoring')
#workunit('priority', 'high')

import monitoring, monitoring_gong;

in_file_ready := exists(monitoring.files.monitor);

update_input_files := true;

current_date := StringLib.GetDateYYYYMMDD();

send_success_msg := fileservices.sendemail('dqi@seisint.com', 
								   if(in_file_ready, 'TM-Suc-', 'TM-NoI-') + current_date,
							        '');
							
send_failure_msg := fileservices.sendemail('5613064307@tmomail.net',
			   			        	   'TM-Fail-' + current_date,
							        '');

monitor_them := if(in_file_ready,
                   sequential(
			               if(update_input_files, 
						            sequential(monitoring.Proc_Update_Customer_Base,
                                   monitoring.Proc_Update_History_Before,
													         monitoring.Proc_Best_Address_Searching)),    
                        monitoring.Proc_Best_Phone_Searching,			
												monitoring.proc_patch_addr_phone_out,
						            monitoring.Proc_History_Update_After,
			     		          monitoring.Proc_SendResults(monitoring.File_Address_Out,
					                                          monitoring.File_Phone_Out,
											                              monitoring.File_Address_History)
					             	),
				            output('No input file found!'));

export proc_monitor_them := sequential(monitor_them, 
                                       monitoring.proc_create_base_delta_file, 
							    monitoring_gong.monitor_them) : SUCCESS(send_success_msg),FAILURE(send_failure_msg);