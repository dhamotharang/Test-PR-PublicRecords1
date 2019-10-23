import inquiry_acclogs, inql_v2;
EXPORT In_File := inql_v2.Files().batch_input; 
//dataset('~thor100_21::in::batch_acclogs_preprocess', Inquiry_AccLogs.Layout_Batch_Logs.extendedInput, csv(maxlength(10000), separator('|'),quote('"')), opt);
