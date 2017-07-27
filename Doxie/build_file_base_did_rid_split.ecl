import header;

// at runtime, should be NEW header, not same as
// current one, which should be head2 below....
// we want 3 versions of the header file here.
slimrec := record
	unsigned6	rid;
	unsigned6	did;
	unsigned6 did2 := 0; // stores old did for each rid.
end;

slimrec into_slim1(header.layout_header L) := transform
	self := L;
end;

head := project(header.file_headers,into_slim1(LEFT));	  
head2 := project(header.file_header_previous,into_slim1(LEFT));	 
head3 := project(header.file_header_prev_prev,into_slim1(LEFT));	
 
head1_byRid := distribute(head,hash(rid));
head2_byRid := distribute(head2,hash(rid));
head3_byRid := distribute(head3, hash(rid));

head2_byDid := distribute(head2,hash(did));
head3_byDid := distribute(head3, hash(did));

// ----------------------------------------------------------------------------
// 				LOGIC TO FIND SPLITS
// Splits are dids that are divided in more than one did from build to build.
// To find splits we join two different header build versions by rid and look 
// for records that changed the did from on build to another.  This logic will 
// also bring collapses (when multiple dids or records are joined in one did), 
// to remove collapses we join again with the older build to get only brand new 
// dids.
// ----------------------------------------------------------------------------

// find splits candidates
splitCandidates1 := join(head1_byRid,head2_byRid,
			 left.rid=right.rid and left.did <> right.did, 
			 transform(slimrec, 
					self.did2 := right.did,
					self := left),local);

// the left only join with previous version eliminates the collapses and leaves only the splits.
splitDids1 := join(distribute(splitCandidates1, hash(did)), head2_byDid, 
													left.did = right.did, local, left only);
													
// find splits candidates
splitCandidates2 := join(head2_byRid, head3_byRid,  
														left.rid = right.rid and left.did <> right.did,
														transform(slimrec, 
															self.did2 := right.did,
															self := left), local);
															
// the left only join with previous version eliminates the collapses and leaves only the splits.
splitDids2 := join(distribute(splitCandidates2, hash(did)), head3_byDid, 
													left.did = right.did, local, left only) ;

// gets dids that from one build to another got a records that was previously part of a split.
// sample table:
//              rid     did
// build 1 -   2243       43    (rid 2234 is linked to did 43)
// build 2 -   2243     2243 		(rid 2243 splitted and is now a singleton)
// build 3 -   2234       10    (rid 2243 is linked to did 10)														
// the code below finds did 10 and now have 2234.
splitDids3 := join(distribute(splitDids2 + splitDids1, hash(rid)), head1_byRid, 
									left.rid = right.rid and left.did2<> right.did and left.did <> right.did,
									transform(slimrec,
											self.did := right.did, self := left));

allsplitDids := splitDids2 + splitDids1 + splitDids3 ;

// get records that rid and did are the same.
allrecs := join(distribute(allsplitDids, hash(did)), head1_byRid, left.did = right.rid, 
	transform(slimrec,
		self.did := left.did,
		self.rid := right.rid,
		self.did2 := right.rid), local) + 
		join(distribute(allsplitDids,  hash(did2)), head1_byRid, left.did2 = right.rid, 
	transform(slimrec,
		self.did := left.did2,
		self.rid := right.rid,
		self.did2 := right.rid), local);

EXPORT build_file_base_did_rid_split := dedup(sort(distribute(allsplitDids + allrecs, hash(did2)), did2, did, local), did2, did, local);