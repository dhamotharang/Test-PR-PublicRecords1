export MAC_External_BID_Address(
	 externalfile
	,sequencenumber_field
	,bid_field
	,outfile
) :=
MACRO

// First, match on address and exact company name match.
#uniquename(ExactMatchedFile)
%ExactMatchedFile% := join(
	distribute(externalfile(bid_field = 0 and (unsigned3)zip != 0 and prim_name != '' and (prim_name[1..7] = 'PO BOX ' or prim_range != '') and company_name != ''),hash(zip,prim_name,prim_range)),
	distributed(TopBusiness_External.Files().Address.QA,hash(zip,prim_name,prim_range)),
	// Join criteria
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
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

// Now, match on address and FEIN and phone number and fuzzy company name match.
#uniquename(FEINPhoneFuzzyMatchedFile)
%FEINPhoneFuzzyMatchedFile% := join(
	%RolledExactMatchedFile%,
	distributed(TopBusiness_External.Files().Address.QA,hash(zip,prim_name,prim_range)),
	left.bid_field = 0 and
	left.fein != '' and right.fein != '' and
	left.phone != '' and right.phone != '' and
	// Join criteria
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	left.fein = right.fein and
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
#uniquename(RolledFEINPhoneFuzzyMatchedFile)
%RolledFEINPhoneFuzzyMatchedFile% := rollup(
	sort(%FEINPhoneFuzzyMatchedFile%,sequencenumber_field,score,bid_field,local),
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(%FEINPhoneFuzzyMatchedFile%),
		self.score := left.score,
		self.bid_field := if(left.score = right.score and left.bid_field != right.bid_field,0,left.bid_field),
		self := left),
	local);

// Now, match on address and FEIN and fuzzy company name match.
#uniquename(FEINFuzzyMatchedFile)
%FEINFuzzyMatchedFile% := join(
	%RolledFEINPhoneFuzzyMatchedFile%,
	distributed(TopBusiness_External.Files().Address.QA,hash(zip,prim_name,prim_range)),
	left.bid_field = 0 and
	left.fein != '' and right.fein != '' and
	// Join criteria
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	left.fein = right.fein and
	ut.StringSimilar100(left.company_name,right.company_name) <= 35,
	transform(recordof(%RolledFEINPhoneFuzzyMatchedFile%),
		self.score := ut.StringSimilar100(left.company_name,right.company_name),
		self.bid_field := if(right.bid = 0,left.bid_field,right.bid),
		self := left),
	left outer,
	limit(3000,skip),
	local);

// Roll up to eliminate records with multiple BIDs
#uniquename(RolledFEINFuzzyMatchedFile)
%RolledFEINFuzzyMatchedFile% := rollup(
	sort(%FEINFuzzyMatchedFile%,sequencenumber_field,score,bid_field,local),
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(%FEINFuzzyMatchedFile%),
		self.score := left.score,
		self.bid_field := if(left.score = right.score and left.bid_field != right.bid_field,0,left.bid_field),
		self := left),
	local);

// Now, match on address and phone and fuzzy company name match.
#uniquename(PhoneFuzzyMatchedFile)
%PhoneFuzzyMatchedFile% := join(
	%RolledFEINFuzzyMatchedFile%,
	distributed(TopBusiness_External.Files().Address.QA,hash(zip,prim_name,prim_range)),
	left.bid_field = 0 and
	left.phone != '' and right.phone != '' and
	// Join criteria
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	left.phone = right.phone and
	ut.StringSimilar100(left.company_name,right.company_name) <= 35,
	transform(recordof(%RolledFEINFuzzyMatchedFile%),
		self.score := ut.StringSimilar100(left.company_name,right.company_name),
		self.bid_field := if(right.bid = 0,left.bid_field,right.bid),
		self := left),
	left outer,
	limit(3000,skip),
	local);

// Roll up to eliminate records with multiple BIDs
#uniquename(RolledPhoneFuzzyMatchedFile)
%RolledPhoneFuzzyMatchedFile% := rollup(
	sort(%PhoneFuzzyMatchedFile%,sequencenumber_field,score,bid_field,local),
	left.sequencenumber_field = right.sequencenumber_field,
	transform(recordof(%PhoneFuzzyMatchedFile%),
		self.score := left.score,
		self.bid_field := if(left.score = right.score and left.bid_field != right.bid_field,0,left.bid_field),
		self := left),
	local);

// Now, match on address and fuzzy company name match.
#uniquename(FuzzyMatchedFile)
%FuzzyMatchedFile% := join(
	%RolledPhoneFuzzyMatchedFile%,
	distributed(TopBusiness_External.Files().Address.QA,hash(zip,prim_name,prim_range)),
	left.bid_field = 0 and
	// Join criteria
	left.zip = right.zip and
	left.prim_name = right.prim_name and
	left.prim_range = right.prim_range and
	ut.StringSimilar100(left.company_name,right.company_name) <= 35,
	transform(recordof(%RolledPhoneFuzzyMatchedFile%),
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

outfile := project(%RolledFuzzyMatchedFile%,recordof(externalfile)) + externalfile(not(bid_field = 0 and (unsigned3)zip != 0 and prim_name != '' and (prim_name[1..7] = 'PO BOX ' or prim_range != '') and company_name != ''));

ENDMACRO;