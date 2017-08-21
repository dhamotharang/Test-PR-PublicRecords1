//this attribute update the history file with the new out file
import monitoring_other, ut;

f_prp_out := monitoring_other.file_prp_out;
f_prp_hist := monitoring_other.file_prp_history;



f_new_prp_hist := distribute(project(f_prp_out, transform(monitoring_other.layout_prp_slim,
                                                          self.prpty_deed_id := left.ln_prp_deed,
																													self.date_in := ut.GetDate,
                                                          self := left)) 
														 + f_prp_hist, hash(customer_id, record_id));
  
create_prp_hist := sequential(output(f_new_prp_hist,,'~thor_data400::base::monitoring_property_history' + thorlib.wuid()),
					                           fileservices.ClearSuperFile('~thor_data400::base::monitoring_property_history'),
							                       fileservices.AddSuperFile('~thor_data400::base::monitoring_property_history',
							                                                 '~thor_data400::base::monitoring_property_history' + thorlib.wuid()));

f_paw_out := monitoring_other.file_paw_out;
f_paw_hist := monitoring_other.file_paw_history;

f_new_paw_hist := distribute(project(f_paw_out, transform(monitoring_other.layout_paw_hist,
																													self.date_in := ut.GetDate,
                                                          self := left)) 
														 + f_paw_hist, hash(customer_id, record_id));
  
create_paw_hist := sequential(output(f_new_paw_hist,,'~thor_data400::base::monitoring_paw_history' + thorlib.wuid()),
					                           fileservices.ClearSuperFile('~thor_data400::base::monitoring_paw_history'),
							                       fileservices.AddSuperFile('~thor_data400::base::monitoring_paw_history',
							                       '~thor_data400::base::monitoring_paw_history' + thorlib.wuid()));

export Proc_prp_paw_history_update_after := parallel(create_prp_hist, create_paw_hist);
