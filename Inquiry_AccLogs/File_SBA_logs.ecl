import ut;

export File_SBA_Logs := module

export input := dataset(ut.foreign_logs + 'thor100_21::in::sba_acclogs', inquiry_acclogs.Layout_SBA_logs.input_raw, csv(quote(''), separator(['~~~']), terminator(['~~^~~'])));
export processed := dataset(ut.foreign_logs + 'thor100_21::in::SBA_acclogs_processed', inquiry_acclogs.Layout_SBA_logs.input_raw, csv(quote(''), separator(['~~~']), terminator(['~~^~~'])));

end;

