import header_services;
weekly_d := gong.File_Gong_Dirty;

gong.Mac_Apply_Legal(weekly_d, weekly_d_out);

export File_Gong_Full := weekly_d_out;