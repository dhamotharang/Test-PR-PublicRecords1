import doxie,ak_perm_fund;
export ak_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_ak := project(myHeader, Doxie.Layout_ref_rid);
rids_ak_dedup := dedup(sort(rids_ak, rid), rid);
ds_ak := Doxie_Raw.ViewSourceRid(rids_ak_dedup, mod_access,
           ['AK']);

ak_perm_fund.Layout_AK_Common getAK(ak_perm_fund.Layout_AK_Common L) := transform
 self := l;
end;

out_file := normalize(ds_ak,left.ak_child,getAK(right));

return out_file;

END;