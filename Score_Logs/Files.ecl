IMPORT UT, Inquiry_Acclogs;
EXPORT Files := MODULE

//MBS transaction files
EXPORT NonFCRA_Transaction := dataset('~thor_data400::in::score_tracking::log_mbs_transaction_online', Score_Logs.Layouts.Input, csv(separator('~~'), terminator('~~^~~')));
EXPORT FCRA_Transaction := dataset('~thor_data400::in::score_tracking::log_mbs_fcra_transaction_online', Score_Logs.Layouts.Input, csv(separator('~~'), terminator('~~^~~')));

EXPORT NonFCRA_Intermediate := dataset('~thor_data400::in::score_tracking::log_mbs_intermediate', Score_Logs.Layouts.Input_Intermediate, csv(separator('~~'), terminator('~~ENDOFRECORD~~')));
EXPORT FCRA_Intermediate := dataset('~thor_data400::in::score_tracking::log_mbs_fcra_intermediate', Score_Logs.Layouts.Input_Intermediate, csv(separator('~~'), terminator('~~ENDOFRECORD~~')));

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Accounting Log Files

//Accurint
EXPORT NonFCRA_Logs_Accurint := dataset(ut.foreign_logs + 'thor100_21::in::accurint_acclogs_sl', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt)
																																				+dataset(ut.foreign_logs + 'thor100_21::in::accurint_acclogs_sl_preprocess', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);

//Custom
EXPORT NonFCRA_Logs_Custom 	 := dataset(ut.foreign_logs + 'thor100_21::in::custom_acclogs_sl', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt)
																																				+ dataset(ut.foreign_logs + 'thor100_21::in::custom_acclogs_sl_preprocess', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);

//Riskwise
EXPORT NonFCRA_Logs_Riskwise := dataset(ut.foreign_logs + 'thor100_21::in::riskwise_acclogs_sl', Inquiry_Acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt)
																																				+dataset(ut.foreign_logs + 'thor100_21::in::riskwise_acclogs_sl_preprocess', Inquiry_Acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')),opt);

//FCRA Riskwise
EXPORT FCRA_Logs_Riskwise := dataset(ut.foreign_fcra_logs + 'thor10_231::in::riskwise_acclogs_sl', Inquiry_Acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt)
																															+ dataset(ut.foreign_fcra_logs + 'thor10_231::in::riskwise_acclogs_sl_preprocess', Inquiry_Acclogs.Layout_Riskwise_Logs.Input, csv(separator('~~'), quote('')), opt);

END;
