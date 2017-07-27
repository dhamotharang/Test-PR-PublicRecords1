import ut;

export fn_patch_search(dataset(recordof(ln_propertyv2.layout_deed_mortgage_property_search)) in_srch) :=
function

recordof(in_srch) t_patch_mname(recordof(in_srch) le) := transform
 
 self.fname    := trim(ut.fn_KeepPrintableChars(le.fname));
 self.mname    := trim(ut.fn_KeepPrintableChars(stringlib.stringfindreplace(le.mname,',ETAL','')));
 self.lname    := trim(ut.fn_KeepPrintableChars(le.lname));
 self.cname    := trim(ut.fn_KeepPrintableChars(le.cname));
 self.nameasis := trim(ut.fn_KeepPrintableChars(ln_propertyv2.fn_patch_name_field(le.nameasis)));
 self          := le;
end;

patch_search0 := project(in_srch,t_patch_mname(left));
patch_search  := patch_search0(fname<>'' or lname<>'' or cname<>'' or nameasis<>'');

return patch_search;

end;