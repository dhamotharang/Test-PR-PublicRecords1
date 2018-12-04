import ut,CurrentCarrier;

slimrec := Layout_Addr.slimrec;

export fn_address_cc (dataset(slimrec) input) := MODULE

	//Determine Insurance address ranges  
	  shared insRecs    := input(src[1..3] = 'IVS' and dt_first_seen<>dt_last_seen);
		shared nonins     := input(src[1..3] = 'ADL');
		
		shared currdtless6 := (integer) ut.date_math(Stringlib.GetDateYYYYMMDD(),-180);

	  export insRanges := ROLLUP(InsRecs(dt_first_seen>0),
		                           left.did = right.did and 
															 left.addr_ind = right.addr_ind and
															 left.dt_last_seen between right.dt_first_seen and right.dt_last_seen,
											         TRANSFORM(slimrec,
											                   self.dt_first_seen := min(left.dt_first_seen,right.dt_first_seen),
											 				           self.dt_last_seen  := max(left.dt_last_seen,right.dt_last_seen),
																         self := left),local);  
		export sortRanges := sort(insRanges,did,dt_last_seen,dt_first_seen,addr_ind,zip,local);
		export insRangesgrace := project(sortRanges,
		                           TRANSFORM(slimrec,
											                   self.dt_first_seen := (integer) ut.date_math((string) left.dt_first_seen,constants.CCGrace);
											 				           self.dt_last_seen  := (integer) ut.date_math((string) left.dt_last_seen,-constants.CCGrace);
																         self := left));
  		
  //Insurance Conflicts totally contained in insurance range  
	  shared bRec1  := JOIN(nonins(dt_first_seen > 0 and dt_last_seen between 0 and currdtless6),insRanges,
                              left.did = right.did and
														  left.dt_first_seen[1..6] >= right.dt_first_seen[1..6] and 
														  left.dt_last_seen[1..6]  <= right.dt_last_seen[1..6] and 
														  left.addr_ind <> right.addr_ind,
											        transform(slimrec,
                                        self.AddressStatus := IF(left.AddressStatus='','IC1',left.AddressStatus),
																				self := left,
																				self := []),local)(AddressStatus='IC1');
																				
		shared remain1 := join(nonins(dt_first_seen > 0 and dt_last_seen between 0 and currdtless6),brec1,
		                      left.did = right.did and
													left.rid = right.rid,
													left only,local);
	  
    shared bRec2  := JOIN(remain1,insRangesgrace,
                              left.did = right.did and
														 (left.dt_last_seen  between right.dt_first_seen and right.dt_last_seen  or
														  left.dt_first_seen between right.dt_first_seen and right.dt_last_seen  or
														 (left.dt_last_seen  > right.dt_last_seen    and  //drop records if policy between
														  left.dt_first_seen < right.dt_first_seen)) and
															left.addr_ind <> right.addr_ind,
											        transform(slimrec,
                                        self.AddressStatus := IF(left.AddressStatus='','IC2',left.AddressStatus),
																				self := left,
																				self := []),local)(AddressStatus='IC2');
																		
		shared first  := dedup(sort(brec2,did,addr_ind,dt_last_seen,local),did,addr_ind,local);
																				
		shared remain2 := join(remain1,brec2,
		                      left.did = right.did and
													left.rid = right.rid,
													left only,local);

    shared brec3 := join(first,remain2,
		                       left.did = right.did and
													 left.addr_ind = right.addr_ind,
													 transform(recordof(left),
													           self.AddressStatus := 'IC3',
																		 self := left),
													 left only,local);
	
	export BadInsRecs := dedup(sort(brec1 + brec2 + brec3,did,rid,prim_range,prim_name,sec_range,zip,segment,-addressstatus,local),did,rid,local);

	// Verify using Insurance Records
	 export GoodInsRecs := JOIN(nonins,sortRanges,
		                    left.did = right.did and
												left.addr_ind = right.addr_ind and
											  left.dt_first_seen >= right.dt_first_seen and
												left.dt_last_seen  <= right.dt_last_seen,
												transform(slimrec,
															    self.AddressStatus := IF(right.prim_name <> '','VCC',left.AddressStatus),
                                  self := left),
												left outer,local)(addressstatus='VCC');

end;

