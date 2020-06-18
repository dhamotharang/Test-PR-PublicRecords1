import	STD, Address, Nid, ut, _validate;

		integer YYYYMMDDToDays(string pInput) := 
									 (((integer)(pInput[1..4])*365) + ((integer)(pInput[5..6])*30)+ ((integer)(pInput[7..8])));


EXPORT proc_CleanClients(dataset(layouts2.rClientEx) clients) := FUNCTION


	base := PROJECT(DISTRIBUTE(clients, hash32(clientid,caseid)), TRANSFORM(layouts2.rClientEx,
									SELF.Prepped_Name := Address.NameFromComponents(
										StandardizeName(left.FirstName)
										,StandardizeName(left.MiddleName)
										,StandardizeName(left.LastName)
										,StandardizeName(left.NameSuffix)
										);
										
									SELF.clean_dob                := if(left.dobType = Mod_sets.Actual_Type
																								,(unsigned)_validate.date.fCorrectedDateString(left.DOB,false)
																								,0);

									today := YYYYMMDDToDays((string8)STD.Date.Today());

									SELF.age:=if(SELF.clean_dob>0,(integer)((today - YYYYMMDDToDays((string)SELF.clean_dob)) / 365),-999);

									Client_SSN		                := if(left.ssnType = NAC_V2.Mod_Sets.Actual_Type
																										and length(regexreplace('[^0-9]',left.SSN,''))=9
																										,left.SSN
																										,'');
									SELF.clean_ssn                := if((unsigned)Client_SSN > 0,if(Client_SSN in ut.Set_BadSSN ,'',Client_SSN), '');
										
									self := LEFT;
									self := [];
							));

//<tkirk-start/////////////////////////////////////////////////////////
	UniqueNames := dedup(table(base,{Prepped_name,Gender,prefname
										,title,fname,mname,lname,name_suffix,FirstName,MiddleName,LastName}),
										Prepped_name,Gender,all);
///////////////////////////////////////////////////////////
fPrepRawForComparison(string pName) :=
function
	string		lNoHyphenOnly		:=	if(trim(pName) = '-', '', pName);
	string		lNoSpacedHyphen	:=	regexreplace(' *\\-+ *', lNoHyphenOnly, '-');
	string		lUpperCaseTrim	:=	trim(Std.Str.ToUpperCase(lNoSpacedHyphen));
	string		lNoCommaPeriod	:=	Std.Str.Translate(lUpperCaseTrim, '.,', '  ');
	string		lCleanSpaces		:=	Std.Str.CleanSpaces(lNoCommaPeriod);
	string		lCharsOnly			:=	Std.Str.Filter(lCleanSpaces, ' -ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	return	lCharsOnly;
end;

fCleanisBad(string pFirstName, string pMiddleName, string pLastName, string pfname, string pmname, string plname, string pname_suffix) :=
function
	return	((Std.str.CountWords(pFirstName, ' ', false) = 1 and pFirstName <> pfname)
					 or trim(pFirstName) + trim(' ' + pMiddleName) <> trim(pfname) + trim(' ' + pmname)
					)
			or	(pLastName <> plname and (pname_suffix <> '' and plname <> pLastName[1..(length(trim(plname)))]));
end;

///////////////////////////////////////////////////////////
{UniqueNames} tCleanNamesFML1(UniqueNames l) := transform
	lOrigCleanName						:=	Address.CleanNameFields(Address.CleanPersonFML73(l.Prepped_Name)).CleanNameRecord;
	self											:=	lOrigCleanName;
	self											:=l;
end;

UniqueNamesCleanFML1:=nofold(project(UniqueNames,tCleanNamesFML1(left)));
///////////////////////////////////////////////////////////
{UniqueNames} tCleanNamesFML2(UniqueNames l) := transform
	lRawFirstCompare					:=	fPrepRawForComparison(l.FirstName);
	lRawMiddleCompare					:=	fPrepRawForComparison(l.MiddleName);
	lRawLastCompare						:=	fPrepRawForComparison(l.LastName);
	lIsOrigFMLBad							:=	fCleanisBad(lRawFirstCompare, lRawMiddleCompare, lRawLastCompare, l.fname, l.mname, l.lname, l.name_suffix);
	lIsFNameRemoved						:=	Std.Str.Find(l.fname + l.mname + l.lname, trim(lRawFirstCompare), 1) = 0;
	lIsLNameRemoved						:=	Std.Str.Find(l.fname + l.mname + l.lname, trim(lRawLastCompare), 1) = 0;
	lIsMNamePushedToLName			:=	lRawMiddleCompare = Std.Str.GetNthWord(l.lname, 1) and l.mname = '';//and lRawMiddleCompare not in ['O', 'D'];
	lIsLNameSplitIntoMName		:=	lRawMiddleCompare	= '' and l.mname = Std.Str.GetNthWord(lRawLastCompare, 1) and Std.Str.WordCount(lRawLastCompare) > Std.Str.WordCount(l.lname); 

	lFML2Prepped							:=	trim(if(lIsFNameRemoved,'ZZZ','') + lRawFirstCompare) + if(Std.Str.WordCount(lRawFirstCompare) > 1,'ZZZ','') + trim(' ' + if(lIsMNamePushedToLName,'ZZZ','') + Std.Str.FindReplace(trim(lRawMiddleCompare), ' ', 'YYY')) + trim(' ' + if(lIsLNameRemoved,'ZZZ','') + Std.Str.FindReplace(trim(lRawLastCompare), ' ', 'YYY'));
	lFML2CleanName						:=	iff(lIsOrigFMLBad, Address.CleanNameFields(Address.CleanPersonFML73(lFML2Prepped)).CleanNameRecord, transfer((string73)'', recordof(Address.Layout_Clean_Name))); 

	//self.Prepped_Name					:=	if(lIsOrigFMLBad, lFML2Prepped, l.Prepped_Name);
	self.fname								:=	if(lIsOrigFMLBad, Std.Str.FindReplace(lFML2CleanName.fname, 'ZZZ', ''), l.fname);
	self.mname								:=	if(lIsOrigFMLBad, Std.Str.FindReplace(Std.Str.FindReplace(lFML2CleanName.mname, 'YYY', ' '), 'ZZZ', ''), l.mname);
	self.lname								:=	if(lIsOrigFMLBad, Std.Str.FindReplace(Std.Str.FindReplace(lFML2CleanName.lname, 'YYY', ' '), 'ZZZ', ''), l.lname);
	self.name_suffix					:=	if(lIsOrigFMLBad, Std.Str.FindReplace(lFML2CleanName.name_suffix, 'ZZZ', ''), l.name_suffix);
////////////////////////////////////////////////////
	self.title								:=	if(lIsOrigFMLBad, 'FML2', 'FML');	// tkirk-signal to next project will know we cleaned FML2
	self											:=	l;
end;

UniqueNamesCleanFML2:=nofold(project(UniqueNamesCleanFML1,tCleanNamesFML2(left)));
///////////////////////////////////////////////////////////
{UniqueNames} tCleanNamesLFM(UniqueNames l) := transform
	lRawFirstCompare					:=	fPrepRawForComparison(l.FirstName);
	lRawMiddleCompare					:=	fPrepRawForComparison(l.MiddleName);
	lRawLastCompare						:=	fPrepRawForComparison(l.LastName);

	lIsFML2CleanNameBad				:=	l.title = 'FML2' and fCleanisBad(lRawFirstCompare, lRawMiddleCompare, lRawLastCompare, l.fname, l.mname, l.lname, l.name_suffix);
	lIsFML2FNameRemoved				:=	Std.Str.Find(l.fname + l.mname + l.lname, trim(lRawFirstCompare), 1) = 0;
	lIsFML2LNameRemoved				:=	Std.Str.Find(l.fname + l.mname + l.lname, trim(lRawLastCompare), 1) = 0;
	lIsMNamePushedToLName			:=	lRawMiddleCompare = Std.Str.GetNthWord(l.lname, 1) and l.mname = '';//and lRawMiddleCompare not in ['O', 'D'];
	lIsFML2BrokenMultiLName		:=	Std.Str.CountWords(lRawFirstCompare, ' ', false) > Std.Str.CountWords(trim(l.lname) + ' ' + l.name_suffix, ' ', false);

	lLFMPrepped								:=	trim(if(lIsFML2LNameRemoved, 'ZZZ', '') + lRawLastCompare) + ', ' + trim(if(lIsFML2FNameRemoved, 'ZZZ', '') + lRawFirstCompare + trim(' ' + if(lIsMNamePushedToLName,'ZZZ','') + lRawMiddleCompare));
	lLFMCleanName							:=	iff(lIsFML2CleanNameBad, Address.CleanNameFields(Address.CleanPersonFML73(lLFMPrepped)).CleanNameRecord, transfer((string73)'', recordof(Address.Layout_Clean_Name))); 

	//self.Prepped_Name					:=	if(lIsFML2CleanNameBad, lLFMPrepped, l.Prepped_Name);
	self.fname								:=	if(lIsFML2CleanNameBad, Std.Str.FindReplace(lLFMCleanName.fname, 'ZZZ', ''), l.fname);
	self.mname								:=	if(lIsFML2CleanNameBad, Std.Str.FindReplace(lLFMCleanName.mname, 'ZZZ', ''), l.mname);
	self.lname								:=	if(lIsFML2CleanNameBad, Std.Str.FindReplace(lLFMCleanName.lname, 'ZZZ', ''), l.lname);
	self.name_suffix					:=	if(lIsFML2CleanNameBad, Std.Str.FindReplace(lLFMCleanName.name_suffix, 'ZZZ', ''), l.name_suffix);
////////////////////////////////////////////////////
	self.title       					:=	map(
																		l.Gender='M' => 'MR'
																		,l.Gender='F' => 'MS'
																		,'');
	self.prefname		  				:=	NID.PreferredFirstNew(self.fname);
	self											:=	l;
end;

	UniqueNamesClean1:=nofold(project(UniqueNamesCleanFML2,tCleanNamesLFM(left)));
////////////////////////////////////////////////////
	{UniqueNames} tCleanNamesNoLast(UniqueNames l) := transform
			self.lname := IF(l.lname='', l.LastName, l.lname);
			self.name_suffix := IF(l.lname='', '', l.name_suffix);
			self := l;
	end;
	UniqueNamesClean:=nofold(project(UniqueNamesClean1,tCleanNamesNoLast(left)));
////////////////////////////////////////////////////
	NamesAppended:=join(distribute(base, hash32(Prepped_name))
						,distribute(UniqueNamesClean,   hash32(Prepped_name))
								,   
								left.Prepped_name=right.Prepped_name
								and left.Gender=right.Gender
								,transform(NAC_V2.layouts2.rClientEx
									,self.title       := right.title
									,self.fname       := right.fname
									,self.mname       := right.mname
									,self.lname       := right.lname
									,self.name_suffix := right.name_suffix
									,self.prefname    := right.prefname
									,self:=left)
								,left outer
								,local);
////////////////////////////////////////////////////end-tkirk>

	WithName := NamesAppended;


	//OUTPUT(CHOOSEN(SORT(UniqueNamesCleanFML1,prepped_name),1000), named('UniqueNamesCleanFML1'));
	//OUTPUT(CHOOSEN(SORT(UniqueNamesCleanFML2,prepped_name),1000), named('UniqueNamesCleanFML2'));
	//OUTPUT(CHOOSEN(SORT(UniqueNamesClean1,prepped_name),1000), named('UniqueNamesClean1'));
	//OUTPUT(CHOOSEN(SORT(UniqueNamesClean,prepped_name),1000), named('UniqueNamesClean'));
	//OUTPUT(CHOOSEN(SORT(NamesAppended,prepped_name),1000), named('NamesAppended'));
	

	return WithName;
END;
