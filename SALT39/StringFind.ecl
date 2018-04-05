//SALT39.StringFind('"\'',s1[1],1)
IMPORT SALT39;
EXPORT StringFind(SALT39.StrType s,SALT39.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
