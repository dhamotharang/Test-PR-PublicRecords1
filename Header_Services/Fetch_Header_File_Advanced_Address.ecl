/*
	Given this person at this address, 
	find every person that ever lived at any of the person's addresses,
	or using the RandR switch, find every person that lived at the same time 
	with the person at any of the persons addresses. 
	
	Inputs
		did_value. The root person for the search. 
		RandR. Do we limit the results to same time?
*/

import doxie, header, suppress, ut;
doxie.MAC_Header_Field_Declare();
mod_access := doxie.functions.GetGlobalDataAccessModule ();

boolean RandR := false : stored('RandR');
// contents of doxie.Layout_AddressSearch
//	unsigned seq;
//	string10 prim_range;
//	string28 prim_name;
//	string8 sec_range;
//	string2 state;
//	string5 zip;
did_val := (unsigned6)did_value;
UncleanParentRecs := doxie.Key_Header(keyed(s_did = did_val)and prim_name[1..6] != 'PO BOX');
header.MAC_GlbClean_Header(UncleanParentRecs,BigParentRecs, , , mod_access);

recordof(doxie.Key_Header) doBigParentProject(BigParentRecs l) := TRANSFORM
	SELF := l;
END;
ParentRecs := project(BigParentRecs, doBigParentProject(LEFT));

doxie.Layout_AddressSearch doParentProject(recordof(doxie.Key_Header) l, INTEGER c) := TRANSFORM
	SELF.prim_name := doxie.StripOrdinal(l.prim_name);
	SELF.seq := c;
	SELF.state := l.st;
	SELF := l;
END;

SearchRecs := project(ParentRecs, doParentProject(LEFT, COUNTER));

SortedSearchRecs := SORT(SearchRecs, RECORD, EXCEPT seq);

DedupedSearchRecs := ROLLUP(SortedSearchRecs,
			TRANSFORM(recordof(SortedSearchRecs),SELF := RIGHT),
      ut.nneq(LEFT.zip, RIGHT.zip), 
			ut.nneq(LEFT.state, RIGHT.state),  
      ut.nneq(LEFT.prim_name, RIGHT.prim_name), 
			ut.nneq(LEFT.prim_range, RIGHT.prim_range),
			ut.nneq(LEFT.sec_range, RIGHT.sec_range));

DidsFromAddresses := doxie.did_from_address(DedupedSearchRecs, true);


recordof(doxie.Key_Header) doKeyHeaderJoin(doxie.Key_Header r) := TRANSFORM
	SELF := r;
END;

UncleanChildRecs := JOIN(DidsFromAddresses,doxie.Key_Header,
									KEYED(LEFT.did = RIGHT.s_did) 
									and LEFT.prim_range = RIGHT.prim_range
									and doxie.StripOrdinal(LEFT.prim_name) = doxie.StripOrdinal(RIGHT.prim_name)
									and LEFT.sec_range = RIGHT.sec_range
									and LEFT.state = RIGHT.st
									and LEFT.zip = RIGHT.zip
									, doKeyHeaderJoin(RIGHT)
									, LEFT OUTER);
header.MAC_GlbClean_Header(UncleanChildRecs,BigChildRecs, , , mod_access);
recordof(doxie.Key_Header) doBigChildProject(BigChildRecs l) := TRANSFORM
	SELF := l;
END;
ChildRecs := project(BigChildRecs, doBigChildProject(LEFT));

recordof(doxie.Key_Header) doMatchingRecsRollup (ChildRecs l, ChildRecs r) := TRANSFORM
	SELF.dt_first_seen := if ( l.dt_first_seen=0 
															or r.dt_first_seen<>0
															and r.dt_first_seen < l.dt_first_seen,
															r.dt_first_seen,
															l.dt_first_seen);
	SELF.dt_last_seen := if ( l.dt_last_seen=0 
															or r.dt_last_seen<>0
															and r.dt_last_seen < l.dt_last_seen,
															l.dt_last_seen,
															r.dt_last_seen);
	SELF := r;
END;

DedupedChildRecs := ROLLUP(SORT(ChildRecs,
																did,prim_range,
																prim_name, sec_range, st, zip),
																doMatchingRecsRollup(LEFT,RIGHT),
																did, prim_range, 
																prim_name, sec_range, st, zip);
// if RandR, find intersection in time of parent and child records.
DedupedParentRecs := ROLLUP(SORT(ParentRecs,
																did,prim_range,
																prim_name, sec_range, st, zip),
																doMatchingRecsRollup(LEFT,RIGHT),
																did, prim_range, 
																prim_name, sec_range, st, zip);

recordof(doxie.Key_Header) doCoLocatedJoin(ParentRecs l,ChildRecs r) := TRANSFORM
	// keep the overlaps, skip the rest
	// parentrec         *---------------------*
	// child #1        *----*
	// child #2                              *----*
	// child #3              *-------------*
	
	, SKIP(IF(r.dt_first_seen <>0 and r.dt_last_seen <>0
						and l.dt_first_seen <>0 and l.dt_last_seen <>0,
					IF(
					  ((r.dt_first_seen <= l.dt_first_seen 
						and r.dt_last_seen > l.dt_first_seen)) //child #1
					or((r.dt_first_seen < l.dt_last_seen 
						and r.dt_last_seen >= l.dt_last_seen)) //child #2
					or((r.dt_first_seen >= l.dt_first_seen 
						and r.dt_last_seen <= l.dt_last_seen)) //child #3 
						, false, true)
					, true)
				)
	SELF := r;
END;

CoLocatedChildRecs := JOIN(DedupedParentRecs, DedupedChildRecs,
													LEFT.prim_range = RIGHT.prim_range
													and LEFT.prim_name = RIGHT.prim_name
													and LEFT.sec_range = RIGHT.sec_range
													and LEFT.st = RIGHT.st
													and LEFT.zip = RIGHT.zip
													, doCoLocatedJoin(LEFT,RIGHT)
);

XformedChildRecs := CHOOSEN(if(RandR,CoLocatedChildRecs,DedupedChildRecs),500);

doxie.layout_presentation doRollupPresentationTransform (recordof(doxie.Key_Header) l) := TRANSFORM
	SELF.penalt := 0;
	SELF.num_compares := 0;
	SELF.glb := false;
	SELF.dppa := false;
	SELF := l;
END;

pre_rollup_presentation := project(XformedChildRecs,doRollupPresentationTransform(LEFT));
export Fetch_Header_File_Advanced_Address := doxie.rollup_presentation(pre_rollup_presentation)[1].Results;

