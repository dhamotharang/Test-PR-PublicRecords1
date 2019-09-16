import inquiry_acclogs;
EXPORT In_File := dataset('~thor100_21::in::custom_acclogs_preprocess', Inquiry_AccLogs.Layout_Custom_Logs, csv(maxlength(10000), quote(''), separator('~~'), terminator(['\r\n', '\n'])), opt);
