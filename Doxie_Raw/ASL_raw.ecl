import doxie, american_student_list;
export asl_raw(
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

rids_asl := project(myHeader, Doxie.Layout_ref_rid);
rids_asl_dedup := dedup(sort(rids_asl, rid), rid);
ds_asl := Doxie_Raw.ViewSourceRid(rids_asl_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,dl_mask_value,['SL'],,,,,,,appType);

american_student_list.layout_american_student_base getASL(american_student_list.layout_american_student_base L) := transform
 self := l;
end;

out_file := normalize(ds_asl,left.student_child,getASL(right));
return out_file;

END;