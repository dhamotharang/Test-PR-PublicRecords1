import Address, STD;
tokens := DEDUP(SORT(DISTRIBUTE(Address.wordtokens, hash(phrase)),phrase,local),phrase,rule,local);

fnames := DEDUP(SORT(DISTRIBUTE(Address.FirstNames+Address.FirstNames2,hash(name))
																	,name,gender,LOCAL),name,gender,LOCAL);

citynames := DISTRIBUTE(Address.City_names,hash(city_name));

countynames := DISTRIBUTE(Address.County_names,hash(county_name));

SEQUENTIAL(
	PARALLEL(
		OUTPUT(tokens,,'~thor::nid::aux::businesstokens::'+WORKUNIT,COMPRESSED,OVERWRITE),
		OUTPUT(fnames,,'~thor::nid::aux::firstnames::'+WORKUNIT,COMPRESSED,OVERWRITE),
		OUTPUT(citynames,,'~thor::nid::aux::citynames::'+WORKUNIT,COMPRESSED,OVERWRITE),
		OUTPUT(countynames,,'~thor::nid::aux::countynames::'+WORKUNIT,COMPRESSED,OVERWRITE)
	),
	std.file.PromoteSuperFileList(['~thor::nid::aux::businesstokens'],'~thor::nid::aux::businesstokens::'+WORKUNIT,deltail := true),
	std.file.PromoteSuperFileList(['~thor::nid::aux::firstnames'],'~thor::nid::aux::firstnames::'+WORKUNIT,deltail := true),
	std.file.PromoteSuperFileList(['~thor::nid::aux::citynames'],'~thor::nid::aux::citynames::'+WORKUNIT,deltail := true),
	std.file.PromoteSuperFileList(['~thor::nid::aux::countynames'],'~thor::nid::aux::countynames::'+WORKUNIT,deltail := true)
);
