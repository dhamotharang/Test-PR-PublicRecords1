base := govdata.File_FDIC_Base_AID;

export File_FDIC_BDID := project(base, transform(layout_fdic_bdid, self := left));

