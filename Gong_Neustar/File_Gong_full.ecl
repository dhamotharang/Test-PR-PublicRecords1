import header_services;
weekly_d := File_Gong_Dirty;

gong_neustar.Mac_Apply_Legal(weekly_d, weekly_d_out);

export File_Gong_Full := weekly_d_out;