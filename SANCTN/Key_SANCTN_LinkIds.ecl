IMPORT BIPV2, SANCTN, Data_Services, Doxie, dx_common;

EXPORT Key_SANCTN_LinkIds := MODULE

  // DEFINE THE INDEX
  SHARED superfile_name	:= Data_Services.Data_Location.Prefix('Telcordia')+'thor_data400::key::sanctn::linkids_qa';

  SHARED Base := SANCTN.file_base_party;

  base_clean := PROJECT(Base,{Base}-enh_did_src); //do not inlucde enh_did_src in the key file
  BIPV2.IDmacros.mac_IndexWithXLinkIDs(base_clean, k, superfile_name)
  EXPORT Key := k;

  // DEFINE THE INDEX ACCESS
  // Jira# CCPA-818,  Added mod_access and Mac_check_access to kfetch functions for CCPA suppressions.
  EXPORT kFetch(
    DATASET(BIPV2.IDlayouts.l_xlink_ids) inputs,
    Doxie.IDataAccess mod_access = MODULE(Doxie.IDataAccess) END,
    STRING1 Level = BIPV2.IDconstants.Fetch_Level_DotID,  //The lowest level you'd like to pay attention to.  If U, then all the records for the UltID will be returned.
                                                          //Values:  D is for Dot.  E is for Emp.  W is for POW.  P is for Prox.  O is for Org.  U is for Ult.
                                                          //Should be enumerated or something?  at least need constants defined somewhere if you keep string1
    UNSIGNED2 ScoreThreshold = 0                          //Applied at lowest level of ID
    ) :=
  FUNCTION

    BIPV2.IDmacros.mac_IndexFetch(inputs, Key, fetched, Level);
    fetch_rolled := dx_common.Incrementals.mac_Rollupv2(fetched);
    Sanctn.MAC_Check_Access(fetch_rolled, out, mod_access); // Jira# CCPA-818, Function created for CCPA suppressions at key fetches.
    RETURN out;

  END;

END;
