import ut,CurrentCarrier,doxie,Address;

slimrec         := Layout_Addr.slimrec;
proprec         := Layout_Addr.proprec;
slimproprec    := Layout_Property_Ownership.slimrec;

export fn_address_prop (dataset(slimrec) input) := MODULE

slimprop  := project(key_Property_Ownership.flat(purchase_date_by_did>0),slimproprec);
distprop  := distribute(slimprop,hash(did));

dedupInput := dedup(sort(input,did,local),did,local);

rawpropranges:= join(dedupInput,distprop(purchase_date_by_did > 0), //Eliminate records without purchase date
                          left.did = right.did,
										      transform(proprec,
                                    self.purchase_date := (string) right.purchase_date_by_did,
										                self.sale_date     := IF(right.sale_date_by_did = 0,
																		                         Stringlib.GetDateYYYYMMDD(),
																		                        (string) right.sale_date_by_did),
                                    self.suffix := right.addr_suffix,
																		self.zip    := right.zip5,
																		self.owner_occupied := right.occupant_owned,
																		self.addr_ind := [],
																		self :=right),limit(1000,skip),local);  
																		
shared propranges := dedup(sort(rawpropranges,did,prim_range,prim_name,sec_range,zip,local),did,prim_range,prim_name,sec_range,zip,local);
																		
EXPORT GoodPropRecs  := JOIN(input,propranges,
                              left.did = right.did and
														 (((string) left.dt_last_seen[1..6]  > right.purchase_date[1..6] and 
														   (string) left.dt_last_seen[1..6]  < right.sale_date[1..6])  or
														  ((string) left.dt_first_seen[1..6] > right.purchase_date[1..6] and 
															 (string) left.dt_first_seen[1..6] < right.sale_date[1..6])  or
														 ((string) left.dt_last_seen[1..6]   > right.sale_date[1..6]    and  //drop records if policy between
														  (string) left.dt_first_seen[1..6] < right.purchase_date[1..6])) and
															left.prim_range = right.prim_range and
															left.prim_name  = right.prim_name and
														  left.sec_range = right.sec_range and
														  left.zip = right.zip,
															transform(slimrec,
                                        self.AddressType := IF(left.AddressType = '','VPR',left.AddressType),
																				self := left,
																				self := []),local)(AddressType='VPR');
																	
EXPORT SecondaryRecs  :=JOIN(propranges(not owner_occupied),propranges(owner_occupied),
                              left.did = right.did and
															left.purchase_date >= right.purchase_date and
															left.sale_date <= right.sale_date and
														  not (left.prim_range = right.prim_range and
															     left.prim_name  = right.prim_name and
														       left.sec_range = right.sec_range  and
														       left.zip = right.zip),
															transform(proprec,
                                        self := left),local);
																				
EXPORT BadPropRecs  := JOIN(input,SecondaryRecs,
                              left.did = right.did and
															left.prim_range = right.prim_range and
														  left.prim_name  = right.prim_name and
														  left.sec_range = right.sec_range and
														  left.zip = right.zip,
															transform(slimrec,
                                        self.Addresstype := IF(left.addresstype='','SEC',left.addresstype),
																				self := left),local)(addresstype = 'SEC');
end;
