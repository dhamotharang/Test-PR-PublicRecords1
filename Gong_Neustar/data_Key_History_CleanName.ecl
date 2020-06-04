IMPORT $, dx_Gong, nid, phonesplus_v2, gong;

hist_in_gong := $.File_Surnames(trim(name_last)<>'');
hist_in_pplus := project(Phonesplus_v2.File_Surnames(trim(name_last)<>''), recordof(File_Surnames));
hist_in := hist_in_gong + hist_in_pplus;

gong.mac_hist_full_slim_dep(hist_in, hist_out);

EXPORT data_key_history_CleanName := PROJECT(hist_out, TRANSFORM(dx_Gong.layouts.i_history_name,
                                                                 SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last),
                                                                 SELF.p_name_first  := NID.PreferredFirstNew(LEFT.name_first),
                                                                 SELF := LEFT));