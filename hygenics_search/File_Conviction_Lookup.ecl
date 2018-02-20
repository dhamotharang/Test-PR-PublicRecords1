import data_services;

export File_Conviction_Lookup := dataset(Data_Services.foreign_prod + 'thor_200::base::crimsrch_conviction_lookup', Layout_Conviction_Lookup, csv(terminator('\r\n'), separator('\t'),quote('')));