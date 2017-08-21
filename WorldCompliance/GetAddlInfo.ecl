import ut, std;

/***
	1		Occupation				
	2		PlaceOfBirth
	3		Other				Negative News Alert
	4		Other				Organization
	5		Other				SourceWebLink

****/

	maxchar(unicode s) := IF(Length(s) > 255,s[1..255],s);

	sourceMsg := U' More sources available';
	maxSourceLen := 8192 - Length(sourceMsg);
	maxsources(unicode s) := IF(Length(s) > maxSourceLen, s[1..maxSourceLen] + sourceMsg, s);

{unsigned8 Ent_ID, Layout_XG.layout_addlinfo} 
	xForm(Layouts.rEntity infile, integer n) := TRANSFORM
		
		self.Ent_ID := infile.Ent_Id;
		self.type := TRIM(CHOOSE(n, 
												IF(infile.EntryType in ['Individual','Organization'] AND infile.EntryCategory in Filters.fPep,
													'Occupation',
													SKIP),
												'PlaceOfBirth',
												'Other',				// Negative News
//												if(TRIM(infile.PictureFile)<>'','Other',SKIP),				// Image
												'Other',				// Organization
												'Other',				// SourceWebLink
												SKIP));
		self.information := TRIM(CHOOSE(n,
								infile.Positions,
								infile.Pob,
								if(infile.Watch, 'Negative News Alert', ''),
//								if(infile.PictureFile<>'','Images',''),
								if(infile.Organization<>'','Organization',''),
								if(infile.SourceWebLink<>'','Sources of Record Information',''),
								SKIP));
		self.comments := TRIM(CHOOSE(n,
												TRIM(IF(infile.EffectiveDate='','', 'Starting ' + infile.EffectiveDate) +
													IF(infile.ExpirationDate='','', ' Ending ' + infile.ExpirationDate),LEFT,RIGHT),
												'','',
//												infile.PictureFile,
												infile.Organization,
												//maxsources(Std.Uni.CleanSpaces(Std.Uni.FindReplace(infile.SourceWebLink,U';',U' | '))),
//												maxsources(Std.Uni.CleanSpaces(RegexReplace(U'[; ]+',infile.SourceWebLink,U' | '))), // Old-Production removed 09/01/2016
												maxsources(Std.Uni.CleanSpaces(RegexReplace(U';+',(RegexReplace(U';%20+',(RegexReplace(U'[ ]+',infile.SourceWebLink,U'%20')),U' | ')),U' | '))), //Production - Added 09/01/2016


												SKIP));
		self := [];

END;
					


EXPORT GetAddlInfo(dataset(Layouts.rEntity) infile) := FUNCTION

	return Normalize(infile, 5, xform(LEFT, COUNTER))(information<>'');

END;