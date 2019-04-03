import Doxie, Doxie_raw, utilfile, mdr;

export Util_raw(
    dataset(Doxie.layout_references_hh) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_ut := project(myHeader, Doxie.Layout_ref_rid);
rids_ut_dedup := dedup(sort(rids_ut, rid), rid);
ds_ut := Doxie_Raw.ViewSourceRid(rids_ut_dedup, mod_access, mdr.sourcetools.set_Utility_sources);

utilfile.layout_utility_in getUT(utilfile.layout_utility_in L) := transform
 self := l;
end;

out_file := normalize(ds_ut,left.util_child,getUT(right))+ // glb already applied in ViewSourceRid.
						PROJECT(doxie_raw.Util_Daily_Raw(dids,mod_access.date_threshold,mod_access.dppa,mod_access.glb,mod_access.industry_class,mod_access.ssn_mask,mod_access.dl_mask>0),utilfile.Layout_Utility_In);

glb_ok := mod_access.isValidGLB();

return IF(~mod_access.isUtility() and glb_ok, out_file);

END;