import doxie, Doxie_Raw, Property;

export For_raw(
    dataset(Doxie.layout_references) dids,
    doxie.IDataAccess mod_access
) := FUNCTION

//input should have been filtered by section=ssn.
myHeader := Doxie_Raw.Header_Raw(dids, mod_access);

rids_fr := project(myHeader, Doxie.Layout_ref_rid);
rids_fr_dedup := dedup(sort(rids_fr, rid), rid);
ds_fr := Doxie_Raw.ViewSourceRid(rids_fr_dedup, mod_access, ['FR']);

Property.Layout_Fares_Foreclosure getFR(Property.Layout_Fares_Foreclosure L) := transform
 self := l;
end;

out_file := normalize(ds_fr,left.for_child,getFR(right));

return out_file;

END;