d := dataset('~thor_data400::base::ucc_party_wexp', uccd.Layout_WithExpParty, flat);
uccd.mac_filterStateOverlap(d, stateclean)
export File_WithExpParty := stateclean;