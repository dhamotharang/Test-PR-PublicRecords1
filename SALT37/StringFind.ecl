//SALT37.StringFind('"\'',s1[1],1)
IMPORT SALT37;
EXPORT StringFind(SALT37.StrType s,SALT37.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
