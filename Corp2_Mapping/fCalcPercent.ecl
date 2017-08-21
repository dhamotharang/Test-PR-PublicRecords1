//********************************************************************
//fCalcPercent: This function calculates the percentage based upon the	
//parameters. The parm pround_value determines whether the value is
//rounded or not.					 
//********************************************************************
EXPORT fCalcPercent(integer pcount, integer ptotal_record_count, boolean pround_value) := function
		percent_value 				:= if (ptotal_record_count <> 0,pcount/ptotal_record_count * 100,0);
		percent_value_integer := (integer)percent_value;
		percent_value_rounded := percent_value + .5;
		return if (pround_value,(integer)percent_value_rounded,percent_value_integer);
end;
		