import ut;

export File_Accurint_Logs := module

export input := dataset(ut.foreign_logs + '~thor10_11::in::accurint_acclogs', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);
export processed := dataset(ut.foreign_logs + '~thor10_11::in::accurint_acclogs_processed', Inquiry_AccLogs.Layout_Accurint_Logs, csv(quote(''), separator(['~~','\t']), terminator(['\r\n', '\n'])), opt);

export clean(string select_source = 'ACCURINT') := dataset(ut.foreign_logs + '~persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;