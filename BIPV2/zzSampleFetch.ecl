//W20120719-155832 is an example, though you can run this on hthor in 10 seconds

//SEARCH FOR IDS
SearchInput := BIPV2.zzzSampleFileForSearch;
output(SearchInput, named('SearchInput'));

BIPRec := {SearchInput, BIPV2.IDlayouts.l_xlink_ids, unsigned6 bdid := 0};
BIPV2.zzzSampleXlinkMacro(
	SearchInput				// ExistingInfileParameter,
	,SearchResult			// ExistingOutfileParameter,
	,BIPRec						// ExistingOutrecParameter,
	,junk							// OtherExistingParameters,
	,TRUE							// AppendBIPids = false, 
)
output(sort(SearchResult, company_name), named('SearchResult'));

//FETCH YOUR DATA USING THOSE IDS
myFetch := BIPV2.zzSampleKey.kFetch(project(SearchResult, BIPV2.IDlayouts.l_xlink_ids)); 
output(myFetch, named('myFetch'));

//NOW TRY DIFFERENT LEVELS
singleFetchInput := choosen(SearchResult, 1);
output(singleFetchInput, named('singleFetchInput'));

myFetchSingleDot := BIPV2.zzSampleKey.kFetch(project(singleFetchInput, BIPV2.IDlayouts.l_xlink_ids), 'D'); 
output(myFetchSingleDot, named('myFetchSingleDot'));

myFetchSingleUlt := BIPV2.zzSampleKey.kFetch(project(singleFetchInput, BIPV2.IDlayouts.l_xlink_ids), 'U');  
output(myFetchSingleUlt, named('myFetchSingleUlt'));