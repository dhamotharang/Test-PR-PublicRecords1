EXPORT mac_append_bus_preferred(indataset, outdataset) := macro

temp_rec_preferred := record
indataset;
string cname_preferred;
end;
append_cname_preferred := join(indataset,LN_propertyV2_fast.File_Bus_Preferred,trim(left.inp.bname) = trim(right.clean_name),
transform(temp_rec_preferred,self.cname_preferred := trim(right.preferred_name), self := left),left outer, lookup);

// ======= ADD BUSINESS PREFERRED NAMES AND NORMALIZE TO BUSINESS NAMES ========
recordof(indataset) norm_cname_preferred(append_cname_preferred l, integer C) := transform
  self.inp.bname := choose(C,l.inp.bname, l.cname_preferred);
  self := l;
END;

outdataset := normalize(append_cname_preferred,if(left.cname_preferred != '',2,1),norm_cname_preferred(left, counter));

endmacro;
