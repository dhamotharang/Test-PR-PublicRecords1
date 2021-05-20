import inquiry_acclogs, inql_v2;
EXPORT In_File := INQL_V2.Files().InputFiles(false,true,'banko','building');
//dataset('~thor100_21::in::banko_acclogs_preprocess', Inquiry_AccLogs.Layout_Banko_Logs, csv(maxlength(10000), separator('~~'), quote('')), opt);
