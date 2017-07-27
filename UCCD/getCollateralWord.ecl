sp(string s,integer1 n) := if( stringlib.stringfind(s,',',n)=0, length(s), 
	stringlib.stringfind(s,',',n) );

export string getCollateralWord(string s,integer1 n) := 
	StringLib.StringFilterOut(if (n = 1, s[1..sp(s,1)],s[sp(s,n-1)+1..sp(s,n)]), ',');
