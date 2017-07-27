import Doxie, Header, Doxie_raw, ut, govdata;

export MSWork_raw(
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

rids_ms := project(myHeader, Doxie.Layout_ref_rid);
rids_ms_dedup := dedup(sort(rids_ms, rid), rid);
ds_ms := Doxie_Raw.ViewSourceRid(rids_ms_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,,['MS'],,,,,,,appType);

govdata.layout_ms_workers_comp_in getMS(govdata.layout_ms_workers_comp_in L) := transform
 self := l;
end;

out_file := normalize(ds_ms,left.mswork_child,getMS(right));

return out_file;

END;