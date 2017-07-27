
import riskwise, gateway, BizLinkFull, Models, Risk_Indicators;
 
export Get_Boca_Shell_Function(grouped dataset(Mortgage_Fraud.layouts.layout_ciid_btst_Output) iid_btst, 
																dataset(Gateway.Layouts.Config) gateways,
																unsigned1 dppa, 
																unsigned1 glb, 
																boolean isUtility = false, 
																boolean isLN = false, 
																boolean includeRelativeInfo = true, 
																boolean includeDLInfo = true, 
																boolean includeVehInfo = true,
																boolean includeDerogInfo = true, 
																unsigned1 BSversion = 53, 
																boolean doScore = false, 
																boolean DISPLAYOutput = false,
																boolean nugen = false,
																string50 DataRestriction=risk_indicators.iid_constants.default_DataRestriction, 
																unsigned8 inBSOptions = 0,
																string50 DataPermission = risk_indicators.iid_constants.default_DataPermission,
																boolean NetAcuity_v4 = true
																) := FUNCTION 

risk_indicators.Layout_Output norm(iid_btst L, integer C) := transform
	self.seq := L.Borrower1_Output.seq + C - 1;
	self := if (C = 1, L.Borrower1_Output, L.Borrower2_Output);
end;

iid_dataset := normalize(iid_btst, 2, norm(LEFT,COUNTER));
	

outf := risk_indicators.Boca_Shell_Function(iid_dataset, 
                                            gateways, 
																						dppa, 
																						glb, 
																						isUtility, 
																						isLN, 
																						includeRelativeInfo, 
																						includeDLInfo, 
																						includeVehInfo, 
																						includeDerogInfo, 
																						BSversion, 
																						doScore, 
																						nugen := nugen, 
																						DataRestriction := DataRestriction,
																						BSOptions := inBSOptions, 
																						DataPermission := DataPermission);

outseq := record
	unsigned4	seq;
	Mortgage_Fraud.layouts.Layout_BocaShell_Out;
end;

outseq into_out1(outf L) := transform
	self.seq := If (L.seq % 2 = 0, L.seq, skip);
	self.Borrower1_Boca_out := L;
	self := [];
end;

outf2 := project(outf, into_out1(LEFT));

Mortgage_Fraud.layouts.Layout_BocaShell_Out into_out2(outf2 L, outf R) := transform
	self.Borrower2_Boca_out := R;
	self := L;
end;

final := join(outf2, outf, left.seq = right.seq - 1, into_out2(LEFT,RIGHT), left outer);
                
IF(DISPLAYOutput,output(iid_btst,    named('iid_btst')));
IF(DISPLAYOutput,output(iid_dataset, named('iid_dataset')));
IF(DISPLAYOutput,output(outf,        named('outf')));
IF(DISPLAYOutput,output(outf2,       named('outf2')));
IF(DISPLAYOutput,output(final,       named('final')));
   	 
return final;

end;