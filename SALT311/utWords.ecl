IMPORT lib_stringlib;
sp(STRING s,INTEGER1 n,STRING1 sep) := IF(StringLib.StringFind(s,sep,n)=0, LENGTH(s)+1, StringLib.StringFind(s,sep,n) );
EXPORT STRING utWords(STRING s,INTEGER1 low, INTEGER1 high, STRING1 sep=' ') := MAP(
	low < 1 or high < low => '',
	low = 1 => s[1..sp(s,high,sep)-1],
	s[sp(s,low-1,sep)+1..sp(s,high,sep)-1]
);
