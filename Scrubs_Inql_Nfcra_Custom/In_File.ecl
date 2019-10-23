import inquiry_acclogs, inql_v2;
EXPORT In_File := inql_v2.Files().custom_input;
//dataset('~thor100_21::in::custom_acclogs_preprocess', Inquiry_AccLogs.Layout_Custom_Logs, csv(maxlength(10000), quote(''), separator('~~'), terminator(['\r\n', '\n'])), opt);
