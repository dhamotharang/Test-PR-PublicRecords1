d :=  dataset('~thor_data400::base::ucc_summary_wexp', uccd.Layout_WithExpFilingSummary, flat);
uccd.mac_filterStateOverlap(d, stateclean)
export File_WithExpSummary := stateclean;