import lib_stringlib;
sp(string s,integer1 n,string1 sep) := if( stringlib.stringfind(s,sep,n)=0, length(s)+1, stringlib.stringfind(s,sep,n) );

export string word(string s,integer1 n,string1 sep=' ') := if (n = 1, s[1..sp(s,1,sep)-1],
                 s[sp(s,n-1,sep)+1..sp(s,n,sep)-1]);