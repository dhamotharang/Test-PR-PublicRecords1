import Risk_Indicators, ut; 

// Grab the descriptions for the SIC codes and NAICS codes. We only have 4 digit SIC codes & 6 digit NAICS codes
// in this data.
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
																trim(left.sic_code)=trim(right.sic_code),
																trfJoinSic(left,right),
																left outer,
																local
															);
															
	distByNaics					:=	distribute(GetSicDescription,hash(naics_code));

													 
	GetNaicsDescription	:=	join(	distByNaics,
																dNaicsFile,
																trim(left.naics_code)=trim(right.naics_code),
																trfJoinNaics(left,right),
																left outer,
																local
															);													 

	return GetNaicsDescription;

end;	