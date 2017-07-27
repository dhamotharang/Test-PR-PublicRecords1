sp(string s,integer1 n,string1 sep) := if( stringlib.stringfind(s,sep,n)=0, length(s)+1, stringlib.stringfind(s,sep,n) );

export string Words(string s,integer1 low, integer1 high, string1 sep=' ') := map (		low < 1 or high < low => '',
																																											low = 1 => s[1..sp(s,high,sep)-1],
																																											s[sp(s,low-1,sep)+1..sp(s,high,sep)-1]);
