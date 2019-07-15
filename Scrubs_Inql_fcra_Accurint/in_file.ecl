import ut,inquiry_acclogs;
EXPORT In_File :=  dataset(ut.foreign_fcra_logs+'thor10_231::in::Accurint_acclogs_preprocess', inquiry_acclogs.Layout_accounting_Logs,csv(maxlength(250000), quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);
