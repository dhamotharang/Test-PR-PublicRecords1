import STD;
EXPORT string UnicodeToAscii(unicode s) := 
						(string)REGEXREPLACE(U'\\p{Zs}',
									REGEXREPLACE(U'[\\p{Pf}\\p{Pi}]', 
									REGEXREPLACE(U'\\p{Pd}', 
									REGEXREPLACE(U'\\p{Po}', Std.Uni.CleanAccents(s), '', nocase),
									'-', nocase), 
									'\'', nocase), 
									' ', 
									nocase);
								
								
								