//SALT28.StringFind('"\'',s1[1],1)
IMPORT SALT28;
EXPORT StringFind(SALT28.StrType s,SALT28.StrType r,INTEGER i) := 
#if (UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
