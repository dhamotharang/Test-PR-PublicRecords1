IMPORT Seed_Files, UT;

EXPORT file_SmallBusFinancialExchange := DATASET('~thor_data400::base::testseed_smallbusfinancialexchange', Seed_Files.layout_SmallBusFinancialExchange, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
