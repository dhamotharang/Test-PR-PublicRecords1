import ut;

EXPORT fn_valid_state_abbr(string st) := function
return if(st in ut.Set_State_Abbrev, 1,
						if(st = '', 1 , 0));
end;