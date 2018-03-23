	IMPORT Anchor, STD;
	
	EXPORT fCleanAscii(string Name) := FUNCTION
		STRING	ClnName	:= MAP(STD.Str.Find(Name,'&APOS;',1) > 0 => STD.Str.FindReplace(Name,'&APOS;','\''),
																							STD.Str.Find(Name,'&#039;',1) > 0 => STD.Str.FindReplace(Name,'&#039;','\''),
																							STD.Str.Find(Name,'&#39;',1) > 0 => STD.Str.FindReplace(Name,'&#39;','\''),
																							STD.Str.Find(Name,'&39;',1) > 0 => STD.Str.FindReplace(Name,'&39;','\''),
																							STD.Str.Find(Name,'& 39',1) > 0 => STD.Str.FindReplace(Name,'& 39','\''),
																							STD.Str.Find(Name,'& #39;',1) > 0 => STD.Str.FindReplace(Name,'& #39;','\''),
																							STD.Str.Find(Name,'& #039;',1) > 0 => STD.Str.FindReplace(Name,'& #039;','\''),
																							STD.Str.Find(Name,'&#;',1) > 0 => STD.Str.FindReplace(Name,'&#;','\''),
																							STD.Str.Find(Name,'#;',1) > 0 => STD.Str.FindReplace(Name,'#;','\''),
																							STD.Str.Find(Name,'#39;',1) > 0 => STD.Str.FindReplace(Name,'#39;','\''),
																							STD.Str.Find(Name,'#38;',1) > 0 => STD.Str.FindReplace(Name,'#38;',''),
																							STD.Str.Find(Name,'&#8203;',1) > 0 => STD.Str.FindReplace(Name,'&#8203;',''),
																							STD.Str.Find(Name,'&#305;',1) > 0 => STD.Str.FindReplace(Name,'&#305;',' '),
																							STD.Str.Find(Name,'&#287;',1) > 0 => STD.Str.FindReplace(Name,'&#287;',' '),
																							STD.Str.Find(Name,'&#263;',1) > 0 => STD.Str.FindReplace(Name,'&#263;',' '),
																							STD.Str.Find(Name,'&#1593;&#160',1) > 0 => STD.Str.FindReplace(Name,'&#1593;&#160',''),
																							STD.Str.Find(Name,';&#13',1) > 0 => STD.Str.FindReplace(Name,';&#13',''),
																							STD.Str.Find(Name,'\\\'',1) > 0 => STD.Str.FindReplace(Name,'\\\'','\''),
																							STD.Str.Find(Name,';',1) > 0 => STD.Str.FindReplace(Name,';',' '),
																							STD.Str.Find(Name,'#NAME?',1) > 0 => STD.Str.FindReplace(Name,'#NAME?',' '),
																							REGEXFIND('#{2,}',Name) => REGEXREPLACE('#{2,}',Name,''),
																							Name);
		RETURN STD.Str.CleanSpaces(ClnName);
	END; 