IMPORT $, BIPV2, doxie;

EXPORT key_linkids := MODULE

  base_clean := DATASET([], $.layouts.i_link_ids);
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_clean, k,  $.names().i_link_ids)
  EXPORT key := k;

  EXPORT kFetch(
    dataset(BIPV2.IDlayouts.l_xlink_ids) inputs,
    doxie.IDataAccess mod_access = MODULE(doxie.IDataAccess) END,
    string1 Level = BIPV2.IDconstants.Fetch_Level_DotID,
    unsigned2 ScoreThreshold = 0
    ) :=
  FUNCTION
    BIPV2.IDmacros.mac_IndexFetch(inputs, key, fetched, Level)
    $.MAC_Check_Access(fetched, out, mod_access);
    return out;																					
  END;

END;
