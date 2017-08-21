import BIPV2_Files, BIPV2, MDR, BIPv2_LGID3;

// Init receives a file in common layout, and narrows it for use in all iterations. We widen
// back to the common layout before promoting it to the base/father/grandfather superfiles.
l_common := BIPV2.CommonBase.Layout;
l_base := BIPV2_Files.files_lgid3.Layout_LGID3;

export proc_lgid3 := BIPV2_LGID3._proc_lgid3;
