export MAC_External_BID_Phone(
	 externalfile
	,sequencenumber_field
	,bid_field
	,outfile
) :=
MACRO

// Match on phone number and fuzzy company name match.
#uniquename(FuzzyMatchedFile)
%FuzzyMatchedFile% := join(
	distribute(externalfile(phone != '' and company_name != ''),hash(phone)),
	distribute(TopBusiness_External.Files().Address.QA(phone != ''),hash(phone)),
	// Join criteria
	left.phone = right.phone and
	ut.StringSimilar100(left.company_name,right.company_name) <= 35,
	transform(recordof(left),
		self.bid_score :=
			(
				if(left.phone != '',100 - ut.StringSimilar100(left.phone,right.phone),0) +
				if(left.company_name != '',100 - ut.StringSimilar100(left.company_name,right.company_name),0) +
				if(left.zip != '',100 - ut.StringSimilar100(left.zip,right.zip) +
					if(left.prim_name != '',100 - ut.StringSimilar100(left.prim_name,right.prim_name),0) +
					if(left.prim_range != '',100 - ut.StringSimilar100(left.prim_range,right.prim_range),0),0) +
				if(left.fein != '',100 - ut.StringSimilar100(left.fein,right.fein),0)
			)
			div
			(
				if(left.phone != '',1,0) +
				if(left.company_name != '',1,0) +
				if(left.zip != '',1 +
					if(left.prim_name != '',1,0) +
					if(left.prim_range != '',1,0),0) +
				if(left.fein != '',1,0)
			);
		self.bid_field := if(right.bid = 0,left.bid_field,right.bid),
		self := left),
	limit(3000,skip),
	local);

// Dedup the results
#uniquename(DedupFuzzyMatchedFile)
%DedupFuzzyMatchedFile% :=
	dedup(
		sort(%FuzzyMatchedFile%,phone,sequencenumber_field,bid_field,-bid_score,local),
		phone,sequencenumber_field,bid_field,local);

// Now, count how many hits there were and reduce score appropriately
#uniquename(HitCounts)
%HitCounts% :=
	table(
		%DedupFuzzyMatchedFile%,
		{phone,sequencenumber_field,unsigned cnt := count(group)},
		phone,sequencenumber_field,local);

#uniquename(AdjustedFuzzyMatchedFile);
%AdjustedFuzzyMatchedFile% := join(
	%DedupFuzzyMatchedFile%,
	%HitCounts%,
	left.phone = right.phone and
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(left),
		self.bid_score := left.bid_score div right.cnt,
		self := left),
	local);

outfile := %AdjustedFuzzyMatchedFile%;

ENDMACRO;