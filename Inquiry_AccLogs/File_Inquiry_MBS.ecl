import data_services;

addsource_layout := record Inquiry_AccLogs.Layout.Common, string source;
end;

export File_Inquiry_MBS := dataset(Data_Services.foreign_logs + 'thor10_11::out::inquiry_tracking::weekly_historical', addsource_layout, thor);