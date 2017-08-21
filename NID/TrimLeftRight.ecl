string TrimRightPunct(string s) := REGEXREPLACE('[ .,+;?*&:#%"(\'/\\\\-]+$',s,'');
string TrimRightHyphenChar(string s) := REGEXREPLACE('([A-Z])-[A-Z]$',s,'$1');
string TrimRightDblGen(string s) := REGEXREPLACE('\\b(JR|SR|II|III) (\\1)$',s,'$1');

string TrimRight(string s) := 
	TrimRightDblGen(TrimRightHyphenChar(TrimRightPunct(s)));
	
string TrimLeftPunct(string s) := REGEXREPLACE('^[ .,+;?*&:#%")\'/\\\\-]+',s,'');
EXPORT TrimLeftRight(string s) := TrimLeftPunct(TrimRightPunct(s));
