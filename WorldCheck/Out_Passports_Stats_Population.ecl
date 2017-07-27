EXPORT Out_Passports_Stats_Population (pPassports
                                      ,pVersion
									  ,zOut) := MACRO

import STRATA;

	#uniquename(rPopulationStats_WorldCheck_Passports);
	#uniquename(dPopulationStats_WorldCheck_Passports);
	#uniquename(zMain);

%rPopulationStats_WorldCheck_Passports% := record
    pPassports.Category;
    CountGroup                           := count(group);
    UID_CountNonBlank                    := sum(group,if(pPassports.UID<>'',1,0));
    Passport_CountNonBlank               := sum(group,if(pPassports.Passport<>'',1,0));
end;
    
// Create the Main table and run the STRATA statistics
%dPopulationStats_WorldCheck_Passports% := table(pPassports
											     ,%rPopulationStats_WorldCheck_Passports%
											     ,Category
											     ,few);

STRATA.createXMLStats(%dPopulationStats_WorldCheck_Passports%
					 ,'World Check'
					 ,'Passports'
					 ,pVersion
					 ,''
					 ,%zMain%
					 ,
					 ,'population');

zOut := parallel(%zMain%);

ENDMACRO;