IMPORT $, dx_Gong, gong, nid;

hist_in := $.File_History_Full_Prepped_for_Keys(trim(name_last)<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

EXPORT data_key_history_name := PROJECT(hist_out, TRANSFORM(dx_Gong.layouts.i_history_name,
                                                            SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last),
                                                            SELF.p_name_first  := NID.PreferredFirstNew(LEFT.name_first),
                                                            SELF := LEFT));