IMPORT Seed_Files;

EXPORT file_SmallBusModels := DATASET('~thor_data400::base::testseed_smallbusmodels', Seed_Files.layout_SmallBusModels, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
