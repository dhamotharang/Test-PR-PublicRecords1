import ln_property,LN_PropertyV2,ut;

fn_handle_zeroes(string in_field) := if((integer)in_field=0,'',regexreplace('^0*',trim(in_field,left,right),''));
fn_handle_dates(string in_field) 	:= if((integer)in_field=0,'',in_field);

export fn_patch_fares_addl_deed(dataset(recordof(LN_PropertyV2.layout_addl_fares_deed)) in_addl_deed) := function

recordof(in_addl_deed) t_cleanup(recordof(in_addl_deed) le) := transform

 self.fares_mortgage_date        := fn_handle_dates(le.fares_mortgage_date);
 self.fares_mortgage_term        := fn_handle_zeroes(le.fares_mortgage_term);
 self.fares_building_square_feet := fn_handle_zeroes(le.fares_building_square_feet);
 self.fares_foreclosure          := trim(ut.fn_KeepPrintableChars(le.fares_foreclosure));
 self.fares_refi_flag            := trim(ut.fn_KeepPrintableChars(le.fares_refi_flag));
 self.fares_equity_flag          := trim(ut.fn_KeepPrintableChars(le.fares_equity_flag));
 self                            := le;

end;

cleanup := project(in_addl_deed,t_cleanup(left));

return cleanup;

end;