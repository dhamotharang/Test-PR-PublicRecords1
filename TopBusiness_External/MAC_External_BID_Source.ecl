export MAC_External_BID_Source(
	 externalfile
	,sequencenumber_field
	,bid_field
	,outfile
) :=
MACRO

// First, match on source information.
#uniquename(ExactMatchedFile)
%ExactMatchedFile% := join(
	distribute(externalfile(source != '' and source_docid != ''),hash(source,source_docid,source_party)),
	distribute(TopBusiness_External.Files().Source.QA,hash(source,source_docid,source_party)),
	// Join criteria
	left.source = right.source and
	left.source_docid = right.source_docid and
	left.source_party = right.source_party,
	transform(recordof(left),
		self.bid_field := if(right.bid = 0,left.bid_field,right.bid),
		self.bid_score := if(right.bid = 0,0,100),
		self := left),
	limit(3000,skip),
	local);

// Dedup the results
#uniquename(DedupExactMatchedFile)
%DedupExactMatchedFile% :=
	dedup(
		sort(%ExactMatchedFile%,source,source_docid,source_party,sequencenumber_field,bid_field,-bid_score,local),
		source,source_docid,source_party,sequencenumber_field,bid_field,local);

// Now, count how many hits there were and reduce score appropriately
#uniquename(HitCounts)
%HitCounts% :=
	table(
		%DedupExactMatchedFile%,
		{source,source_docid,source_party,sequencenumber_field,unsigned cnt := count(group)},
		source,source_docid,source_party,sequencenumber_field,local);

#uniquename(AdjustedExactMatchedFile);
%AdjustedExactMatchedFile% := join(
	%DedupExactMatchedFile%,
	%HitCounts%,
	left.source = right.source and
	left.source_docid = right.source_docid and
	left.source_party = right.source_party and
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(left),
		self.bid_score := left.bid_score div right.cnt,
		self := left),
	local);

outfile := %AdjustedExactMatchedFile%;

ENDMACRO;