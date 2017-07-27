IMPORT lib_stringlib;
sp(STRING s,INTEGER1 n,STRING1 sep) := IF(StringLib.StringFind(s,sep,n)=0, LENGTH(s)+1, StringLib.StringFind(s,sep,n));
EXPORT STRING utWord(STRING s,INTEGER1 n,STRING1 sep=' ') := IF(n=1, s[1..sp(s,1,sep)-1], s[sp(s,n-1,sep)+1..sp(s,n,sep)-1]);
