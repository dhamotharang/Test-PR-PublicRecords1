import risk_indicators, gateway, business_risk;

export InstantId_Function_BtSt(dataset(Layout_BIID_BtSt) inf, dataset(Gateway.Layouts.Config) gateways, boolean hasbdids = false, 
                               unsigned1 dppa, 
                               unsigned1 glb, 
                               boolean isUtility=false, 
                               boolean ln_branded=false, 
                               string4 tribcode='',
                               unsigned1 ofac_version = 1,
                               boolean include_ofac = false,
                               boolean include_additional_watchlists = false,
                               real global_watchlist_threshold = 0.84, 
                               string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction,
                               string50 DataPermission=risk_indicators.iid_constants.default_DataPermission,
                               unsigned1 LexIdSourceOptout = 1,
                               string TransactionID = '',
                               string BatchUID = '',
                               unsigned6 GlobalCompanyId = 0) := function


seqrec := record
	layout_biid_btst;
	unsigned4	seq;
end;

seqrec into_seq(inf L) := transform
	self.seq := l.bill_to_input.seq * 2;
	self := L;
end;

df := project(inf, into_seq(LEFT));

business_risk.layout_input norm_to_input(df L, integer C) := transform
	self.seq := L.seq + C - 1;
	self := if (C = 1, L.bill_to_input, L.ship_to_input);
end;

df2 := normalize(df, 2, norm_to_input(LEFT,COUNTER));

outf1 := business_risk.InstantID_Function(df2, gateways, hasbdids, dppa, glb, isUtility, ln_branded, tribcode, , , ofac_version, include_ofac, include_additional_watchlists, 
                                          global_watchlist_threshold, DataRestriction:=DataRestriction, DataPermission:=DataPermission,
                                          LexIdSourceOptout := LexIdSourceOptout, 
                                          TransactionID := TransactionID, 
                                          BatchUID := BatchUID, 
                                          GlobalCompanyID := GlobalCompanyID);

out_seqrec := record
	unsigned4	seq;
	business_risk.Layout_BIID_BtSt_Output;
end;

out_Seqrec into_out1(outf1 R) := transform
	self.seq := if (R.seq % 2 = 0, R.seq, skip);
	self.Bill_to_output := R;
	self := [];
end;

outf2 := project(outf1, into_out1(LEFT));

business_risk.layout_biid_btst_output into_out2(outf2 L, outf1 R) := transform
	self.Ship_to_output := R;
	self := L;
end;

outf3 := join(outf2,outf1, left.seq = right.seq - 1, into_out2(LEFT,RIGHT), left outer);

return outf3;

end;
