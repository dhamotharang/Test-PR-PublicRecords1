import AID;

export Layout_IDEXEC_Base := record
	InfoUSA.Layout_Cleaned_IDEXEC_file;
	unsigned6 bid							:= 0;
	unsigned1 bid_score				:= 0;
	AID.Common.xAID	Raw_AID;
	AID.Common.xAID	ACE_AID;
	string100	Firm_prep_addr_line1;
	string50	Firm_prep_addr_line_last;
end;