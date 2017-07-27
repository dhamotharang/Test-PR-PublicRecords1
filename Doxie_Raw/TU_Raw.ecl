import Doxie, Header, Doxie_raw, ut, LN_TU;

export tu_raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE',
    boolean dl_mask_value = false,		
		string32 appType
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids,
    dateVal, dppa_purpose, glb_purpose);

rids_tu := project(myHeader, Doxie.Layout_ref_rid);
rids_tu_dedup := dedup(sort(rids_tu, rid), rid);
ds_tu := Doxie_Raw.ViewSourceRid(rids_tu_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,dl_mask_value,['LT'],,,,,,,appType);

LN_TU.Layout_In_Header_All getTU(LN_TU.Layout_In_Header_All L) := transform
 self := l;
end;

out_file := normalize(ds_tu,left.tu_child,getTU(right));

return out_file;

END;