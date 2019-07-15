import inquiry_acclogs;
EXPORT in_file := dataset('~thor10_231::in::batch_acclogs_preprocess',Inquiry_AccLogs.Layout_Batch_Logs.input, csv(separator('|'),quote('"')), opt);
