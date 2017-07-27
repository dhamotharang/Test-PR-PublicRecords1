//SALT26.StringFind('"\'',s1[1],1)
IMPORT SALT26;
EXPORT StringFind(SALT26.StrType s,SALT26.StrType r,INTEGER i) := 
#if (UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
