import IDLExternalLinking,idl_header,ut;

export fn_address_hier (dataset(layout_addr.addrsegrec) insHeader) := MODULE

  //project into slim layout  
	shared slimHdr     := project(insHeader,transform(Layout_Addr.slimrec,self:=left,self:=[]));	
	
	// Collapse like addresses (for zip) by setting addr_ind to same value prior to process  
	shared iHdr  := iterate(sort(slimHdr(addr_ind NOT IN ['','0']),did,prim_range,prim_name,sec_range,city,st,local),
	                        transform(recordof(left),
													          self.addr_ind := IF(left.did        = right.did        and
																		                    left.address_group_id = right.address_group_id and
																		                    left.segment    = right.segment,
																												left.addr_ind,
																												right.addr_ind),
																		self.id := IF(left.did        = right.did        and
																		                    left.address_group_id = right.address_group_id and
																		                    left.segment    = right.segment,
																												left.id,
																												right.id),
																		self := right),local);
	
	shared sHdr        := sort(iHdr,did,id,dt_last_seen,dt_first_seen,local);  
	// output(shdr,named('shdr'),extend);
	
  shared outliers    := fn_address_outlier(sHdr(not (dt_last_seen < Constants.OutlierMinDt and zip4<>''))).outliers;
	// shared foutliers   := outliers(not (dt_last_seen < Constants.OutlierMinDt and zip4<>''));

	shared Goodrecs    := join(sHdr,outliers,  //Header less outliers
	                           left.did = right.did and
														 left.rid = right.rid,
														 left only,local);
														 
	shared CCConflicts   := fn_address_cc(sHdr).BadInsRecs;//(AddressStatus <> 'IC3');
	shared CCValidated   := fn_address_cc(Goodrecs).GoodInsRecs;
	shared PropValidated := fn_address_prop(sHdr).GoodPropRecs;
	shared PropConflicts := fn_address_prop(sHdr).BadPropRecs;
	Export ADVOrecs      := fn_address_ADVO(sHdr).BadADVOrecs;
	Export Seasonrecs    := fn_address_ADVO(sHdr).Seasonrecs;
			
  shared statrecs    := rollup(sort(outliers + CCConflicts + CCValidated,did,rid,addressstatus,local),
	                                    left.did = right.did and
												              left.rid = right.rid,
												              transform(recordof(left),
												                        self.addressstatus := MAP(left.addressstatus  IN ['IC1','IC2'] => left.addressstatus,
																								                          right.addressstatus IN ['IC1','IC2'] => right.addressstatus,
																														              right.addressstatus = ''             => left.addressstatus,
																														              right.addressstatus),
                                                self := left),
												 local);
	
	shared OHDRemaining := dedup(sort(statrecs(dt_first_seen > 0 and dt_last_seen > 0 and addressstatus not in ['IC1','IC2']),
	                                  did,address_group_id,segment,addressstatus,local),did,addr_ind,local)(addressstatus = 'OHD');
	// output(OHDRemaining,named('OHDRemaining'),extend);
	shared cleanstatrecs := join(statrecs,OHDRemaining,
	                             left.did = right.did and
															 left.rid = right.rid,
															 transform(recordof(left),
															           self.addressstatus := IF(right.rid>0,'',left.addressstatus),
																				 self := left),left outer,local);
  // output(cleanstatrecs,named('cleanstatrecs'),extend);
	shared typerecs    := rollup(sort(PropConflicts + ADVOrecs + Seasonrecs + PropValidated,did,rid,addresstype,local),
	                                    left.did = right.did and
												              left.rid = right.rid,
												              transform(recordof(left),
												                        self.addresstype := MAP(left.addresstype IN ['BUS','SEC','SEA'] => left.addresstype,
																								                        right.addresstype = ''                  => left.addresstype,
																																				right.addresstype),  
																	              self := left),local);
																                // output(typerecs,named('typerecs'),extend);
	shared statsplustype := JOIN(cleanstatrecs,typerecs, 
	                             left.did = right.did and left.rid = right.rid,
							                 transform(Layout_Addr.outrec,
                                         self.addresstype   := right.addresstype,
								                         self := left,
																         self := []),
								               left outer,local);
															 // output(statsplustype,named('statsplustype'),extend);
															 
  shared typeonly      := JOIN(cleanstatrecs,typerecs, 
	                             left.did = right.did and left.rid = right.rid,
							                 transform(Layout_Addr.outrec,
                                         self := right,
																         self := []),
								               right only,local);
															 // output(typeonly,named('typeonly'),extend);
											 
  export NewFullHdr    := JOIN(insHeader,statsplustype + typeonly, 
	                             left.did = right.did and left.rid = right.rid,
							                 transform(Layout_Addr.outrec,
                                         self.addressstatus := right.addressstatus,                                 
																         self.addresstype   := right.addresstype,
								                         self := left,
																         self := []),
								               left outer,local) : persist('persist::addr_hier_newfullhdr');
		
end;

