

EXPORT IndBusnExecNetwKRI (DATASET(Layouts.AMLExecLayoutV2) BusnExecIds) := FUNCTION



Layouts.IndvExecSummaryLayoutV2  ExecsCount(BusnExecIds le) := TRANSFORM
  highValue := 'HIGH';
  SELF.seq  := le.seq;
	SELF.historydate  := le.historydate;
	SELF.origDID  := le.origdid;
	SELF.AssocDID := le.assocdid;
	SELF.isexec  := le.isexec;
	SELF.BDID := le.bdid;
	SELF.relatdegree := LE.relatdegree;
	SELF.currIncarCnt  := if(le.CurrIncarcer, 1, 0);
	SELF.potentialSOCnt := if(le.potentialSO, 1, 0);
	SELF.felony1yrcnt  := le.Felony1yr;
	SELF.everIncarCnt  := if(le.CurrIncarcer, 1,0);
	SELF.BDIDcountPerIndv := if(le.relatdegree = 52, 1, 0);
	SELF.HRBusnCnt    := if(le.HRBusnSIC = highValue or le.BusnRisklevel = highValue or le.HRBusnYPNAICS = highValue, 1,0); 
	SELF.HRDegreeCnt      := if(le.HRDegree, 1, 0);
	SELF.HRProfServProvCnt  := if(le.HRProfServProv, 1, 0);
	self.ShellIndCount  :=  le.ShellIndCount;
	SELF.BusExecNetwKRI  := '';
END;


addExeccounts := sort(project(BusnExecIds, ExecsCount(left)), seq, origdid, assocdid);


Layouts.IndvExecSummaryLayoutV2  RollExecsCount(addExeccounts le, addExeccounts ri) := TRANSFORM
  sameBdid := le.bdid = ri.bdid;
  SELF.seq  := le.seq;
	SELF.historydate  := le.historydate;
	SELF.origDID  := le.origdid;
	SELF.AssocDID := le.assocdid;
	SELF.isexec  := le.isexec;
	SELF.relatdegree := LE.relatdegree;
	SELF.currIncarCnt  := le.currIncarCnt + ri.currIncarCnt;
	SELF.potentialSOCnt := le.potentialSOCnt + ri.potentialSOCnt;
	SELF.felony1yrcnt  := le.felony1yrcnt + ri.felony1yrcnt;
	SELF.everIncarCnt  := le.everIncarCnt + ri.everIncarCnt;
	SELF.BDIDcountPerIndv := if(sameBdid, le.BDIDcountPerIndv + 0, le.BDIDcountPerIndv + ri.BDIDcountPerIndv);
	SELF.HRBusnCnt    := le.HRBusnCnt + ri.HRBusnCnt;
	SELF.HRDegreeCnt      := le.HRDegreeCnt + ri.HRDegreeCnt;
	SELF.HRProfServProvCnt  := le.HRProfServProvCnt + ri.HRProfServProvCnt;
	SELF.ShellIndCount  := max(le.ShellIndCount,ri.ShellIndCount);
	// SELF.ShelfCnt  :=   le.ShelfCnt + ri.ShelfCnt;
	SELF.BusExecNetwKRI  := '';
	SELF.bdid := if(sameBdid, le.bdid, ri.bdid);
END;


rolledcountsPerExec := rollup(addExeccounts, RollExecsCount(left, right), seq, origdid, assocdid);


Layouts.IndvExecSummaryLayoutV2  execNetwKRI(rolledcountsPerExec le)  := TRANSFORM
	self.seq    := le.seq ;
	self.historydate := le.historydate;
	self.origdid  := le.origdid;
	self.assocdid  := le.assocdid;
	self.relatdegree  := le.relatdegree;
	self.isexec  := le.isexec;
	self.BusExecNetwKRI := Map(
														le.currIncarCnt > 0 or le.potentialSOCnt > 0									  	=> '9', 
														(le.felony1yrcnt > 0) or le.everIncarCnt > 0				  						=> '8',
														(le.HRBusnCnt > 1 or 	le.ShellIndCount > 4) 															
														and le.HRProfServProvCnt > 0																			=> '7',
														(le.HRBusnCnt > 1 or 	
														 le.ShellIndCount > 4)																						=> '6',

														le.HRBusnCnt > 0   and
														(le.HRProfServProvCnt > 0  or  le.HRDegreeCnt > 1)								=> '5',	
																				
														le.HRBusnCnt > 0 																									=> '4',	
														le.HRProfServProvCnt > 0  or  le.HRDegreeCnt > 1								 	=> '3',	
														 '0');  // values 1 and 2 are calculated back in main attrib

	self := le;
END;

GetBusExecNetwKRI   := project(rolledcountsPerExec, execNetwKRI(left));

// output(addExeccounts, named('addExeccounts'));
// output(rolledcountsPerExec, named('rolledcountsPerExec'));


RETURN GetBusExecNetwKRI;

END;