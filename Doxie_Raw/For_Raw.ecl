import doxie,Property;
export For_raw(
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

rids_fr := project(myHeader, Doxie.Layout_ref_rid);
rids_fr_dedup := dedup(sort(rids_fr, rid), rid);
ds_fr := Doxie_Raw.ViewSourceRid(rids_fr_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,,['FR'],,,,,,,appType);

Property.Layout_Fares_Foreclosure getFR(Property.Layout_Fares_Foreclosure L) := transform
 self := l;
end;

out_file := normalize(ds_fr,left.for_child,getFR(right));

return out_file;

END;