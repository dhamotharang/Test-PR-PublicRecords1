import hygenics_crim;
EXPORT fn_StandardizeRace(string inString) := function;

	ReturnedRace:=hygenics_crim._functions.fn_standarddize_race(inString);
	return if(ReturnedRace Not In ['ASIAN/PACIFIC ISLAND','BLACK','HISPANIC BLACK','HISPANIC','AMER INDIAN/ALASKAN','WHITE','MIXED','MIDDLE EASTERN',''],0,1);
end;