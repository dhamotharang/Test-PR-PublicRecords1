IMPORT ut;

EXPORT LnkdBusnShellScore(DATASET(Layouts.BusnExecsLayoutV2) BDIDsIn) := FUNCTION

ShellScoreSlimLayout := RECORD
  unsigned4		seq;
	UNSIGNED3		historydate;
	unsigned6   	OrigBdid;
	unsigned6 		bdid := 0;
	unsigned6 		did := 0;
	unsigned6 		relatdid := 0;
	boolean     	LinkedBusn := false;
	boolean   		isExec := false;
  unsigned3 		RelatDegree ;
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
	unsigned6   	origBdid;
	unsigned6 		bdid := 0;
	unsigned6 		did := 0;
	string1      ShellInd;
	string30  	  ShellBusnIndvalues;
	unsigned1    IndCount;
END;

ShellScoreSlimLayout  GetPoints(BDIDsIn le) := TRANSFORM
  self.seq           					:= le.seq;
	self.historydate 						:= le.historydate;
	self.origbdid  							:= le.origbdid;
	self.bdid  									:= le.bdid;
	self.did  									:= le.did;
	self.RelatDegree 						:= le.RelatDegree;
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
																					((round((ut.DaysApart((string)le.SOSFirstReported, ut.GetDate)) / 30) >= 24 and
																					round((ut.DaysApart((string)le.BusnHdrDtFirstNonCredit, ut.GetDate)) / 30) < 24 and
																					round((ut.DaysApart((string)le.BusnHdrDtFirstNonCredit, (string)le.SOSFirstReported)) / 30) >= 24)
																					or le.srcCount = 0), 'L', '');
	
	self := [];
	
END;

GetShellInd := project(BDIDsIn, GetPoints(left));


ShellIndicatorLayout NormINDs(GetShellInd le, INTEGER C) := TRANSFORM
	SELF.seq := le.seq;
	self.origBdid := le.OrigBdid;
	self.Bdid := le.Bdid;
	self.did := le.did;
	self.historydate 		:= le.historydate;
	self.ShellInd  := CHOOSE(C, le.LooseIncorpInd	,le.busStrucInd	,le.NoFeinInd	,le.NoBureauSrcInd	,le.SrcCntInd	,le.ShellSrcInd	,le.CurrRAInd	,le.RAAddrInd	,le.CurrAddrInd	,le.AddrLooseIncorpInd	,le.BusaddrNoFeinInd	,le.AgedShelfInd);
	self.ShellBusnIndvalues := CHOOSE(C, le.LooseIncorpInd	,le.busStrucInd	,le.NoFeinInd	,le.NoBureauSrcInd	,le.SrcCntInd	,le.ShellSrcInd	,le.CurrRAInd	,le.RAAddrInd	,le.CurrAddrInd	,le.AddrLooseIncorpInd	,le.BusaddrNoFeinInd	,le.AgedShelfInd);
	self := [];
END;

NormInd := NORMALIZE(GetShellInd,12,NormINDs(LEFT,COUNTER));


TableInd := table(NormInd(shellInd <> ''), {seq, origbdid, bdid, unsigned1 IndCount := count(group)}, seq,origbdid, bdid);

ValidIndicators := sort(NormInd(shellInd <> ''), seq, bdid, shellind);

ShellIndicatorLayout  Indrollup(ValidIndicators le, ValidIndicators ri) := TRANSFORM
	self.seq   := le.seq;
  self.historydate   := le.historydate;
	self.origBdid    := le.origBdid;
	self.Bdid    := le.Bdid;
	self.did    := le.did;
	self.ShellInd   := le.ShellInd;
	self.ShellBusnIndvalues   := trim(le.ShellBusnIndvalues) + if(trim(ri.ShellBusnIndvalues) <> '', ',' + trim(ri.ShellBusnIndvalues), '');
	self.IndCount := 0;
END;


ShellIterate  := rollup(ValidIndicators, left.seq = right.seq and
																					left.bdid = right.bdid,
																					Indrollup(LEFT,RIGHT));


AddTotCnt := join(ShellIterate, TableInd,
												left.OrigBdid = right.OrigBdid and
												left.	bdid 	= right.bdid ,
									transform(ShellIndicatorLayout,
														 self.IndCount := if(right.bdid <> 0, right.IndCount,0);
														 self := left),left outer);
																	
																	
Layouts.BusnExecsLayoutV2  GetScore(BDIDsIn le,AddTotCnt ri ) := TRANSFORM

	self.seq 										:= le.seq; 
	self.historydate           := le.historydate;
	self.OrigBdid              := le.OrigBdid;
	self.bdid 									:= le.bdid;
	self.did 										:= le.did;
	self.relatdid 							:= le.relatdid;
	self.LinkedBusn 						:= Le.LinkedBusn;
	self.isExec 								:= le.isExec;
	self.ShellIndCount 					:= ri.IndCount,
	self.ShellBusnIndvalues 		:= ri.ShellBusnIndvalues,
	self := le;
END;

AddShellInds := join(BDIDsIn, AddTotCnt, 
												left.seq = right.seq and
												left.OrigBdid = right.OrigBdid and
												left.	bdid 	= right.bdid and
												left.did  = right.did,
												GetScore(left,right), left outer);


// output(BDIDsIn, named('LNKBDIDsIn'));
// output(GetShellInd, named('LNKGetShellInd'));
// output(NormInd, named('LNKNormInd'));
// output(TableInd, named('LNKTableInd'));
// output(ValidIndicators, named('LNKValidIndicators'));
// output(ShellIterate, named('LNKShellIterate'));
// output(AddTotCnt, named('LNKAddTotCnt'));
// output(AddShellInds, named('LNKAddShellInds'));

RETURN AddShellInds;

END;