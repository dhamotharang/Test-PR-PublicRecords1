import ut;

addsource_layout := record Inquiry_AccLogs.Layout.Common, string source;
end;

export File_Inquiry_MBS := dataset(ut.foreign_logs + 'thor10_11::out::inquiry_tracking::weekly_historical', addsource_layout, thor);