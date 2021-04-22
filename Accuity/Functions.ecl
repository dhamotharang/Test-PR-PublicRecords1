Import Worldcheck_Bridger,ut,Std;

export Functions := module

shared STRING8 GetDate := (STRING8)Std.Date.Today();


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT HEADER
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export unsigned getEntityCount(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile) := function
	//return(count(dedup(infile,id,all)));
	return count(infile);
end;

export Concat(string s1, string s2, string sep=' | '):= TRIM(
	IF(s1='',s2,
		IF(s2='',s1,s1 + sep + s2)),LEFT,RIGHT);
		
export Concat3(string s1, string s2, string s3):= 
	Concat(Concat(s1,s2),s3);

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT DATES
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*export string10 fSlashedMDYtoCYMD(string pDateIn) :=  function
  prepped_date1 := if(length(pDateIn) = 4,
									  '/00/00'+pDateIn, pDateIn);
	prepped_date2 := Accuity.Conversions.AlphatoNumericMonth(prepped_date1);
	return*/
//			 intformat((integer2)regexreplace('.*/.*/([0-9]+)',prepped_date2,'$1'),4,1) 
//		   +  '/' + 
//			 intformat((integer1)regexreplace('([0-9]+)/.*/.*',prepped_date2,'$1'),2,1)
//			 +  '/' + 
//			 intformat((integer1)regexreplace('.*/([0-9]+)/.*',prepped_date2,'$1'),2,1);
//	end;

FixCentury(string pDateIn) := FUNCTION
	year := (integer)REGEXFIND('^([0-9]+)\\b', pDateIn, 1);
	return MAP(
		year = 0 => '',
		year > 99 => pDateIn,
		year < 20 => '20' + pDateIn,
		'19' + pDateIn
	);
END;

export string10 fSlashedMDYtoCYMD(string pDateIn) :=  function
	fmtout := '%Y/%m/%d';
	fmts := [
		'%m/%d/%Y',
		'%d %B %Y',
		'%d %b %Y',
		'%d.%m.%Y',
		'%d-%B-%Y'
		];
	
	return MAP(
		length(TRIM(pDateIn,LEFT,RIGHT))=4 => pDateIn + '/00/00',
		FixCentury(Std.date.ConvertDateFormatMultiple(pDateIn, fmts, fmtout))
	);
	
END;

export string10 precleanDate(string pDateIn) := 
	fSlashedMDYtoCYMD(TRIM(
		REGEXREPLACE('(Approximately|circa|vers|APROXIMADAMENTE EN|APROXIMADAMENTE|ALREDEDOR DE|en torno a|hacia|est\\.?)',
			pDateIn,'',NOCASE),LEFT,RIGHT));
		
shared MinOtherLen := 128;
	

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Addresses
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export normAddresses(dataset(Accuity.Layouts.input.rEntity) infile) := function
													 
	tbl_addr := table(infile, 
							{integer addrCount := count(Addresses), 
							infile});
	return
	 dedup(normalize(tbl_addr,left.addrCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses},
								self.id 				:= left.id;
								self.type 			:= '';
								self.street_1		:= left.Addresses[counter].address1;
								self.street_2		:= left.Addresses[counter].address2;
								self.city			:= left.Addresses[counter].city;
								region := IF(left.Addresses[counter].state_abbr_us='',left.Addresses[counter].province,left.Addresses[counter].state_abbr_us);
								self.state			:= region;
								self.postal_code	:= left.Addresses[counter].postal_code;
								self.country		:= left.Addresses[counter].country_name;
								self.comments		:= '';
							)
					),record,all);
end;
/////////////////////////
export denormAddresses(dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses})) infile) := function
	pAddr := 
				project(infile,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.addr_rollup},
						self.id := left.id;
						self.address := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses); 
																			)
								);
						
	pAddr rollRecs(pAddr L, pAddr R) := transform
		self.id  := L.id;
		self.address := L.address + row({	R.address[1].type,
										R.address[1].street_1,
										R.address[1].street_2,
										R.address[1].city,
										R.address[1].state,
										R.address[1].postal_code,
										R.address[1].country,
										R.address[1].comments
				},Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addresses);
	end;
	return
		rollup(sort(distribute(pAddr,hash(id)),id,local), id, rollRecs(left, right),local);
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Additional Information
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ChangeToOther := ['OtherInformation', 'Organization','AltAddress','LanguagesSpoken',
					'CONTACT','ENHANCEMENT',
					'DocumentOfCompliance','EffectiveDate','ExpirationDate',
					'GroupBeneficialOwner','Legal_Basis','Manager','Operator',
					'Org_PID','Organizatin','PlaceofIncorporation','Relationship',
					'TechnicalManager','Typeofdenial',
					'SubCategory', 'OwnershipPercent','SourceLink'
					];

export normAddl(dataset(Accuity.Layouts.input.rEntity) infile) := function
	tbl_addl := table(infile, 
						{integer addlCount := count(Additional_Info), 
						infile});
	result := normalize(tbl_addl,left.addlCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
						typ := left.Additional_Info[counter].sdf_name;
					
						self.id 			:= left.id;
						self.type			:= MAP(
												typ in ChangeToOther => 'Other',
												typ = 'RegisteredOwner' => 'VesselOwner',
												typ);
						self.information	:= left.Additional_Info[counter].sdf_value;	
						self.Parsed			:= if(regexfind('DATE',typ),fSlashedMDYtoCYMD(self.information),'');
						self.comments		:= trim(Accuity.Conversions.sdfCodetoDescr(typ),left,right);
				)
			);
	EntityIDs := PROJECT(infile, transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
					self.id := left.id;
					self.type := 'Other';
					self.information := LEFT.List_id + ':' + LEFT.id;
					self.comments := 'Internal Record ID';
					self := [];
					));
			//,record,all);
//OUTPUT('normAddl');					
//OUTPUT(tbl_addl(id='496000'));					
//OUTPUT(result(id='496000'));					
	return result + EntityIDs;
end;

/////////////////////////
lenok(string typ, string info) := typ<>'Other' OR length(trim(info)) < MinOtherLen;
export denormAddl(dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo})) infile) := function
set_omittype := ['Gender','PHONE','GENDER','Phone', 'OriginalID', 'RelatedEntities','Relationship','Program',
					'OtherInformation2','Organization','AltAddress','LanguagesSpoken',
					'CONTACT','ENHANCEMENT',
					'DocumentOfCompliance','EffectiveDate','ExpirationDate',
					'GroupBeneficialOwner','Legal_Basis','Manager','Operator',
					'Org_PID','Organizatin','PlaceofIncorporation','RegisteredOwner',
					'TechnicalManager','Typeofdenial'
					];	
	pAddl := 
			project(infile(type not in set_omittype,lenok(infile.type,information)),
					transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo); 
					)
				);
														
	pAddl rollRecs(pAddl L, pAddl R) := transform
		self.id  := L.id;
		self.additionalinfo := L.additionalinfo + row({	R.additionalinfo[1].type,
										R.additionalinfo[1].information,
										R.additionalinfo[1].parsed,
										R.additionalinfo[1].comments
						},Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo);
		end;
		
	result := rollup(sort(distribute(pAddl,hash(id)),id,local), id, rollRecs(left, right),local);
//OUTPUT('denormAddl');						
//OUTPUT(pAddl(id='39261'));					
//output(result(id = '39261'));			//in [''31721'','452202','460148']))74532
	return result;
		
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: AKAs
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export normAliases(dataset(Accuity.Layouts.input.rEntity) infile) := function
													 
	tbl_aka := table(infile, 
							{integer akaCount := count(AKAs), 
							infile});
	
		ds1 := normalize(tbl_aka,left.akacount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases},
			fullname := if (counter < 256, left.AKAs[counter].alias,SKIP);
			alias_type:= if (counter < 256, left.AKAs[counter].alias_type,SKIP);

			self.id 				:= left.id;
			self.type 			:= map(alias_type = 'Alias' => 'AKA',
													   alias_type = 'DBA'   => 'AKA',alias_type);
			self.category 	:= left.AKAs[counter].alias_cat;
			cln_name := IF(Conversions.IsPersonCode(LEFT.type), Persons.CleanName(fullname), '');
			self.first_name 			:= TRIM(cln_name[6..55],LEFT,RIGHT);
			self.middle_name 			:= TRIM(cln_name[56..105],LEFT,RIGHT);
			self.last_name 				:= TRIM(cln_name[106..155],LEFT,RIGHT);
			self.generation 			:= TRIM(cln_name[156..161],LEFT,RIGHT);
			newname := TRIM(stringlib.StringCleanSpaces(cln_name),LEFT,RIGHT);
			self.full_name := if(Conversions.IsPersonCode(LEFT.type),
									if(newname='',fullname,newname),
									TRIM(fullname,LEFT,RIGHT));
			self.comments   := (string)if(alias_type = 'DBA','dba ' + trim(fullname,left,right),
								fullname);
			)
		);
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases} 
				extractAlias(Accuity.Layouts.input.rEntity src, File_AKANormalized aliases) := TRANSFORM
			self.id := src.id;
			cln_name := Persons.CleanName(aliases.aka);
			self.full_name := TRIM(stringlib.StringCleanSpaces(cln_name),LEFT,RIGHT);
			self.first_name 			:= TRIM(cln_name[6..55],LEFT,RIGHT);
			self.middle_name 			:= TRIM(cln_name[56..105],LEFT,RIGHT);
			self.last_name 				:= TRIM(cln_name[106..155],LEFT,RIGHT);
			self.generation 			:= TRIM(cln_name[156..161],LEFT,RIGHT);
			self.type := 'AKA';
			self.comments := aliases.full_name;
			self.category := '';
			self := [];
		END;
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases} 
				extractAKA(Accuity.Layouts.input.rEntity src, File_AKANormalized aliases) := TRANSFORM
			self.id := src.id;
			cln_name := aliases.aka;
			self.full_name := cln_name;
			self.type := 'AKA';
			self.comments := aliases.full_name;
			self.category := '';
			self := [];
		END;
		/*aka1 := PROJECT(infile(Conversions.IsPersonCode(infile.type),Persons.HasAlias(full_name)),
						extractAlias(LEFT));
		aka2 := NORMALIZE(infile(NOT Conversions.IsPersonCode(infile.type),Persons.HasParen(full_name)),
						2, extractAKA(LEFT, counter));*/
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases} 
				extractAKAaka({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases} src, File_AKANormalized aliases) := TRANSFORM
			self.id := src.id;
			aka_name := aliases.aka;
			self.full_name := aka_name;
			cln_name := IF(src.last_name<>'', Persons.CleanName(aka_name), '');
			self.first_name 			:= TRIM(cln_name[6..55],LEFT,RIGHT);
			self.middle_name 			:= TRIM(cln_name[56..105],LEFT,RIGHT);
			self.last_name 				:= TRIM(cln_name[106..155],LEFT,RIGHT);
			self.generation 			:= TRIM(cln_name[156..161],LEFT,RIGHT);
			self.type := 'AKA';
			self.comments := aliases.full_name;
			self.category := '';
			self := [];
		END;
		akaaka2 := JOIN(ds1,
						File_AKANormalized,LEFT.id = RIGHT.id AND LEFT.comments=RIGHT.full_name, 
						extractAKAaka(LEFT,RIGHT),
						INNER);
		aka1 := JOIN(infile(Conversions.IsPersonCode(infile.type)),
						File_AKANormalized,LEFT.id = RIGHT.id AND LEFT.full_name=RIGHT.full_name, 
						extractAlias(LEFT,RIGHT),
						INNER);
		aka2 := JOIN(infile(Conversions.IsBusinessCode(infile.type)),
						File_AKANormalized,LEFT.id = RIGHT.id AND LEFT.full_name=RIGHT.full_name, 
						extractAKA(LEFT,RIGHT),
						INNER);
		
		akas := aka1 + aka2 + akaaka2;
		ds := IF(EXISTS(akas), ds1 + akas, ds1);
		//ds := ds1;
//OUTPUT('normAliases');
//OUTPUT(infile(id='65038'),OVERWRITE,named('nmInfile'));
//OUTPUT(akaaka2(id='604518'),OVERWRITE,named('nmakaaka2'));
//OUTPUT(aka1(id='65038'),OVERWRITE,named('nmaka1'));
//OUTPUT(akas(id='65038'),OVERWRITE,named('nmakas'));
//OUTPUT(tbl_aka(id='39676'),OVERWRITE,named('nmAka'));
//OUTPUT(ds(id='604518'),OVERWRITE,named('nmds'));
	return DEDUP(ds,id,full_name,hash);
end;
/////////////////////////
export denormAliases(dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases})) infile) := function
pAlias := 
				project(infile,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.aka_rollup},
						self.id := left.id;
						self.aka := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases); 
																			)
								);
														
	pAlias rollRecs(pAlias L, pAlias R) := transform
		self.id  := L.id;
		self.aka := L.aka + row({R.aka[1].type,
							 R.aka[1].category,
							 R.aka[1].first_name,
							 R.aka[1].middle_name,
							 R.aka[1].last_name,
							 R.aka[1].generation,
							 R.aka[1].full_name,
							 R.aka[1].comments
		 },Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_aliases);
	end;
//OUTPUT('denormAliases');
//OUTPUT(infile(id='39676'),OVERWRITE,named('deInfile'));
//OUTPUT(pAlias(id='39676'),OVERWRITE,named('deAlias'));
	return
		rollup(sort(distribute(pAlias,hash(id)),id,local), id, rollRecs(left, right),local);
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Citizenship
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export normCitizenship(dataset(Accuity.Layouts.input.rEntity) infile) := function

tbl := table(infile, 
						{integer citizenshipCount := count(citizenships), 
						infile});
return
dedup(normalize(tbl,left.citizenshipCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
								self.id 			:= left.id;
								self.type			:= 'Citizenship';
								self.information	:= left.citizenships[counter].citizenship;
								self.Parsed     	:= '';
								self.comments	    := '';
							)
						),record,all);
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: DOBs
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export normDOB(dataset(Accuity.Layouts.input.rEntity) infile) := function
													 
	tbl_dob := table(infile, 
							{integer dobCount := count(DOBs), 
							infile});

	ds1 := normalize(tbl_dob,left.dobcount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
		string dob := (string)left.DOBs[counter].dob; 
		self.id 			:= left.id;
		self.Type 			:= 'DOB';	//'Date of Birth'; 
		self.Information	:= dob;
		//self.Parsed			:= TRIM(precleanDate(dob));
		self.Parsed			:= IF(Dates.HasDateRange(dob), '', TRIM(Dates.ParseBirthday(dob)));
		self.Comments		:= if(regexfind('[a-zA-Z]',dob),dob,'');
					)
		)(Parsed !='0000/00/00');
		
	{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo} AddRanges(
				{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo} L, integer c) := TRANSFORM
		dob := Dates.dobRange1(l.Information);
		mdob := Dates.dobRange2(l.Information);
		self.id := IF(dob + c - 1 > mdob,SKIP,L.id);
		self.Information := INTFORMAT(dob + c - 1, 4, 1);
		self.Parsed := self.Information + '/00/00';
		self.Comments := l.Information;
		self := L;
	END;
	
	// compute date ranges
	ds2 := normalize(ds1(Dates.deltaRange(Information)>1), 10, AddRanges(LEFT, COUNTER));
/*		transform(,
		string dob := 		dobRange1; 
		self.id 			:= left.id;
		self.Type 			:= 'DOB';	//'Date of Birth'; 
		self.Information	:= dob;
		self.Parsed			:= TRIM(precleanDate(dob));
		self.Comments		:= if(regexfind('[a-zA-Z]',dob),dob,'');
					)
		);
*/
	ds := SORT(IF(EXISTS(ds2), ds1 + ds2, ds1),id,parsed);
//OUTPUT(infile(id='375395'));
//OUTPUT(tbl_dob(id='375395'));
//OUTPUT(ds(id='375395'),OVERWRITE,named('ds'));
	return ds;
end;

/////////////////////////
export denormDob(dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo})) infile) := function
	pDob := 
				project(dedup(infile,record,all),transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.addlinfo_rollup},
						self.id := left.id;
						self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo); 
				)
			);
														
	pDob rollRecs(pDob L, pDob R) := transform
	self.id  := L.id;
	self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
							R.additionalinfo[1].information,
							R.additionalinfo[1].parsed,
							R.additionalinfo[1].comments
		},Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo);
	end;
	return
		rollup(sort(distribute(pDob,hash(id)),id,local), id, rollRecs(left, right),local);
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Routing Codes
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export normRoutingCodes(dataset(Accuity.Layouts.input.rEntity) infile) := function							
	tbl_RoutingCodes := table(infile, 
						{integer RoutingCodesCount := count(RoutingCodes), 
						infile});
	return
		dedup(normalize(tbl_RoutingCodes,left.RoutingCodesCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp},
					self.id 			:= left.id;
					self.type			:= Conversions.ConvertRoutingCode(
												left.RoutingCodes[counter].routing_type); 
					self.number	:= left.RoutingCodes[counter].routing_code;		
					self.comments		:= left.RoutingCodes[counter].routing_type + ' :  ' + left.RoutingCodes[counter].routing_code;
					self := [];
				)
			)
	,record,all);
end;

string FixMonth(string s) := FUNCTION
	inmon := REGEXFIND('\\d+ +([A-Z.]+) +\\d+',s,1,NOCASE);
	outmon := CASE(stringlib.stringtolowercase(inmon),
		'janvier' => 'January',
		'fevrier' => 'February',
		'fÃƒÂ©vrier' => 'February',
		'mars' => 'March',
		'avril' => 'April',
		'mai' => 'May',
		'juin' => 'June',
		'aout' => 'August',
		'aoÃƒÂ»t' => 'August',
		'septembre' => 'September',
		'octobre' => 'October',
		'novembre' => 'November',
		'dccembre' => 'December',
		'dÃƒÂ©cembre' => 'December',
		'sept' => 'September',
		'sept.' => 'September',
		'');

	return if(outmon='',s,
			StringLib.StringFindReplace(s,' '+inmon+' ',' '+outmon+' '));
END;

GetCentury(string pDateIn) := FUNCTION
	year := (integer)REGEXFIND('/([0-9]+)$', pDateIn, 1);
	return 
		IF(year < 20,'20','19');
END;

CorrectCentury(string pDateIn) :=
	IF(REGEXFIND('/([0-9]+)$', pDateIn, 1) = '200',pDateIn + '0',pDateIn);


FixSlashCentury(string pDateIn) := 
	MAP(
		REGEXFIND('/\\d{1}$',pDateIn) => 
			REGEXREPLACE('/(\\d{1})$',pDateIn,'/'+GetCentury(pDateIn)+'0$1'),
		REGEXFIND('/\\d{2}$',pDateIn) => 
			REGEXREPLACE('/(\\d{2})$',pDateIn,'/'+GetCentury(pDateIn)+'$1'),
		pDateIn);




rgxIssue1 := '(Issued On|Issued On:|Date of Issue:|DELIVRE LE|DATE D\'EMISSION:|expedido el|expedido en [A-Z]+ el|expedido) (.+)';	
rgxIssue2x := 'Issued in [A-Z, ]+ +expired';	
rgxIssue2 := 'Issued in [A-Z ,]+ on (.+)';	
rgxIssue3 := 'Issued (.+)';	
string ExtractIssueDate(string s) := MAP(

		REGEXFIND(rgxIssue1,s,NOCASE) => 
			Dates.cvtDate(REGEXFIND(rgxIssue1, s, 2, NOCASE)),
		REGEXFIND(rgxIssue2x,s,NOCASE) => '',	//false alarm	
		REGEXFIND(rgxIssue2,s,NOCASE) => 
			Dates.cvtDate(REGEXFIND(rgxIssue2, s, 1, NOCASE)),
		REGEXFIND('Issued (by|in)',s,NOCASE) => '',	//false alarm	
		REGEXFIND(rgxIssue3,s,NOCASE) => 
			Dates.cvtDate(REGEXFIND(rgxIssue3, s, 1, NOCASE)),
	'');


rgxExpiry1 := '(expires|expiring|expired|expiration|valid until|valid til|date d\'expiration|expiro|valido hasta|EXPIRADO|expira|expiry|expire le)( on| date| el)?(:|;)? (.+)';

string ExtractExpiryDate(string s) := FUNCTION
		
	return IF(REGEXFIND(rgxExpiry1,s,NOCASE),
				Dates.CvtDate(REGEXFIND(rgxExpiry1,s,4,NOCASE)),
				'');
END;

ExtractIssuedBy(string s) := MAP(
		REGEXFIND('issued by (.+) on\\b',s,NOCASE) => REGEXFIND('issued by (.+) on\\b',s,1,NOCASE),	
		REGEXFIND('issued by (.+)\\.',s,NOCASE) => REGEXFIND('issued by (.+)\\.',s,1,NOCASE),	
		REGEXFIND('issued by (.+)$',s,NOCASE) => REGEXFIND('issued by (.+)$',s,1,NOCASE),	
		'');
		
rgxID := '^([A-Z0-9-]+) +\\(';
TrimId(string id) := TRIM(
	IF(REGEXFIND(rgxID, id), REGEXFIND(rgxID,id,1),id),LEFT,RIGHT);


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Identifications
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

HasLeftParen(string s) :=
	REGEXFIND('\\((.+)$', s);
	
GetLeftParen(string s) :=
	REGEXFIND('\\((.+)$', s, 1);
	
RemoveLeftParen(string s) :=
	stringlib.StringCleanSpaces(TRIM(REGEXREPLACE('(\\(.+)$', s, ''),LEFT,RIGHT));



cleanIdNumber(string s) := MAP(
	REGEXFIND('^([0-9A-Z-]+),',s,NOCASE) => REGEXFIND('^([0-9A-Z-]+),',s,1,NOCASE),
	REGEXFIND('^([0-9A-Z-]+) issued.+',s,NOCASE) => REGEXFIND('^([0-9A-Z-]+)',s,1,NOCASE),
	HasLeftParen(s) => RemoveLeftParen(s),
	Persons.HasParen(s) => Persons.RemoveParen(s),
	s);
	
cleanIdComments(string s) := MAP(
	REGEXFIND('^([0-9A-Z-]+),',s,NOCASE) => REGEXREPLACE('^([0-9A-Z-]+,)',s,'',NOCASE),
	REGEXFIND('^([0-9A-Z-]+) issued.+',s,NOCASE) => TRIM(REGEXREPLACE('^([0-9A-Z-]+)',s,'',NOCASE),LEFT,RIGHT),
	Persons.HasParen(s) => Persons.GetParen(s),
	HasLeftParen(s) => GetLeftParen(s),
	'');
	

ExtractIssueDate2(string s1, string s2) := FUNCTION
	issue1 := ExtractIssueDate(s1);
	return if(issue1<>'',issue1,ExtractIssueDate(s2));
END;

ExtractExpiryDate2(string s1, string s2) := FUNCTION
	issue1 := ExtractExpiryDate(s1);
	return if(issue1<>'',issue1,ExtractExpiryDate(s2));
END;
		
export normIDs(dataset(Accuity.Layouts.input.rEntity) infile) := function

	tbl_id := table(infile, 
						{integer idCount := count(Identifications), 
						infile});
	ids := normalize(tbl_id,left.idCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp},
				self.id 	:= TrimId(left.id);
				idtype 		:= 	left.identifications[counter].id_type;
				self.type				:= Conversions.ConvertIDType(idtype);
				self.label				:= Conversions.ConvertIDTypeToLabel(idtype);	// original type
				idnum := left.identifications[counter].id;
				self.number				:= cleanIdNumber(idnum);
				s := left.identifications[counter].other_info;
				self.issued_by		:= ExtractIssuedBy(s);
				self.date_issued	:= ExtractIssueDate2(s,idnum);
				self.date_expires	:= ExtractExpiryDate2(s,idnum);
				extraComment := 	cleanIdComments(idnum);
				extraComment1 := 	Conversions.ConvertIDTypeToComment(idtype);
				self.comments		:= Concat3(left.identifications[counter].other_info,extraComment,extraComment1);
			)
		);
    routingCodes := normRoutingCodes(infile);
	return dedup(ids+routingCodes,record,all);
end;

/////////////////////////
export denormIds(dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp})) infile) := function
	pID := 
			project(infile,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.id_rollup},
					self.id := left.id;
					self.identification := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp); 
										)
				);
														
	pID rollRecs(pID L, pID R) := transform
	self.id  := L.id;
	self.identification:= L.identification + row({R.identification[1].type,
												R.identification[1].label,
												R.identification[1].number,
												R.identification[1].issued_by,
												R.identification[1].date_issued,
												R.identification[1].date_expires,
												R.identification[1].comments
	 },Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_sp);
	end;
	return
		rollup(sort(distribute(pId,hash(id)),id,local), id, rollRecs(left, right),local);
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Nationalities
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export normNationality(dataset(Accuity.Layouts.input.rEntity) infile) := function

tbl := table(infile, 
						{integer nationalityCount := count(Nationalities), 
						infile});
return
dedup(normalize(tbl,left.nationalityCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
									self.id 					:= left.id;
									self.type					:= 'Nationality';
									self.information	:= left.Nationalities[counter].nationality;
									self.Parsed       := '';
									self.comments	    := '';
							)
					),record,all);
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Phones
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

export normPhones(dataset(Accuity.Layouts.input.rEntity) infile) := function

	tbl := table(infile, 
						{integer phoneCount := count(Additional_Info), 
						infile});
	children := dedup(
		normalize(tbl,left.phoneCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_phones},
							s := TRIM(left.Additional_Info[counter].sdf_value,Left,Right);
							self.type			:= IF(Phones.GetPhone(left.Additional_Info[counter].sdf_name,s)<>'',
						//	left.Additional_Info[counter].sdf_name
											Phones.GetPhoneType(left.Additional_Info[counter].sdf_name,s)
											,SKIP);
							self.id 			:= left.id;
							self.address_id		:= '';
							self.number			:= Phones.GetPhone(left.Additional_Info[counter].sdf_name,s);
							self.comments		:= s;
							)
					//),record,all);
					),record,all);
//output(infile(id='62534'));
//output(count((infile(id='62534').Additional_Info)));
//output(tbl(id='62534'));
//output(children(id='62534'));
	return children;
end;
/////////////////////////
export denormPhones(dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_phones})) infile) := function
	pPhones := 
				project(infile,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.phones_rollup},
						self.id := left.id;
						self.phones := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_phones); 
					)
				);
														
	pPhones rollRecs(pPhones L, pPhones R) := transform
		self.id  := L.id;
		self.phones := L.phones  + row({	R.phones [1].type,
									R.phones [1].address_id,
									R.phones [1].number,
									R.phones [1].comments
								},Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_phones);
	end;

	ds1 := sort(distribute(pPhones,hash(id)),id,local);
	ds :=	rollup(ds1, id, rollRecs(left, right),local);
//output(pPhones(id='31721'));
//output(ds1(id='31721'));
//output(ds(id='31721'));
	return ds;
end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: POBs
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export normPOB(dataset(Accuity.Layouts.input.rEntity) infile) := function
													 
	tbl_pob := table(infile, 
						{integer pobCount := count(POBs), 
						infile});
	return
		dedup(normalize(tbl_pob,left.pobcount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
											self.id 				:= left.id;
											self.Type 			:= 'PlaceOfBirth'; 
											self.Information	:= left.POBs[counter].pob;
											self.Parsed			:= '';
											self.Comments		:= '';
									)
							),record,all);
end;

/////////////////////////
export denormPob(dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo})) infile) := function
	pPob := 
			project(infile,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.addlinfo_rollup},
					self.id := left.id;
					self.additionalinfo := row(left, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo); 
				)
			);
														
	pPob rollRecs(pPob L, pPob R) := transform
		self.id  := L.id;
		self.additionalinfo:= L.additionalinfo + row({R.additionalinfo[1].type,
												R.additionalinfo[1].information,
												R.additionalinfo[1].parsed,
												R.additionalinfo[1].comments
					 },Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo);
	end;
	return
		rollup(sort(distribute(pPob,hash(id)),id,local), id, rollRecs(left, right),local);
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT CHILD RECORDS: Programs 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export normPrograms(dataset(Accuity.Layouts.input.rEntity) infile) := function
// creates a pseudo record of 'Program'
	tbl := table(infile, 
						{integer progCount := count(Programs), 
						infile});

	return
		dedup(normalize(tbl,left.progCount,transform({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
										self.id 			:= left.id;
										self.type			:= 'Program';
										self.information	:= left.Programs[counter].program_desc;
										self.Parsed       := '';
										self.comments	    := left.Programs[counter].program_type;
									)
							),record,all);
end;



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//FORMAT PARENT RECORDS: Entity
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

	gender_type := ['Gender','GENDER'];
GetGender(string rtype, string info) := MAP(
	rtype in gender_type and info[1]='M' => 'Male',
	rtype in gender_type and info[1]='F' => 'Female',
	REGEXFIND('\\bMALE\\b',info,NOCASE) => 'Male',
	REGEXFIND('\\bFEMALE\\b',info,NOCASE) => 'Female',
	REGEXFIND('\\bfils (de|du)\\b',info,NOCASE) => 'Male',
	REGEXFIND('\\bfille (de|du)\\b',info,NOCASE) => 'Female',
	REGEXFIND('\\b(son|husband|brother) of\\b',info,NOCASE) => 'Male',
	REGEXFIND('\\b(daughter|wife|sister) of\\b',info,NOCASE) => 'Female',
	REGEXFIND('\\bSEX: M',info,NOCASE) => 'Male',
	REGEXFIND('\\bSEX: F',info,NOCASE) => 'Female',
	REGEXFIND('\\bSEXE: M',info,NOCASE) => 'Male',
	REGEXFIND('\\bSEXE: F',info,NOCASE) => 'Female',
	'');
	
idtypes := ['OriginalID'];
GetOriginalID(string rtype, string info) := IF(rtype in idtypes, info, '');

normPgm(dataset(Accuity.Layouts.input.rEntity) infile) := function
													 
	tbl_addr := table(infile, 
							{integer pgmCount := count(programs), 
							infile});
	ttl :=	SORT(DISTRIBUTE(normalize(tbl_addr,left.pgmCount,transform({string id,string program},
								self.id 			:= left.id;
								self.program 	:= left.programs[counter].program_desc;
							)),hash(id)), id, local);
	{string id,string program} rollPgms({string id,string program} L, {string id,string program} R) := TRANSFORM
		self.program := IF(L.program='',R.program,
							IF(trim(R.program)='',L.program, L.program + '; ' + R.program));
		self := L;
	END;
	tds := rollup(ttl, left.id=right.id, rollPgms(LEFT,RIGHT),LOCAL);
	//title := IF(EXISTS(tds),tds[1].title,'');

	return tds;
end;

string GetPgms(dataset(Accuity.Layouts.input.crPrograms) pgms) := FUNCTION
	return '';
END;

normTitles(dataset(Accuity.Layouts.input.rEntity) infile) := function
													 
	tbl_addr := table(infile, 
							{integer titleCount := count(titles), 
							infile});
	ttl :=	SORT(DISTRIBUTE(normalize(tbl_addr,left.titleCount,transform({string id,string title,boolean isPerson},
								self.id 			:= left.id;
								self.title 			:= left.Titles[counter].title;
								self.isPerson		:= Conversions.IsPersonCode(left.type);
							)),hash(id)), id, local);
	{string id,string title,boolean isPerson} rolltitles({string id,string title,boolean isPerson} L, {string id,string title,boolean isPerson} R) := TRANSFORM
		sep := IF(L.isPerson,'; ',' | ');
		self.title := IF(L.title='',R.Title,
								IF(R.title='', L.title, L.title + sep + R.title));
		self := L;
	END;
	tds := rollup(ttl, left.id=right.id, rolltitles(LEFT,RIGHT),LOCAL);
	//title := IF(EXISTS(tds),tds[1].title,'');

	return tds;
end;

normRelatedEntities(dataset(Accuity.Layouts.input.rEntity) infile) := function
													 
	tbl_addr := table(infile, 
							{integer relatedEntityCount := count(Additional_Info), 
							infile});
	ttl :=	SORT(DISTRIBUTE(normalize(tbl_addr,left.relatedEntityCount,transform({string id,string relation},
								self.id 			:= if(left.Additional_Info[counter].sdf_name='RelatedEntities',left.id,SKIP);
								self.relation 		:= left.Additional_Info[counter].sdf_value;
							)),hash(id)), id, local);
	{string id,string relation} rollrelations({string id,string relation} L, {string id,string relation} R) := TRANSFORM
		sep := '| ';
		self.relation := Concat(L.relation,R.relation);
		self := L;
	END;
	tds := rollup(ttl, left.id=right.id, rollrelations(LEFT,RIGHT),LOCAL);
	//title := IF(EXISTS(tds),tds[1].title,'');

	return tds;
end;

export mapEntity(dataset(Accuity.Layouts.input.rEntity) infile_parent, dataset({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo}) infile_child) := function

	Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp trecs(infile_parent L,infile_child R) := transform
			self.id 					:= L.id;
			self.accuityDataSource		:= L.source+' '+L.list_id;
			self.type					:= Conversions.EtypeCodetoDescr(L.type);
			self.Entity_Unique_ID		:= 'AC' + L.id;		// 117791
			self.title 					:= '';
			cln_name := IF(Conversions.IsPersonCode(L.type), Persons.CleanName(L.full_name), '');
			self.first_name 			:= TRIM(cln_name[6..55],LEFT,RIGHT);
			self.middle_name 			:= TRIM(cln_name[56..105],LEFT,RIGHT);
			self.last_name 				:= TRIM(cln_name[106..155],LEFT,RIGHT);
			self.generation 			:= TRIM(cln_name[156..161],LEFT,RIGHT);
			self.full_name				:= if(Conversions.IsPersonCode(L.type) AND cln_name <> '',
									TRIM(stringlib.StringCleanSpaces(cln_name),LEFT,RIGHT),
									//TRIM(L.full_name,LEFT,RIGHT),
									TRIM(L.full_name,LEFT,RIGHT));
			self.gender 				:= IF(L.id = R.id,GetGender(R.type, R.information),'');
			self.listed_date 			:= L.listed_date;
			self.modified_date 		:= L.last_updated;
			self.entity_added_by 	:= '';
			//	L.source+' '+L.list_id+': '+Accuity.Conversions.SourceCodetoDescr(L.source+L.list_id);
			self.reason_listed 		:= '';
			self.reference_id 		:= GetOriginalID(R.type, R.information);
			
			self.comments := MAP(
				R.type IN ['Other','OtherInformation'] AND length(trim(R.information)) >= MinOtherLen
								=>				R.information,
				R.type = 'OtherInformation2' =>				R.information,
				//R.type IN ['RelatedEntities','Relationship'] => 'Associations: ' + R.information
				//R.type = 'RelatedEntities' => 'Associations: ' + R.information
				'');
			//self.comments := R.information;
			self := L;
			self := [];
	end;
	
		Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp fixup(
				Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp L,
				Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp R) := TRANSFORM
			self.gender := IF(R.gender<>'',R.gender,L.gender);
			self.reference_id := IF(trim(L.reference_id)='',R.reference_id, 
					IF(trim(R.reference_id)='',L.reference_id, L.reference_id + '; ' + R.reference_id));
			self.reason_listed := IF(trim(L.reason_listed)='',R.reason_listed, 
					IF(trim(R.reason_listed)='',L.reason_listed, L.reason_listed + '; ' + R.reason_listed));
			self.comments := IF(trim(L.comments)='',R.comments, 
					IF(trim(R.comments)='',L.comments, L.comments + ' | ' + R.comments));
			SELF := R;
		END;
		
		children := sort(distribute(infile_child(information !=''),hash(id)),id,type,LOCAL);
	
		j := join(distribute(infile_parent,hash(id)),children,
								left.id = right.id,
								trecs(left,right),left outer,local);
		
		j2 := rollup(sort(distribute(j,hash(id)),id,local),LEFT.id=RIGHT.id,fixup(LEFT,RIGHT),local);
		titles := normTitles(infile_parent);
		r1 := join(j2, titles, left.id=RIGHT.id, TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
					boolean isPerson := LEFT.type='Individual';
					SELF.title := if(isPerson,RIGHT.title,'');
					cmts := IF(isPerson,LEFT.comments,
						IF(Right.title='',left.Comments,Concat(LEFT.comments, 'Titles: | ' +RIGHT.title, ' || ')));
					self.comments := cmts;
					SELF := LEFT;), LEFT OUTER);
					
		relations := normRelatedEntities(infile_parent);
		r2 := join(r1, relations, left.id=RIGHT.id, TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
					rel := 'Associations: | ';
					self.comments := IF(right.relation='',LEFT.comments,
									Concat(LEFT.comments,rel + Right.relation,' || '));
					SELF := LEFT;), LEFT OUTER);

		pgms := normPgm(infile_parent);
		result := join(r2, pgms, left.id=RIGHT.id, TRANSFORM(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp,
					SELF.reason_listed := RIGHT.program;
					SELF := LEFT;), LEFT OUTER);
					
//OUTPUT('mapEntity');
//OUTPUT(infile_child(id = '62856'));
//OUTPUT(children(id = '39252'));
//OUTPUT(j2(id = '22260'));
//OUTPUT(relations(id = '164890'));
//OUTPUT(titles(id='520907'));
		return result;
end;

		
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//LINK PARENT RECORDS w/CHILDREN
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
export linkAddl(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.AddlInfo_rollup})) infile_child):= function
	infile_parent cmbnRecs(infile_parent L, infile_child R) := transform
		self.additional_info_list.additionalinfo := R.additionalinfo;
		self := L;
	end;

	return
		join(distribute(infile_parent,hash(id))
							,distribute(infile_child,hash(id)),
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);							
end;
//////////////////////////////////////////////////////////////////
export linkAddr(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.addr_rollup})) infile_child):= function
	infile_parent cmbnRecs(infile_parent L, infile_child R) := transform
		self.address_list.address := R.address;
		self := L;
	end;

	return
		join(distribute(infile_parent,hash(id))
							,distribute(infile_child,hash(id)),
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);							
end;


//////////////////////////////////////////////////////////////////

//integer daynum(string dt) := ut.DayOfYear((integer4)dt[1..4],(integer1)dt[5..6],(integer1)dt[7..8]);
integer daynum(string dt) := 100*(integer1)dt[5..6]+(integer1)dt[7..8];

		
integer AgeAsOf(string birthday) := FUNCTION
	dob := dates.FixBirthday(birthday);	// yyyymmddd
	rightnow := GetDate;
	yrs := (integer4)(rightnow[1..4]) - (integer4)(dob[1..4]);
	daysapart := IF(daynum(rightnow) >= daynum(dob),1,-1);
	return MAP(
		dob = '' => 0,
		daysapart < 0 => yrs - 1,
		yrs
	);
END;

export linkAge(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo})) infile_child):= function
	infile_parent cmbnRecs(infile_parent L, infile_child R) := 
		transform
			Age_as_of_date:= GetDate[1..4] +'/'+ GetDate[5..6]+'/' + GetDate[7..8];
			Age_as_of_date_comment:= 'as of '+Age_as_of_date;
			unsigned Age 	:= AgeAsOf(R.information);

			Age_comment	:= if(Age<>0, 
							'Age: '+Age+' '+age_as_of_date_comment,'');

			self.comments := IF(trim(L.comments)='',R.comments, 
					IF(trim(R.comments)='',L.comments, L.comments + ' || ' + R.comments));
			self := L;
		end;
		
	withdob := DISTRIBUTE(PROJECT(infile_child(NOT Dates.HasDateRange(information),AgeAsOf(information) <> 0), 
					TRANSFORM({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo},
							Age_as_of_date:= GetDate[1..4]+'/'+ GetDate[5..6]+'/' + GetDate[7..8];
							Age_as_of_date_comment:= 'as of '+Age_as_of_date;
							unsigned Age 	:= AgeAsOf(LEFT.information);

							Age_comment	:= if(Age between 1 and 120, 
											'Age: '+Age+' '+age_as_of_date_comment,'');

							self.comments :=  Age_comment;
							self := LEFT;
						)),hash(id));
						
	{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo} rolldb(
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo} L,
		{string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.layout_addlinfo} R) := TRANSFORM
			self.comments := IF(trim(L.comments)='',R.comments, 
					IF(trim(R.comments)='',L.comments, L.comments + ' | ' + R.comments));
			self := L;
	END;
						
	withdob1 := ROLLUP(SORT(withdob,id,LOCAL), LEFT.id=RIGHT.id, rolldb(LEFT, RIGHT), LOCAL);

	ds :=	join(distribute(infile_parent,hash(id))
							,withdob1,
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);							
//OUTPUT(infile_child(id='375395'));
//OUTPUT(withdob(id='375395'));
//OUTPUT(withdob1(id='375395'));
//OUTPUT(ds(id='375395'));
	return ds;
end;

//////////////////////////////////////////////////////////////////
export linkAlias(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.aka_rollup})) infile_child):= function
	infile_parent cmbnRecs(infile_parent L, infile_child R) := transform
		self.aka_list.AKA := R.AKA;
		self := L;
	end;

	return
		join(distribute(infile_parent,hash(id))
							,distribute(infile_child,hash(id)),
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);
							
end;

//////////////////////////////////////////////////////////////////
export linkDob(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.AddlInfo_rollup})) infile_child):= function
	infile_parent cmbnRecs(infile_parent L, infile_child R) := transform
		self.additional_info_list.additionalinfo := R.additionalinfo;
		self := L;
	end;

	return
		join(distribute(infile_parent,hash(id))
							,distribute(infile_child,hash(id)),
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);							
end;

//////////////////////////////////////////////////////////////////
export linkID(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.id_rollup})) infile_child):= function
infile_parent cmbnRecs(infile_parent L, infile_child R) := transform
		self.identification_list.identification := R.identification;
		self := L;
	end;

	return
		join(distribute(infile_parent,hash(id))
							,distribute(infile_child,hash(id)),
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);							
end;

//////////////////////////////////////////////////////////////////
export linkPhone(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id, Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.phones_rollup})) infile_child):= function
		infile_parent cmbnRecs(infile_parent L, infile_child R) := transform
			self.phone_number_list.phones := R.phones;
			self := L;
		end;

		ds := join(distribute(infile_parent,hash(id))
							,distribute(infile_child,hash(id)),
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);
//output('linkPhone');							
//output(infile_parent(id='31721'));
//output(infile_child(id='31721'));
//output(ds(id='31721'));
		return ds;
end;

//////////////////////////////////////////////////////////////////
export linkPob(dataset(recordof(Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.routp)) infile_parent,
					dataset(recordof({string id,Worldcheck_Bridger.Layout_Worldcheck_Entity_Exported.AddlInfo_rollup})) infile_child):= function
		infile_parent cmbnRecs(infile_parent L, infile_child R) := transform
			self.additional_info_list.additionalinfo := R.additionalinfo;
			self := L;
		end;

		return
				join(distribute(infile_parent,hash(id))
							,distribute(infile_child,hash(id)),
							left.id = right.id,
							cmbnRecs(left,right),left outer,local);							
	end;
end;