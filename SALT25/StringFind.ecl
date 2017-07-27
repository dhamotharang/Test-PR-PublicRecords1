//SALT25.StringFind('"\'',s1[1],1)
IMPORT SALT25;
EXPORT StringFind(SALT25.StrType s,SALT25.StrType r,INTEGER i) := 
#if (UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
