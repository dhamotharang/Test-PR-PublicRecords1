import crimsrch, data_services;

export File_Traffic_Lookup := dataset(data_services.foreign_prod+'thor_200::in::crimsrch_traffic_lookups',
CrimSrch.Layout_Traffic_Lookup, flat, unsorted);