import DriversV2,Header;

f_dlx := PROJECT(DriversV2.File_DL_Extended,DriversV2.Layout_DL);

export File_DL := header.fn_dlamx(f_dlx);