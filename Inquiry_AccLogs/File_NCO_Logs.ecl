import ut, Data_Services;
export File_NCO_Logs := module 

export input := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_tracking::weekly_historical::in::nco_acclogs', inquiry_acclogs.LAYOUT_NCO_LOGS, csv(separator(','), terminator('\n'), quote('"')), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::out::inquiry_tracking::weekly_historical::in::nco_acclogs_processed', inquiry_acclogs.LAYOUT_NCO_LOGS, csv(separator(','), terminator('\n'), quote('"')), opt);
																				
export clean(string select_source = 'NCO') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;