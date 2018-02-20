import crimsrch, data_services;

export File_Traffic_Lookup := dataset(Data_Services.foreign_prod+'~thor_200::in::crimsrch_traffic_lookup', CrimSrch.Layout_Traffic_Lookup, flat, unsorted);