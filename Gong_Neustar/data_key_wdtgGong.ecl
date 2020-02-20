IMPORT dx_Gong, doxie, nid, ut, Relocations;

baserecset := Relocations.file_wdtgGong;

EXPORT data_key_wdtgGong := PROJECT(baserecset, TRANSFORM(dx_Gong.layouts.i_history_wdtg,
                                                          SELF.dph_name_last := metaphonelib.DMetaPhone1(LEFT.name_last),
                                                          SELF.zip5 := (integer4)LEFT.z5,
                                                          SELF.p_name_first := NID.PreferredFirstNew(LEFT.name_first),
                                                          SELF := LEFT)
);