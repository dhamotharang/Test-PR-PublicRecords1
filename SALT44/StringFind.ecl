//SALT44.StringFind('"\'',s1[1],1)
IMPORT SALT44;
EXPORT StringFind(SALT44.StrType s,SALT44.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
