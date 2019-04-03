import Doxie, Doxie_raw, LN_TU;

export tu_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_tu := project(myHeader, Doxie.Layout_ref_rid);
rids_tu_dedup := dedup(sort(rids_tu, rid), rid);
ds_tu := Doxie_Raw.ViewSourceRid(rids_tu_dedup, mod_access, ['LT']);

LN_TU.Layout_In_Header_All getTU(LN_TU.Layout_In_Header_All L) := transform
 self := l;
end;

out_file := normalize(ds_tu,left.tu_child,getTU(right));

return out_file;

END;