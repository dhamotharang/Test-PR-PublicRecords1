//SALT27.StringFind('"\'',s1[1],1)
IMPORT SALT27;
EXPORT StringFind(SALT27.StrType s,SALT27.StrType r,INTEGER i) := 
#if (UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
