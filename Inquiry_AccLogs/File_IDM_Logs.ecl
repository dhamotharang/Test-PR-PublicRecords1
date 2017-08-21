import ut, Data_Services;

EXPORT File_IDM_Logs := module

export preprocess := dataset(Data_Services.foreign_logs + 'thor100_21::in::idm_bls_acclogs_preprocess', Inquiry_AccLogs.Layout_idm_Logs, csv(separator(','), heading(1), quote('')), opt);
export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::idm_bls_acclogs', Inquiry_AccLogs.Layout_idm_Logs, csv(separator(','), heading(1), quote('')), opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::idm_bls_acclogs_processed', Inquiry_AccLogs.Layout_idm_Logs, csv(separator(','), heading(1), quote('')), opt);

export clean(string select_source = 'IDM') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;