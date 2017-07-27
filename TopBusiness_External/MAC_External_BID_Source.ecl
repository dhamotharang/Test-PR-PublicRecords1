export MAC_External_BID_Source(
	 externalfile
	,sequencenumber_field
	,bid_field
	,outfile
) :=
MACRO

// First, match on address and exact company name match.
#uniquename(ExactMatchedFile)
%ExactMatchedFile% := join(
	distribute(externalfile(bid_field = 0 and source != '' and source_docid != ''),hash(source,source_docid,source_party)),
	distributed(TopBusiness_External.Files().Source.QA,hash(source,source_docid,source_party)),
	// Join criteria
	left.source = right.source and
	left.source_docid = right.source_docid and
	left.source_party = right.source_party,
	transform(recordof(externalfile),
		self.bid_field := if(right.bid = 0,left.bid_field,right.bid),
		self := left),
	left outer,
	limit(3000,skip),
	local);

// Roll up to eliminate records with multiple BIDs
#uniquename(RolledExactMatchedFile)
%RolledExactMatchedFile% := rollup(
	sort(%ExactMatchedFile%,sequencenumber_field,bid_field,local),
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(%ExactMatchedFile%),
		self.bid_field := if(left.bid_field != right.bid_field,0,left.bid_field),
		self := left),
	local);

outfile := %RolledExactMatchedFile% + externalfile(not(bid_field = 0 and source != '' and source_docid != ''));

ENDMACRO;