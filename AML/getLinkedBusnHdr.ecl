IMPORT Business_Header_SS, Business_Risk_BIP, doxie;

EXPORT getLinkedBusnHdr(DATASET(Layouts.BusnExecsLayoutV2) linkedBusnIn, doxie.IDataAccess mod_access) := FUNCTION


//version 2
DDBusnIds := dedup(sort(linkedBusnIn, seq, bdid), seq, bdid);

BusnHeader := Business_Header_SS.Key_BH_BDID_pl;

LnkSlimHdrLayout := RECORD
	unsigned4 seq;
  unsigned6 bdid;      
  string2   source;           
  unsigned3 historydate;   
  unsigned4 dt_first_seen;   
  unsigned4 dt_last_seen; 
END;


LnkBusnHeadRec := join(DDBusnIds, BusnHeader, 
										Keyed(right.bdid=left.Bdid) and
										right.dt_first_seen < (unsigned4)(string)(left.historydate + '01') and
										right.dt_first_seen <> 0 and
										right.source <> '' AND 
                    doxie.compliance.isBusHeaderSourceAllowed(right.source, mod_access.DataPermissionMask, mod_access.DataRestrictionMask),
                    transform(LnkSlimHdrLayout, 
															self.seq := left.seq,
															self.bdid := left.bdid,
															self.historydate := left.historydate,
															self.dt_first_seen := if((unsigned)((STRING)right.dt_first_seen)[1..6]>0 AND 
															                         ((unsigned)((STRING)right.dt_first_seen)[7..8]=0 or trim(((STRING)right.dt_first_seen)[7..8])=''), 
															                              (unsigned)(((STRING)right.dt_first_seen)[1..6]+'01'), 
															                              right.dt_first_seen), 											
															self.dt_last_seen :=  if((unsigned)((STRING)right.dt_last_seen)[1..6]>0 AND 
															                         ((unsigned)((STRING)right.dt_last_seen)[7..8]=0 or trim(((STRING)right.dt_last_seen)[7..8])=''), 
															                              (unsigned)(((STRING)right.dt_last_seen)[1..6]+'01'), 
															                              right.dt_last_seen), 
                              SELF.source := right.source),															
										atmost(Keyed(right.bdid=left.Bdid), Business_Risk_BIP.Constants.Limit_BusHeader), keep(10000),
										left outer);
										
LnkBusnHdrSrcSort := dedup(sort(LnkBusnHeadRec(source!=''), seq,bdid,source),seq,bdid,source);

LnkHdrSrcTable := table(LnkBusnHdrSrcSort, {seq,bdid, SrcCount := count(group)}, seq,bdid);   // get src count

LnkAddHdrSrcCnt := join(linkedBusnIn,LnkHdrSrcTable,
                     left.seq=right.seq and
										 left.Bdid=right.bdid,
										 transform(Layouts.BusnExecsLayoutV2, 
															self.srcCount := right.SrcCount,
															self := left),
											left outer);		
											
// IT2 changes											
							
  LnkCreditSrccount := sort(LnkBusnHdrSrcSort(source in AMLConstants.CreditSources), seq, bdid, source);
	
	LnkCreditSrcTable := table(LnkCreditSrccount, {seq, bdid, CrdSrcCnt := count(group)}, seq, bdid); 
	
	LnkAddCreditSrcCnt := join(LnkAddHdrSrcCnt, LnkCreditSrcTable,
                       left.seq=right.seq and
											 left.Bdid=right.bdid,
											 transform(Layouts.BusnExecsLayoutV2, 
															self.CreditSrcCnt := right.CrdSrcCnt,
															self := left),
											left outer);		
											
	LnkHdrShellSrcTbl := table(LnkBusnHdrSrcSort(source in AMLconstants.BusnShellSrcs), {seq,bdid, ShellSrcCount := count(group)}, seq,bdid);  
	
	LnkAddShellSrcCnt := join(LnkAddCreditSrcCnt, LnkHdrShellSrcTbl,
                       left.seq=right.seq and
											 left.Bdid=right.bdid,
											 transform(Layouts.BusnExecsLayoutV2, 
															self.ShellHdrSrcCnt := right.ShellSrcCount,
															self := left),
											left outer);	
											
	 LnkNonCreditFrstSeen  :=  dedup(sort(LnkBusnHeadRec(source not in AMLConstants.CreditSources and dt_first_seen <> 0 ), seq, bdid, dt_first_seen), seq, bdid);

	LnkAddNonCrdFrstSeen := join(LnkAddShellSrcCnt, LnkNonCreditFrstSeen,
												left.seq=right.seq and
												left.Bdid=right.bdid,
												transform(Layouts.BusnExecsLayoutV2, 
																		self.BusnHdrDtFirstNonCredit := right.dt_first_seen,
																		self := left),
												left outer);
 

// output(LnkBusnHeadRec, named('LnkBusnHeadRec'));
// output(LnkBusnHdrSrcSort, named('LnkBusnHdrSrcSort'));
// output(LnkAddHdrSrcCnt, named('LinkedAddHdrSrcCnt'));
// output(LnkCreditSrcTable, named('linkedCreditSrcTable'));
// output(LnkAddCreditSrcCnt, named('linkedAddCreditSrcCnt'));
// output(LnkHdrShellSrcTbl, named('LnkHdrShellSrcTbl'));
// output(LnkAddShellSrcCnt, named('LnkAddShellSrcCnt'));
// output(LnkNonCreditFrstSeen, named('linkedNonCreditFrstSeen'));
// output(LnkAddNonCrdFrstSeen, named('linkedAddNonCrdFrstSeen'));
							
RETURN 	LnkAddNonCrdFrstSeen;										
											
END;
										