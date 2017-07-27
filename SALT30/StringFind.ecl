//SALT30.StringFind('"\'',s1[1],1)
IMPORT SALT30;
EXPORT StringFind(SALT30.StrType s,SALT30.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
