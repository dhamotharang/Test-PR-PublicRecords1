IMPORT dx_Gong, gong, nid;

hist_in := $.File_History_Full_Prepped_for_Keys(z5<>'');
gong.mac_hist_full_slim_dep(hist_in, hist_out)

// project first, to avoid duplicate call to metaphonelib:
ds_ready := PROJECT(hist_out, TRANSFORM(dx_Gong.layouts.i_history_zip_name,
                                        SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last),
                                        SELF.p_name_first  := NID.PreferredFirstNew(LEFT.name_first),
                                        SELF.zip5 := (integer4) LEFT.z5,
                                        SELF := LEFT));

EXPORT data_key_history_zip_name := ds_ready(dph_name_last != '');