//============================================================================
// Attribute: SSN_Raw.  Used by view source service.
// Function to get the source of header records by did.
// Return value: dataset of layout Doxie_Raw.Layout_crs_raw.
//============================================================================
import Doxie, Doxie_raw;

export SSN_raw(
    dataset(Doxie_raw.Layout_input) input,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(
    project(input, transform(Doxie.layout_references, self.did:=(unsigned6)left.id)),
    mod_access)(ssn!='' and valid_ssn!='M');

rids_ssn := project(myHeader, Doxie.Layout_ref_rid);
rids_ssn_dedup := dedup(sort(rids_ssn, rid), rid);
ds_ssn := Doxie_Raw.ViewSourceRid(rids_ssn_dedup, mod_access);
 
return ds_ssn;
END;