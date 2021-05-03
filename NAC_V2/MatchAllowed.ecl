/**
NAC programs need to be separated from PPA programs
This attribute will determine if two programs are allowed in interstate matches
**/
SNAP := ['D','S'];			// NAC programs
EXPORT boolean MatchAllowed(string1 program1, string1 program2) := 
			(program1 in SNAP AND program2 in SNAP) OR
			(program1 not in SNAP AND program2 not in SNAP);
