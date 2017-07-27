//SALT32.StringFind('"\'',s1[1],1)
IMPORT SALT32;
EXPORT StringFind(SALT32.StrType s,SALT32.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
