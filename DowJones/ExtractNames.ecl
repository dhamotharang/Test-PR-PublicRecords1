import STD;
rBareName := RECORD
	string			id;
	string			nameType;
	string			TitleHonorific;
	unicode			FirstName;
	unicode			MiddleName;
	unicode			SurName;
	unicode			Suffix;
	unicode			MaidenName;
	set of unicode			FullNames;
END;

unicode makename(unicode fname, unicode mname, unicode lname, unicode nmsuffix=U'') :=
		STD.Uni.CleanSpaces(fname+' '+mname+' '+lname+' '+nmsuffix);

rname1 := RECORD
	string		id;
	string		nameType;
	dataset(Layouts.rNameValue)	NameValue;
END;

		names1 := SORT(
							NORMALIZE(File_Person, LEFT.NameDetails, TRANSFORM(rname1,
								self.id := LEFT.id;
								self.nameType := RIGHT.NameType;
								self.NameValue := RIGHT.NameValue;))
		& 				NORMALIZE(File_Entity, LEFT.NameDetails, TRANSFORM(rname1,
								self.id := LEFT.id;
								self.nameType := RIGHT.NameType;
								self.NameValue := RIGHT.NameValue;))
								,id,local);
								
names2 := NORMALIZE(names1, LEFT.NameValue, TRANSFORM(rBareName,
			self.id := LEFT.id;
			self.nameType := LEFT.NameType;
			self.TitleHonorific := RIGHT.TitleHonorific;
			self.FirstName := RIGHT.FirstName;
			self.MiddleName := RIGHT.MiddleName;
			self.SurName 	:= IF(LEFT.nameType='Maiden Name',RIGHT.MaidenName,RIGHT.SurName);
			self.Suffix := RIGHT.Suffix;
			self.MaidenName := RIGHT.MaidenName;
			self.FullNames := IF(RIGHT.EntityName = '',
						RIGHT.OriginalScriptName + RIGHT.SingleStringName,
						RIGHT.OriginalScriptName + RIGHT.SingleStringName + [RIGHT.EntityName])));
runi := RECORD
	unicode		name;
END;

// parens: \uFF08\uFF09
// spaces: \\u00A0\\u200B
//\p{Z}
names3 := Normalize(names2, 
								DATASET(LEFT.FullNames,runi),
						TRANSFORM(rName,
					self.fullname := RIGHT.name;
					self.primary := if(LEFT.nametype =	'Primary Name', 1, 2);
					self.fullNameType := MAP(
//							REGEXFIND(U'^[\\p{Latin} ()0-9\\\\.,/\'Â’"Â„Â”Â„Â”Â“Â«Â»\\&*+=|%Â°\\@:!?#;~$Â„Â”\\[\\]\\u00A0\\u200B\\uFF08\\uFF09\n_Â–Â­?-]+$', TRIM(RIGHT.name), NOCASE) => 2,		// Latin character \p{L}
							REGEXFIND(U'^[\\p{Latin}\\p{Z}\\u200B\\p{Punctuation}0-9\'Â’"Â„Â”Â„Â”Â“Â«Â»\\&*+=|%Â°\\@:!?#;~$Â„Â”\\[\\]\\uFF08\\uFF09\n_\\p{Dash_Punctuation}Â–Â­?]+$', TRIM(RIGHT.name), NOCASE) => 2,		// Latin character \p{L}
							Length(TRIM(RIGHT.name)) > 0 => 4,		// any characters
							5);				// blank string
					self.TitleHonorific := '';	//LEFT.TitleHonorific;
					self.FirstName := '';				//LEFT.FirstName;
					self.MiddleName := '';			//LEFT.MiddleName;
					self.SurName 	:= '';				//IF(LEFT.nameType='Maiden Name',LEFT.MaidenName,LEFT.SurName);
					self.MaidenName := '';			//LEFT.MaidenName;
					self.Suffix := '';					//LEFT.Suffix;
					self := LEFT;				
				));
						
								
//names4 := PROJECT(names2(COUNT(FullNames)=0), TRANSFORM(rName,
names4 := PROJECT(names2(TRIM(FirstName)<>'' OR TRIM(SurName)<>'' OR TRIM(MaidenName)<>''), TRANSFORM(rName,
					self.TitleHonorific := LEFT.TitleHonorific;
					self.FirstName := LEFT.FirstName;
					self.MiddleName := LEFT.MiddleName;
					self.SurName 	:= IF(LEFT.nameType='Maiden Name',LEFT.MaidenName,LEFT.SurName);
					self.MaidenName := LEFT.MaidenName;
					self.Suffix := LEFT.Suffix;
//					self.FullName := 	IF(LEFT.FirstName='' OR LEFT.SurName='','',
//														makename(self.FirstName,self.MiddleName,self.Surname,self.Suffix));
//					self.fullNameType := if(self.Fullname='',99,1);
					self.FullName := 	MAP(
																LEFT.nametype = 'Maiden Name' => '',
																LEFT.nametype = 'Spelling Variation' AND (LEFT.FirstName='' OR LEFT.SurName='') => '',
														makename(self.FirstName,self.MiddleName,self.Surname,self.Suffix));
					self.fullNameType := if(self.Fullname='',99,1);
					self.primary := if(LEFT.nametype =	'Primary Name', 1, 2);
					self := LEFT;
			));


integer SortOrder(string nametype) := CASE(nametype,
	'Primary Name' => 1,
	'Secondary Name' => 2,
	'Spelling Variation' => 3,
	'Also Known As' => 4,
	'Low Quality AKA' => 5,
	'Formerly Known As' => 6,
	'Maiden Name' => 7,
	8);
	

//names := SORT(names3(nametype<>'Maiden Name') & names4,id,SortOrder(nametype),fullnametype,local);
names := SORT(names3 & names4,id,SortOrder(nametype),fullnametype,local);
/*
parsed := PROJECT(names(fullname=''),TRANSFORM(rName,
								self.fullname := makename(LEFT.firstname,LEFT.middlename,LEFT.surname);
								self := LEFT;)
								);
justfull := names(fullname<>'',TRIM(firstname+surname,LEFT,RIGHT)='');*/
// choose one of the full names to be the primary
primary := SORT(names(nametype='Primary Name'),id,fullNameType,local);
rName xFull(rName L, rName R, integer n) := TRANSFORM
		self.nametype := IF(n=1, 'Primary Name', 'Secondary Name');
		self.primary := if(n=1, 1, 2);
		self := R;
END;
fullgroup := GROUP(primary, id,LOCAL);
fullup := UNGROUP(ITERATE(fullgroup, xFull(LEFT,RIGHT,COUNTER)));

allnames1 := names(nametype<>'Primary Name') & fullup;

names5 := SORT(allnames1,id,local);
primaryname := names5(nametype='Primary Name');
maiden := names5(fullNameType=99);

maidenx := JOIN(maiden, primaryname, LEFT.id = RIGHT.id,
				TRANSFORM(recordof(maiden),
							self.firstname := IF(LEFT.firstname='',RIGHT.firstname,LEFT.firstname);
							self.middlename := IF(LEFT.middlename='',RIGHT.middlename,LEFT.middlename);
							self.surname := IF(LEFT.maidenname<>'',LEFT.maidenname,
																		IF(LEFT.surname='',RIGHT.surname,LEFT.surname));
							self.fullname := makename(self.FirstName,self.MiddleName,self.Surname);
							self.fullNameType := 3;
							self.primary := 2;
							self := LEFT;), INNER, LOCAL);

allnames2 := DISTRIBUTE(names5(fullNameType<>99) & maidenx,(integer)id);
// now dedupe the names


allnames := //DEDUP(
							SORT(allnames2, id,fullname, surname,firstname,middlename,suffix,TitleHonorific, primary, LOCAL);
						//																id,fullname,surname,firstname,middlename,suffix,TitleHonorific);
	
EXPORT rName ExtractNames := 
							SORT(DISTRIBUTE(allnames,(integer)id),
										id,  SortOrder(nametype), fullnameType, surname, LOCAL);
						//DEDUP(SORT(allnames,id,  SortOrder(nametype), fullnameType, local),RECORD,LOCAL);
