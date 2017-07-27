import ut,doxie, header,ExperianCred;
export EN_Raw(
    dataset(Doxie.layout_references) dids,
    unsigned3 dateVal = 0,
    unsigned1 dppa_purpose = 0,
    unsigned1 glb_purpose = 0,
    string6 ssn_mask_value = 'NONE',
		string32 appType
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids,dateVal, dppa_purpose, glb_purpose);

rids_en := project(myHeader, Doxie.Layout_ref_rid);
rids_en_dedup := dedup(sort(rids_en, rid), rid);
ds_en := Doxie_Raw.ViewSourceRid(rids_en_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,,['EN'],,,,,,,appType);

ExperianCred.Layouts.Layout_SourceDoc getEN(ExperianCred.Layouts.Layout_SourceDoc L) := transform
 self := l;
end;
out_file := normalize(ds_en,left.en_child,getEN(right));

return if(~ut.glb_ok(glb_purpose),dataset([],ExperianCred.Layouts.Layout_SourceDoc),out_file);


END;