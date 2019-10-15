import inquiry_acclogs, inql_v2;
EXPORT in_file := inql_v2.Files(true).batch_input;
//dataset('~thor10_231::in::batch_acclogs_preprocess',Inquiry_AccLogs.Layout_Batch_Logs.input, csv(separator('|'),quote('"')), opt);
