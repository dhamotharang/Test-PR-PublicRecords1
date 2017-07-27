EXPORT Out_Companies_Stats_Population (pCompanies
                                      ,pVersion
									  ,zOut) := MACRO

import STRATA;

#uniquename(rPopulationStats_WorldCheck_Companies);
#uniquename(dPopulationStats_WorldCheck_Companies);
#uniquename(zMain);

%rPopulationStats_WorldCheck_Companies% := record 
    pCompanies.Category;
    CountGroup                           := count(group);
    UID_CountNonBlank                    := sum(group,if(pCompanies.UID<>'',1,0));
    Company_CountNonBlank                := sum(group,if(pCompanies.Company<>'',1,0));
  end;

    
// Create the Main table and run the STRATA statistics
%dPopulationStats_WorldCheck_Companies% := table(pCompanies
											     ,%rPopulationStats_WorldCheck_Companies%
											     ,Category
											     ,few);

STRATA.createXMLStats(%dPopulationStats_WorldCheck_Companies%
					 ,'World Check'
					 ,'Companies'
					 ,pVersion
					 ,''
					 ,%zMain%
					 ,
					 ,'population');

zOut := parallel(%zMain%);

ENDMACRO;