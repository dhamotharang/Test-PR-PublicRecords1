import marketing_best, govdata, versioncontrol,paw,Risk_Indicators,aca;

// -- rollback everything
// -- the first rollback is for the files used in the bdid macros(the slimsorts)
// -- they are promoted to prod by the following attribute:
// -- 		Business_Header.BWR_Expose_Slimsorts
// -- once the build passes QA and is put in production.
// -- if that above attribute hasn't been run for this build, then set hasExposeSlimsortsBeenRun to false.

IsTesting									:= false																												;
bdidmacroregex						:= '.*?base::business_header.*?(search|best|companyname|BDL2).*';
hasExposeSlimsortsBeenRun	:= true																													;

sequential(
	 if(hasExposeSlimsortsBeenRun
		,business_header.Rollback('^'+bdidmacroregex+'$'		,pIsTesting := IsTesting).Father2Prod	()
	 )
	,business_header.Rollback('^'+bdidmacroregex+'$'			,pIsTesting := IsTesting).Prod2QA			()
	,business_header.Rollback('^(?!'+bdidmacroregex+').*$',pIsTesting := IsTesting).Father2QA		()
	,Marketing_Best.Rollback															(pIsTesting := IsTesting).Father2QA		()
	,govdata.Rollback																			(pIsTesting := IsTesting).Father2QA		()
	,paw.Rollback																					(pIsTesting := IsTesting).Father2QA		()
	,Risk_Indicators.Rollback															(pIsTesting := IsTesting).Father2QA		()
	,ACA.Rollback																					(pIsTesting := IsTesting).Father2QA		()
);
