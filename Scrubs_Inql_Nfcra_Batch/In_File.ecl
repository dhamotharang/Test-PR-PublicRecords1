import inquiry_acclogs;
EXPORT In_File := dataset('~thor100_21::in::batch_acclogs_preprocess', Inquiry_AccLogs.Layout_Batch_Logs.extendedInput, csv(maxlength(10000), separator('|'),quote('"')), opt);
