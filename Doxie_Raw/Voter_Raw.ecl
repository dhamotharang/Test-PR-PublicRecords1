//============================================================================
// Attribute: Voter_Raw.  Used by view source service and comp-report.
// Function to get voter records by did.
// Return value: Dataset with layout 'plusdid'.
//============================================================================

import VotersV2_Services, emerges, ut,doxie_files,codes,doxie_crs, Doxie, Census_Data, suppress;

export Voter_Raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE'
) := FUNCTION

  out_mskd := VotersV2_Services.raw.MOXIE_VIEW.by_did (dids, ssn_mask_value);	
  return out_mskd;
END;
