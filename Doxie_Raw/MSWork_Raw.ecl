import Doxie, Doxie_raw;

export MSWork_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_ms := project(myHeader, Doxie.Layout_ref_rid);
rids_ms_dedup := dedup(sort(rids_ms, rid), rid);
ds_ms := Doxie_Raw.ViewSourceRid(rids_ms_dedup, mod_access, ['MS']);

out_file := normalize(ds_ms,left.mswork_child,transform(right));

return out_file;

END;
