//SALT311.StringFind('"\'',s1[1],1)
IMPORT SALT311;
EXPORT StringFind(SALT311.StrType s,SALT311.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
