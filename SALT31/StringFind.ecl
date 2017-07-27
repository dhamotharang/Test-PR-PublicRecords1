//SALT31.StringFind('"\'',s1[1],1)
IMPORT SALT31;
EXPORT StringFind(SALT31.StrType s,SALT31.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
