export	Functions	:=
module
	export	unicode	unicodeClean2Upper(unicode	pUnicodeStr)	:=	unicodelib.unicodetouppercase(unicodelib.unicodecleanspaces(pUnicodeStr));
	export	unicode	unicode2Upper(unicode	pUnicodeStr)				:=	unicodelib.unicodetouppercase(pUnicodeStr);
	export	unicode	unicodeClean(unicode	pUnicodeStr)				:=	unicodelib.unicodecleanspaces(pUnicodeStr);
	export	string	ustrClean2Upper(unicode	pUnicodeStr)			:=	stringlib.stringtouppercase(stringlib.stringcleanspaces((string)pUnicodeStr));
	export	string	ustrClean(unicode	pUnicodeStr)						:=	stringlib.stringcleanspaces((string)pUnicodeStr);
	export	string	strClean2Upper(string	pStr)								:=	stringlib.stringtouppercase(stringlib.stringcleanspaces(pStr));
	export	string	strClean(string	pStr)											:=	stringlib.stringcleanspaces(pStr);
	export	string	removeLineFeeds(string	pStr)							:=	strClean(regexreplace('\\n|\\r\\n',pStr,' '));
end;