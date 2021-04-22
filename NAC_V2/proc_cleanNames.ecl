import ut, lib_stringlib,lib_fileservices,_control, address, NID, STD;

name_suffixes := $.Mod_Validation.suffix_set;
string FixSuffix(string sfx) := IF(sfx in name_suffixes, sfx, '');

EXPORT proc_cleanNames(dataset(layout_Base2) basein) := FUNCTION

	base := PROJECT(basein, TRANSFORM(Layout_Base2,
									SELF.Prepped_Name := Address.NameFromComponents(
										StandardizeName(left.FirstName)
										,StandardizeName(left.MiddleName)
										,StandardizeName(left.LastName)
										,FixSuffix(StandardizeName(left.NameSuffix))
										);
									self := LEFT;
							));

//<tkirk-start/////////////////////////////////////////////////////////
	UniqueNames := dedup(table(base,{Gender,Prepped_name,prefname
										,title,fname,mname,lname,name_suffix,FirstName,MiddleName,LastName}),
										Prepped_name,Gender,all);
///////////////////////////////////////////////////////////
fPrepRawForComparison(string pName) :=
function
	string		lNoHyphenOnly		:=	if(trim(pName) = '-', '', pName);
	string		lNoSpacedHyphen	:=	regexreplace(' *\\-+ *', lNoHyphenOnly, '-');
	string		lUpperCaseTrim	:=	trim(StringLib.StringToUpperCase(lNoSpacedHyphen));
	string		lNoCommaPeriod	:=	StringLib.StringTranslate(lUpperCaseTrim, '.,', '  ');
	string		lCleanSpaces		:=	StringLib.StringCleanSpaces(lNoCommaPeriod);
	string		lCharsOnly			:=	StringLib.StringFilter(lCleanSpaces, ' -ABCDEFGHIJKLMNOPQRSTUVWXYZ');
	return	lCharsOnly;
end;

fCleanisBad(string pFirstName, string pMiddleName, string pLastName, string pfname, string pmname, string plname, string pname_suffix) :=
function
	return	((StringLib.CountWords(pFirstName, ' ', false) = 1 and pFirstName <> pfname)
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
	lIsFNameRemoved						:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawFirstCompare), 1) = 0;
	lIsLNameRemoved						:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawLastCompare), 1) = 0;
	lIsMNamePushedToLName			:=	lRawMiddleCompare = StringLib.StringGetNthWord(l.lname, 1) and l.mname = '';//and lRawMiddleCompare not in ['O', 'D'];
	lIsLNameSplitIntoMName		:=	lRawMiddleCompare	= '' and l.mname = StringLib.StringGetNthWord(lRawLastCompare, 1) and StringLib.StringWordCount(lRawLastCompare) > StringLib.StringWordCount(l.lname); 

	lFML2Prepped							:=	trim(if(lIsFNameRemoved,'ZZZ','') + lRawFirstCompare) + if(StringLib.StringWordCount(lRawFirstCompare) > 1,'ZZZ','') + trim(' ' + if(lIsMNamePushedToLName,'ZZZ','') + StringLib.StringFindReplace(trim(lRawMiddleCompare), ' ', 'YYY')) + trim(' ' + if(lIsLNameRemoved,'ZZZ','') + StringLib.StringFindReplace(trim(lRawLastCompare), ' ', 'YYY'));
	lFML2CleanName						:=	iff(lIsOrigFMLBad, Address.CleanNameFields(Address.CleanPersonFML73(lFML2Prepped)).CleanNameRecord, transfer((string73)'', recordof(Address.Layout_Clean_Name))); 

	//self.Prepped_Name					:=	if(lIsOrigFMLBad, lFML2Prepped, l.Prepped_Name);
	self.fname								:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(lFML2CleanName.fname, 'ZZZ', ''), l.fname);
	self.mname								:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(StringLib.StringFindReplace(lFML2CleanName.mname, 'YYY', ' '), 'ZZZ', ''), l.mname);
	self.lname								:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(StringLib.StringFindReplace(lFML2CleanName.lname, 'YYY', ' '), 'ZZZ', ''), l.lname);
	self.name_suffix					:=	if(lIsOrigFMLBad, StringLib.StringFindReplace(lFML2CleanName.name_suffix, 'ZZZ', ''), l.name_suffix);
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
	lIsFML2FNameRemoved				:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawFirstCompare), 1) = 0;
	lIsFML2LNameRemoved				:=	StringLib.StringFind(l.fname + l.mname + l.lname, trim(lRawLastCompare), 1) = 0;
	lIsMNamePushedToLName			:=	lRawMiddleCompare = StringLib.StringGetNthWord(l.lname, 1) and l.mname = '';//and lRawMiddleCompare not in ['O', 'D'];
	lIsFML2BrokenMultiLName		:=	StringLib.CountWords(lRawFirstCompare, ' ', false) > StringLib.CountWords(trim(l.lname) + ' ' + l.name_suffix, ' ', false);

	lLFMPrepped								:=	trim(if(lIsFML2LNameRemoved, 'ZZZ', '') + lRawLastCompare) + ', ' + trim(if(lIsFML2FNameRemoved, 'ZZZ', '') + lRawFirstCompare + trim(' ' + if(lIsMNamePushedToLName,'ZZZ','') + lRawMiddleCompare));
	lLFMCleanName							:=	iff(lIsFML2CleanNameBad, Address.CleanNameFields(Address.CleanPersonFML73(lLFMPrepped)).CleanNameRecord, transfer((string73)'', recordof(Address.Layout_Clean_Name))); 

	//self.Prepped_Name					:=	if(lIsFML2CleanNameBad, lLFMPrepped, l.Prepped_Name);
	self.fname								:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.fname, 'ZZZ', ''), l.fname);
	self.mname								:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.mname, 'ZZZ', ''), l.mname);
	self.lname								:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.lname, 'ZZZ', ''), l.lname);
	self.name_suffix					:=	if(lIsFML2CleanNameBad, StringLib.StringFindReplace(lLFMCleanName.name_suffix, 'ZZZ', ''), l.name_suffix);
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
	NamesAppended:=join(distribute(base, hash64(Prepped_name))
						,distribute(UniqueNamesClean,   hash64(Prepped_name))
								,   
								left.Prepped_name=right.Prepped_name
								and left.Gender=right.Gender
								,transform(NAC_V2.Layout_base2
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

	WithName:=NamesAppended;


	//OUTPUT(CHOOSEN(SORT(UniqueNamesCleanFML1,prepped_name),1000), named('UniqueNamesCleanFML1'));
	//OUTPUT(CHOOSEN(SORT(UniqueNamesCleanFML2,prepped_name),1000), named('UniqueNamesCleanFML2'));
	//OUTPUT(CHOOSEN(SORT(UniqueNamesClean1,prepped_name),1000), named('UniqueNamesClean1'));
	//OUTPUT(CHOOSEN(SORT(UniqueNamesClean,prepped_name),1000), named('UniqueNamesClean'));
	//OUTPUT(CHOOSEN(SORT(NamesAppended,prepped_name),1000), named('NamesAppended'));
	

	return WithName;
END;
