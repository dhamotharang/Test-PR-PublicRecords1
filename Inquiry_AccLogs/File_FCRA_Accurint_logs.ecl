IMPORT ut;
EXPORT File_FCRA_Accurint_Logs :=  dataset(ut.foreign_fcra_logs+'thor10_231::in::Accurint_acclogs', inquiry_acclogs.Layout_accounting_Logs,csv(maxlength(250000), quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);

