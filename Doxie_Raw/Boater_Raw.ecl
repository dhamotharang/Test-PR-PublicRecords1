import Doxie, Doxie_raw, emerges;

export Boater_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_bt := project(myHeader, Doxie.Layout_ref_rid);
rids_bt_dedup := dedup(sort(rids_bt, rid), rid);
ds_bt := Doxie_Raw.ViewSourceRid(rids_bt_dedup, mod_access, ['EB']); 

emerges.Layout_Boats_In getBoats(emerges.Layout_Boats_In L) := transform
 self := l;
end;

out_file := normalize(ds_bt,left.boater_child,getBoats(right));

return out_file;

END;