import doxie, Doxie_Raw, iesp;

export Nod_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_nt := project(myHeader, Doxie.Layout_ref_rid);
rids_nt_dedup := dedup(sort(rids_nt, rid), rid);
ds_nt := Doxie_Raw.ViewSourceRid(rids_nt_dedup, mod_access, ['NT']);

iesp.foreclosure.t_ForeclosureReportRecord getNT(iesp.foreclosure.t_ForeclosureReportRecord L) := transform
 self := l;
end;

out_file := normalize(ds_nt,left.nod_child,getNT(right));

return out_file;

END;