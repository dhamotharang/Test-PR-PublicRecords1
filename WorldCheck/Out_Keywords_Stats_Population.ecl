EXPORT Out_Keywords_Stats_Population (pKeywords
                                     ,pVersion
									 ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_WorldCheck_Keywords);
	#uniquename(dPopulationStats_WorldCheck_Keywords);
	#uniquename(zMain);

%rPopulationStats_WorldCheck_Keywords% := record
    pKeywords.Category;
    CountGroup                      := count(group);
    UID_CountNonBlank               := sum(group,if(pKeywords.UID<>'',1,0));
    Keyword_CountNonBlank           := sum(group,if(pKeywords.Keyword<>'',1,0));
    Source_Name_CountNonBlank       := sum(group,if(pKeywords.Source_name<>'',1,0));
    Authority_Country_CountNonBlank := sum(group,if(pKeywords.Authority_Country<>'',1,0));

end;
    
// Create the Main table and run the STRATA statistics
%dPopulationStats_WorldCheck_Keywords% := table(pKeywords
											   ,%rPopulationStats_WorldCheck_Keywords%
											   ,Category
											   ,few);

STRATA.createXMLStats(%dPopulationStats_WorldCheck_Keywords%
					 ,'World Check'
					 ,'Keywords'
					 ,pVersion
					 ,''
					 ,%zMain%
					 ,
					 ,'population');

zOut := parallel(%zMain%);

ENDMACRO;