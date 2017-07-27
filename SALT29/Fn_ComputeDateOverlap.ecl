export fn_ComputeDateOverlap(unsigned frst1,unsigned lst1,unsigned frst2,unsigned lst2) := function
// Cannot use ut.date_overlap as I want the distance in the non-overlap case too
  unsigned4 f1 := if ( frst1 = 0, lst1 div 100, frst1 div 100 );
	unsigned4 l1 := if ( lst1 = 0, f1, lst1 div 100 );
  unsigned4 f2 := if ( frst2 = 0, lst2 div 100, frst2 div 100 );
	unsigned4 l2 := if ( lst2 = 0, f2, lst2 div 100 );
	dm(unsigned hi,unsigned lo) := ( hi div 100 - lo div 100 ) * 12 + hi % 100 - lo % 100;
	// Note - returns an inclusive count; thus if there is 1 common month it counts as 1 (not zero)
	return MAP ( f1 = 0 or f2 = 0 => 0,
							 l1 < f2 => -dm(f2,l1), // 1 completes before two begins
							 f1 <= f2 and l1 <= l2 => 1+dm(l1,f2), // 2 starts during 1 and 1 ends during 2
							 f1 <= f2 and f2 <= l1 => 1+dm(l2,f2), // 2 occurs within 1
							 l2 < f1 => -dm(f1,l2), // 2 completes before 1 begins
							 f2 <= f1 and l2 <= l1 => 1+dm(l2,f1), // 1 starts during 2 and 2 ends during 1
							 f2 <= f1 and f1 <= l2 => 1+dm(l1,f1), // 1 occurs within 2
							 -9999 // I screwed up the coding of this function somehow
							);
	end;
