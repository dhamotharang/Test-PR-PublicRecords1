import inquiry_acclogs, inql_v2;
EXPORT In_File := INQL_V2.Files().InputFiles(false,true,'custom','building');
//dataset('~thor100_21::in::custom_acclogs_preprocess', Inquiry_AccLogs.Layout_Custom_Logs, csv(maxlength(10000), quote(''), separator('~~'), terminator(['\r\n', '\n'])), opt);
