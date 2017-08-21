#workunit('name', 'Thor Monitoring - Property')
#workunit('priority', 'high')

import monitoring, monitoring_other;

export proc_monitor_them := 
	     sequential(monitoring_other.proc_prp_paw_history_update_before,
			            monitoring_other.proc_prp_paw_search,

                  // sending results
			            // monitoring.Client (monitoring.Constants.ClientID.PRA).SendProperty (monitoring_other.file_prp_out, 
									                                                                    // monitoring.File_Address_History),
			            // monitoring.Client (monitoring.Constants.ClientID.PRA).SendPAW (monitoring_other.file_paw_out, 
									                                                               // monitoring.File_Address_History),

                  // monitoring.Clients.WAM.SendPaw  (monitoring_other.file_paw_out, monitoring.File_Address_History),
                  // monitoring.Clients.WAM2.SendPaw (monitoring_other.file_paw_out, monitoring.File_Address_History),

                  // monitoring.Clients.WPF.SendProperty (monitoring_other.file_prp_out, monitoring.File_Address_History),
                  // monitoring.Clients.WPF.SendPaw      (monitoring_other.file_paw_out, monitoring.File_Address_History),
                  // all sent

									monitoring_other.proc_prp_paw_history_update_after);