import Doxie, Header, Doxie_raw, ut, utilfile, mdr;

export Util_raw(
    dataset(Doxie.layout_references_hh) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		string5 industry_class_value,
    string6 ssn_mask_value = 'NONE',
    boolean dl_mask_value = false,
	  string32 appType
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids,
    dateVal, dppa_purpose, glb_purpose);

rids_ut := project(myHeader, Doxie.Layout_ref_rid);
rids_ut_dedup := dedup(sort(rids_ut, rid), rid);
ds_ut := Doxie_Raw.ViewSourceRid(rids_ut_dedup, dateVal, dppa_purpose, glb_purpose,ssn_mask_value,dl_mask_value,mdr.sourcetools.set_Utility_sources,,,,,,,appType);

utilfile.layout_utility_in getUT(utilfile.layout_utility_in L) := transform
 self := l;
end;

out_file := normalize(ds_ut,left.util_child,getUT(right))+ // glb already applied in ViewSourceRid.
						PROJECT(doxie_raw.Util_Daily_Raw(dids,dateVal,dppa_purpose,glb_purpose,industry_class_value,ssn_mask_value,dl_mask_value),utilfile.Layout_Utility_In);

glb_ok := ut.PermissionTools.glb.ok(glb_purpose);

return IF(industry_class_value<>'UTILI' and glb_ok,out_file);

END;