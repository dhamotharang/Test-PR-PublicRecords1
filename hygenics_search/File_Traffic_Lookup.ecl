import crimsrch, ut;

export File_Traffic_Lookup := dataset(ut.foreign_prod+'~thor_200::in::crimsrch_traffic_lookup', CrimSrch.Layout_Traffic_Lookup, flat, unsorted);