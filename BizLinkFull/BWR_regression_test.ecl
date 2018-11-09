IMPORT BIPV2;
THISMODULE:=BizLinkFull;
INPUTLAYOUT:=THISMODULE.Process_Biz_Layouts.InputLayout;
MEOW:=THISMODULE.MEOW_Biz;
macBuildInput(d):=FUNCTIONMACRO
  RETURN PROJECT(THISMODULE._Search.macFormalize(d),INPUTLAYOUT);
ENDMACRO;
lTests:={STRING test;BOOLEAN result;};
//---------------------------------------------------------------------------
// Verify that the max IDs process is clipping results at 50
//---------------------------------------------------------------------------
bMaxResults:=COUNT(MEOW(macBuildInput(DATASET([{'realty','new york','ny'}],{STRING company_name;STRING city;STRING state;}))).uid_results)=50 AND
  (MEOW(macBuildInput(DATASET([{'realty','new york','ny'}],{STRING company_name;STRING city;STRING state;}))).Data_)[1].is_truncated;
dMaxResults:=DATASET([{'Max IDs Functioning',bMaxResults}],lTests);
//---------------------------------------------------------------------------
// Verfiy that the lead threshold process is clipping results to within 10 from top
//---------------------------------------------------------------------------
dNoLeadThreshold:=MEOW(macBuildInput(DATASET([{'New York Deli','Boca Raton','FL',20}],{STRING company_name;STRING city;STRING state;UNSIGNED leadthreshold;}))).uid_results;
iNoLeadSpan:=MAX(dNoLeadThreshold,weight)-MIN(dNoLeadThreshold,weight);
dWithLeadThreshold:=MEOW(macBuildInput(DATASET([{'New York Deli','Boca Raton','FL',10}],{STRING company_name;STRING city;STRING state;UNSIGNED leadthreshold;}))).uid_results;
iWithLeadSpan:=MAX(dWithLeadThreshold,weight)-MIN(dWithLeadThreshold,weight);
bLeadThresholdWorks:=iNoLeadSpan>10 AND iWithLeadSpan<10;
dLeadThresholdWorks:=DATASET([{'Lead threshold works',bLeadThresholdWorks}],lTests);
//---------------------------------------------------------------------------
// Large query to verify no memory errors
//---------------------------------------------------------------------------
bNoMemoryErrors:=COUNT(MEOW(macBuildInput(DATASET([{'Minnesota bank & trust'}],{STRING company_name;}))).uid_results)>0;
dNoMemoryErrors:=DATASET([{'Free of memory errors',bNoMemoryErrors}],lTests);
//---------------------------------------------------------------------------
// Verify results are restricted to the state specified
//---------------------------------------------------------------------------
dAAA:=TABLE(MEOW(macBuildInput(DATASET([{'AAA','dayton','oh'}],{STRING company_name;STRING city;STRING state;}))).Data_,{st},st)(st<>'');
bStateRestricted:=COUNT(dAAA)=1 AND dAAA[1].st='OH';
dStateRestricted:=DATASET([{'State requested resticts results to that state',bStateRestricted}],lTests);
//---------------------------------------------------------------------------
// Verify that queries returning large results return results
//---------------------------------------------------------------------------
bVeryLargeResults:=COUNT(MEOW(macBuildInput(DATASET([{'mcdonalds','centerville','oh','45458'}],{STRING company_name;STRING city;STRING state;STRING zip;}))).uid_results)>0;
dVeryLargeResults:=DATASET([{'Queries with large result sets return appropriately',bVeryLargeResults}],lTests);
//---------------------------------------------------------------------------
// Verify that plurals and singulars in the company name get the same results
//---------------------------------------------------------------------------
dTomorrows:=DISTRIBUTE(MEOW(macBuildInput(DATASET([{'tomorrows seafood','dallas','tx'}],{STRING company_name;STRING city;STRING state;}))).uid_results,HASH32(proxid));
dTomorrow:=DISTRIBUTE(MEOW(macBuildInput(DATASET([{'tomorrow seafood','dallas','tx'}],{STRING company_name;STRING city;STRING state;}))).uid_results,HASH32(proxid));
dTomorrowJoined:=JOIN(dTomorrows,dTomorrow,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT),LOOKUP);
bPlural:=COUNT(dTomorrows)=COUNT(dTomorrow) AND COUNT(dTomorrows)=COUNT(dTomorrowJoined);
dPlural:=DATASET([{'Plurals in company name return same results as singular',bPlural}],lTests);
//---------------------------------------------------------------------------
// IDs in lower-radius searches should all appear in higher-radius searches.
//---------------------------------------------------------------------------
d123Main10:=DISTRIBUTE(MEOW(macBuildInput(DATASET([{'123','main','OH','45342','10',100}],{STRING prim_range;STRING prim_name;STRING state;STRING zip;STRING zip_radius;UNSIGNED maxIDs;}))).uid_results,proxid);
d123Main20:=DISTRIBUTE(MEOW(macBuildInput(DATASET([{'123','main','OH','45342','20',100}],{STRING prim_range;STRING prim_name;STRING state;STRING zip;STRING zip_radius;UNSIGNED maxIDs;}))).uid_results,proxid);
d123Main30:=DISTRIBUTE(MEOW(macBuildInput(DATASET([{'123','main','OH','45342','30',100}],{STRING prim_range;STRING prim_name;STRING state;STRING zip;STRING zip_radius;UNSIGNED maxIDs;}))).uid_results,proxid);
d123Main_20_30:=JOIN(d123Main20,d123Main30,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT));
d123Main:=JOIN(d123Main10,d123Main_20_30,LEFT.proxid=RIGHT.proxid,TRANSFORM(LEFT));
bRadiusCheck:=COUNT(d123Main20)=COUNT(d123Main_20_30) AND COUNT(d123Main10)=COUNT(d123Main);
dRadiusCheck:=DATASET([{'Lower-radius results all in higher-radius ones',bRadiusCheck}],lTests);
//---------------------------------------------------------------------------
// Encapsulated results
//---------------------------------------------------------------------------
dResults:=dMaxResults+dLeadThresholdWorks+dNoMemoryErrors+dStateRestricted+dVeryLargeResults+dPlural+dRadiusCheck;
dResults;

