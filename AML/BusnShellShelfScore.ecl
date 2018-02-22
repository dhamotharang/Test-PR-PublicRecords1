IMPORT ut, std;

EXPORT BusnShellShelfScore(DATASET(Layouts.BusnLayoutV2) BDIDsIn) := FUNCTION

ShellScoreSlimLayout := RECORD
  unsigned4		seq;
	UNSIGNED3		historydate;
	unsigned6   	OrigBdid;
  unsigned3 		BusnRelatDegree ;
	string30  	ShellBusnInd;
	STRING1   LooseIncorpInd;
	STRING1   busStrucInd;
	STRING1   NoFeinInd;
	STRING1   NoBureauSrcInd;
	STRING1   SrcCntInd;
	STRING1   ShellSrcInd;
	STRING1   CurrRAInd;
	STRING1   RAAddrInd;
	STRING1   CurrAddrInd;
	STRING1   AddrLooseIncorpInd;
	STRING1   BusaddrNoFeinInd;
	STRING1   AgedShelfInd;
	unsigned1  IndCount;
END;

ShellIndicatorLayout := RECORD
	unsigned4		seq;
  UNSIGNED3		historydate;
	unsigned6   	Bdid;
	string1      ShellInd;
	string30  	  ShellBusnIndvalues;
	unsigned1    IndCount;
END;
 



ShellScoreSlimLayout  GetPoints(BDIDsIn le) := TRANSFORM
  self.seq           					:= le.seq;
	self.historydate 						:= le.historydate;
	self.origbdid  							:= le.origbdid;
	self.BusnRelatDegree 				:= le.BusnRelatDegree;
	self.busStrucInd      		:= if((trim(le.busnType) = 'TRUST' or 											
																	trim(le.busnType) = 'LIMITED LIABILITY CORPORATION'		or 
																	trim(le.busnType) = 'FOREIGN LLC'	), 'A', '');
  self.NoFeinInd        		:= if(le.NoFein, 'B', '');  
	self.LooseIncorpInd    		:= if(le.inc_st_loose, 'C', '');
	self.NoBureauSrcInd    		:= if(le.CreditSrcCnt = 0, 'D', '');
	self.SrcCntInd          		:= if(le.srcCount = 1, 'E', '');
	self.ShellSrcInd        		:= if(le.ShellHdrSrcCnt	= 0, 'F', '');
	self.CurrRAInd         		:= if(le.HasCurrRA, 'G', '');
	self.RAAddrInd           	:= if(le.RAPotentialNIS or le.RAShelfBusn, 'H', '');
	self.CurrAddrInd           := if(le.drop or le.potential_remail or
																le.priv_post or le.undel_sec or le.storage, 'I', '');
	self.AddrLooseIncorpInd    := if(le.busAddrCntLooseIncorp, 'J', '');
	self.BusaddrNoFeinInd      := if(le.BusAddrCntnoFein, 'K', '');
	self.AgedShelfInd        := if(le.SOSFirstReported <> 0 and
																					((round((ut.DaysApart((string)le.SOSFirstReported, (STRING)Std.Date.Today())) / 30) >= 24 and
																					round((ut.DaysApart((string)le.BusnHdrDtFirstNonCredit, (STRING)Std.Date.Today())) / 30) < 24 and
																					round((ut.DaysApart((string)le.BusnHdrDtFirstNonCredit, (string)le.SOSFirstReported)) / 30) >= 24)
																					or le.srcCount = 0), 'L', '');
	
	self := [];
	
END;

GetShellInd := project(BDIDsIn, GetPoints(left));

ShellIndicatorLayout NormINDs(GetShellInd le, INTEGER C) := TRANSFORM
	SELF.seq := le.seq;
	self.Bdid := le.OrigBdid;
	self.historydate 		:= le.historydate;
	self.ShellInd  := CHOOSE(C, le.LooseIncorpInd	,le.busStrucInd	,le.NoFeinInd	,le.NoBureauSrcInd	,le.SrcCntInd	,le.ShellSrcInd	,le.CurrRAInd	,le.RAAddrInd	,le.CurrAddrInd	,le.AddrLooseIncorpInd	,le.BusaddrNoFeinInd	,le.AgedShelfInd);
	self.ShellBusnIndvalues := CHOOSE(C, le.LooseIncorpInd	,le.busStrucInd	,le.NoFeinInd	,le.NoBureauSrcInd	,le.SrcCntInd	,le.ShellSrcInd	,le.CurrRAInd	,le.RAAddrInd	,le.CurrAddrInd	,le.AddrLooseIncorpInd	,le.BusaddrNoFeinInd	,le.AgedShelfInd);
	self := [];
END;

NormInd := NORMALIZE(GetShellInd,12,NormINDs(LEFT,COUNTER));


TableInd := table(NormInd(shellInd <> ''), {seq, bdid, unsigned1 IndCount := count(group)}, seq,bdid);

ValidIndicators := sort(NormInd(shellInd <> ''), seq, bdid, shellind);

ShellIndicatorLayout  Indrollup(ValidIndicators le, ValidIndicators ri) := TRANSFORM
	self.seq   := le.seq;
  self.historydate   := le.historydate;
	self.Bdid    := le.Bdid;
	self.ShellInd   := le.ShellInd;
	// IndValues := Business_Risk_BIP.Common.convertDelimited(SortedInquiries, InquiryDate, Business_Risk_BIP.Constants.FieldDelimiter);
	self.ShellBusnIndvalues   := trim(le.ShellBusnIndvalues) + if(trim(ri.ShellBusnIndvalues) <> '', ',' + trim(ri.ShellBusnIndvalues), '');
	self.IndCount := 0;
END;



ShellIterate  := rollup(ValidIndicators, left.seq = right.seq and
																					left.bdid = right.bdid,
																					Indrollup(LEFT,RIGHT));


AddTotCnt := join(ShellIterate, TableInd,
									left.seq = right.seq and
									left.bdid = right.bdid,
									transform(ShellIndicatorLayout,
														 self.IndCount := if(right.bdid <> 0, right.IndCount,0);
														 self := left),left outer);

AddshellInd := join(BDIDsIn, AddTotCnt,
										right.seq = left.seq and
										right.bdid = left.origbdid,
										transform(Layouts.BusnLayoutV2,
															 self.ShellIndCount := right.IndCount,
															 self.ShellBusnIndvalues := right.ShellBusnIndvalues,
															 self := left), left outer);
									 



// output(BDIDsIn, named('BDIDsIn'));
// output(GetShellInd, named('GetShellInd'));
// output(NormInd, named('NormInd'));
// output(TableInd, named('TableInd'));
// output(ValidIndicators, named('ValidIndicators'));
// output(ShellIterate, named('ShellIterate'));
// output(AddTotCnt, named('AddTotCnt'));
// output(AddshellInd, named('AddshellInd'));

// RETURN GetFinalShellScore;
RETURN AddshellInd;

END;