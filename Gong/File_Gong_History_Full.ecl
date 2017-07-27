import Header_Services;
hist_d := gong.File_History;

gong.Mac_Apply_Legal(hist_d, hist_d_out);

export File_Gong_History_Full := hist_d_out;