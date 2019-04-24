import Doxie, Doxie_raw, TransunionCred;

export tn_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_tn := project(myHeader, Doxie.Layout_ref_rid);
rids_tn_dedup := dedup(sort(rids_tn, rid), rid);
ds_tn := Doxie_Raw.ViewSourceRid(rids_tn_dedup, mod_access, ['TN']);

TransunionCred.Layouts.base getTN(TransunionCred.Layouts.base L) := transform
 self := l;
end;

out_file := normalize(ds_tn,left.tn_child,getTN(right));
return out_file;

END;