import ut;
EXPORT fn_valid_cphone7 (string s, string src):= function
return  ut.isNumeric(s) and length(trim(s))= 7 and src[44] <> 'F';
end;