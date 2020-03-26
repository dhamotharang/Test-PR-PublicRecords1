IMPORT UT, Inquiry_Acclogs, data_services;
EXPORT Files := MODULE

//MBS transaction files
EXPORT NonFCRA_Transaction := dataset('~thor_data400::in::score_tracking::log_mbs_transaction_online', Score_Logs.Layouts.Input, csv(separator('|\t|'), terminator('|\n')));
EXPORT FCRA_Transaction := dataset('~thor_data400::in::score_tracking::log_mbs_fcra_transaction_online', Score_Logs.Layouts.Input, csv(separator('|\t|'), terminator('|\n')));

EXPORT NonFCRA_Intermediate := dataset('~thor_data400::in::score_tracking::log_mbs_intermediate', Score_Logs.Layouts.Input_Intermediate, csv(separator('|\t|'), terminator('|\n')));
EXPORT FCRA_Intermediate := dataset('~thor_data400::in::score_tracking::log_mbs_fcra_intermediate', Score_Logs.Layouts.Input_Intermediate, csv(separator('|\t|'), terminator('|\n')));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Accounting Log Files

//Accurint
EXPORT NonFCRA_Logs_Accurint := dataset('~thor_data400::in::accurint_acclogs_sl', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);
																																				
//Custom
EXPORT NonFCRA_Logs_Custom 	 := dataset('~thor_data400::in::custom_acclogs_sl', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);
																															
//Riskwise
EXPORT NonFCRA_Logs_Riskwise := dataset('~thor_data400::in::riskwise_acclogs_sl', Inquiry_Acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt);
																															
//FCRA Riskwise
EXPORT FCRA_Logs_Riskwise := dataset('~thor_data400::in::FCRA_riskwise_acclogs_sl', Inquiry_Acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt);
																															
END;
