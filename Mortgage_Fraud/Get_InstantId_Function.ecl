
import ut, Mortgage_Fraud, risk_indicators, gateway;

export Get_InstantId_Function(dataset(Mortgage_Fraud.layouts.Layout_CIID_BtSt_In) inf, 
                          dataset(Gateway.Layouts.Config) gateways,
													unsigned1 dppa, 
													unsigned1 glb, 
													boolean isUtility = false, 
													boolean ln_branded, 
													boolean ofac_only = true,
													BOOLEAN suppressNearDups = false, 
													boolean require2Ele = false,
													boolean from_BIID = false, 
													boolean isFCRA = false, 
													boolean ExcludeWatchLists = false, 
													boolean from_IT1O = false, 
													unsigned1 ofac_version = 1,
													boolean include_ofac = FALSE, 
													boolean include_additional_watchlists = false, 
													real global_watchlist_threshold = .84,
													integer2 dob_radius = -1, 
													unsigned1 BSversion = 1,
													unsigned8 BSOptions = 0,
													BOOLEAN   DISPLAYOutput = false,
													string50 DataRestriction = risk_indicators.iid_constants.default_DataRestriction,
													boolean runDLverification = false,
													string50 DataPermission = risk_indicators.iid_constants.default_DataPermission
													) := FUNCTION

seqrec := record
	inf;
	unsigned4	seq;
end;


seqrec into_seq(inf L) := transform
	self.seq := L.Borrower1_In.seq * 2;
	self := l;
end;

fs := project(inf, into_seq(LEFT));

risk_indicators.Layout_Input norm_into_in(fs l, integer C) := transform
	self.seq := L.seq + C - 1;
	self := if (C = 1, L.Borrower1_In, L.Borrower2_In);
end;

df := normalize(fs, 2, norm_into_in(LEFT,COUNTER));

outIID := risk_indicators.InstantID_Function(df, gateways, dppa, glb, isUtility, ln_branded, ofac_only,
									suppressNearDups, require2Ele, from_BIID, isFCRA, ExcludeWatchLists, from_IT1O, ofac_version,
									include_ofac, include_additional_watchlists, global_watchlist_threshold, dob_radius, 
									BSversion, in_DataRestriction := DataRestriction, in_runDLverification:=runDLverification,
									in_DataPermission := DataPermission, in_BSOptions := bsOptions);

outseq := record
	unsigned4	 seq;
	Mortgage_Fraud.layouts.Layout_CIID_BtSt_Output;
end;

outseq into_out1(outIID L) := transform
	self.seq := if (L.seq % 2 = 0, L.seq, skip);
	self.Borrower1_Output := L;
	self := [];
end;

outIID2 := project(outIID, into_out1(LEFT));

Mortgage_Fraud.layouts.layout_ciid_btst_Output into_out2(outIID2 L, outIID R) := transform
	self.Borrower2_Output := R;
	self := L;
end;

outIID3 := join(outIID2, outIID, left.seq = right.seq - 1, into_out2(LEFT,RIGHT), left outer);
groupIID := group(sort(outIID3, Borrower1_Output.seq),Borrower1_Output.seq);

IF(DISPLAYOutput, output  (outIID,   named('outIID')));
IF(DISPLAYOutput, output  (outIID2,  named('outIID2')));
IF(DISPLAYOutput, output  (outIID3,  named('outIID3')));
IF(DISPLAYOutput, output  (groupIID, named('groupIID')));

return groupIID;

end;
