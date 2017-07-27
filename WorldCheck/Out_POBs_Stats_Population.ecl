EXPORT Out_POBs_Stats_Population (pPOBs
                                 ,pVersion
								 ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_WorldCheck_POBs);
	#uniquename(dPopulationStats_WorldCheck_POBs);
	#uniquename(zMain);

%rPopulationStats_WorldCheck_POBs% := record
    pPOBs.Category;
    CountGroup        := count(group);
    UID_CountNonBlank := sum(group,if(pPOBs.UID<>'',1,0));
    POB_CountNonBlank := sum(group,if(pPOBs.Place_of_Birth<>'',1,0));
end;
    
// Create the Main table and run the STRATA statistics
%dPopulationStats_WorldCheck_POBs% := table(pPOBs
										   ,%rPopulationStats_WorldCheck_POBs%
										   ,Category
										   ,few);

STRATA.createXMLStats(%dPopulationStats_WorldCheck_POBs%
					 ,'World Check'
					 ,'Places of Birth'
					 ,pVersion
					 ,''
					 ,%zMain%
					 ,
					 ,'population');

zOut := parallel(%zMain%);

ENDMACRO;