import data_services, inql_v2;
d:= dataset(data_services.foreign_logs + 'thor_data::base::inql::nonfcra::weekly::qa', INQL_v2.Layouts.Common_ThorAdditions, thor);

EXPORT File_Inquiry_MBS := project(d,transform (Inquiry_AccLogs.Layout.Common_ThorAdditions, self:=left;));

// export File_Inquiry_MBS := dataset(data_services.foreign_logs + 'thor100_21::out::inquiry_tracking::weekly_historical', Inquiry_AccLogs.Layout.Common_ThorAdditions, thor);