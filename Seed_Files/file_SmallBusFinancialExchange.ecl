IMPORT Data_Services,Seed_Files;

EXPORT file_SmallBusFinancialExchange := DATASET(Data_Services.Data_location.Prefix('NONAMEGIVEN')+'~thor_data400::base::testseed_smallbusfinancialexchange', Seed_Files.layout_SmallBusFinancialExchange, CSV(HEADING(1), SEPARATOR(','), QUOTE('"')), OPT);
