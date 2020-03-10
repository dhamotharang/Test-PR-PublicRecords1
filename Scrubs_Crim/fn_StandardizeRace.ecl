import hygenics_crim;
EXPORT fn_StandardizeRace(string inString) := function;

	ReturnedRace:=hygenics_crim._functions.fn_standarddize_race(inString);
	return if(ReturnedRace Not In ['ASIAN/PACIFIC ISLAND','ASIAN OR P','BLACK','HISPANIC BLACK','HISPANIC','AMER INDIAN/ALASKAN','WHITE','MIXED','MIDDLE EASTERN','CAUCASIAN(NON-HISPANIC)','AMERICAN (US)','CAUCASIAN/WHITE','NON WHITE','OTHER-HISP','(NONE)',''],0,1);
end;