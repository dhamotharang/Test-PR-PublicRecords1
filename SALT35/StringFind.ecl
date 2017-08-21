//SALT35.StringFind('"\'',s1[1],1)
IMPORT SALT35;
EXPORT StringFind(SALT35.StrType s,SALT35.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
