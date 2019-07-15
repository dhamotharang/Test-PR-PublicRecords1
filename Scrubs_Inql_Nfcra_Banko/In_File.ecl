import inquiry_acclogs;
EXPORT In_File := dataset('~thor100_21::in::banko_acclogs_preprocess', Inquiry_AccLogs.Layout_Banko_Logs, csv(maxlength(10000), separator('~~'), quote('')), opt);
