import data_services;

export File_Inquiry_MBS := dataset(data_services.foreign_logs + 'thor100_21::out::inquiry_tracking::weekly_historical', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor);