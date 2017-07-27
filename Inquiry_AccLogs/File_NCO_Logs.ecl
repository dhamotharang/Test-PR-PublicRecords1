import ut;
export File_NCO_Logs := module 

export input := dataset(ut.foreign_logs + '~thor10_11::in::nco_acclogs', inquiry_acclogs.LAYOUT_NCO_LOGS, csv(separator(','), terminator('\n'), quote('"')), opt);
export processed := dataset(ut.foreign_logs + '~thor10_11::in::nco_acclogs_processed', inquiry_acclogs.LAYOUT_NCO_LOGS, csv(separator(','), terminator('\n'), quote('"')), opt);
																				
export clean(string select_source = 'NCO') := dataset(ut.foreign_logs + '~persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;