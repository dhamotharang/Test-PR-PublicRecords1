import ut;

DNB_Fein_base := DNB_FEINV2.File_DNB_Fein_base_main_new;

export File_DNB_Fein_base_main := project(DNB_Fein_base, transform(DNB_FEINV2.layout_DNB_fein_base_main, self := left));
