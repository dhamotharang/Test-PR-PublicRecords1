import data_services;

temp_file := dataset(data_services.foreign_prod+'thor_200::base::crimsrch_conviction_lookup', Layout_Conviction_Lookup, csv(terminator('\r\n'), separator('\t'),quote('"')))(conviction_flag not in ['','Conviction_flag'] );

FilteredTempFile := temp_file(~(court_disp_desc ='NG CHANGED TO GUILTY - OR' and conviction_flag ='N')); //filtering duplicate and wrong entry 

export File_Conviction_Lookup := dedup(sort(FilteredTempFile,record),record);
