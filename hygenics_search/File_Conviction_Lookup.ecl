import ut;

export File_Conviction_Lookup := dataset('~thor_200::base::crimsrch_conviction_lookup', Layout_Conviction_Lookup, csv(terminator('\r\n'), separator('\t'),quote('"')))(conviction_flag not in ['','Conviction_flag'] );

// export File_Conviction_Lookup := dataset('~thor_400::new_dispositions20151204_updated.txt', Layout_Conviction_Lookup, csv(terminator('\r\n'), separator('\t'),quote('"')));
