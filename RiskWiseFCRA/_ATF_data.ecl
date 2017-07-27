import doxie, doxie_raw, FCRA, Suppress;

// ATF records are linked by "atf_id" which is actually a persistent and unique id

boolean IsFCRA := true;

EXPORT _ATF_data (dataset (doxie.layout_references) in_dids, 
                  dataset (fcra.Layout_override_flag) flag_file,
                  integer nss = Suppress.Constants.NonSubjectSuppression.doNothing) := MODULE

  // we can use basic doxie version implementation
  export atf := doxie_raw.atf_raw (in_dids, , , , , IsFCRA, flag_file, nss);
    // unsigned3 dateVal = 0,
    // unsigned1 dppa_purpose = 0,
    // unsigned1 glb_purpose = 0,
    // string6 ssn_mask_value = 'NONE',
END;
