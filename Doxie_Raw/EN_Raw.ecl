import doxie, ExperianCred;

export EN_Raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_en := project(myHeader, Doxie.Layout_ref_rid);
rids_en_dedup := dedup(sort(rids_en, rid), rid);
ds_en := Doxie_Raw.ViewSourceRid(rids_en_dedup, mod_access, ['EN']);

ExperianCred.Layouts.Layout_SourceDoc getEN(ExperianCred.Layouts.Layout_SourceDoc L) := transform
 self := l;
end;
out_file := normalize(ds_en,left.en_child,getEN(right));

return if(~mod_access.isValidGLB(),dataset([],ExperianCred.Layouts.Layout_SourceDoc),out_file);


END;