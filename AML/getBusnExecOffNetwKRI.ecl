IMPORT UT;

EXPORT getBusnExecOffNetwKRI(DATASET(Layouts.BusnExecsLayoutV2) execsIds) := FUNCTION

ExecLayout := Record

	unsigned4		seq := 0;
	UNSIGNED3		historydate;
	unsigned6   OrigBdid;
	unsigned6 	bdid := 0;
	unsigned6 	did := 0;
	unsigned6 	relatdid := 0;
	boolean     LinkedBusn := false;
	boolean   	isExec := false;
  unsigned3 	RelatDegree := 0;
	unsigned2   HRBusn := 0;
	unsigned1   ShellIndCount := 0;
	boolean   	HRProfServProv := 0;
	boolean     HRDegree;
	boolean  	  SameExecMultiBusn;
	unsigned2   HRBusnCnt := 0;
	unsigned2   SameExecMultiBusnCnt := 0;
	unsigned2   ExecCntperBDID := 0;
	string2     BusExecOfficersRisk;
END;



ExecLayout  PreplegalCnt(execsIds le) := TRANSFORM

	self.seq     := le.seq;
	self.historydate := le.historydate;
	self.OrigBdid  := le.OrigBdid;
	self.bdid  := le.bdid;
	self.did  := le.did;
	self.relatdid := le.relatdid;
	self.LinkedBusn   := le.LinkedBusn;
	self.isExec   := le.isExec;
	self.relatdegree := le.relatdegree;
	self.HRProfServProv := le.ExecHRProfLic;
	self.HRDegree := le.ExecHRDegree;
	self.HRBusn := If(le.HRBusnSIC = 'HIGH' or le.HRBusnYPNAICS = 'HIGH' OR le.BusnRisklevel = 'HIGH', 1, 0);
	self.ShellIndCount := le.ShellIndCount;
	self := [];
END;



SrtExecs := sort(project(execsIds(relatdegree = AMLConstants.execSubjBsnDegree),PreplegalCnt(left)) ,seq,bdid,did);

SrtLinkedExec := sort(project(execsIds(relatdegree = AMLConstants.relatedbusnDegree),PreplegalCnt(left)) ,seq,bdid,did);

Justsubjexecs := join(SrtExecs, SrtLinkedExec,
										left.seq = right.seq and
										left.origbdid = right.origbdid and 
										left.relatdid = right.relatdid and
										left.did = left.did,
										transform(ExecLayout,
																self := right));
																
Allsubjexecbdid := sort(SrtExecs + Justsubjexecs, seq, did, bdid);


BDIDExecsCnt  := table(SrtExecs, {seq, bdid,  ExecCount := count(group)}, seq,bdid ); 

LinkBDIDExecsCnt  := table(Justsubjexecs, {seq, bdid,  ExecCount := count(group)}, seq,bdid ); 

BDID2CntExecs := BDIDExecsCnt(ExecCount >= 2);
LinkBDID2CntExecs := LinkBDIDExecsCnt(ExecCount >= 2);

SlimExecLayout := RECORD 
  unsigned4		seq := 0;
	unsigned6 	bdid := 0;
  unsigned6   did;
  unsigned2   ExectoBusnCnt;
END;

BdidsToCheck  :=  join(BDID2CntExecs, SrtExecs, 
														left.seq = right.seq and
														left.bdid  = right.bdid,
														transform(SlimExecLayout,
																			self.seq := right.seq,
																			self.bdid := right.bdid,
																			self.did := right.did,
																			self.ExectoBusnCnt := 0));
																			
LinkBdidsToCheck := join(LinkBDID2CntExecs, Justsubjexecs, 
														left.seq = right.seq and
														left.bdid  = right.bdid,
														transform(SlimExecLayout,
														          self.seq := right.seq,
																			self.bdid := right.bdid,
																			self.did := right.did,
																			self.ExectoBusnCnt := 0));
																			
SlimExecLayout  FindExecPairs(BdidsToCheck le,LinkBdidsToCheck ri) := TRANSFORM
   		self.seq := le.seq,
			self.bdid := le.bdid,
			self.did := le.did,
			self.ExectoBusnCnt := IF(ri.did <> 0, 1, 0);
END;


ExecPairs := join(BdidsToCheck, LinkBdidsToCheck,
                  left.seq = right.seq and
									left.did = right.did,
									FindExecPairs(left,right));
									


addmultiexec := join(SrtExecs, ExecPairs,
                     left.seq = right.seq and
										 left.bdid = right.bdid and
										 left.did = right.did,
										 transform(ExecLayout,
																self.SameExecMultiBusn := if(right.seq <> 0, true, false),
																self := left), left outer);


ExecLayout  RollLinkExes(Allsubjexecbdid le, Allsubjexecbdid ri) := transform
  
	self.HRBusnCnt := le.hrbusn + ri.hrbusn;
	self.ShellIndCount := max(le.ShellIndCount,ri.ShellIndCount);
	self.HRProfServProv := le.HRProfServProv or ri.HRProfServProv;
	self.HRDegree := le.HRDegree or ri.HRDegree;
	self.relatdegree := le.relatdegree;
	self.bdid := le.bdid;
	Self := le;
	
END;

rolledLinkExecs := rollup(sort(Allsubjexecbdid, seq,origbdid, did, relatdegree), RollLinkExes(left,right), seq, origbdid, did);

AddLinkHRbusncnt := join(addmultiexec, rolledLinkExecs,
                     left.seq = right.seq and
										 left.origbdid = right.origbdid and
										 left.did = right.did and
										 left.bdid = right.bdid,
										 transform(ExecLayout,
																self.HRBusnCnt := right.HRBusnCnt,
																self.ShellIndCount := right.ShellIndCount,
																self.HRdegree := right.hrdegree,
																self.HRProfServProv := right.HRProfServProv,
																self := left), left outer);

// SortExecs := sort(AddLinkHRbusncnt, seq, origbdid);

ExecLayout  ExecsKRI(AddLinkHRbusncnt le) := transform
  
	self.BusExecOfficersRisk := Map(
																		le.HRBusnCnt > 1 and le.HRProfServProv          			=>  '9',
																		le.ShellIndCount > 4 and le.HRProfServProv         	=>  '8',
																		le.ShellIndCount > 4        													=>  '7',
																		le.HRBusnCnt > 0 and le.HRProfServProv or 
																		le.HRDegree                                           =>  '6',
																		le.SameExecMultiBusn                                  =>  '5',
																		le.HRBusnCnt > 0                                =>  '4',
																		le.HRProfServProv or  le.HRDegree                    =>  '3',
																		le.HRBusnCnt = 0 or le.ShellIndCount = 0 or
																		~le.HRDegree or ~le.HRProfServProv                   =>  '2',
																		// value 1 is default back in main code when there are no execs
																		'0');
																		
	Self := le;
	
END;

GetExecKRI := sort(project(AddLinkHRbusncnt, ExecsKRI(left)), seq, origbdid);

NetworkKRILayout := RECORD
  unsigned4		seq;
	UNSIGNED3		historydate;
	unsigned6   OrigBdid;
	// unsigned6 	bdid;
	// unsigned6 	did;
  unsigned3 	RelatDegree;
  unsigned2   execKRI9cnt;
  unsigned2   execKRI8cnt;
  unsigned2   execKRI7cnt;
  unsigned2   execKRI6cnt;
  unsigned2   execKRI5cnt;
  unsigned2   execKRI4cnt;
  unsigned2   execKRI3cnt;
  unsigned2   execKRI2cnt;
  unsigned2   execKRI1cnt;
  unsigned2   execKRI0cnt;
  string2   BusExecOfficersRisk;
END;
																
NetworkKRILayout  prepExecKRI(GetExecKRI le) := TRANSFORM
  self.seq   := le.seq;
	self.historydate  := le.seq;
	self.OrigBdid  := le.bdid;
  self.RelatDegree  := le.relatdegree;
  self.execKRI9cnt  := if(le.BusExecOfficersRisk = '9', 1, 0);
  self.execKRI8cnt  := if(le.BusExecOfficersRisk = '8', 1, 0);
  self.execKRI7cnt  := if(le.BusExecOfficersRisk = '7', 1, 0);
  self.execKRI6cnt  := if(le.BusExecOfficersRisk = '6', 1, 0);
  self.execKRI5cnt  := if(le.BusExecOfficersRisk = '5', 1, 0);
  self.execKRI4cnt  := if(le.BusExecOfficersRisk = '4', 1, 0);
  self.execKRI3cnt  := if(le.BusExecOfficersRisk = '3', 1, 0);
  self.execKRI2cnt  := if(le.BusExecOfficersRisk = '2', 1, 0);
  self.execKRI1cnt  := if(le.BusExecOfficersRisk = '1', 1, 0);
  self.execKRI0cnt  := if(le.BusExecOfficersRisk = '0', 1, 0);
  self.BusExecOfficersRisk  := '';
END;
																				
 
GetNtwKRI := sort(project(GetExecKRI, prepExecKRI(left)), seq, origbdid);

NetworkKRILayout  rollNetwKRI(GetNtwKRI le, GetNtwKRI ri) := TRANSFORM
  self.seq   := le.seq;
	self.historydate  := le.seq;
	self.OrigBdid  := le.OrigBdid;
	// self.bdid  := le.bdid;
	// self.did   := le.did;
  self.RelatDegree  := le.relatdegree;
  self.execKRI9cnt  := le.execKRI9cnt + ri.execKRI9cnt;
  self.execKRI8cnt  := le.execKRI8cnt + ri.execKRI8cnt;
  self.execKRI7cnt  := le.execKRI7cnt + ri.execKRI7cnt;
  self.execKRI6cnt  := le.execKRI6cnt + ri.execKRI6cnt;
  self.execKRI5cnt  := le.execKRI5cnt + ri.execKRI5cnt;
  self.execKRI4cnt  := le.execKRI4cnt + ri.execKRI4cnt;
  self.execKRI3cnt  := le.execKRI3cnt + ri.execKRI3cnt;
  self.execKRI2cnt  := le.execKRI2cnt + ri.execKRI2cnt;
  self.execKRI1cnt  := le.execKRI1cnt + ri.execKRI1cnt;
  self.execKRI0cnt  := le.execKRI0cnt + ri.execKRI0cnt;
  self.BusExecOfficersRisk  := '';
END;
																			
rolledNetwKRI := rollup(sort(GetNtwKRI, seq,origbdid), rollNetwKRI(left,right), seq, origbdid);

NetworkKRILayout  NetwKRI(rolledNetwKRI le) := TRANSFORM
  SELF.BusExecOfficersRisk   := MAP(
																			le.execKRI9cnt > 0    => '9',
																			le.execKRI8cnt > 0    => '8',
																			le.execKRI7cnt > 0    => '7',
																			le.execKRI6cnt > 0    => '6',
																			le.execKRI5cnt > 0    => '5',
																			le.execKRI4cnt > 0    => '4',
																			le.execKRI3cnt > 0    => '3',
																			le.execKRI2cnt > 0    => '2',
																			le.execKRI1cnt > 0    => '1',
																			'0');
	self := le;
END;

GetExecNetwKRI :=  project(rolledNetwKRI, NetwKRI(left));


// output(execsIds, named('execsIds'));
// output(SrtExecs, named('SrtExecs'));
// output(SrtLinkedExec, named('SrtLinkedExec'));
// output(Justsubjexecs, named('Justsubjexecs'));
// output(Allsubjexecbdid, named('Allsubjexecbdid'));
// output(BDIDExecsCnt, named('BDIDExecsCnt'));
// output(LinkBDIDExecsCnt, named('LinkBDIDExecsCnt'));
// output(BDID2CntExecs, named('BDID2CntExecs'));
// output(LinkBDID2CntExecs, named('LinkBDID2CntExecs'));
// output(BdidsToCheck, named('BdidsToCheck'));
// output(LinkBdidsToCheck, named('LinkBdidsToCheck'));

// output(ExecPairs, named('ExecPairs'));
// output(addmultiexec, named('addmultiexec'));
// output(rolledLinkExecs, named('rolledLinkExecs'));
// output(AddLinkHRbusncnt, named('AddLinkHRbusncnt'));
// output(GetExecKRI, named('GetExecKRI'));
// output(GetNtwKRI, named('GetNtwKRI'));
// output(rolledNetwKRI, named('rolledNetwKRI'));
// output(GetExecNetwKRI, named('GetExecNetwKRI'));



RETURN GetExecNetwKRI;

END;