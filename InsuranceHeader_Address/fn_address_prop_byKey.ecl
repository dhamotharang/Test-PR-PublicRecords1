import ut,CurrentCarrier,doxie,Address;

slimrec         := Layout_Addr.slimrec;
proprec         := Layout_Addr.proprec;
slimproprec    := Layout_Property_Ownership.slimrec;

export fn_address_prop_byKey (dataset(slimrec) input) := MODULE

dedupInput := input[1];
// output(input,named('input'),extend);

rawpropranges:= project(key_Property_Ownership.key(did=dedupInput.did), //Eliminate records without purchase date
                          transform(proprec,
                                    self.purchase_date := (string) left.purchase_date_by_did,
										                self.sale_date     := IF(left.sale_date_by_did = 0,
																		                         Stringlib.GetDateYYYYMMDD(),
																		                        (string) left.sale_date_by_did),
                                    self.suffix := left.addr_suffix,
																		self.zip    := left.zip5,
																		self.owner_occupied := left.occupant_owned,
																		self.addr_ind := [],
																		self :=left));  
// output(rawpropranges,named('rawpropranges'),extend);																		
shared propranges := dedup(sort(rawpropranges,did,prim_range,prim_name,sec_range,zip,local),did,prim_range,prim_name,sec_range,zip,local);
// output(propranges,named('propranges'),extend);						
						
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
																				// output(secondaryrecs,named('secondaryrecs'),extend);
																				
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
