import fcra;

export file_FCRA_GongHistory := dataset('~thor_data400::base::testseed_fcra_gonghistory', fcra.GongHistoryLayouts.Layout_TestSeed, csv(heading(single), quote('"')));
