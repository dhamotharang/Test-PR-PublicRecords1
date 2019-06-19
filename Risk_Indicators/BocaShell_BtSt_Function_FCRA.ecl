import FCRA, gateway, risk_indicators;

export BocaShell_BtSt_Function_FCRA(dataset(risk_indicators.Layout_BocaShell_BtSt_In) inf, dataset(Gateway.Layouts.Config) gateways,
													unsigned1 dppa, unsigned1 glb, boolean isUtility=false, boolean isLN=false,
													boolean require2Ele = false,
													// optimization options
													boolean includeRelativeInfo=true, boolean includeDLInfo=true, boolean includeVehInfo=true,
													boolean includeDerogInfo=true,
													unsigned1 BSversion=1,
													boolean isPreScreen=false, 
													boolean doScore=false,
													string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction, 
													boolean excludewatchlists=false,
													string50 DataPermission=risk_indicators.iid_constants.default_DataPermission) := 

FUNCTION

risk_indicators.Layout_BocaShell_BtSt_In into_seq(inf le) := TRANSFORM
	self.seq := le.seq * 2;
	self := le;
END;
df := project(inf, into_seq(LEFT));

risk_indicators.layout_input into_in(df le, integer C) := TRANSFORM
	self.seq := le.seq + C - 1;
	self := if(C = 1, le.Bill_to_In, le.Ship_To_In);
END;
pre_iid2 := normalize(df, 2, into_in(LEFT,COUNTER));




ids_wide := group(sort(FCRA.Boca_Shell_FCRA_Neutral_DID_Soapcall (pre_iid2, gateways, dppa, glb, 
													isUtility, isLN, includeRelativeInfo, require2Ele, IN_ExcludeWatchLists:=excludewatchlists, in_bsversion:=bsversion,datarestriction:=datarestriction,datapermission:=datapermission), seq), seq);

p := dedup(group(sort(project(ids_wide(~isrelat), transform (risk_indicators.Layout_Boca_Shell, self := LEFT)), seq), seq), seq);
  


risk_indicators.layout_output into_iid(p L) := transform
	self.fname := L.shell_input.fname;
	self.lname := L.shell_input.lname;
	self.dl_number := l.shell_input.dl_number;
	self.seq := L.seq;
	self.did := L.did;
	self.prim_range := L.address_verification.input_address_information.prim_range;
	self.prim_name := L.address_verification.input_address_information.prim_name;
	self.sec_range := L.address_verification.input_address_information.sec_range;
	self.z5 := L.address_verification.input_address_information.zip5;
	self := [];
end;
iid := project(p, into_iid(LEFT));



dppa_ok := dppa > 0 and dppa < 8;
filter_out_fares := true;
per_prop := risk_indicators.getAllBocaShellData (iid, ids_wide, p,
                                   TRUE, isLN, dppa, dppa_ok,
                                   includeRelativeInfo, includeDLInfo, includeVehInfo, includeDerogInfo,
								   BSVersion, isPreScreen, doScore, filter_out_fares, DataRestriction, 0, glb, gateways, DataPermission);



outseq := record
	unsigned4	seq;
	risk_indicators.layout_bocashell_btst_out;
end;

outseq into_out1(per_prop L) := transform
	self.seq := if(L.seq % 2 = 0, L.seq, skip);
	self.bill_to_out := L;
	self := [];
end;
outf2 := project(per_prop, into_out1(LEFT));

risk_indicators.layout_bocashell_btst_out into_out2(outf2 L, per_prop R) := transform
	self.ship_to_out := R;
	self := L;
end;
outf := group(sort(join(outf2, per_prop, left.seq = right.seq - 1, into_out2(LEFT,RIGHT), left outer), bill_to_out.seq), bill_to_out.seq);

return outf;
END;