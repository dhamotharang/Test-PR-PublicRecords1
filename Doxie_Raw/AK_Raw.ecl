import doxie,ak_perm_fund;
export ak_raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		string32 appType
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids,
    dateVal, dppa_purpose, glb_purpose);

rids_ak := project(myHeader, Doxie.Layout_ref_rid);
rids_ak_dedup := dedup(sort(rids_ak, rid), rid);
ds_ak := Doxie_Raw.ViewSourceRid(rids_ak_dedup,dateVal,dppa_purpose,glb_purpose,,,['AK'],,,,,,,appType);

ak_perm_fund.Layout_AK_Common getAK(ak_perm_fund.Layout_AK_Common L) := transform
 self := l;
end;

out_file := normalize(ds_ak,left.ak_child,getAK(right));

return out_file;

END;