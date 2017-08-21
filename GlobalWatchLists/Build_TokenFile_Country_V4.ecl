import	RoxieKeyBuild,ut;

export	Build_TokenFile_Country_V4(string	pFileDate)	:=
function
	dCountries	:=	GlobalWatchLists.Normalize_CountryAKAList;

	LayoutPrep_V4	:=	GlobalWatchLists.Layout_GlobalWatchLists_V4.LayoutCountryTokenPrep;
	
	LayoutPrep_V4	tPrepTokens(dCountries	l)	:=
	transform
		self.CountryName	:=	l.Name;
		self.Key					:=	l.Key;
	end;
	
	dPrep	:=	project(dCountries,tPrepTokens(left));
	
	dCountryTokens	:=	Globalwatchlists.fn_CountryTokens_V4(dPrep);
	
	RoxieKeyBuild.Mac_SF_BuildProcess_V2(dCountryTokens,'~thor_200::base::globalwatchlistsV2','country_tokens',pFileDate,bldCountryTokens,,,true);
	
	return	bldCountryTokens;
end;
