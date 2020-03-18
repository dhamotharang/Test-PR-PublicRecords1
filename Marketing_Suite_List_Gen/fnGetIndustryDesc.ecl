import Risk_Indicators, ut; 

EXPORT fnGetIndustryDesc(dataset(Marketing_Suite_List_Gen.Layouts.Layout_NormTemp)	NormFile) := function

	NormLayout	:=	Marketing_Suite_List_Gen.Layouts.Layout_NormTemp;

	dist_normFile	:=	distribute(NormFile,hash(sic_code));

	FilterSicFile	:=	Risk_Indicators.Files().SicLookup.qa(sic_code[5..]='0000'); //want only the base sic codes since our sic codes are 4 digits.
	
	SlimSicFile		:=	project(FilterSicFile,
														transform(Risk_Indicators.Layouts.SicLookup,
																				self.sic_code	:= left.sic_code[1..4];
																				self					:= left;
																			)
														);
														
	dSicFile			:=	distribute(SlimSicFile,hash(sic_code));
	dNaicsFile		:=	distribute(Risk_Indicators.Files().NAICLookup(length(ut.CleanSpacesAndUpper(naics_code))=6),hash(naics_code));
	
	NormLayout	trfJoinSic(NormLayout l, Risk_Indicators.Layouts.SicLookup r)	:=	transform
		self.sic_desc		:=	ut.CleanSpacesAndUpper(r.sic_description);
		self						:=	l;
	end;

	NormLayout	trfJoinNaics(NormLayout l, Risk_Indicators.Layouts.NaicLookup r)	:=	transform
		self.naics_desc	:=	ut.CleanSpacesAndUpper(r.naics_description);
		self						:=	l;
	end;

	GetSicDescription		:=	join(	dist_normFile,
																dSicFile,
																ut.CleanSpacesAndUpper(left.sic_code)=ut.CleanSpacesAndUpper(right.sic_code),
																trfJoinSic(left,right),
																left outer,
																local
															);
															
	distByNaics					:=	distribute(GetSicDescription,hash(naics_code));

													 
	GetNaicsDescription	:=	join(	distByNaics,
																dNaicsFile,
																ut.CleanSpacesAndUpper(left.naics_code)=ut.CleanSpacesAndUpper(right.naics_code),
																trfJoinNaics(left,right),
																left outer,
																local
															);													 

	return GetNaicsDescription;

end;	