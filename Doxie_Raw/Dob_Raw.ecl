//============================================================================
// Attribute: Dob_Raw  Used by view source service.
// Function to get the source of header records by did.
// Return value: dataset of layout Doxie_Raw.Layout_crs_raw.
//============================================================================
import codes, Doxie, Header, Doxie_raw, ut;

export Dob_Raw(
    dataset(Doxie_raw.Layout_input) input,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE',
    boolean dl_mask_value = false,		
	  string32 appType
) := FUNCTION

//input should have been filtered by 'section='ssn'.
myHeader := Doxie_Raw.Header_Raw(
    project(input, transform(Doxie.layout_references, self.did:=(unsigned6)left.id)),
    dateVal, dppa_purpose, glb_purpose)(dob > 0 and valid_dob!='M');


//dob section
rids_dob := project(myHeader, Doxie.Layout_ref_rid);
rids_dob_dedup := dedup(sort(rids_dob, rid), rid);
ds_dob := Doxie_Raw.ViewSourceRid(rids_dob_dedup, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,dl_mask_value,,,,,,,,appType);

return ds_dob;
END;
