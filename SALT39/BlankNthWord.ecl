EXPORT StrType BlankNthWord(StrType s, INTEGER1 n, INTEGER1 wc, Str1Type sep=' ') := 
#if (UnicodeCfg.UseUnicode AND UnicodeCfg.UseLocale)
			MAP(n<=1 => sep+saltlib.UnicodeLocaleGetRangeOfWords(s,n+1,wc,sep, UnicodeCfg.LocaleName),
			    n=wc => saltlib.UnicodeLocaleGetRangeOfWords(s,1,wc-1,sep, UnicodeCfg.LocaleName)+sep,
			    n>wc => saltlib.UnicodeLocaleGetRangeOfWords(s,1,wc,sep, UnicodeCfg.LocaleName),				
					saltlib.UnicodeLocaleGetRangeOfWords(s,1,n-1,sep, UnicodeCfg.LocaleName)+sep+sep+saltlib.UnicodeLocaleGetRangeOfWords(s,n+1,wc,sep, UnicodeCfg.LocaleName));
#elseif (UnicodeCfg.UseUnicode AND NOT UnicodeCfg.UseLocale)		
			MAP(n<=1 => sep+saltlib.UnicodeGetRangeOfWords(s,n+1,wc,sep),
			    n=wc => saltlib.UnicodeGetRangeOfWords(s,1,wc-1,sep)+sep,
			    n>wc => saltlib.UnicodeGetRangeOfWords(s,1,wc,sep),					
					saltlib.UnicodeGetRangeOfWords(s,1,n-1,sep)+sep+sep+saltlib.UnicodeGetRangeOfWords(s,n+1,wc,sep));
#else
			MAP(n<=1 => sep+SALT39.GetRangeOfWords(s,n+1,wc,sep),
			    n=wc => SALT39.GetRangeOfWords(s,1,wc-1,sep)+sep,
					n>wc => SALT39.GetRangeOfWords(s,1,wc,sep),
					SALT39.GetRangeOfWords(s,1,n-1,sep)+sep+sep+SALT39.GetRangeOfWords(s,n+1,wc,sep));
#end
