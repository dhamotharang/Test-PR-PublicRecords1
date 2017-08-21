//SALT34.StringFind('"\'',s1[1],1)
IMPORT SALT34;
EXPORT StringFind(SALT34.StrType s,SALT34.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
