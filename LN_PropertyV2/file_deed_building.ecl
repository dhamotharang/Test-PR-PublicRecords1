import ut; 

ut.mac_suppress_by_phonetype(LN_PropertyV2.File_Deed, phone_number,  state, deed_phone_suppressed,false);

export file_deed_building := deed_phone_suppressed(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID) : persist('deed_phone_suppression');