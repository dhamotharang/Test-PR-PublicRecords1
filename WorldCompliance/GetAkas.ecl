import ut, std;

rgxLF := U'^(\\p{L}+),\\p{Zs}*(\\p{L}+)$';			// L, F
rgxLFM := U'^(\\p{L}+),\\p{Zs}*(\\p{L}+)\\p{Zs}+(\\p{L}+)$';			// L, F M
// for below: NAME (ALT NAME)
rgxParen := U'^([^\\p{Open_Punctuation}\\p{Close_Punctuation}]+)\\p{Open_Punctuation}([^\\p{Open_Punctuation}\\p{Close_Punctuation}]+)\\p{Close_Punctuation}$';

/*
Normalize values
  1				Weak names
	2, 3		PrimaryName
  4, 5		OriginalName2
*/
{unsigned8 Ent_ID, Layout_XG.layout_aliases} 
	xForm(Layouts.rEntity infile, integer n) := TRANSFORM,
										SKIP((n=1 AND infile.aka='') OR (n in [2,3] AND infile.PrimaryName='')
													OR (n in [4,5] AND infile.OriginalName2=''))
													
	rawname := TRIM(CHOOSE(n,
							infile.aka, infile.PrimaryName, infile.PrimaryName, infile.OriginalName2, infile.OriginalName2));
	self.Ent_ID := infile.Ent_id;
	self.Type := 'AKA';
	
	self.category := IF(n=1, 'Weak', '');
	self.full_name := TRIM
			(CHOOSE(n,
			/*1*/				infile.aka,
			/*2*/				MAP(
											infile.EntryType != 'Individual' => infile.PrimaryName,
											REGEXFIND(rgxLF,infile.PrimaryName,nocase) => REGEXREPLACE(rgxLF,infile.PrimaryName,'$2 $1', nocase),
											REGEXFIND(rgxLFM,infile.PrimaryName,nocase) => REGEXREPLACE(rgxLFM,infile.PrimaryName,'$2 $3 $1', nocase),
											REGEXFIND(rgxParen,TRIM(infile.PrimaryName),nocase) => REGEXREPLACE(rgxParen,TRIM(infile.PrimaryName),'$1', nocase),
											infile.PrimaryName),
			/*3*/				IF(infile.EntryType = 'Individual' AND REGEXFIND(rgxParen,TRIM(infile.PrimaryName),nocase),
																	REGEXREPLACE(rgxParen,TRIM(infile.PrimaryName),'$2', nocase),SKIP),
			/*4*/				MAP(
											infile.EntryType != 'Individual' => infile.OriginalName2,
											REGEXFIND(rgxLF,infile.OriginalName2,nocase) => REGEXREPLACE(rgxLF,infile.OriginalName2,'$2 $1', nocase),
											REGEXFIND(rgxLFM,infile.OriginalName2,nocase) => REGEXREPLACE(rgxLFM,infile.OriginalName2,'$2 $3 $1', nocase),
											REGEXFIND(rgxParen,TRIM(infile.OriginalName2),nocase) => REGEXREPLACE(rgxParen,TRIM(infile.OriginalName2),'$1', nocase),
												infile.OriginalName2),
			/*5*/				IF(infile.EntryType = 'Individual' AND REGEXFIND(rgxParen,TRIM(infile.OriginalName2),nocase),
																REGEXREPLACE(rgxParen,TRIM(infile.OriginalName2),'$2', nocase),SKIP)
			));
	self.first_name := MAP(
													infile.EntryType != 'Individual' OR n=1 => '',
													REGEXFIND(rgxLF,rawname,nocase) =>	REGEXFIND(rgxLF,rawname,2,nocase),
													REGEXFIND(rgxLFM,rawname,nocase) =>	REGEXREPLACE(rgxLFM,rawname,'$2 $3',nocase),
													'');
	self.last_name := MAP(
													infile.EntryType != 'Individual' OR n=1 => '',
													REGEXFIND(rgxLF,rawname,nocase) =>	REGEXFIND(rgxLF,rawname,1,nocase),
													REGEXFIND(rgxLFM,rawname,nocase) =>	REGEXFIND(rgxLFM,rawname,1,nocase),
													'');

	//self.comments := rawname;
	self := [];
END;

{unsigned8 Ent_ID, Layout_XG.layout_aliases} 
	xFormAka(Layouts.rEntity infile) := TRANSFORM
	self.Ent_ID := infile.ParentId;
	//self.Type := 'AKA';
	self.Type := IF (infile.EntryType = 'Individual', 'AKA', 'DBA');
	self.category := IF(Std.Uni.Find(infile.Positions, 'Weak Aka', 1) > 0, 'Weak', '');
	//self.full_name := infile.Name;
  self.full_name := IF(infile.EntryType='Individual',
											TRIM(Std.uni.CleanSpaces(infile.firstname+' '+infile.lastname+' '+infile.suffix)),
											infile.name);
  self.first_name := infile.firstname;
  self.middle_name := '';
  self.last_name := infile.lastname;
  self.generation := infile.suffix;
	self.comments := 'ID: ' + (string)infile.Ent_ID + IF(infile.remarks<>'',' || ' + CvtPilcrow(infile.remarks), '');
	self := [];
END;

// New addition for Chinese space scrubbing

{unsigned8 Ent_ID, Layout_XG.layout_aliases} 
	xFormCS(Layouts.rEntity infile, integer n) := TRANSFORM,
										SKIP((n=1 AND (infile.aka='' or infile.aka = STD.Uni.FindReplace(infile.aka,U' ', U'') or (infile.Country <> 'China' and infile.Country <> 'Japan')))
													OR (n=2 AND (infile.PrimaryName='' or infile.PrimaryName = STD.Uni.FindReplace(infile.PrimaryName,U' ', U'') or (infile.Country <> 'China' and infile.Country <> 'Japan')))
													OR (n=3 AND (infile.OriginalName2='' or infile.OriginalName2 = STD.Uni.FindReplace(infile.OriginalName2,U' ', U'') or (infile.Country <> 'China' and infile.Country <> 'Japan'))))
													
	rawname := TRIM(CHOOSE(n,
							infile.aka, infile.PrimaryName,infile.OriginalName2));
	self.Ent_ID := infile.Ent_id;
	self.Type := 'AKA';
	
	self.category := IF(n=1, 'Weak', '');
	self.full_name := TRIM
			(CHOOSE(n,
			/*1*/				IF(infile.Country <> 'China' AND infile.Country <> 'Japan',SKIP,
										IF(infile.aka = STD.Uni.FindReplace(infile.aka,U' ', U''),
												SKIP,
												STD.Uni.FindReplace(infile.aka,U' ', U''))),
											
											
			/*2*/				IF(infile.Country <> 'China' AND infile.Country <> 'Japan',SKIP,
										IF(infile.PrimaryName = STD.Uni.FindReplace(infile.PrimaryName,U' ', U''),SKIP,
														STD.Uni.FindReplace(infile.PrimaryName,U' ', U''))),
										
									
								
			/*3*/	/*			IF(infile.Country <> 'China' AND infile.Country <> 'Japan',SKIP,
										IF(infile.PrimaryName = STD.Uni.FindReplace(infile.PrimaryName,U' ', U''),SKIP,
														STD.Uni.FindReplace(infile.PrimaryName,U' ', U''))),
														
			/*4*/		/*		IF(infile.Country <> 'China' AND infile.Country <> 'Japan',SKIP,
													IF(infile.OriginalName2 = STD.Uni.FindReplace(infile.OriginalName2,U' ', U''),SKIP,
														STD.Uni.FindReplace(infile.OriginalName2,U' ', U''))),
										
												
			/*5*/				IF(infile.Country <> 'China' AND infile.Country <> 'Japan',SKIP,
													IF(infile.OriginalName2 = STD.Uni.FindReplace(infile.OriginalName2,U' ', U''),SKIP,
														STD.Uni.FindReplace(infile.OriginalName2,U' ', U'')))
									
									
			));
	self.first_name := '';
	self.last_name := '';

	self.comments := 'VENDOR ADDED';
	self := [];
END;

{unsigned8 Ent_ID, Layout_XG.layout_aliases}
	xFormON2(Layouts.rEntity infile) := TRANSFORM,
	SKIP(infile.OriginalName2 = '')
	self.Ent_ID := infile.ParentId;
	//self.Type := 'AKA';
	self.Type := IF (infile.EntryType = 'Individual', 'AKA', 'DBA');
	self.category := '';
	//self.full_name := infile.Name;
  self.full_name := IF((infile.OriginalName2 <> ''),
			infile.OriginalName2,'');
  self.first_name := '';
  self.middle_name := '';
  self.last_name := '';
  self.generation := '';
	self.comments := 'ID: ' + (string)infile.Ent_ID + IF(infile.remarks<>'',' || ' + CvtPilcrow(infile.remarks), '');
	self := [];
END;

{unsigned8 Ent_ID, Layout_XG.layout_aliases} 
	xFormPN(Layouts.rEntity infile) := TRANSFORM,
	SKIP(infile.PrimaryName = '')
	self.Ent_ID := infile.ParentId;
	//self.Type := 'AKA';
	self.Type := IF (infile.EntryType = 'Individual', 'AKA', 'DBA');
	self.category := '';
	//self.full_name := infile.Name;
  self.full_name := IF((infile.PrimaryName <> ''),
			infile.PrimaryName,'');
  self.first_name := '';
  self.middle_name := '';
  self.last_name := '';
  self.generation := '';
	self.comments := 'ID: ' + (string)infile.Ent_ID + IF(infile.remarks<>'',' || ' + CvtPilcrow(infile.remarks), '');
	self := [];
END;


{unsigned8 Ent_ID, Layout_XG.layout_aliases} 
	xFormCSPN(Layouts.rEntity infile) := TRANSFORM,
	SKIP(infile.PrimaryName = '' or infile.PrimaryName = STD.Uni.FindReplace(infile.PrimaryName,U' ', U'') or (infile.Country <> 'China' and infile.Country <> 'Japan'))
	self.Ent_ID := infile.ParentId;
	//self.Type := 'AKA'
	self.Type := IF (infile.EntryType = 'Individual', 'AKA', 'DBA');
	self.category := '';
	//self.full_name := infile.Name;
	self.full_name := IF(infile.Country <> 'China' AND infile.Country <> 'Japan','',
											IF(infile.PrimaryName = STD.Uni.FindReplace(infile.PrimaryName,U' ', U''),'',
														STD.Uni.FindReplace(infile.PrimaryName,U' ', U'')));
	
  self.first_name := '';
  self.middle_name := '';
  self.last_name := '';
  self.generation := '';
	self.comments := 'VENDOR ADDED ID: ' + (string)infile.Ent_ID + IF(infile.remarks<>'',' || ' + CvtPilcrow(infile.remarks), '');
	self := [];
END;

{unsigned8 Ent_ID, Layout_XG.layout_aliases} 
	xFormCSON(Layouts.rEntity infile) := TRANSFORM,
	SKIP(infile.OriginalName2 = '' or infile.OriginalName2 = STD.Uni.FindReplace(infile.OriginalName2,U' ', U'') or (infile.Country <> 'China' and infile.Country <> 'Japan'))
	self.Ent_ID := infile.ParentId;
	//self.Type := 'AKA';
	self.Type := IF (infile.EntryType = 'Individual', 'AKA', 'DBA');
	self.category := '';
	//self.full_name := infile.Name;
	self.full_name := IF(infile.Country <> 'China' AND infile.Country <> 'Japan','',
												IF(infile.OriginalName2 = STD.Uni.FindReplace(infile.OriginalName2,U' ', U''),'',
															STD.Uni.FindReplace(infile.OriginalName2,U' ', U'')));
	
  self.first_name := '';
  self.middle_name := '';
  self.last_name := '';
  self.generation := '';
	self.comments := 'VENDOR ADDED ID: ' + (string)infile.Ent_ID + IF(infile.remarks<>'',' || ' + CvtPilcrow(infile.remarks), '');
	self := [];
END;



EXPORT GetAkas(dataset(Layouts.rEntity) infile) := FUNCTION

	weak := Normalize(infile(ParentId=0), 5, xform(LEFT, COUNTER));
	strong := PROJECT(infile(ParentId<>0), xFormAka(LEFT));

// New AKA's of AKA's and Chinese space scrubbing

	weakCS := Normalize(infile(ParentId=0), 3, xFormCS(LEFT, COUNTER));
	strongON := PROJECT(infile(ParentId<>0), xFormON2(LEFT));
	strongPN := PROJECT(infile(ParentId<>0), xFormPN(LEFT));
	strongCSPN := PROJECT(infile(ParentId<>0), xFormCSPN(LEFT));
	strongCSON := PROJECT(infile(ParentId<>0), xFormCSON(LEFT));
	
	return SORT(DISTRIBUTE(weak&(DISTRIBUTE(strong&(DISTRIBUTE(strongON&(DISTRIBUTE(strongPN&(DISTRIBUTE(StrongCSPN&(Distribute(StrongCSON&weakcs,Ent_ID)),Ent_ID)),Ent_ID)),Ent_ID)),Ent_ID)), Ent_ID), Ent_ID, category, type, full_name, last_name, first_name, local);

//	return SORT(DISTRIBUTE(weak&strong, Ent_ID), Ent_ID, category, type, full_name, last_name, first_name, local);

END;