import Doxie, Header, Doxie_raw, ut, TransunionCred;

export tn_raw(
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

rids_tn := project(myHeader, Doxie.Layout_ref_rid);
rids_tn_dedup := dedup(sort(rids_tn, rid), rid);
ds_tn := Doxie_Raw.ViewSourceRid(rids_tn_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,dl_mask_value,['TN'],,,,,,,appType);

TransunionCred.Layouts.base getTN(TransunionCred.Layouts.base L) := transform
 self := l;
end;

out_file := normalize(ds_tn,left.tn_child,getTN(right));
return out_file;

END;