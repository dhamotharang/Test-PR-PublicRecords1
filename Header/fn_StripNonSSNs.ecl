import watchdog;

rec := //header.Layout_MatchCandidates;
header.Layout_Header;

export fn_StripNonSSNs(
	dataset(rec) pm) :=
MODULE

//FIND BAD SSNS
prep := project(pm, transform(header.layout_NonIDs, self.ID := if((unsigned6)left.ssn > 999999, left.ssn, ''), self := left));
shared bad := header.fn_FindNonIDs(prep);

//REMOVE FROM HEADER
export head := join(pm, bad, 
						left.ssn = right.ID,
						transform(rec, self.ssn := if(right.ID <> '', '', left.ssn), self := left),
						left outer,
						lookup);

//REMOVE FROM BEST
export best(dataset(watchdog.Layout_Best) bestfile) := join(bestfile, bad, 
						left.ssn = right.ID,
						transform(watchdog.Layout_Best, self.ssn := if(right.ID <> '', '', left.ssn), self := left),
						left outer,
						lookup);
// output(choosen(bad, 100), named('bad'));
// output(count(bad), named('bad_count'));
// output(t2(ssn = '952371093'), named('myt2'));


END;