import Doxie, Header, Doxie_raw, ut, census_data;

export Finder_raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE',
		string32 appType
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids,
    dateVal, dppa_purpose, glb_purpose);

rids_fi := project(myHeader, Doxie.Layout_ref_rid);
rids_fi_dedup := dedup(sort(rids_fi, rid), rid);
ds_fi := Doxie_Raw.ViewSourceRid(rids_fi_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,,['FI'],,,,,,,appType);

layout_header_raw getFI(Doxie_Raw.Layout_header_raw L) := transform
 self := l;
end;

out_file := normalize(ds_fi,left.finder_child,getFI(right));

eq_nonglb := project(myHeader(src='EQ'),transform(layout_header_raw,self := left));

ret := if(~ut.glb_ok(glb_purpose),out_file + eq_nonglb,out_file);

//Populate county_name.
census_data.MAC_Fips2County_Keyed(ret,st,county,county_name,with_county_name);

return with_county_name;

END;