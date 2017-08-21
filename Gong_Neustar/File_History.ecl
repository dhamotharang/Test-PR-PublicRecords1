IMPORT header_services;
hist_d := File_GongHistory;
gong_neustar.Mac_Apply_Legal(hist_d, hist_d_out);


EXPORT File_History := hist_d_out;