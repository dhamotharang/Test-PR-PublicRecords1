//SALT36.StringFind('"\'',s1[1],1)
IMPORT SALT36;
EXPORT StringFind(SALT36.StrType s,SALT36.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
