import ut;

export File_Custom_Logs := module

export input := dataset(ut.foreign_logs + '~thor10_11::in::custom_acclogs', Inquiry_AccLogs.Layout_Custom_Logs, csv(maxlength(10000), quote(''), separator('~~'), terminator(['\r\n', '\n'])), opt);
export processed := dataset(ut.foreign_logs + '~thor10_11::in::custom_acclogs_processed', Inquiry_AccLogs.Layout_Custom_Logs, csv(maxlength(10000), quote(''), separator('~~'), terminator(['\r\n', '\n'])), opt);

export clean(string select_source = 'CUSTOM') := dataset(ut.foreign_logs + '~persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);


end;