dGWLCountryV2	:=	GlobalWatchLists.File_GlobalWatchLists_V4.Base.Country;

// add primary country to aka/name list
GlobalWatchLists.Layouts.Base.rCountry_Layout	tAddPrimaryCountryName(dGWLCountryV2	pInput)	:=
transform
	self.CountryNames	:=	dataset(	[{1,u'COUNTRY',pInput.CountryType,pInput.CountryName}],
																	GlobalWatchLists.Layouts.Base.rCountryName_Layout
																)
												+	project(pInput.CountryNames,transform(GlobalWatchLists.Layouts.Base.rCountryName_Layout,self.RecordID	:=	left.RecordID+1;self	:=	left));
	self							:=	pInput;
end;

dGWLAddPrimaryCountryName	:=	project(dGWLCountryV2,tAddPrimaryCountryName(left));

Layout_Country	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryIndex	or	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryAka;

Layout_Country	tNormCountryAka(dGWLAddPrimaryCountryName	pInput,integer	cnt)	:=
transform
	self.Key	:=	0;
	self			:=	pInput.CountryNames[cnt];
	self			:=	pInput;
end;

dNormCountryAKAs	:=	normalize(	dGWLAddPrimaryCountryName,
																	left.NameCount	+	1,
																	tNormCountryAka(left,counter)
																);

dNormCountryAKAsSort	:=	sort(dNormCountryAKAs,CountryID,RecordID);

Layout_Country	tAddKey(dNormCountryAKAsSort	pInput,integer	cnt)	:=
transform
	self.Key	:=	cnt;
	self			:=	pInput;
end;

dCountryAkaNameNormKey	:=	project(dNormCountryAKAsSort,tAddKey(left,counter))	:	persist('~thor_200::persist::globalwatchlists::norm_countryakalist');					

export	Normalize_CountryAKAList	:=	dCountryAkaNameNormKey;