export MAC_External_BID_Address(
	 externalfile
	,sequencenumber_field
	,bid_field
	,outfile
) :=
MACRO

// First, match on address and company name match.
#uniquename(FullAddrFuzzyMatchedFile)
%FullAddrFuzzyMatchedFile% := join(
	distribute(externalfile((unsigned3)zip != 0 and prim_name != '' and (prim_name[1..7] = 'PO BOX ' or prim_range != '') and company_name != ''),hash(zip,prim_name,prim_range)),
	dedup(distribute(TopBusiness_External.Files().Address.QA,hash(zip,prim_name,prim_range)),zip,prim_name,prim_range,company_name,bid,all,local),
	// Join criteria
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	ut.StringSimilar100(left.company_name,right.company_name) <= 50,
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
	limit(10000,skip),
	local);

// Dedup the results
#uniquename(DedupFullAddrFuzzyMatchedFile)
%DedupFullAddrFuzzyMatchedFile% :=
	dedup(
		sort(%FullAddrFuzzyMatchedFile%,zip,prim_name,prim_range,sequencenumber_field,bid_field,-bid_score,local),
		zip,prim_name,prim_range,sequencenumber_field,bid_field,local);

// Now, count how many hits there were and reduce score appropriately
#uniquename(FullAddrHitCounts)
%FullAddrHitCounts% :=
	table(
		%DedupFullAddrFuzzyMatchedFile%,
		{zip,prim_name,prim_range,sequencenumber_field,unsigned cnt := count(group)},
		zip,prim_name,prim_range,sequencenumber_field,local);

#uniquename(AdjustedFullAddrFuzzyMatchedFile);
%AdjustedFullAddrFuzzyMatchedFile% := join(
	%DedupFullAddrFuzzyMatchedFile%,
	%FullAddrHitCounts%,
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(left),
		self.bid_score := left.bid_score div right.cnt,
		self := left),
	local);

// First, match on zip and company name match.
#uniquename(OnlyZipPnFuzzyMatchedFile)
%OnlyZipPnFuzzyMatchedFile% := join(
	distribute(externalfile((unsigned3)zip != 0 and prim_name != '' and company_name != ''),hash(zip,prim_name)),
	dedup(distribute(TopBusiness_External.Files().Address.QA,hash(zip,prim_name)),zip,prim_name,company_name,bid,all,local),
	// Join criteria
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	ut.StringSimilar100(left.company_name,right.company_name) <= 50,
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
	limit(10000,skip),
	local);

// Dedup the results
#uniquename(DedupOnlyZipPnFuzzyMatchedFile)
%DedupOnlyZipPnFuzzyMatchedFile% :=
	dedup(
		sort(%OnlyZipPnFuzzyMatchedFile%,zip,prim_name,sequencenumber_field,bid_field,-bid_score,local),
		zip,prim_name,sequencenumber_field,bid_field,local);

// Now, count how many hits there were and reduce score appropriately
#uniquename(OnlyZipPnHitCounts)
%OnlyZipPnHitCounts% :=
	table(
		%DedupOnlyZipPnFuzzyMatchedFile%,
		{zip,prim_name,sequencenumber_field,unsigned cnt := count(group)},
		zip,prim_name,sequencenumber_field,local);

#uniquename(AdjustedOnlyZipPnFuzzyMatchedFile);
%AdjustedOnlyZipPnFuzzyMatchedFile% := join(
	%DedupOnlyZipPnFuzzyMatchedFile%,
	%OnlyZipPnHitCounts%,
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(left),
		self.bid_score := left.bid_score div right.cnt,
		self := left),
	local);

// First, match on zip and company name match.
#uniquename(OnlyZipFuzzyMatchedFile)
%OnlyZipFuzzyMatchedFile% := join(
	distribute(externalfile((unsigned3)zip != 0 and company_name != ''),hash(zip)),
	dedup(distribute(TopBusiness_External.Files().Address.QA,hash(zip)),zip,company_name,bid,all,local),
	// Join criteria
	left.zip = right.zip and
	ut.StringSimilar100(left.company_name,right.company_name) <= 50,
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
	limit(10000,skip),
	local);

// Dedup the results
#uniquename(DedupOnlyZipFuzzyMatchedFile)
%DedupOnlyZipFuzzyMatchedFile% :=
	dedup(
		sort(%OnlyZipFuzzyMatchedFile%,zip,sequencenumber_field,bid_field,-bid_score,local),
		zip,sequencenumber_field,bid_field,local);

// Now, count how many hits there were and reduce score appropriately
#uniquename(OnlyZipHitCounts)
%OnlyZipHitCounts% :=
	table(
		%DedupOnlyZipFuzzyMatchedFile%,
		{zip,sequencenumber_field,unsigned cnt := count(group)},
		zip,sequencenumber_field,local);

#uniquename(AdjustedOnlyZipFuzzyMatchedFile);
%AdjustedOnlyZipFuzzyMatchedFile% := join(
	%DedupOnlyZipFuzzyMatchedFile%,
	%OnlyZipHitCounts%,
	left.zip = right.zip and
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(left),
		self.bid_score := left.bid_score div right.cnt,
		self := left),
	local);

outfile := %AdjustedFullAddrFuzzyMatchedFile% + %AdjustedOnlyZipPnFuzzyMatchedFile% + %AdjustedOnlyZipFuzzyMatchedFile%;

ENDMACRO;