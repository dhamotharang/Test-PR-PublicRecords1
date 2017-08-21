//this attribute update the history file with the new out file
import monitoring;

f_addr_out := monitoring.File_Address_Out;
f_addr_hist := monitoring.File_Address_History;

f_new_addr_hist := distribute(project(f_addr_out, monitoring.layout_address_history) + f_addr_hist, hash(customer_id, record_id));
  
create_addr_hist := sequential(output(f_new_addr_hist,,'~thor_data400::base::monitoring_address_history' + thorlib.wuid()),
					                     fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_history_2',true),
											         fileServices.AddSuperFile('~thor_data400::base::monitoring_address_history_2', 
											                                   '~thor_data400::base::monitoring_address_history',, true),
															 fileservices.ClearSuperFile('~thor_data400::base::monitoring_address_history'),
							                 fileservices.AddSuperFile('~thor_data400::base::monitoring_address_history',
							                                           '~thor_data400::base::monitoring_address_history' + thorlib.wuid()));

f_phone_out := monitoring.File_Phone_Out;
f_phone_hist := monitoring.File_Phone_History;

f_new_phone_hist := distribute(project(f_phone_out, monitoring.Layout_Phone_Update) + f_phone_hist, hash(customer_id, record_id));
  
create_phone_hist := sequential(output(f_new_phone_hist,,'~thor_data400::base::monitoring_phone_history' + thorlib.wuid()),
					                      fileservices.ClearSuperFile('~thor_data400::base::monitoring_phone_history_2', true),
																fileServices.AddSuperFile('~thor_data400::base::monitoring_phone_history_2', 
											                                    '~thor_data400::base::monitoring_phone_history',, true),
																fileservices.ClearSuperFile('~thor_data400::base::monitoring_phone_history'),													
							                  fileservices.AddSuperFile('~thor_data400::base::monitoring_phone_history',
							                                            '~thor_data400::base::monitoring_phone_history' + thorlib.wuid()));

export Proc_History_Update_After := parallel(create_addr_hist, create_phone_hist);