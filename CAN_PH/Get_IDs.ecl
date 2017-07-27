IMPORT autokeyb2, CanadianPhones_V2,CanadianPhones;

EXPORT Get_ids
 (boolean workhard = true, boolean nofail = true, boolean isV2 = false ) := FUNCTION

  key_name_prefix := if(isV2,CanadianPhones_V2.Constants.FILE_NAME_MASK_QA,CanadianPhones.Constants.FILE_NAME_MASK_QA );
  skip_set := CanadianPhones_V2.Constants.SKIP_SET;
  typestr := CanadianPhones_V2.Constants.AK_TYPESTR;
  // those are "real" fdids, no need to use autokeys' payload file
  ids := autokeyb2.get_IDs (key_name_prefix, typestr, skip_set, workHard, noFail, CAN_PH.MFetch, CAN_PH.MFetchB); 
  return ids;
END;
