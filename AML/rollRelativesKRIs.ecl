

EXPORT rollRelativesKRIs (  DATASET(Layouts.RelatLayoutV2) RelatsIn) := FUNCTION





Layouts.RelatSummaryLayoutV2  relatSmmry(RelatsIn le)  := TRANSFORM
	self.origdid := le.origdid;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.RelatDID := le.RelatDID;
	self.ResidencyKRI9   := if((integer)le.ResidencyRisk = 9, 1, 0);
	self.ResidencyKRI8   := if((integer)le.ResidencyRisk = 8, 1, 0);
	self.ResidencyKRI7   := if((integer)le.ResidencyRisk = 7, 1, 0);
	self.ResidencyKRI6   := if((integer)le.ResidencyRisk = 6, 1, 0);
	self.ResidencyKRI5   := if((integer)le.ResidencyRisk = 5, 1, 0);
	self.ResidencyKRI4   := if((integer)le.ResidencyRisk = 4, 1, 0);
	self.ResidencyKRI3   := if((integer)le.ResidencyRisk = 3, 1, 0);
	self.ResidencyKRI2   := if((integer)le.ResidencyRisk = 2, 1, 0);
	self.ResidencyKRI1   := if((integer)le.ResidencyRisk = 1, 1, 0);
	self.PersnlKRI9  := if((integer)le.IndPersonalKRI = 9, 1, 0);
	self.PersnlKRI8  := if((integer)le.IndPersonalKRI = 8, 1, 0);
	self.PersnlKRI7  := if((integer)le.IndPersonalKRI = 7, 1, 0);
	self.PersnlKRI6  := if((integer)le.IndPersonalKRI = 6, 1, 0);
	self.PersnlKRI5  := if((integer)le.IndPersonalKRI = 5, 1, 0);
	self.PersnlKRI4  := if((integer)le.IndPersonalKRI = 4, 1, 0);
	self.PersnlKRI3  := if((integer)le.IndPersonalKRI = 3, 1, 0);
	self.PersnlKRI2  := if((integer)le.IndPersonalKRI = 2, 1, 0);
	self.PersnlKRI1  := if((integer)le.IndPersonalKRI = 1, 1, 0);
END;


GetNetworkcounts := dedup(sort(project(RelatsIn, relatSmmry(left)), seq, origdid, relatdid),seq, origdid, relatdid) ;

Layouts.RelatSummaryLayoutV2  rollrelatSmmry(GetNetworkcounts le, GetNetworkcounts ri)  := TRANSFORM
	self.origdid := le.origdid;
	self.seq := le.seq;
	self.historydate := le.historydate;
	self.RelatDID := le.RelatDID;
	self.ResidencyKRI9   := le.ResidencyKRI9 + ri.ResidencyKRI9;
	self.ResidencyKRI8   := le.ResidencyKRI8 + ri.ResidencyKRI8;
	self.ResidencyKRI7   := le.ResidencyKRI7 + ri.ResidencyKRI7;
	self.ResidencyKRI6   := le.ResidencyKRI6 + ri.ResidencyKRI6;
	self.ResidencyKRI5   := le.ResidencyKRI5 + ri.ResidencyKRI5;
	self.ResidencyKRI4   := le.ResidencyKRI4 + ri.ResidencyKRI4;
	self.ResidencyKRI3   := le.ResidencyKRI3 + ri.ResidencyKRI3;
	self.ResidencyKRI2   := le.ResidencyKRI2 + ri.ResidencyKRI2;
	self.ResidencyKRI1   := le.ResidencyKRI1 + ri.ResidencyKRI1;
	self.PersnlKRI9  := le.PersnlKRI9 + ri.PersnlKRI9;
	self.PersnlKRI8  := le.PersnlKRI8 + ri.PersnlKRI8;
	self.PersnlKRI7  := le.PersnlKRI7 + ri.PersnlKRI7;
	self.PersnlKRI6  := le.PersnlKRI6 + ri.PersnlKRI6;
	self.PersnlKRI5  := le.PersnlKRI5 + ri.PersnlKRI5;
	self.PersnlKRI4  := le.PersnlKRI4 + ri.PersnlKRI4;
	self.PersnlKRI3  := le.PersnlKRI3 + ri.PersnlKRI3;
	self.PersnlKRI2  := le.PersnlKRI2 + ri.PersnlKRI2;
	self.PersnlKRI1  := le.PersnlKRI1 + ri.PersnlKRI1;
END;

rolledRelatKRIs := rollup(GetNetworkcounts, rollrelatSmmry(left, right), seq, origdid);

Return rolledRelatKRIs;

END;
