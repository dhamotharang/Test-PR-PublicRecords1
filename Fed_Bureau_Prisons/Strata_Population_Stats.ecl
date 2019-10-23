//
IMPORT Strata, tools;

EXPORT Strata_Population_Stats(STRING pVersion) := FUNCTION 
															 
	Strata.mac_Pops(Fed_Bureau_Prisons.file_federal_bureau_base,	dostats);
		
															 
	STRATA.createXMLStats(dostats
					 ,'Fed_Bureau'
					 ,'_Prisons20'  //rename to _Prisons
					 ,pVersion
					 ,'tarun.patel@lexisnexis.com'
					 ,outStrata);														 
		
	RETURN outStrata;	
	
	END;
	
	