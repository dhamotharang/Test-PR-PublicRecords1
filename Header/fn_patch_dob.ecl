import header,Std,_validate;
#stored ('_Validate_Year_Range_Low', '1800'); 
#stored ('_Validate_Year_Range_high', ((STRING8)Std.Date.Today())[1..4]); 
export fn_patch_dob(dataset(header.Layout_Header) head0) :=
FUNCTION

header.Layout_Header t_fix_dobs(head0 le) := transform
 self.dob := (unsigned)_validate.date.fCorrectedDateString((string)le.dob,false);
 self     := le;
end;

fix_dobs := project(head0,t_fix_dobs(left));

return fix_dobs;

END;