import ut;

slimrec := Layout_Addr.slimrec;

export fn_address_outlier (dataset(slimrec) input) := MODULE

	// outlier candidates  
	//find address sets with zeroes in dt_first_seen and dt_last_seen
	zerodts := dedup(sort(input(dt_first_seen = 0 and dt_last_seen = 0),did,addr_ind,local),did,addr_ind,local); 
	shared remove_zerodts := join(input,zerodts, left.did = right.did and left.addr_ind = right.addr_ind, left only,local);
	                       
  //dedup to not count multiple instances and eliminates sets that have a zero record  
	dout1 := dedup(input(dt_first_seen <> 0 and dt_last_seen <> 0),did,addr_ind,dt_last_seen,dt_first_seen,local); 	
	iout  := iterate(dout1,
	                transform(slimrec,
	                self.days_differ := IF(left.did = right.did and 
									                       left.addr_ind = right.addr_ind,
								                         IF(left.dt_last_seen < right.dt_first_seen,
												                    ut.daysapart((string)right.dt_first_seen,(string)left.dt_last_seen),
																			      0),
																			   0);
                  self.seq := IF(left.did = right.did and 
									               left.addr_ind = right.addr_ind,
																 left.seq+1,
																 1);                   
									self := right),local);

	fout  := iout(days_differ >= Constants.AddrGap);
  //Take highest sequence 	
	dout2 := dedup(sort(fout,did,addr_ind,-seq,local),did,addr_ind,local)(seq > Constants.MinPriorCnt);
  //Get all records post outlier	
	export jout := join(input(dt_first_seen <> 0 and dt_last_seen <> 0),dout2,left.did = right.did and 
	                                left.addr_ind = right.addr_ind and 
																	left.dt_last_seen >= right.dt_last_seen,
	                   transform(slimrec,self:=left),local); 
	
  // Single Record outliers		
	tSRrec := record
    jout;
		integer cnt := COUNT(GROUP);
	end;
 	tSR     := TABLE(jout,tSRrec,did,addr_ind,local);
	export SRrecs  := PROJECT(tSR(cnt=1),
	                   transform(slimrec,
										           self.AddressStatus := 'OSR',
															 // self.OSRcnt := 1;
															 self := left,
															 self := []));
	
  // Single Source / Single Date Outliers
  rSS := ROLLUP(jout,  
	              left.did = right.did and 
								left.addr_ind = right.addr_ind and
								left.src = right.src,
								TRANSFORM(slimrec,
								          self.dt_first_seen := MIN(left.dt_first_seen,right.dt_first_seen);
								          self.dt_last_seen  := MAX(left.dt_last_seen,right.dt_last_seen);
                          self := left,
								  				self := []),local); 
		
	tSSrec := record
    rSS;
		integer cnt := COUNT(GROUP);
	end;
 	tSS     := TABLE(rSS,tSSrec,did,addr_ind,local)(cnt=1 and dt_first_seen = dt_last_seen and dt_first_seen <> 0);
	export SSrecs := JOIN(input(dt_first_seen <> 0 and dt_last_seen <> 0),tSS,
								 left.did = right.did and 
								 left.addr_ind = right.addr_ind and
								 left.src = right.src AND 
								 left.dt_last_seen = right.dt_last_seen,
                 transform(slimrec,
                           self.AddressStatus := IF(left.AddressStatus='','OSS',left.AddressStatus),
									  			 self := left,
													 self := []),local);
	
	// Single Source / Single Date Records	
	SSDate := (integer) ut.date_math(stringlib.GetDateYYYYMMDD(),-Constants.NewWindow);	
	rSD := ROLLUP(sort(remove_zerodts,did,addr_ind,src,local),  // SS SD Candidates
                    left.did = right.did and 
										left.addr_ind = right.addr_ind and
										left.src = right.src,
								    TRANSFORM(slimrec,
								              self.dt_first_seen := MIN(left.dt_first_seen,right.dt_first_seen);
								              self.dt_last_seen  := MAX(left.dt_last_seen,right.dt_last_seen);
								              self := left,
															self := right,
															self := []),local); 

	tSDrec := record
    rSD;
		integer cnt := COUNT(GROUP);
	end;
 	tSD           := TABLE(rSD,tSDrec,did,addr_ind,local)(cnt=1 and dt_first_seen = dt_last_seen and dt_last_seen < SSDate);

	export SDrecs := JOIN(remove_zerodts,tSD,
								        left.did = right.did and 
								        left.addr_ind = right.addr_ind and
								        left.src = right.src AND 
								        left.dt_last_seen = right.dt_last_seen,
                        transform(slimrec,
                                  self.AddressStatus := 'OSD',
									  			        self := left,
													        self := []),local);
  
  HDRecsDistinctSrcs1 := DEDUP(SORT(remove_zerodts,did,addr_ind,src,local),
	                                              did,addr_ind,src,local);  
	HDMultiRec := record // Nonzero source counts
	  HDRecsDistinctSrcs1,
		integer cnt := COUNT(GROUP);
	end;  
	HDMultiSrcOnly := TABLE(HDRecsDistinctSrcs1,HDMultiRec,did,addr_ind,local)(cnt>1);
	// output(HDMultiSrcOnly,named('HDMultiSrcOnly'),extend);
	HDMultiSrcRecs := JOIN(remove_zerodts,HDMultiSrcOnly,
	                   left.did = right.did AND
							       left.addr_ind = right.addr_ind,local);
  // output(HDMultiSrcRecs,named('HDMultiSrcRecs'),extend);
	HighDates := DEDUP(SORT(HDMultiSrcRecs,did,addr_ind,-dt_last_seen,local),
	                             did,addr_ind,local);
	// output(HighDates,named('HighDates'),extend);
	HDCandidates := JOIN(HDMultiSrcRecs,HighDates,
	                     left.did = right.did AND
							         left.addr_ind = right.addr_ind AND
										   left.dt_last_seen = right.dt_last_Seen,local);
	// output(HDCandidates,named('HDCandidates'),extend);
	HDRecsDistinctSrcs2 := DEDUP(SORT(HDCandidates,did,addr_ind,src,local),
	                                              did,addr_ind,src,local);
	// output(HDRecsDistinctSrcs,named('HDRecsDistinctSrcs'),extend);
	HDRec := record  
	  HDRecsDistinctSrcs2,
		integer cnt2 := COUNT(GROUP);
	end;  
	HDRecsSingle := TABLE(HDRecsDistinctSrcs2,HDRec,did,addr_ind,local)(cnt2=1);
	// output(HDRecsSingle,named('HDRecsSingle'),extend);
	HDRecsRaw := JOIN(HDCandidates,HDRecsSingle,
	                  left.did = right.did AND
							      left.addr_ind = right.addr_ind AND
										left.dt_last_seen = right.dt_last_Seen AND
										left.src = right.src AND
										left.src[1..3] NOT IN ['IVS','ICA','ICP'],local);
	// output(HDRecsRaw,named('HDRecsRaw'),extend);									
	export HDRecs := PROJECT(HDRecsRaw,transform(slimrec,self.addressstatus:='OHD',self:=left));
	// output(HDRecs,named('HDRecs'),extend);
							 
	shared doutrec  := dedup(sort(SRrecs + SSRecs + SDRecs + HDRecs,did,rid,addr_ind,local),
	                         did,rid,addr_ind,local);  
							
  export outliers   := sort(doutrec,did,(integer) addr_ind,local); 
	export SR_Out     := sort(SRrecs,did,(integer) addr_ind,local);
	export SS_Out     := sort(SSrecs,did,(integer) addr_ind,local);
	export SD_Out     := sort(SDrecs,did,(integer) addr_ind,local);
	export HD_Out     := sort(HDrecs,did,(integer) addr_ind,local);
	
end;

