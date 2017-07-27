EXPORT Out_Linked_To_Stats_Population (pLinked_Tos
                                      ,pVersion
									  ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_WorldCheck_Linked_Tos);
	#uniquename(dPopulationStats_WorldCheck_Linked_Tos);
	#uniquename(zMain);

%rPopulationStats_WorldCheck_Linked_Tos% := record
    pLinked_Tos.Category;
    CountGroup              := count(group);
    UID_CountNonBlank       := sum(group,if(pLinked_Tos.UID<>'',1,0));
    Linked_To_CountNonBlank := sum(group,if(pLinked_Tos.Linked_To<>'',1,0));
end;
    
// Create the Main table and run the STRATA statistics
%dPopulationStats_WorldCheck_Linked_Tos% := table(pLinked_Tos
											     ,%rPopulationStats_WorldCheck_Linked_Tos%
											     ,Category
											     ,few);

STRATA.createXMLStats(%dPopulationStats_WorldCheck_Linked_Tos%
					 ,'World Check'
					 ,'Linked To IDs'
					 ,pVersion
					 ,''
					 ,%zMain%
					 ,
					 ,'population');

zOut := parallel(%zMain%);

ENDMACRO;