//SALT29.StringFind('"\'',s1[1],1)
IMPORT SALT29;
EXPORT StringFind(SALT29.StrType s,SALT29.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
