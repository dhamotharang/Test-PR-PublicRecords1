


EXPORT rollBusnExecKRIs (  DATASET(Layouts.IndvExecSummaryLayoutV2) execsIn) := FUNCTION





Layouts.BusnExecSummaryLayoutV2  relatSmmry(execsIn le)  := TRANSFORM
	self.origdid := le.origdid;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.Assocdid := le.Assocdid;
	self.BusExecOfficersKRI9   := if((integer)le.BusExecNetwKRI = 9, 1, 0);
	self.BusExecOfficersKRI8   := if((integer)le.BusExecNetwKRI = 8, 1, 0);
	self.BusExecOfficersKRI7   := if((integer)le.BusExecNetwKRI = 7, 1, 0);
	self.BusExecOfficersKRI6   := if((integer)le.BusExecNetwKRI = 6, 1, 0);
	self.BusExecOfficersKRI5   := if((integer)le.BusExecNetwKRI = 5, 1, 0);
	self.BusExecOfficersKRI4   := if((integer)le.BusExecNetwKRI = 4, 1, 0);
	self.BusExecOfficersKRI3   := if((integer)le.BusExecNetwKRI = 3, 1, 0);
	self.BusExecOfficersKRI2   := if((integer)le.BusExecNetwKRI = 2, 1, 0);  //not used
	self.BusExecOfficersKRI1   := if((integer)le.BusExecNetwKRI = 1, 1, 0);  //not used

END;


GetExecNetwcounts := sort(project(execsIn, relatSmmry(left)), seq, origdid);

Layouts.BusnExecSummaryLayoutV2  rollExecSmmry(GetExecNetwcounts le, GetExecNetwcounts ri)  := TRANSFORM
	self.origdid := le.origdid;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.Assocdid := le.Assocdid;
	self.BusExecOfficersKRI9   := le.BusExecOfficersKRI9 + ri.BusExecOfficersKRI9;
	self.BusExecOfficersKRI8   := le.BusExecOfficersKRI8 + ri.BusExecOfficersKRI8;
	self.BusExecOfficersKRI7   := le.BusExecOfficersKRI7 + ri.BusExecOfficersKRI7;
	self.BusExecOfficersKRI6   := le.BusExecOfficersKRI6 + ri.BusExecOfficersKRI6;
	self.BusExecOfficersKRI5   := le.BusExecOfficersKRI5 + ri.BusExecOfficersKRI5;
	self.BusExecOfficersKRI4   := le.BusExecOfficersKRI4 + ri.BusExecOfficersKRI4;
	self.BusExecOfficersKRI3   := le.BusExecOfficersKRI3 + ri.BusExecOfficersKRI3;
	self.BusExecOfficersKRI2   := le.BusExecOfficersKRI2 + ri.BusExecOfficersKRI2;//not used
	self.BusExecOfficersKRI1   := le.BusExecOfficersKRI1 + ri.BusExecOfficersKRI1;//not used
END;

rolledexecKRIs := rollup(GetExecNetwcounts, rollExecSmmry(left, right), seq, origdid);


// output(GetExecNetwcounts, named('GetExecNetwcounts'));
// output(rolledexecKRIs, named('rolledexecKRIs'));

Return rolledexecKRIs;

END;
