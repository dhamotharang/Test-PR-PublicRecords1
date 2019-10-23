slimrec := Layout_Addr.slimrec;

EXPORT fn_address_ADVO_byKey (dataset(slimrec) input) := MODULE

shared dedup_input := dedup(sort(input,did,addr_ind,zip,prim_range,prim_name,-sec_range,local),
                                 did,addr_ind,zip,prim_range,prim_name,local);
shared result      := join(dedup_input,key_ADVO.key,
                           keyed(right.zip        = left.zip AND
										       right.prim_range = left.prim_range AND
													 right.prim_name  = left.prim_name),
									         transform(slimrec,
                                     self.addresstype := MAP(right.seasonal_delivery_indicator = 'Y'      => 'SEA',
																		                         right.secondary_unit_designator = 'APT'      => 'SKP',
																														 left.unit_desig = 'APT'                      => 'SKP',
										                                         left.sec_range = right.sec_range and 
																														     right.residential_or_business_ind = 'A'  => 'SKP',
                                                             left.sec_range = right.sec_range and 
																														     right.residential_or_business_ind = 'B'  => 'BUS',
                                                             left.sec_range = right.sec_range and 
																														     right.address_type = '0'                 => 'BUS',
																						                 ''),
										                 self :=left),hash);
										
shared distresult  := distribute(result,hash(did));
shared taggedrecs  := DEDUP(SORT(distresult,did,addr_ind,-addresstype,local),did,addr_ind,local)(addresstype <> 'SKP');

EXPORT allrecs     := join(input(unit_desig <> 'APT'),taggedrecs,
                           left.did = right.did and
													 left.addr_ind = right.addr_ind,
													 transform(slimrec,
													 					 self.addresstype := right.addresstype,
													           self := left),local);
// output(allrecs,named('allrecs'),extend);
																		 
EXPORT BadADVOrecs := allrecs(addresstype = 'BUS');
EXPORT Seasonrecs  := allrecs(addresstype = 'SEA');

end;

