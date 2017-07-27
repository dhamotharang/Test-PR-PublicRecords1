//SALT33.StringFind('"\'',s1[1],1)
IMPORT SALT33;
EXPORT StringFind(SALT33.StrType s,SALT33.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
