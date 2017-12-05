import ut, inquiry_acclogs,data_services;

n := 0; /* n - to test a sample set */

export File_AccLogs_in := dataset('~thor_data400::in::accurint_acclogs_cc', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])));