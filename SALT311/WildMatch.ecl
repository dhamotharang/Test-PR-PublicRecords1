IMPORT Std;
EXPORT BOOLEAN WildMatch(StrType src,StrType Pat,BOOLEAN _NoCase) := FUNCTION
#if (UnicodeCfg.UseUnicode)
	RETURN Std.Uni.WildMatch(src,Pat,_NoCase);
#else
	RETURN Std.Str.WildMatch(src,Pat,_NoCase);
#end
END;
