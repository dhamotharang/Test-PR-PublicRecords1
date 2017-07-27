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
#if(return_bid_score)
	%InfileSequenceLayout%.bid_score_field;
#end
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

#uniquename(SlimInfile)
%SlimInfile% := project(%SequencedInfile%,
	transform(%InfileSlimLayout%,
		self.bid_field := 0,
#if(return_bid_score)
		self.bid_score_field := 0,
#end
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

#uniquename(SourceMatchedFile)
TopBusiness_External.MAC_External_BID_Source(%SlimInfile%,%SequenceNumber%,bid_field,%SourceMatchedFile%);
#uniquename(AddressMatchedFile)
TopBusiness_External.MAC_External_BID_Address(%SourceMatchedFile%,%SequenceNumber%,bid_field,%AddressMatchedFile%);
#uniquename(FEINMatchedFile)
TopBusiness_External.MAC_External_BID_FEIN(%AddressMatchedFile%,%SequenceNumber%,bid_field,%FEINMatchedFile%);
#uniquename(PhoneMatchedFile)
TopBusiness_External.MAC_External_BID_Phone(%FEINMatchedFile%,%SequenceNumber%,bid_field,%PhoneMatchedFile%);

// Distribute, sort, and dedup by Unique ID
#uniquename(DedupedMatchedFile)
%DedupedMatchedFile% := dedup(
	sort(
		distribute(%PhoneMatchedFile%,hash(%SequenceNumber%)),
		%SequenceNumber%,if(bid_field != 0,0,1),bid_field,local),
	%SequenceNumber%);

#uniquename(InfileBID)
%InfileBID% := join(
	distribute(%SequencedInfile%,hash(%SequenceNumber%)),
	distribute(%DedupedMatchedFile%,hash(%SequenceNumber%)),
	left.%SequenceNumber% = right.%SequenceNumber%,
	transform(%AdjustedInfileLayout%,
		self.bid_field := right.bid_field,
		self := left),
	left outer,
	local);

outfile := %InfileBID%;

ENDMACRO;