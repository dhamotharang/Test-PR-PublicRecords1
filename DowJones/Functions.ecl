Import Worldcheck_Bridger,ut;
Import std;
EXPORT Functions := MODULE

shared FmtCmt(string hdr, string s, string sep = ' | ') :=
	IF(trim(s,LEFT,RIGHT)='','',sep + hdr + s);
	
export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} RollupNames := FUNCTION
		
		rTempName	:= RECORD
			string			id;
			string			nameType;
			unicode			FirstName;
			unicode			MiddleName;
			unicode			SurName;
			unicode			MaidenName;
			unicode			FullName;
			unicode 		full_name_uppercase;
		END;
		
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_aliases} akaDJtoXG(rTempName/*rName*/ src) := TRANSFORM
					self.id := src.id;
					self.type 			:= case(src.nameType,
								'Primary Name' => 'NKA',
								'Secondary Name' => 'AKA',				// created internally
								'Formerly Known As' => 'FKA',
								'Maiden Name' => 'AKA',
								'AKA'); 
					self.category 				:= if(src.nameType='Low Quality AKA','Weak','');
					self.first_name 			:= src.FirstName;
					self.middle_name 			:= src.MiddleName;
					self.last_name 				:= IF(src.nameType='Maiden Name',src.MaidenName,src.SurName);
					self.generation 			:= '';		// do not use for AKA
					self.full_name 				:= src.FullName; //Std.Uni.CleanAccents(src.FullName);
					self.comments   			:= '';
					self := [];
		END;
		
		tempnames := PROJECT(Extractnames(NameType<>'Primary Name'), TRANSFORM(rTempName, 
																																		self.full_name_uppercase := regexreplace(u'-', STD.Uni.ToUpperCase(Std.Uni.CleanAccents(LEFT.FullName)), u' ');
																																		self.FullName					   := Std.Uni.CleanAccents(LEFT.FullName);
																																		self := LEFT));
																																		
		uniqueakas1 := DEDUP(SORT(tempnames, id, FirstName, MiddleName, SurName, MaidenName, FullName, LOCAL), id, FirstName, MiddleName, SurName, MaidenName, FullName, LOCAL);
		uniqueakas2 := DEDUP(SORT(uniqueakas1, id, FirstName, MiddleName, SurName, MaidenName, full_name_uppercase, LOCAL), id, FirstName, MiddleName, SurName, MaidenName, full_name_uppercase, LOCAL);
		
		names := PROJECT(uniqueakas2, akaDJtoXG(LEFT));
			
		pAlias := 
				project(names,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup},
						self.id := left.id;
						self.aka := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_aliases); 
						)
				);
				
	{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} R) := transform
		self.id  := L.id;
		self.aka := L.aka + row({R.aka[1].type,
							 R.aka[1].category,
							 R.aka[1].first_name,
							 R.aka[1].middle_name,
							 R.aka[1].last_name,
							 R.aka[1].generation,
							 R.aka[1].full_name,
							 R.aka[1].comments
		 },Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_aliases);
	end;

	return
		rollup(pAlias, id, rollRecs(left, right), local);
END;

export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} 
		GetNames(dataset(Layouts.rPersons) infile) := FUNCTION

		rid1 := RECORD
			string		id;
			string		nameType;
			dataset(Layouts.rNameValue)	NameValue;
		END;
		rid1 xid1(Layouts.rPersons L, Layouts.rNameDetails R) := TRANSFORM
					self.id := L.id;
					self.nameType := R.NameType;
					self.NameValue := R.NameValue;
		END;		

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_aliases} akaDJtoXG(rid1 src,Layouts.rNameValue R) := TRANSFORM
					self.id := src.id;
					self.type 			:= case(src.nameType,
								'Primary Name' => 'NKA',
								'Formerly Known As' => 'FKA',
								'Maiden Name' => 'AKA',
								'AKA'); 
					self.category 	:= if(src.nameType='Low Quality AKA','Weak','');
					self.first_name 			:= R.FirstName;
					self.middle_name 			:= R.MiddleName;
					self.last_name 				:= IF(src.nameType='Maiden Name',R.MaidenName,R.SurName);
					//self.generation 			:= src.Suffix;
					self.full_name := MAP(
								COUNT(R.OriginalScriptName) > 0 => R.OriginalScriptName[1],
								COUNT(R.SingleStringName) > 0 => R.SingleStringName[1],
								R.EntityName <> '' => R.EntityName,
								'');
					self.comments   := '';
					self := [];
		END;
	
		norm1 := NORMALIZE(infile, LEFT.NameDetails, xid1(LEFT,RIGHT));
		norm2 := NORMALIZE(norm1, LEFT.NameValue, akaDJtoXG(LEFT,RIGHT));

pAlias := 
				project(norm2,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup},
						self.id := left.id;
						self.aka := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_aliases); 
						)
				);

	{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.aka_rollup} R) := transform
		self.id  := L.id;
		self.aka := L.aka + row({R.aka[1].type,
							 R.aka[1].category,
							 R.aka[1].first_name,
							 R.aka[1].middle_name,
							 R.aka[1].last_name,
							 R.aka[1].generation,
							 R.aka[1].full_name,
							 R.aka[1].comments
		 },Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_aliases);
	end;

	return
		//rollup(sort(distribute(pAlias,(integer)id),id,local), id, rollRecs(left, right),local);
		rollup(pAlias, id, rollRecs(left, right), local);
END;

export rDJDates := RECORD
	string		id;
	string		dateType;
	Layouts.rDateValues date;
END;


export {rDJDates} 
		NormDates(dataset(Layouts.rPersons) infile) := FUNCTION
		
		rid1 := RECORD
			string		id;
			string		dateType;
			dataset(Layouts.rDateValues)	DateValues;
		END;
		rDJDates xid(rid1 L, Layouts.rDateValues R) := TRANSFORM
					self.id := L.id;
					self.dateType := L.dateType;
					self.date := R;
		END;		

		rid1 xid1(Layouts.rPersons L, Layouts.rDateDetail R) := TRANSFORM
			self.id := L.id;
			self.dateType := R.dateType;
			self.DateValues := R.DateValues;
		END;		

		ids := NORMALIZE(infile, LEFT.DateDetail, xid1(LEFT,RIGHT));
		idx := NORMALIZE(ids, LEFT.DateValues, xid(LEFT,RIGHT));

		return idx;
END;

export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} 
		GetDOB(dataset(Layouts.rPersons) infile) := FUNCTION

		birthdates := NormDates(infile)(datetype='Date of Birth');
		
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} xDob(rDJDates src) := TRANSFORM
			self.id := src.id;
			string dob := TRIM(src.date.Day+' '+src.date.Month+' '+src.date.Year,LEFT,RIGHT); 
			self.Type 			:= 'DOB';	//'Date of Birth'; 
			self.Information	:= dob;
			//self.Parsed			:= TRIM(precleanDate(dob));
			self.Parsed			:= Dates.PiecesToXG(src.date.Year,src.date.Month,src.date.Day);
			self.Comments		:= src.date.Dnotes;
		END;
		
		norm := PROJECT(birthdates, xDob(LEFT));
		
		pDob := 
				project(norm,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
				)
			);
														
		pDob rollRecs(pDob L, pDob R) := transform
		self.id  := L.id;
		self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
							R.additionalinfo[1].information,
							R.additionalinfo[1].parsed,
							R.additionalinfo[1].comments
		},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
	end;
	return
		rollup(pDob, id, rollRecs(left, right),local);		
	
END;

export rComments GetDOD(dataset(Layouts.rPersons) infile) := FUNCTION

		dod := NormDates(infile)(datetype='Deceased Date');
		deceased := PROJECT(dod, TRANSFORM(rComments,
				self.id := LEFT.id;
				self.cmts := Dates.PiecesToString(LEFT.date.Year,LEFT.date.Month,LEFT.date.Day);));
				
		rComments rollRecs(rComments L, rComments R) := TRANSFORM
				self.id := L.id;
				self.cmts := TRIM(L.cmts + ' ' + R.cmts);
		END;
	
		return rollup(deceased, id, rollRecs(left,right),local);	
END;


export {rDJDates} 
		NormEntityDates(dataset(Layouts.rEntities) infile) := FUNCTION
		
		rid1 := RECORD
			string		id;
			string		dateType;
			dataset(Layouts.rDateValues)	DateValues;
		END;
		rDJDates xid(rid1 L, Layouts.rDateValues R) := TRANSFORM
					self.id := L.id;
					self.dateType := L.dateType;
					self.date := R;
		END;		

		rid1 xid1(Layouts.rEntities L, Layouts.rDateDetail R) := TRANSFORM
			self.id := L.id;
			self.dateType := R.dateType;
			self.DateValues := R.DateValues;
		END;		

		ids := NORMALIZE(infile, LEFT.DateDetail, xid1(LEFT,RIGHT));
		idx := NORMALIZE(ids, LEFT.DateValues, xid(LEFT,RIGHT));

		return idx;
END;

export rComments GetRegistrationDate := FUNCTION

		regdates1 := NormEntityDates(File_Entity)(datetype='Date of Registration');
		regdates := PROJECT(regdates1, TRANSFORM(rComments,
				self.id := LEFT.id;
				self.cmts := Dates.PiecesToString(LEFT.date.Year,LEFT.date.Month,LEFT.date.Day);));
				
		rComments rollRecs(rComments L, rComments R) := TRANSFORM
				self.id := L.id;
				self.cmts := TRIM(L.cmts + ' ' + R.cmts);
		END;
	
		return rollup(regdates, id, rollRecs(left,right),local);	
END;

export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} 
		GetRegistrationDateAsInfo := FUNCTION

		regdates := NormEntityDates(File_Entity)(datetype='Date of Registration');
		
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} xDates(rDJDates src) := TRANSFORM
			self.id := src.id;
			string dob := TRIM(src.date.Day+' '+src.date.Month+' '+src.date.Year,LEFT,RIGHT); 
			self.Type 			:= 'DOB';	//'Date of Birth'; 
			self.Information	:= dob;
			self.Parsed			:= Dates.PiecesToXG(src.date.Year,src.date.Month,src.date.Day);
			self.Comments		:= src.date.Dnotes;
		END;
		
		norm := PROJECT(regdates, xDates(LEFT));
		
		pRegdates := 
				project(norm,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
				)
			);
														
		pRegdates rollRecs(pRegdates L, pRegdates R) := transform
		self.id  := L.id;
		self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
							R.additionalinfo[1].information,
							R.additionalinfo[1].parsed,
							R.additionalinfo[1].comments
		},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
	end;
	return
		rollup(pRegdates, id, rollRecs(left, right),local);		
	
END;

export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} 
		GetRoles(dataset(Layouts.rPersons) infile) := FUNCTION

		rid1 := RECORD
			string		id;
			string		roleType;
			dataset(Layouts.rOccTitle)	OccTitles;
		END;
		rid1 xid1(Layouts.rPersons L, Layouts.rRoleDetail R) := TRANSFORM
					self.id := L.id;
					self.roleType := R.roleType;
					self.OccTitles := R.OccTitles;
		END;		
		rid2 := RECORD
			string		id;
			string		roleType;
			string		information;
			string		dStart;
			string		dEnd;
			string		occCat;
			string		occTitle;
			string		occName;
		END;
		rid2 xid2(rid1 L, Layouts.rOccTitle R) := TRANSFORM
					self.id := L.id;
					self.roleType := L.roleType;
					self.Information := R.OccTitle;
					self.dStart := Dates.PiecesToString(R.SinceYear,R.SinceMonth,R.SinceDay);
					self.dEnd := Dates.PiecesToString(R.ToYear,R.ToMonth,R.ToDay);
					self.OccCat := R.OccCat;
					self.occTitle := R.OccTitle;
					self.occName := '';
		END;

		/*{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} roleToInfo(rid1 src,Layouts.rOccTitle R) := TRANSFORM
					self.id := src.id;
					self.type 			:= 'Occupation';
					self.Information := R.OccTitle;
					dStart := Dates.PiecesToString(R.SinceYear,R.SinceMonth,R.SinceDay);
					dEnd := Dates.PiecesToString(R.ToYear,R.ToMonth,R.ToDay);
					occName := Lists.OccupationList(code=R.OccCat)[1].name;
					self.comments := TRIM('Type: ' + src.roletype +
													FmtCmt('Category: ', R.OccCat) +  
													FmtCmt('Start Date: ',dStart) + 
													FmtCmt('End Date: ',dEnd),LEFT,RIGHT); 
					self := [];
		END;*/
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} roleToInfo(rid2 src) := TRANSFORM
					self.id := src.id;
					self.type 			:= 'Occupation';
					self.Information := src.Information;
					self.comments := TRIM('Type: ' + src.roletype +
													FmtCmt('Category: ', src.OccName) +  
													FmtCmt('Start Date: ',src.dStart) + 
													FmtCmt('End Date: ',src.dEnd),LEFT,RIGHT); 
					self := [];
		END;	
		norm1 := NORMALIZE(infile, LEFT.RoleDetail, xid1(LEFT,RIGHT));
		norm1a := NORMALIZE(norm1, LEFT.OccTitles, xid2(LEFT,RIGHT));
		norm1b := JOIN(norm1a, Lists.OccupationList, LEFT.occCat = RIGHT.code, TRANSFORM(rid2,
											self.Occname := RIGHT.name;
											self := LEFT;), LEFT OUTER, LOOKUP);
		norm2 := PROJECT(norm1b, roleToInfo(LEFT));

		pRoles := 
				project(norm2,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
						)
				);

	{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} R) := transform
		self.id  := L.id;
		self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
							R.additionalinfo[1].information,
							R.additionalinfo[1].parsed,
							R.additionalinfo[1].comments
		 },Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
	end;

	return
		rollup(pRoles,id, rollRecs(left, right),local);
END;

export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} 
		GetBirthPlaces(dataset(Layouts.rPersons) infile) := FUNCTION

		rid1 := RECORD
			string		id;
			string		name;
		END;
//		rid1 xid1(Layouts.rPersons L, Layouts.rPlaces R) := TRANSFORM
//					self.id := L.id;
//					self.name := R.name;
//		END;		

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} placeToInfo(Layouts.rPersons src,Layouts.rPlaces R) := TRANSFORM
					self.id := src.id;
					self.type 			:= 'PlaceOfBirth';
					self.Information := R.name;
					self := [];
		END;
	
		norm2 := NORMALIZE(infile, LEFT.BirthPlace, placeToInfo(LEFT,RIGHT));

		pPlaces := 
				project(norm2,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
						)
				);

	{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} R) := transform
		self.id  := L.id;
		self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
							R.additionalinfo[1].information,
							R.additionalinfo[1].parsed,
							R.additionalinfo[1].comments
		 },Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
	end;

	return
		rollup(pPlaces,id, rollRecs(left, right),local);
END;

		
shared	ridInfo := RECORD
			string		id;
			string		idType;
			string		IDnotes;
			string		IDvalue;
		END;
export GetIds := FUNCTION
		rid1 := RECORD
			string		id;
			string		idType;
			dataset(Layouts.rIdValues)	IDValues;
		END;
		ridInfo xid(rid1 L, Layouts.rIdValues R) := TRANSFORM
					self.id := L.id;
					self.idType := L.idType;
					self.IDvalue := R.IDValue;
					self.IDNotes := R.IDNotes;
		END;
		rid1 xidPerson(Layouts.rPersons L, Layouts.rIdTypes R) := TRANSFORM
					self.id := L.id;
					self.idType := R.idType;
					self.IDValues := R.IDValues;
		END;
		rid1 xidEntity(Layouts.rEntities L, Layouts.rIdTypes R) := TRANSFORM
					self.id := L.id;
					self.idType := R.idType;
					self.IDValues := R.IDValues;
		END;
		idp := NORMALIZE(File_Person, LEFT.IdTypes, xidPerson(LEFT,RIGHT));
		ide := NORMALIZE(File_Entity, LEFT.IdTypes, xidEntity(LEFT,RIGHT));
		idx := NORMALIZE(idp&ide, LEFT.IdValues, xid(LEFT,RIGHT));
		
		return SORT(idx,id,LOCAL);

END;

export GetProprietaryIds := FUNCTION
		ridInfo xidPerson(Layouts.rPersons L) := TRANSFORM
					self.id := L.id;
					self.idType := 'ProprietaryUID';
					self.IDvalue := L.id;
					self.IDNotes := '';
		END;
		ridInfo xidEntity(Layouts.rEntities L) := TRANSFORM
					self.id := L.id;
					self.idType := 'ProprietaryUID';
					self.IDvalue := L.id;
					self.IDNotes := '';
		END;
		idp := PROJECT(File_Person, xidPerson(LEFT));
		ide := PROJECT(File_Entity, xidEntity(LEFT));
		idx := idp&ide;
		
		return SORT(idx,id,LOCAL);

END;

export GetIdsAsAddlinfo := FUNCTION

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} idToInfo(ridInfo src) := TRANSFORM
					self.id := src.id;
					self.type 			:= 'Other';
					self.Information := TRIM(src.IDType) + ' : ' + TRIM(src.IDvalue);
					self.comments := src.IDNotes;
					self := [];
		END;

		candidates := GetIds(DJtoXGIDType(idtype)='');

		ids := PROJECT(candidates, idToInfo(LEFT));

		pIds := 
				project(ids,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
						)
				);

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} R) := transform
						self.id  := L.id;
						self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
								R.additionalinfo[1].information,
								R.additionalinfo[1].parsed,
								R.additionalinfo[1].comments
					},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
			end;
		 
	return
		rollup(pIds, id, rollRecs(left, right),local);

	end;
	
export GetIdsAsIdlist := FUNCTION

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_SP} idToInfo(ridInfo src) := TRANSFORM
					self.id := src.id;
					self.type 			:= TRIM(DJtoXGIDType(src.IDType));
					self.number := src.IDvalue;
					self.comments := IF(src.IDNotes='' AND self.type='Other',src.IDType,src.IDNotes);
					self := [];
		END;

		candidates := SORT(GetProprietaryIds & GetIds(DJtoXGIDType(idtype)<>''), id, LOCAL);

		ids := PROJECT(candidates, idToInfo(LEFT));

		pIds := 
				project(ids,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.id_rollup},
						self.id := left.id;
						self.identification := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_sp); 
						)
				);

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.id_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.id_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.id_rollup} R) := transform
						self.id  := L.id;
						self.identification:= L.identification + row({R.identification[1].type,
												R.identification[1].label,
												R.identification[1].number,
												R.identification[1].issued_by,
												R.identification[1].date_issued,
												R.identification[1].date_expires,
												R.identification[1].comments
					},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_sp);
			end;
		 
	return
		rollup(pIds, id, rollRecs(left, right),local);

	end;	
/*	
shared	rCountries := RECORD
			string		id;
			string		CountryType;
			string		CountryCode;
			string		CountryName;
		END;
export GetCountries(dataset(Layouts.rPersons) infile) := FUNCTION
		rid1 := RECORD
			string		id;
			string		CountryType;
			dataset(Layouts.rCountryValues)	CountryValues;
		END;
		rCountries xid(rid1 L, Layouts.rCountryValues R) := TRANSFORM
					self.id := L.id;
					self.CountryType := L.CountryType;
					self.CountryCode := R.CountryCode;
					self.CountryName := '';
		END;
		rid1 xid1(Layouts.rPersons L, Layouts.rCountries R) := TRANSFORM
					self.id := L.id;
					self.CountryType := R.CountryType;
					self.CountryValues := R.CountryValues;
		END;
		ids := NORMALIZE(infile, LEFT.Countries, xid1(LEFT,RIGHT));
		idx := NORMALIZE(ids, LEFT.CountryValues, xid(LEFT,RIGHT));
		
		countries := JOIN(idx, Lists.CountryList, LEFT.CountryCode = RIGHT.code, TRANSFORM(rCountries,
											self.CountryName := RIGHT.name;
											self := LEFT;), LEFT OUTER, LOOKUP);
		
		return countries;

	end;
*/	
export GetCitizenship(dataset(Layouts.rPersons) infile) := FUNCTION
		//countries := GetCountries(infile)(CountryType='Citizenship');
		countries := AllCountries(CountryType='Citizenship');
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} idToInfo(rCountry src) := TRANSFORM
					self.id := src.id;
					self.type 			:= src.CountryType;
					self.Information := src.CountryName;
					self.comments := src.comment;
					self := [];
		END;

		citizen1 := PROJECT(countries, idToInfo(LEFT));
		pCitizen := 
				project(citizen1,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
						)
				);

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup} R) := transform
						self.id  := L.id;
						self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
								R.additionalinfo[1].information,
								R.additionalinfo[1].parsed,
								R.additionalinfo[1].comments
					},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
			end;
		 
	return
		rollup(pCitizen, id, rollRecs(left, right),local);		

END;

export GetResidence(dataset(Layouts.rPersons) infile) := FUNCTION
		//countries := GetCountries(infile)(CountryType='Resident of');
		countries := AllCountries(CountryType='Resident of');

		residence1 := PROJECT(countries, TRANSFORM({string id; Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses},
									self.id := LEFT.id;
									self.type := 'Current';
									self.Country := LEFT.CountryName;
									self.comments := LEFT.comment;
									self := [];
									));
									
		residences := 
				project(residence1,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup},
						self.id := left.id;
						self.address := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses); 
						)
				);		

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} R) := transform
						self.id  := L.id;
						self.address:= L.address + row({R.address[1].type,
												R.address[1].street_1,
												R.address[1].street_2,
												R.address[1].city,
												R.address[1].state,
												R.address[1].postal_code,
												R.address[1].country,
												R.address[1].comments
					},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses);
			end;
		 
	return
		rollup(residences, id, rollRecs(left, right),local);		

END;


export rComments GetCountryNotes := FUNCTION
		//countries := GetCountries(infile)(CountryType NOT IN ['Citizenship','Resident of']);
		countries := AllCountries(CountryType NOT IN ['Citizenship','Resident of']);
r := RECORD
		rComments;
		string	CountryType;
END;
		notes := PROJECT(countries, TRANSFORM(r,
				self.id := LEFT.id;
				self.CountryType := Left.CountryType;
				self.cmts := LEFT.CountryName;));
		
		r rollRecs(r L, r R) := TRANSFORM
			self.id := L.id;
			self.CountryType := L.CountryType;
			self.cmts := TRIM(L.cmts + '; ' + R.cmts);
		END;
		n1 := rollup(notes, rollRecs(left, right), id, CountryType, local);
		RETURN PROJECT(n1, TRANSFORM(DowJones.rComments,
								SELF.ID := LEFT.id;
								SELF.cmts := LEFT.CountryType + ': ' + LEFT.cmts));

END;

	
export GetAddresses(dataset(Layouts.rPersons) infile) := FUNCTION
	
	rid1 := RECORD
		string		id;
		string		AddressLine;
		string		AddressCity;
		string		AddressCountry;
		string		CountryName := '';
		unicode		URL;
	END;
	
		rid1 xid(Layouts.rPersons L, Layouts.rAddresses R) := TRANSFORM
					self.id := L.id;
					self.AddressLine := R.AddressLine;
					self.AddressCity := R.AddressCity;
					self.AddressCountry := R.AddressCountry;
					self.URL := R.URL;
		END;
		
		address1 := NORMALIZE(infile, LEFT.Addresses, xid(LEFT,RIGHT));
		address2 := JOIN(address1, Lists.CountryList, LEFT.AddressCountry = RIGHT.code, TRANSFORM(rid1,
											self.CountryName := RIGHT.name;
											self := LEFT;), LEFT OUTER, LOOKUP);
		address3 := PROJECT(address2, TRANSFORM({string id; Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses},
									self.id := LEFT.id;
									self.type := 'Unknown';
									self.street_1 := IF(TRIM(LEFT.AddressLine)='',LEFT.AddressCity,LEFT.AddressLine);
									self.street_2 := IF(TRIM(LEFT.AddressLine)<>'',LEFT.AddressCity,'');
									self.Country := LEFT.CountryName;
									self.Comments := IF(LEFT.URL='','','URL: ' + (string)LEFT.URL);
									self := [];
									));
											
		pAddressess := 
				project(address3,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup},
						self.id := left.id;
						self.address := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses); 
						)
				);		

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} R) := transform
						self.id  := L.id;
						self.address:= L.address + row({R.address[1].type,
												R.address[1].street_1,
												R.address[1].street_2,
												R.address[1].city,
												R.address[1].state,
												R.address[1].postal_code,
												R.address[1].country,
												R.address[1].comments
					},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses);
			end;
		 
		return
			rollup(pAddressess, id, rollRecs(left, right),local);
	
	end;
	
	
export GetAddressesEntities(dataset(Layouts.rEntities) infile) := FUNCTION
	
	rid1 := RECORD
		string		id;
		string		AddressLine;
		string		AddressCity;
		string		AddressCountry;
		string		CountryName := '';
		unicode		URL;
	END;
	
		rid1 xid(Layouts.rEntities L, Layouts.rAddresses R) := TRANSFORM
					self.id := L.id;
					self.AddressLine := R.AddressLine;
					self.AddressCity := R.AddressCity;
					self.AddressCountry := R.AddressCountry;
					self.URL := R.URL;
		END;
		
		address1 := NORMALIZE(infile, LEFT.CompanyDetails, xid(LEFT,RIGHT));
		address2 := JOIN(address1, Lists.CountryList, LEFT.AddressCountry = RIGHT.code, TRANSFORM(rid1,
											self.CountryName := RIGHT.name;
											self := LEFT;), LEFT OUTER, LOOKUP);
		address3 := PROJECT(address2, TRANSFORM({string id; Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses},
									self.id := LEFT.id;
									self.type := 'Unknown';
									self.street_1 := IF(TRIM(LEFT.AddressLine)='',LEFT.AddressCity,LEFT.AddressLine);
									self.street_2 := IF(TRIM(LEFT.AddressLine)<>'',LEFT.AddressCity,'');
									self.Country := LEFT.CountryName;
									self.Comments := IF(LEFT.URL='','','URL: ' + (string)LEFT.URL);
									self := [];
									));
											
		pAddressess := 
				project(address3,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup},
						self.id := left.id;
						self.address := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses); 
						)
				);		

		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} rollRecs(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} L,
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Addr_rollup} R) := transform
						self.id  := L.id;
						self.address:= L.address + row({R.address[1].type,
												R.address[1].street_1,
												R.address[1].street_2,
												R.address[1].city,
												R.address[1].state,
												R.address[1].postal_code,
												R.address[1].country,
												R.address[1].comments
					},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.Layout_Addresses);
			end;
		 
		return
			rollup(pAddressess, id, rollRecs(left, right),local);
	
	end;
	
export GetRawSanctions := FUNCTION
		rSanctions := RECORD
			string			id;
			string			status := '';
			string			dStart;
			string			dEnd;
			string			reference;
			unicode			refName := '';
			string			description2Id := '';
			unicode			comment := '';
		END;
		
		rSanctions xidp(Layouts.rPersons L, Layouts.rReferences R) := TRANSFORM
					self.id := L.id;
					self.dStart := Dates.PiecesToString(R.SinceYear,R.SinceMonth,R.SinceDay);
					self.dEnd := Dates.PiecesToString(R.ToYear,R.ToMonth,R.ToDay);
					self.reference := R.reference;
		END;
		rSanctions xidE(Layouts.rEntities L, Layouts.rReferences R) := TRANSFORM
					self.id := L.id;
					self.dStart := Dates.PiecesToString(R.SinceYear,R.SinceMonth,R.SinceDay);
					self.dEnd := Dates.PiecesToString(R.ToYear,R.ToMonth,R.ToDay);
					self.reference := R.reference;
		END;

		sanctionsP := NORMALIZE(File_Person, LEFT.Sanctions, xidp(LEFT,RIGHT));
		sanctionsE := NORMALIZE(File_Entity, LEFT.Sanctions, xide(LEFT,RIGHT));
		sanctions1 := SORT(sanctionsP&sanctionsE, id);
		sanctions2 := JOIN(sanctions1, Lists.SanctionsList, LEFT.reference = RIGHT.code, TRANSFORM(rSanctions,
											self.refName := RIGHT.name;
											self.description2Id := RIGHT.description2Id;
											self.status := RIGHT.status;
											self.comment := RIGHT.name + MAP(
												LEFT.dStart = '' AND LEFT.dEnd = '' => '',
												LEFT.dStart <> '' AND LEFT.dEnd = '' => '(Start Date: ' + LEFT.dStart + ')',
												LEFT.dStart = '' AND LEFT.dEnd <> '' => '(End Date: ' + LEFT.dEnd + ')',
												LEFT.dStart <> '' AND LEFT.dEnd <> '' => '(Start Date: ' + LEFT.dStart + ', End Date: ' + LEFT.dEnd + ')',
												'') + ';';
											self := LEFT;),
											LEFT OUTER, LOOKUP);
		return sanctions2;	
		
END;

shared GetSanctions(dataset(Layouts.rPersons) infile) := FUNCTION
		rid1 := RECORD
			string				id;
			string			dStart;
			string			dEnd;
			string			reference;
			unicode			refName := '';
			unicode			comment := '';
		END;
		rid1 xid(Layouts.rPersons L, Layouts.rReferences R) := TRANSFORM
					self.id := L.id;
					self.dStart := Dates.PiecesToString(R.SinceYear,R.SinceMonth,R.SinceDay);
					self.dEnd := Dates.PiecesToString(R.ToYear,R.ToMonth,R.ToDay);
					self.reference := R.reference;
		END;

		sanctions1 := NORMALIZE(infile, LEFT.Sanctions, xid(LEFT,RIGHT));
		sanctions2 := JOIN(sanctions1, Lists.SanctionsList, LEFT.reference = RIGHT.code, TRANSFORM(rid1,
											self.refName := RIGHT.name;
											self.comment := RIGHT.name + MAP(
												LEFT.dStart = '' AND LEFT.dEnd = '' => '',
												LEFT.dStart <> '' AND LEFT.dEnd = '' => ' (Start Date: ' + LEFT.dStart + ')',
												LEFT.dStart = '' AND LEFT.dEnd <> '' => ' (End Date: ' + LEFT.dEnd + ')',
												LEFT.dStart <> '' AND LEFT.dEnd <> '' => ' (Start Date: ' + LEFT.dStart + ', End Date: ' + LEFT.dEnd + ')',
												'');
											self := LEFT;),
											LEFT OUTER, LOOKUP);
	
		rid1 RollRecs(rid1 L, rid1 R) := TRANSFORM
				self.id := L.id;
				self.comment := TRIM(L.Comment) + ' | ' + TRIM(R.Comment);
				self := L;
		END;

		sanctions := ROLLUP(sanctions2, id, RollRecs(LEFT, RIGHT));
	
		return sanctions;

	end;
	
shared GetSanctionsEntity(dataset(Layouts.rEntities) infile) := FUNCTION
		rid1 := RECORD
			string				id;
			string			dStart;
			string			dEnd;
			string			reference;
			unicode			refName := '';
			unicode			comment := '';
		END;
		rid1 xid(Layouts.rEntities L, Layouts.rReferences R) := TRANSFORM
					self.id := L.id;
					self.dStart := Dates.PiecesToString(R.SinceYear,R.SinceMonth,R.SinceDay);
					self.dEnd := Dates.PiecesToString(R.ToYear,R.ToMonth,R.ToDay);
					self.reference := R.reference;
		END;

		sanctions1 := NORMALIZE(infile, LEFT.Sanctions, xid(LEFT,RIGHT));
		sanctions2 := JOIN(sanctions1, Lists.SanctionsList, LEFT.reference = RIGHT.code, TRANSFORM(rid1,
											self.refName := RIGHT.name;
											self.comment := RIGHT.name + MAP(
												LEFT.dStart = '' AND LEFT.dEnd = '' => '',
												LEFT.dStart <> '' AND LEFT.dEnd = '' => ' (Start Date: ' + LEFT.dStart + ')',
												LEFT.dStart = '' AND LEFT.dEnd <> '' => ' (End Date: ' + LEFT.dEnd + ')',
												LEFT.dStart <> '' AND LEFT.dEnd <> '' => ' (Start Date: ' + LEFT.dStart + ', End Date: ' + LEFT.dEnd + ')',
												'');
											self := LEFT;),
											LEFT OUTER, LOOKUP);
	
		rid1 RollRecs(rid1 L, rid1 R) := TRANSFORM
				self.id := L.id;
				self.comment := TRIM(L.Comment) + ' | ' + TRIM(R.Comment);
				self := L;
		END;

		sanctions := ROLLUP(sanctions2, id, RollRecs(LEFT, RIGHT), local);
	
		return sanctions;

	end;	
	
export rComments GetImages(dataset(Layouts.rPersons) infile) := FUNCTION
		
		rComments NormImage(Layouts.rPersons infile, Layouts.rImages img) := TRANSFORM
				self.id := infile.id;
				self.cmts := img.URL;
		END;
		images := NORMALIZE(infile, LEFT.Images, NormImage(LEFT,RIGHT));
		
		rComments rollRecs(rComments L, rComments R) := TRANSFORM
			self.id := L.id;
			self.cmts := TRIM(L.cmts + ' | ' + R.cmts);
		END;
		return rollup(images, id, rollRecs(left, right), local);

END;

export GetRawDescriptions := FUNCTION
		rDesc := RECORD
			string					id;
			integer					Description1;
			string					Name1 := '';
			integer					Description2;
			string					Name2 := '';
			integer					Description3;
			string					Name3 := '';
		END;
		
		rDesc NormDesc(Layouts.rPersons infile, Layouts.rDescriptions desc) := TRANSFORM
				self.id := infile.id;
				self := desc;
		END;
		rDesc NormDescEntity(Layouts.rEntities infile, Layouts.rDescriptions desc) := TRANSFORM
				self.id := infile.id;
				self := desc;
		END;
		
		dscPerson := NORMALIZE(File_Person, LEFT.Descriptions, NormDesc(LEFT,RIGHT));
		dscEntity := NORMALIZE(File_Entity, LEFT.Descriptions, NormDescEntity(LEFT,RIGHT));
		dsc0 := SORT(dscPerson & dscEntity, id, local);
		dsc1 := JOIN(dsc0, Lists.Description1List, LEFT.Description1 = RIGHT.Description1Id, TRANSFORM(rDesc,
									self.Name1 := RIGHT.name;
									self := LEFT;), LEFT OUTER, LOOKUP);
		dsc2 := JOIN(dsc1, Lists.Description2List, LEFT.Description2 = RIGHT.Description2Id, TRANSFORM(rDesc,
									self.Name2 := RIGHT.name;
									self := LEFT;), LEFT OUTER, LOOKUP);
		dsc3 := JOIN(dsc2, Lists.Description3List, LEFT.Description3 = RIGHT.Description3Id, TRANSFORM(rDesc,
									self.Name3 := RIGHT.name;
									self := LEFT;), LEFT OUTER, LOOKUP);
									

		return dsc3;
END;

export GetDescriptions := FUNCTION
		rDesc := RECORD
			string					id;
			integer					Description1;
			string					Name1 := '';
			integer					Description2;
			string					Name2 := '';
			integer					Description3;
			string					Name3 := '';
			integer					descNum;
			string					description := '';
		END;
		r1 := RECORD
			string			id;
			integer			descNum;
			string			description;
		END;
		r := RECORD
			string			id;
			string			description;
		END;
		

		dsc1 := GetRawDescriptions;
		
		//Bug: 145107
		SetOfExcludedDescription3Id := [79,80,81,82,83];
		dsc12 := dsc1(Description3 not in SetOfExcludedDescription3Id);
		//Bug: 145107
		
		dsc2 := NORMALIZE(dsc12/*dsc1*/, 3, TRANSFORM(r1,
								self.id := LEFT.id;
								self.description := CASE(COUNTER,
									1 => LEFT.Name1,
									2 => LEFT.Name2,
									3 => LEFT.Name3,
									'');
								self.descNum := COUNTER;));
		
		dsc3 := PROJECT(DEDUP(SORT(dsc2(description<>''), id, descNum, description, LOCAL), id, descNum, description, LOCAL),r,LOCAL);
		
		
									
		dsc := ROLLUP(dsc3, id, TRANSFORM(r,
								self.id := LEFT.id;
								self.description := if (((length(LEFT.description)+length(RIGHT.description))> 253), LEFT.description, LEFT.description + '; ' + RIGHT.description);),local);

		
		return dsc;
END;

export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup}
		GetVessels := FUNCTION

			r := RECORD
				string	id;
				layouts.rVesselDetails VesselDetails;
			end;
			
		r	xid(Layouts.rEntities L, layouts.rVesselDetails R) := TRANSFORM
				self.ID := L.ID;
				self.VesselDetails := R;
		END;

		// pull out the vessel data
		vesseldata := Normalize(File_Entity, LEFT.VesselDetails, xid(LEFT,RIGHT));
		// fix country code
		
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} xVessel(r src, integer n) := TRANSFORM
			self.id := src.id;
			self.Type 			:= CASE(n,
													1 => 'VesselCallSign',
													2 => 'VesselType',
													3 => 'VesselTonnage',
													4 => 'VesselGRT',
													5 => 'VesselOwner',
													6 => 'VesselFlag',
													'Other');
			self.Information	:= CASE(n,
							1 => IF(TRIM(src.VesselDetails.VesselCallSign)='',SKIP,src.VesselDetails.VesselCallSign),
							2 => IF(TRIM(src.VesselDetails.VesselType)='',SKIP,src.VesselDetails.VesselType),
							3 => IF(TRIM(src.VesselDetails.VesselTonnage)='',SKIP,src.VesselDetails.VesselTonnage),
							4 => IF(TRIM(src.VesselDetails.VesselGRT)='',SKIP,src.VesselDetails.VesselGRT),
							5 => IF(TRIM(src.VesselDetails.VesselOwner)='',SKIP,src.VesselDetails.VesselOwner),
							6 => IF(TRIM(src.VesselDetails.VesselFlag)='',SKIP,src.VesselDetails.VesselFlag),
							SKIP);

			self.Parsed			:= '';
			self.Comments		:= '';
		END;
		
		// now create an additional info record for each vessel detail field
		vesselinfo1 := normalize(vesseldata, 6, xVessel(LEFT, COUNTER)); 
		vesselinfo := SORT(DISTRIBUTE(JOIN(vesselinfo1, Lists.CountryList, LEFT.Information=RIGHT.code,
										TRANSFORM({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo},
												SELF.Information := IF(LEFT.Type='VesselFlag',
																			RIGHT.name, LEFT.Information);
												SELF := LEFT;), LEFT OUTER), (integer)id), id, TYPE, Information, LOCAL);
		
		pVessel := 
				project(vesselinfo,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
				)
			);
														
		pVessel rollRecs(pVessel L, pVessel R) := transform
				self.id  := L.id;
				self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
							R.additionalinfo[1].information,
							R.additionalinfo[1].parsed,
							R.additionalinfo[1].comments
		},Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo);
	end;
	return
		rollup(pVessel, id, rollRecs(left, right),local);		

END;

export {string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup}
	GetSources := FUNCTION
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo}	xidEntity(Layouts.rEntities L, layouts.rSources R) := TRANSFORM
				self.ID := L.ID;
				self.Type := 'Other';
				self.Information := 'Source Descriptions';
				self.Comments := R.name;
				self := [];
		END;
		normSourcesEntity := Normalize(File_Entity, LEFT.Sources, xidEntity(LEFT,RIGHT));
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo}	xidPerson(Layouts.rPersons L, layouts.rSources R) := TRANSFORM
				self.ID := L.ID;
				self.Type := 'Other';
				self.Information := 'Source Descriptions';
				self.Comments := R.name;
				self := [];
		END;
		normSourcesPerson := Normalize(File_Person, LEFT.Sources, xidPerson(LEFT,RIGHT));
		normSources := SORT(normSourcesEntity & normSourcesPerson, id, local);
		
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo}	
						xSource({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} L,
										{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo} R) := TRANSFORM
				self.ID := L.ID;
				self.Comments := L.Comments + ' | ' + R.Comments;
				self := L;
		END;
		sources := ROLLUP(normSources, id, xSource(LEFT,RIGHT), local);

		pSources := 
				project(sources,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Unicode.layout_addlinfo); 
				)
			);

		return pSources;

	END;

END;