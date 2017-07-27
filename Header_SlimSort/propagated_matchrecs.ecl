import watchdog,header,mdr;

inf := header.fn_filter_for_keys_and_slimsorts(header.file_headers,true);

export propagated_matchrecs := header.fn_populate_matchrecs(inf,watchdog.File_Best,'_slimsort',Header_Slimsort.Constants.UsePFNew);