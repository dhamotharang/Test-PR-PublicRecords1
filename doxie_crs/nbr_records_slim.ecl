import doxie,CriminalRecords_Services;
doxie.MAC_Selection_Declare();
slimFmt		:= doxie.layout_nbr_records_slim;
nbrRows		:= doxie_crs.nbr_records;
addrRows	:= doxie.Comp_Addresses;

tmpFmt := record
	unsigned2 address_seq_no;
	nbrRows;
end;

tmpFmt doSeq(nbrRows L, addrRows R) := transform
		SELF.address_seq_no := R.address_seq_no;
		SELF := L;
end;

slimRows := join(
	nbrRows, addrRows,
	LEFT.did = RIGHT.did
		AND LEFT.zip = RIGHT.zip
		AND LEFT.prim_name = RIGHT.prim_name
		AND LEFT.prim_range = RIGHT.prim_range
		AND LEFT.sec_range = RIGHT.sec_range,
	doSeq(LEFT, RIGHT), keep (1) 
);

slimFmt doBaseSeq(slimRows L, addrRows R) := transform
		SELF.base_address_seq_no := R.address_seq_no;
		SELF := L;
end;

slimRows_b := join(
	slimRows, addrRows,
	LEFT.base_did = RIGHT.did
		AND LEFT.zip = RIGHT.zip
		AND LEFT.prim_name = RIGHT.prim_name
		AND LEFT.base_prim_range = (integer)RIGHT.prim_range
		AND LEFT.base_sec_range = RIGHT.sec_range,
	doBaseSeq(LEFT, RIGHT), keep (1)
);

slimRows_s := sort(
	slimRows_b,
	mode, seqTarget, seqNPA, seqNbr
);

// OUTPUT(nbrRows, named('nbrRows'));				// DEBUG
// OUTPUT(addrRows, named('addrRows'));			// DEBUG
// OUTPUT(slimRows_b, named('slimRows_b'));	// DEBUG
// OUTPUT(slimRows_s, named('slimRows_s'));	// DEBUG

// add crim indicators
recsIn := PROJECT(slimRows_s,TRANSFORM({slimFmt,STRING12 UniqueId},SELF.UniqueId:=(STRING)LEFT.did,SELF:=LEFT,SELF:=[]));
CriminalRecords_Services.MAC_Indicators(recsIn,recsOut);
outfile := PROJECT(IF(include_CriminalIndicators_val,recsOut,recsIn),slimFmt);

export nbr_records_slim := outfile;