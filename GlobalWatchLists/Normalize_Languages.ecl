dComments	:=	Globalwatchlists.Normalize_Comments(StringLib.StringFind(GlobalWatchLists.Functions.strClean2Upper(comments),'LANGUAGE SPOKEN:',1)	!=	0);

rLanguage_Layout	:=
record
	string20	recordid;
	string60	watchlistname;
	string		language;
end;
	
rLanguage_Layout	tLanguage(dComments	pInput)	:=
transform
	self.language	:=	GlobalWatchLists.Functions.strClean(regexreplace('LANGUAGE SPOKEN:',GlobalWatchLists.Functions.strClean(pInput.comments),'',nocase));
	self					:=	pInput;
end;

dLanguage	:=	project(dComments,tLanguage(left));

pattern	SingleLanguage	:=	pattern('[^,]+');

rParsedLang_Layout	:=
record
	dLanguage;
	string	Completelanguage	:=	GlobalWatchLists.Functions.strClean(matchtext(SingleLanguage));
end;

dLanguageParsed	:=	parse(dLanguage,language,SingleLanguage,rParsedLang_Layout,scan,first);

rLanguage_Layout	tReformatLang(dLanguageParsed	pInput)	:=
transform
	self.language	:=	if(	GlobalWatchLists.Functions.strClean2Upper(pInput.Completelanguage)	in	GlobalWatchLists.constants.InvalidVals,
												skip,
												GlobalWatchLists.Functions.strClean(pInput.Completelanguage)
											);
	self					:=	pInput;
end;

dLanguageReformat	:=	project(dLanguageParsed,tReformatLang(left));
							
dLanguageSort	:= sort(dLanguageReformat,recordid,watchlistname)	:	persist('~thor_200::persist::globalwatchlists::language');

export	Normalize_Languages	:=	dLanguageSort;