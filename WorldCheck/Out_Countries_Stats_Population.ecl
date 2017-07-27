EXPORT Out_Countries_Stats_Population (pCountries
                                      ,pVersion
									  ,zOut) := MACRO

import STRATA;

#uniquename(rPopulationStats_WorldCheck_Countries);
#uniquename(dPopulationStats_WorldCheck_Countries);
#uniquename(zMain);

%rPopulationStats_WorldCheck_Countries% := record 
    pCountries.Category;
    CountGroup                           := count(group);
    UID_CountNonBlank                    := sum(group,if(pCountries.UID<>'',1,0));
    Country_CountNonBlank                := sum(group,if(pCountries.Country<>'',1,0));
  end;

    
// Create the Main table and run the STRATA statistics
%dPopulationStats_WorldCheck_Countries% := table(pCountries
											     ,%rPopulationStats_WorldCheck_Countries%
											     ,Category
											     ,few);

STRATA.createXMLStats(%dPopulationStats_WorldCheck_Countries%
					 ,'World Check'
					 ,'Countries'
					 ,pVersion
					 ,''
					 ,%zMain%
					 ,
					 ,'population');

zOut := parallel(%zMain%);

ENDMACRO;