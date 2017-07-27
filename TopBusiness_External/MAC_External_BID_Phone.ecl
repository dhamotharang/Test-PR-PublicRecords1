export MAC_External_BID_Phone(
	 externalfile
	,sequencenumber_field
	,bid_field
	,outfile
) :=
MACRO

// First, match on Phone and exact company name match.
#uniquename(ExactMatchedFile)
%ExactMatchedFile% := join(
	distribute(externalfile(bid_field = 0 and phone != '' and company_name != ''),hash(phone)),
	distributed(TopBusiness_External.Files().Phone.QA,hash(phone)),
	// Join criteria
	left.phone = right.phone and
	left.company_name = right.company_name,
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

// Now, match on phone number and fuzzy company name match.
#uniquename(FuzzyMatchedFile)
%FuzzyMatchedFile% := join(
	%RolledExactMatchedFile%,
	distributed(TopBusiness_External.Files().Phone.QA,hash(phone)),
	left.bid_field = 0 and
	// Join criteria
	left.phone = right.phone and
	ut.StringSimilar100(left.company_name,right.company_name) <= 35,
	transform({recordof(%RolledExactMatchedFile%),unsigned score},
		self.score := ut.StringSimilar100(left.company_name,right.company_name),
		self.bid_field := if(right.bid = 0,left.bid_field,right.bid),
		self := left),
	left outer,
	limit(3000,skip),
	local);

// Roll up to eliminate records with multiple BIDs
#uniquename(RolledFuzzyMatchedFile)
%RolledFuzzyMatchedFile% := rollup(
	sort(%FuzzyMatchedFile%,sequencenumber_field,score,bid_field,local),
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(%FuzzyMatchedFile%),
		self.score := left.score,
		self.bid_field := if(left.score = right.score and left.bid_field != right.bid_field,0,left.bid_field),
		self := left),
	local);

outfile := project(%RolledFuzzyMatchedFile%,recordof(externalfile)) + externalfile(not(bid_field = 0 and phone != '' and company_name != ''));

ENDMACRO;