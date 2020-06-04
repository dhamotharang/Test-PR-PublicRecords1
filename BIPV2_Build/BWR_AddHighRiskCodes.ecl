pversion := '<>'; //e.g. 20191010

codesToUpdate := dataset([ 
                           {'<code>','SIC'}
                          ,{'<code>','NAICS'}
                         ], BIPV2_Build.Layouts.HighRiskCodesListLayout);

//Add Codes												 
BIPV2_Build.HighRiskIndustries.removeCodes(codesToUpdate,pversion);

//Remove Codes;
BIPV2_Build.HighRiskIndustries.addCodes(codesToUpdate,pversion);