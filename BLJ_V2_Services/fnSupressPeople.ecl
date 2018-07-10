Import bankruptcyv2_services;

EXPORT fnSupressPeople(dataset(bankruptcyv2_services.layouts.layout_rollup) bk_recs) := function

 
 newBkRec := record(bankruptcyv2_services.layouts.layout_rollup)
								unsigned BKRecordType; // 0 - only people, 1 - only business, 2 - Business & People	,	
           end;
									

 bk_recs_classified := project(bk_recs,transform(newBkRec,
																	debtors := left.debtors; 
																	biz_debtors := debtors(  (unsigned)bdid > 0 or (unsigned)ultid > 0 or 
																	                         (unsigned)orgid > 0 or (unsigned)seleid > 0 or 
																													    (unsigned)proxid > 0 or  (unsigned)powid > 0 or
																														  (unsigned)empid > 0 or (unsigned)dotid > 0);
																	
																	biz_debtors_pure := biz_debtors((unsigned)did = 0);
																	biz_debtors_mixed := biz_debtors((unsigned)did <> 0);
																	
																	biz_debtors_cleaned  := project(biz_debtors_mixed,
																	                          transform(recordof(biz_debtors_mixed),
   																																	Names := left.names;
																																		CleanedUpNames := Names(cname <> '' and fname = '');
   																																	self.Names := CleanedUpNames;
																																		Addresses := dedup(sort(left.addresses,record),record); // remove duplicate addresses
																																		self.Addresses := Addresses;
																																		self := left;
   																																));
																	biz_debtors_final := 	biz_debtors_pure + biz_debtors_cleaned;																		
																	
																	self.debtors :=  biz_debtors_final;
																	self.BKRecordType := map(
																	                         count(biz_debtors_final) = 0  => 0, 
																															count(biz_debtors_pure) = count(debtors)  => 1,
																															2
																														 );
																	
																	self := left;
																	
																	));

  return bk_recs_classified;
end;