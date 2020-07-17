IMPORT Business_Header_SS, RiskWise, Business_Risk_BIP, doxie;

EXPORT BusnHeaderRecs(DATASET(Layouts.BusnLayoutV2) BusnIn,
                      doxie.IDataAccess mod_access) := FUNCTION
//version 2
BusnHeader := Business_Header_SS.Key_BH_BDID_pl;

BusnHeadRec := join(BusnIn(OrigBdid!=0), BusnHeader, 
										Keyed(right.bdid=left.OrigBdid) and
										right.dt_first_seen < (unsigned4)(string)(left.historydate + '01') AND
										right.dt_first_seen <> 0 and
										right.source not in AMLConstants.ExcludeSrcs AND 
                    doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
                    transform({recordof(BusnHeader), unsigned4 seq, unsigned4	historydate }, 
										self.seq:=left.seq, 
										self.historydate := left.historydate,
                    self.dt_first_seen := if((unsigned)((STRING)right.dt_first_seen)[1..6]>0 and 
                                             ((unsigned)((STRING)right.dt_first_seen)[7..8]=0 or trim(((STRING)right.dt_first_seen)[7..8])=''), 
                                                  (unsigned)(((string)right.dt_first_seen)[1..6]+'01'), 
                                                  right.dt_first_seen), 											
										self.dt_last_seen := if((unsigned)((STRING)right.dt_last_seen)[1..6]>0 and 
										                        ((unsigned)((STRING)right.dt_last_seen)[7..8]=0 or trim(((STRING)right.dt_last_seen)[7..8])=''), 
										                             (unsigned)(((STRING)right.dt_last_seen)[1..6]+'01'), 
										                             right.dt_last_seen), 
										self := right), 
										atmost(Keyed(right.bdid=left.OrigBdid),Business_Risk_BIP.Constants.Limit_BusHeader), keep(10000),
										left outer);
										
BusnHdrFirstSort := dedup(sort(BusnHeadRec, seq,bdid,dt_first_seen),seq,bdid);  // get BusnHdrDtFirstSeen

AddBusnHdrFrstDt :=   join(BusnIn, BusnHdrFirstSort, 
	                       left.seq=right.seq and
												 left.OrigBdid=right.bdid,
												 transform(Layouts.BusnLayoutV2, 
															self.BusnHdrDtFirstSeen := right.dt_first_seen,
															self := left),
											left outer);

BusnHdrlastSort := dedup(sort(BusnHeadRec, seq,bdid,-dt_last_seen),seq,bdid);  // get BusnHdrDtLastSeen

  AddBusnHdrDt :=   join(AddBusnHdrFrstDt, BusnHdrlastSort, 
	                       left.seq=right.seq and
												 left.OrigBdid=right.bdid,
												 transform(Layouts.BusnLayoutV2, 
															self.BusnHdrDtLastSeen := right.dt_Last_seen,
															self := left),
											left outer);

BusnHdrSrcSort := dedup(sort(BusnHeadRec(source!=''), seq,bdid,source),seq,bdid,source);




HdrSrcTable := table(BusnHdrSrcSort, {seq,bdid, SrcCount := count(group)}, seq,bdid);   // get src count  todo should this exclude credit sources

AddHdrSrcCnt := join(AddBusnHdrDt,HdrSrcTable,
                     left.seq=right.seq and
										 left.OrigBdid=right.bdid,
										 transform(Layouts.BusnLayoutV2, 
															self.srcCount := right.SrcCount,
															self := left),
											left outer);
											
  CreditSrccount := sort(BusnHdrSrcSort(source in AMLConstants.CreditSources), seq, bdid, source);
	
	CreditSrcTable := table(CreditSrccount, {seq, bdid, CrdSrcCnt := count(group)}, seq, bdid); 
	
	AddCreditSrcCnt := join(AddHdrSrcCnt, CreditSrcTable,
                       left.seq=right.seq and
											 left.OrigBdid=right.bdid,
											 transform(Layouts.BusnLayoutV2, 
															self.CreditSrcCnt := right.CrdSrcCnt,
															self := left),
											left outer);
	//ShellHdrSrcCnt

HdrShellSrcTable := table(BusnHdrSrcSort(source in AMLconstants.BusnShellSrcs), {seq,bdid, ShellSrcCount := count(group)}, seq,bdid);  

AddShellSrcCnt :=  join(AddCreditSrcCnt, HdrShellSrcTable,
                       left.seq=right.seq and
											 left.OrigBdid=right.bdid,
											 transform(Layouts.BusnLayoutV2, 
															self.ShellHdrSrcCnt := right.ShellSrcCount,
															self := left),
											left outer);

BusnHdrAddrSort := dedup(sort(BusnHeadRec(prim_name!=''), seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip, dt_first_seen)
														,seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip);

HdrAddrTable := table(BusnHdrAddrSort, {seq,bdid, AddrCount := count(group)}, seq,bdid);  // get addr count

AddBusnHdrAddr := join(AddShellSrcCnt, HdrAddrTable,
                       left.seq=right.seq and
											 left.OrigBdid=right.bdid,
											 transform(Layouts.BusnLayoutV2, 
															self.HDAddrCount := right.AddrCount,
															self := left),
											left outer);
											
BusnHdrStateSort := dedup(sort(BusnHeadRec(prim_name!=''), seq,bdid,state),seq,bdid,state);

HdrStateTable := table(BusnHdrStateSort, {seq,bdid, StateCount := count(group)}, seq,bdid);  // get state count

AddBusnHdrState := join(AddBusnHdrAddr, HdrStateTable,
                       left.seq=right.seq and
											 left.OrigBdid=right.bdid,
											 transform(Layouts.BusnLayoutV2, 
															self.HDStateCount := right.StateCount,
															self := left),
											left outer);
											
LenInputAddr := join(BusnIn,BusnHeadRec,
                     right.seq=left.seq and
										 right.bdid=left.OrigBdid and
										 right.prim_name = left.prim_name and
										 right.prim_range = left.prim_range and
										 right.predir = left.predir and
										 right.addr_suffix = left.addr_suffix and
										 right.postdir = left.postdir and
										 right.state  = left.st and
										 (string)right.zip = left.z5,
										 transform({recordof(BusnHdrAddrSort)}, 
															 self := right),
									   left outer);
										 
InputAddrSort := dedup(sort(LenInputAddr(prim_name!=''and dt_first_seen<>0), seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip, dt_first_seen)
														,seq,bdid,prim_range,prim_name,addr_suffix,postdir, state, zip);
									
Layouts.BusnLayoutV2   addAddrLen(AddBusnHdrState le, InputAddrSort ri)  := TRANSFORM
	self.FirstSeenInputAddr := ri.dt_first_seen;   
	self := le;
		
END;		
		
AddAddrFirstSeen :=  join(AddBusnHdrState ,InputAddrSort ,
                        left.seq=right.seq and
												left.OrigBdid=right.bdid,
												addAddrLen(left,right),
												left outer);
												
NonCreditFrstSeen  :=  dedup(sort(BusnHeadRec(source not in AMLConstants.CreditSources and dt_first_seen <> 0), seq, bdid, dt_first_seen), seq, bdid);

AddNonCrdFrstSeen := join(AddAddrFirstSeen, NonCreditFrstSeen,
												left.seq=right.seq and
												left.OrigBdid=right.bdid,
												transform(Layouts.BusnLayoutV2, 
																		self.BusnHdrDtFirstNonCredit := right.dt_first_seen,
																		self := left),
												left outer);
/*  moved to SOS code
BusRegSrc := BusnHdrSrcSort(source = 'BR');

AddBusRegHit := join(AddNonCrdFrstSeen, BusRegSrc,
											left.seq = right.seq and
											left.OrigBdid=right.bdid,
											transform(Layouts.BusnLayoutV2, 
																self.BusRegHit := if(right.bdid <> 0, TRUE, FALSE),
																		self := left),
												left outer);	
*/
											
											
											
RETURN AddNonCrdFrstSeen;


END;
  