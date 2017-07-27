import lib_stringlib;
suf := ['ST','ND','RD','TH'];

rm_suf(string s) := IF(s[LENGTH(TRIM(s))-1..LENGTH(TRIM(s))] IN suf, s[1..LENGTH(TRIM(s))-2], s);

alpha := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

export StripOrdinal(STRING s) := IF(LENGTH(TRIM(s)) < 3 OR StringLib.StringFilter(rm_suf(s),alpha) <> '', s, rm_suf(s));