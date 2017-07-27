import lib_stringlib;
rm_suf(string s) := IF(stringlib.StringWildMatch('ST', s[LENGTH(TRIM(s))-1..LENGTH(TRIM(s))], true) or
                       stringlib.StringWildMatch('ND', s[LENGTH(TRIM(s))-1..LENGTH(TRIM(s))], true) or 
				   stringlib.StringWildMatch('RD', s[LENGTH(TRIM(s))-1..LENGTH(TRIM(s))], true) or 
				   stringlib.StringWildMatch('TH', s[LENGTH(TRIM(s))-1..LENGTH(TRIM(s))], true), 
                       s[1..LENGTH(TRIM(s))-2], s);

wild_alpha := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

export StripWildOrdinal(STRING s) := IF(LENGTH(TRIM(s)) < 3 OR StringLib.StringFilter(rm_suf(s),wild_alpha) <> '', s, rm_suf(s));
