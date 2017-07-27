import ut; 

ut.mac_suppress_by_phonetype(LN_PropertyV2.File_Assessment,assessee_phone_number,state_code,assesor_phone_suppressed,false);

export file_assessment_building := assesor_phone_suppressed(ln_fares_id not in LN_PropertyV2.Suppress_LNFaresID) : persist('assessor_phone_suppression');