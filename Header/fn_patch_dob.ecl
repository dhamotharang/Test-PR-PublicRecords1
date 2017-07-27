import header,ut;

export fn_patch_dob(dataset(header.Layout_Header) head0) :=
FUNCTION

header.Layout_Header t_fix_dobs(head0 le) := transform

 integer v_dob := le.dob;
 
 boolean v_8digits := v_dob<>0 and length(trim((string)v_dob))=8;
 
 string4 v_yy := (string4)v_dob[1..4];
 string2 v_mm := (string2)v_dob[5..6];
 string2 v_dd := (string2)v_dob[7..8];
 
 string2 v_28_days_or_leap_yr := if(ut.LeapYear((integer)v_yy)=true,'29','28');
		  			 
 self.dob     := if(v_8digits,
                  if((v_mm in ['01','03','05','07','08','10','12'] and v_dd>'31') or
				     (v_mm in ['04','06','09','11']                and v_dd>'30') or
					 (v_mm='02'                                    and v_dd>v_28_days_or_leap_yr),
				  (integer)(v_yy+v_mm+'00'),
				  v_dob),v_dob);
 
 self     := le;
end;

fix_dobs := project(head0,t_fix_dobs(left));

return fix_dobs;

END;