import Header_Services;
hist_d := File_GongHistory;

gong_neustar.Mac_Apply_Legal(hist_d, hist_d_out);

export File_Gong_History_FullEx := hist_d_out;
