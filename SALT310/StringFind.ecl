//SALT310.StringFind('"\'',s1[1],1)
IMPORT SALT310;
EXPORT StringFind(SALT310.StrType s,SALT310.StrType r,INTEGER i) := 
#if (UnicodeCfg.UseUnicode)
			Unicodelib.UnicodeFind(s,r,i);
#else
			StringLib.StringFind(s,r,i);
#end
