//============================================================================
// Attribute: Dob_Raw  Used by view source service.
// Function to get the source of header records by did.
// Return value: dataset of layout Doxie_Raw.Layout_crs_raw.
//============================================================================
import Doxie, Doxie_raw;

export Dob_Raw(
    dataset(Doxie_raw.Layout_input) input,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by 'section='ssn'.
myHeader := Doxie_Raw.Header_Raw(
    project(input, transform(Doxie.layout_references, self.did:=(unsigned6)left.id)),
    mod_access)(dob > 0 and valid_dob!='M');


//dob section
rids_dob := project(myHeader, Doxie.Layout_ref_rid);
rids_dob_dedup := dedup(sort(rids_dob, rid), rid);
ds_dob := Doxie_Raw.ViewSourceRid(rids_dob_dedup, mod_access);

return ds_dob;
END;
