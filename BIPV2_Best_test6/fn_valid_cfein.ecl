import ut,Business_Header;
EXPORT fn_valid_cfein (string s, string src):= function
return Business_Header.ValidFEIN((unsigned)s) and ut.isNumeric(s) and (unsigned)s not in Business_Header.SetBadFeins;
end;