//SALT38.StringFind('"\'',s1[1],1)
IMPORT SALT38;
EXPORT StringFind(SALT38.StrType s,SALT38.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
