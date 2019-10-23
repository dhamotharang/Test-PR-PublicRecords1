/*
day=01 is often used when the actual day is not known
Prefer a later day if available
*/
EXPORT fn_preffered_dob(string s, string src) :=
			fn_valid_dob(s, src) AND s[7..8] <> '01';