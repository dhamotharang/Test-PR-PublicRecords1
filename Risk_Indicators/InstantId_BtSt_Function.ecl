import gateway, doxie, risk_indicators;

export InstantId_BtSt_Function(dataset(risk_indicators.Layout_CIID_BtSt_In) inf, dataset(Gateway.Layouts.Config) gateways,
													unsigned1 dppa, unsigned1 glb, 
													boolean isUtility=false, boolean ln_branded, 
													boolean ofac_only=true,
													BOOLEAN suppressNearDups=false, boolean require2Ele=false,
													boolean from_BIID=false, boolean isFCRA=false, boolean ExcludeWatchLists=false, 
													boolean from_IT1O=false, unsigned1 ofac_version=1,boolean include_ofac=FALSE, 
													boolean include_additional_watchlists=false, real global_watchlist_threshold=.84,
													integer2 dob_radius=-1, unsigned1 BSversion=1,
													string50 DataRestriction = risk_indicators.iid_constants.default_DataRestriction,
													boolean runDLverification=false,
													string50 DataPermission = risk_indicators.iid_constants.default_DataPermission,
													unsigned8 BSOptions = 0,
                                                    unsigned1 LexIdSourceOptout = 1,
                                                    string TransactionID = '',
                                                    string BatchUID = '',
                                                    unsigned6 GlobalCompanyId = 0
													) := FUNCTION

   mod_access := MODULE(Doxie.IDataAccess)
      EXPORT unsigned1 lexid_source_optout := LexIdSourceOptout;
      EXPORT string transaction_id := TransactionID; // esp transaction id or batch uid
      EXPORT unsigned6 global_company_id := GlobalCompanyId; // mbs gcid
    END;
    
seqrec := record
	inf;
	unsigned4	seq;
end;


seqrec into_seq(inf L) := transform
	self.seq := L.bill_to_in.seq * 2;
	self := l;
end;

	//CBD 51 - if digital order then run Doxie Best
appendedSTinfo := Risk_Indicators.Boca_Shell_BtSt_ImputingST(inf, glb, dppa, ,DataRestriction, mod_access);	
inf_info := if(bsversion >= 51, appendedSTinfo, inf); 

fs := project(inf_info, into_seq(LEFT));

risk_indicators.Layout_Input norm_into_in(fs l, integer C) := transform
	self.seq := L.seq + C - 1;
	self := if (C = 1, L.Bill_to_In, L.ship_to_in);
end;

df := normalize(fs, 2, norm_into_in(LEFT,COUNTER));

outf1 := risk_indicators.InstantID_Function(df, gateways, dppa, glb, isUtility, ln_branded, ofac_only,
									suppressNearDups, require2Ele, from_BIID, isFCRA, ExcludeWatchLists, from_IT1O, ofac_version,
									include_ofac, include_additional_watchlists, global_watchlist_threshold, dob_radius, 
									BSversion, in_DataRestriction := DataRestriction, in_runDLverification:=runDLverification,
									in_DataPermission := DataPermission, in_BSOptions := bsOptions,
                                    LexIdSourceOptout := LexIdSourceOptout, TransactionID := TransactionID, 
                                    BatchUID := BatchUID, GlobalCompanyID := GlobalCompanyID);

outseq := record
	unsigned4	 seq;
	Layout_CIID_BtSt_Output;
end;

outseq into_out1(outf1 L) := transform
	self.seq := if (L.seq % 2 = 0, L.seq, skip);
	self.Bill_To_Output := L;
	self := [];
end;

outf2 := project(outf1, into_out1(LEFT));

layout_ciid_btst_Output into_out2(outf2 L, outf1 R) := transform
	self.Ship_to_output := R;
	self := L;
end;

outf3 := join(outf2, outf1, left.seq = right.seq - 1, into_out2(LEFT,RIGHT), left outer);
outf4 := group(sort(outf3, bill_to_output.seq),bill_to_output.seq);

return outf4;

end;
