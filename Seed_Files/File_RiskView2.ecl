IMPORT Seed_Files, UT;

EXPORT File_RiskView2 := DATASET('~thor_data400::base::testseed_riskview2', Seed_Files.Layout_RiskView2, CSV(HEADING(2), separator(','), QUOTE('"')), OPT);