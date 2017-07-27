import Doxie, Header, Doxie_raw, ut, emerges;

export Boater_raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
		string32 appType
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids,
    dateVal, dppa_purpose, glb_purpose);

rids_bt := project(myHeader, Doxie.Layout_ref_rid);
rids_bt_dedup := dedup(sort(rids_bt, rid), rid);
ds_bt := Doxie_Raw.ViewSourceRid(rids_bt_dedup,dateVal,dppa_purpose,glb_purpose,,,['EB'],,,,,,,appType);

emerges.Layout_Boats_In getBoats(emerges.Layout_Boats_In L) := transform
 self := l;
end;

out_file := normalize(ds_bt,left.boater_child,getBoats(right));

return out_file;

END;