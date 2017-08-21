import ut, Data_Services;

export File_BatchR3_Logs := module 

export input := dataset(Data_Services.foreign_logs + 'thor100_21::in::batchr3_acclogs', {inquiry_acclogs.Layout_ProdR3, string source}, thor, opt);
export processed := dataset(Data_Services.foreign_logs + 'thor100_21::in::batchr3_acclogs_processed', {inquiry_acclogs.Layout_ProdR3, string source}, thor, opt);

export clean(string select_source = 'BATCHR3') := dataset(Data_Services.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;