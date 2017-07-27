import Header_Services;
daily_d := gong.File_Daily_Additions;

gong.Mac_Apply_Legal(daily_d, daily_d_out);

export File_Daily_Full := daily_d_out;