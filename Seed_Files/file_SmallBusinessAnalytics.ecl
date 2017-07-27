IMPORT Seed_Files, UT;

EXPORT file_SmallBusinessAnalytics := DATASET('~thor_data400::base::testseed_smallbusinessanalytics', Seed_Files.layout_SmallBusinessAnalytics, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);