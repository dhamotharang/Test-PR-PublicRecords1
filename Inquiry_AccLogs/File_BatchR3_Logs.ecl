import ut;

export File_BatchR3_Logs := module 

export input := dataset(ut.foreign_logs + 'thor10_11::in::batchr3_acclogs', {inquiry_acclogs.Layout_ProdR3, string source}, thor, opt);
export processed := dataset(ut.foreign_logs + 'thor10_11::in::batchr3_acclogs_processed', {inquiry_acclogs.Layout_ProdR3, string source}, thor, opt);

export clean(string select_source = 'BATCHR3') := dataset(ut.foreign_logs + 'persist::inquiry_tracking::appends::daily', Inquiry_AccLogs.layout_in_common, thor, opt)(source_file = select_source);

end;