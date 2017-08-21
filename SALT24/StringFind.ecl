//SALT24.StringFind('"\'',s1[1],1)
IMPORT SALT24;
EXPORT StringFind(SALT24.StrType s,SALT24.StrType r,INTEGER i) := 
#if (UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
