EXPORT MAC_External_BID(
	 infile													// The input file to have BIDs appended
	,outfile												// The output file to write to
	,bid_field						= '\'\''	// The field into which the BID should be populated
	,bid_score_field			= '\'\''	// The field into which the BID score should be populated
	,source_field					= '\'\''	// The field in which the source value is populated
	,source_docid_field		= '\'\''	// The field in which the source_docid value is populated
	,source_party_field		= '\'\''	// The field in which the source_party value is populated
	,company_name_field		= '\'\''	// The field in which the company_name value is populated
	,zip_field						= '\'\''	// The field in which the ZIP value is populated
	,prim_name_field			= '\'\''	// The field in which the prim_name value is populated
	,prim_range_field			= '\'\''	// The field in which the prim_range value is populated
	,fein_field						= '\'\''	// The field in which the FEIN value is populated
	,phone_field					= '\'\''	// The field in which the phone value is populated
	,return_bid_score			= false		// Do we want to return a BID score at all?
) := MACRO

import ut,TopBusiness;

// If necessary add fields to the input file layout
#uniquename(AdjustedInfileLayout)
%AdjustedInfileLayout% := RECORD
	recordof(infile) OR
	{
		unsigned6 bid_field;
#if(return_bid_score)
		unsigned1 bid_score_field;
#end
	};
end;

// Add unique sequence number to input file
#uniquename(InfileSequenceLayout)
#uniquename(SequenceNumber)
%InfileSequenceLayout% := RECORD
  unsigned6 %SequenceNumber% := 0;
  %AdjustedInfileLayout%;
END;

#uniquename(SequencedInfile)
%SequencedInfile% := PROJECT(infile,
	transform(%InfileSequenceLayout%,
		self.%SequenceNumber% := counter,
		self := left,
		self := []));

// Project input file to slim layout for matching
#uniquename(InfileSlimLayout)
%InfileSlimLayout% := RECORD
	%InfileSequenceLayout%.%SequenceNumber%;
	%InfileSequenceLayout%.bid_field;
	unsigned1 bid_score;
	TopBusiness_External.Layouts.Source.source;
	TopBusiness_External.Layouts.Source.source_docid;
	TopBusiness_External.Layouts.Source.source_party;
	TopBusiness_External.Layouts.Address.company_name;
	TopBusiness_External.Layouts.Address.zip;
	TopBusiness_External.Layouts.Address.prim_name;
	TopBusiness_External.Layouts.Address.prim_range;
	TopBusiness_External.Layouts.Address.fein;
	TopBusiness_External.Layouts.Address.phone;
END;

#uniquename(SlimInfileBeforeClean)
%SlimInfileBeforeClean% := project(%SequencedInfile%,
	transform(%InfileSlimLayout%,
		self.bid_field := 0,
		self.bid_score := 0,
		self.source := evaluate(left,source_field),
		self.source_docid := evaluate(left,source_docid_field),
		self.source_party := evaluate(left,source_party_field),
		self.company_name := evaluate(left,company_name_field),
		self.zip := evaluate(left,zip_field),
		self.prim_name := evaluate(left,prim_name_field),
		self.prim_range := evaluate(left,prim_range_field),
		self.fein := evaluate(left,fein_field),
		self.phone := evaluate(left,phone_field),
		self := left));

#uniquename(SlimInfile)
TopBusiness.Macro_CleanCompanyName(%SlimInfileBeforeClean%(company_name != ''),company_name,company_name,%SlimInfile%);

#uniquename(SourceMatchedFile)
TopBusiness_External.MAC_External_BID_Source(%SlimInfile%,%SequenceNumber%,bid_field,%SourceMatchedFile%);
#uniquename(NotSourceMatched)
%NotSourceMatched% := join(
	distribute(%SlimInfile%,hash64(%SequenceNumber%)),
	distribute(%SourceMatchedFile%,hash64(%SequenceNumber%)),
	left.%SequenceNumber% = right.%SequenceNumber%,
	transform(left),
	left only,
	local);
#uniquename(AddressMatchedFile)
TopBusiness_External.MAC_External_BID_Address(%NotSourceMatched%,%SequenceNumber%,bid_field,%AddressMatchedFile%);
#uniquename(FEINMatchedFile)
TopBusiness_External.MAC_External_BID_FEIN(%NotSourceMatched%,%SequenceNumber%,bid_field,%FEINMatchedFile%);
#uniquename(PhoneMatchedFile)
TopBusiness_External.MAC_External_BID_Phone(%NotSourceMatched%,%SequenceNumber%,bid_field,%PhoneMatchedFile%);

#uniquename(AllMatchedFile)
%AllMatchedFile% :=
	%SlimInfile% +
	%SourceMatchedFile% +
	%AddressMatchedFile% +
	%FEINMatchedFile% +
	%PhoneMatchedFile% +
	%SlimInfileBeforeClean%(company_name = '');
	
// Roll up to eliminate records with multiple "best" BIDs
#uniquename(RolledExactMatchedFile)
%RolledExactMatchedFile% := rollup(
	sort(
		distribute(%AllMatchedFile%,hash(%SequenceNumber%)),
		%SequenceNumber%,-bid_score,bid_field,local),
	left.%SequenceNumber% = right.%SequenceNumber%,
	transform(recordof(left),
		self.bid_score := if(left.bid_score = right.bid_score and left.bid_field != right.bid_field,0,left.bid_score),
		self.bid_field := if(left.bid_score = right.bid_score and left.bid_field != right.bid_field,0,left.bid_field),
		self := left),
	local);

#uniquename(InfileBID)
%InfileBID% := join(
	distribute(%SequencedInfile%,hash(%SequenceNumber%)),
	distribute(%RolledExactMatchedFile%,hash(%SequenceNumber%)),
	left.%SequenceNumber% = right.%SequenceNumber%,
	transform(%AdjustedInfileLayout%,
		self.bid_field := right.bid_field,
#if(return_bid_score)
		self.bid_score_field := right.bid_score,
#end
		self := left),
	left outer,
	local);

outfile := %InfileBID%;

ENDMACRO;