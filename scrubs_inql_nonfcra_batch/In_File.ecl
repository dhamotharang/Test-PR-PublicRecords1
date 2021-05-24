import inquiry_acclogs, inql_v2;
EXPORT In_File := INQL_V2.Files().InputFiles(false,true,'batch','building');
//dataset('~thor100_21::in::batch_acclogs_preprocess', Inquiry_AccLogs.Layout_Batch_Logs.extendedInput, csv(maxlength(10000), separator('|'),quote('"')), opt);
