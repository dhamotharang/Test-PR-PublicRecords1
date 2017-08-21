/********************************************************************************************************** 
	Name: 			_Macros
	Created On: 07/15/2013
	By: 				ssivasubramanian
	Desc: 			Module holding all macros created for this application	
***********************************************************************************************************/	

EXPORT _Macros := MODULE
	// This macro takes in any dataset as input and gives a report on the value distribution for 
	// each of the column. This is used for data profiling and evaluation.
	EXPORT Profile(ds) := MACRO
		LOADXML('<xml/>');
		#EXPORTXML(fields,RECORDOF(ds));  
		#FOR(fields)
			#FOR(Field)
				#UNIQUENAME(dsMaxCount);
				%dsMaxCount%:= MAX(TABLE(ds,{%{@label}%; Cnt := COUNT(GROUP)},%{@label}%),cnt);
				OUTPUT(SORT(TABLE(ds,{%{@label}%; Cnt := COUNT(GROUP);},%{@label}%),-Cnt),NAMED(#TEXT(ds) + '_' + #TEXT(%{@label}%)),ALL);
			#END
		#END;
	ENDMACRO;	

END;