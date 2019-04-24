import Doxie, Doxie_raw, census_data;

export Finder_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_fi := project(myHeader, Doxie.Layout_ref_rid);
rids_fi_dedup := dedup(sort(rids_fi, rid), rid);
ds_fi := Doxie_Raw.ViewSourceRid(rids_fi_dedup, mod_access, ['FI']);

layout_header_raw getFI(Doxie_Raw.Layout_header_raw L) := transform
 self := l;
end;

out_file := normalize(ds_fi,left.finder_child,getFI(right));

eq_nonglb := project(myHeader(src='EQ'),transform(layout_header_raw,self := left));

ret := if(~mod_access.isValidGLB(),out_file + eq_nonglb,out_file);

//Populate county_name.
census_data.MAC_Fips2County_Keyed(ret,st,county,county_name,with_county_name);

return with_county_name;

END;