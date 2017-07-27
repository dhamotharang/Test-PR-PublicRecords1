import doxie,iesp;
export Nod_raw(
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

rids_nt := project(myHeader, Doxie.Layout_ref_rid);
rids_nt_dedup := dedup(sort(rids_nt, rid), rid);
ds_nt := Doxie_Raw.ViewSourceRid(rids_nt_dedup,dateVal,dppa_purpose,glb_purpose,ssn_mask_value,,['NT'],,,,,,,appType);

iesp.foreclosure.t_ForeclosureReportRecord getNT(iesp.foreclosure.t_ForeclosureReportRecord L) := transform
 self := l;
end;

out_file := normalize(ds_nt,left.nod_child,getNT(right));

return out_file;

END;