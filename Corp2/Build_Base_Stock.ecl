import ut, corp2_mapping;

export Build_Base_Stock(
												DATASET(Corp2.Layout_Corporate_Direct_Stock_Base_expanded)	inStockBase,
												DATASET(Corp2_Mapping.LayoutsCommon.Stock)									inStockUpdate,
												string																											pversion,
												string pPersistname = corp2.persistnames.UpdateStock) := function 

inStockUpdatedist	:=	dedup(sort(distribute(inStockUpdate,hash(corp_key)),record, local), record, local);

// Project Stock Update to Base Format
Corp2.Layout_Corporate_Direct_Stock_Base_expanded InitStockUpdate(Corp2_Mapping.LayoutsCommon.Stock l) := transform
	self.dt_first_seen						:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_last_seen							:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_vendor_first_reported	:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_vendor_last_reported	:= (unsigned4)fCheckDate(l.corp_process_date);
	self.record_type							:= 'H';
	self													:= l;
end;

Stock_update_init				:= project(inStockUpdatedist, InitStockUpdate(left));
Stock_update_init_dist	:= distribute(Stock_update_init, hash(corp_key));

Stock_update_init_sort	:= sort(Stock_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, 
															 record_type, local);

Corp2.Layout_Corporate_Direct_Stock_Base_expanded RollupStockUpdate(Corp2.Layout_Corporate_Direct_Stock_Base_expanded l, Corp2.Layout_Corporate_Direct_Stock_Base_expanded r) := transform
	SELF.dt_first_seen						:=	ut.EarliestDate(
																					ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
																					ut.EarliestDate(l.dt_last_seen,r.dt_last_seen)
																										);
	SELF.dt_last_seen							:= ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	SELF.dt_vendor_last_reported	:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported	:= ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	SELF.corp_process_date 				:= if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
	self 													:= l;
end;

Stock_update_init_rollup := rollup(	Stock_update_init_sort, RollupStockUpdate(left, right), except bdid, dt_first_seen, 
																		dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, 
																		record_type, local);
							   
// Initialize Current base file
Corp2.Layout_Corporate_Direct_Stock_Base_expanded InitCurrentStockBase(Corp2.Layout_Corporate_Direct_Stock_Base_expanded l) := transform
	self.bdid					:= 0;
	self.record_type	:= 'H';
	self							:= l;
end;

Stock_current_init				:= project(inStockBase, InitCurrentStockBase(left));
Stock_current_init_dist		:= dedup(sort(distribute(Stock_current_init, hash(corp_key)),record,local),record,local);

// Combine current base with update
stock_update_combined := map(	Flags.Update.stock and flags.ExiststockV2CurrentSprayed =>
																	stock_current_init_dist + stock_update_init_rollup,
															Flags.Update.stock =>
																	stock_current_init_dist,
															stock_update_init_rollup
														);

// Rollup dates for identical records
Stock_update_combined_sort		:= sort(	Stock_update_combined, except bdid, dt_first_seen, dt_last_seen,
																				dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, 
																				record_type, local);

Stock_update_combined_rollup	:= rollup(Stock_update_combined_sort, RollupStockUpdate(left, right), except bdid, 
																				dt_first_seen, dt_last_seen, dt_vendor_first_reported, dt_vendor_last_reported, 
																				corp_process_date, record_type, local);

// Set Current - Historical Indicator
Stock_update_combined_rollup_sort				:= sort(Stock_update_combined_rollup, corp_key, local);
Stock_update_combined_rollup_grpd				:= group(Stock_update_combined_rollup_sort, corp_key, local);
Stock_update_combined_rollup_grpd_sort	:= sort(Stock_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

Corp2.Layout_Corporate_Direct_Stock_Base_expanded SetRecordType(Corp2.Layout_Corporate_Direct_Stock_Base_expanded L, Corp2.Layout_Corporate_Direct_Stock_Base_expanded R) := transform
	isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord 					:= if(l.record_type = '',true, false);
	decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type				:= decision;
	self 										:= r;
end;

Stock_update := group(iterate(Stock_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

//////////////////////////////
//Assign BDIDs
///////////////////////////////
Layout_Corp_BDID_List := record
	unsigned6 bdid;
	string30  corp_key;
	unsigned4 dt_vendor_first_reported;
	unsigned4 dt_vendor_last_reported;
end;

pUpdate_Corp					:=	corp2.files(pversion).base_xtnd.corp.new(bdid!=0);

Layout_Corp_BDID_List InitCorpBDID(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded l) := transform
	self := l;
end;

Corp_BDID_Init 				:= sort(project(distribute(pUpdate_Corp,hash(bdid)), InitCorpBDID(left)), bdid, corp_key,local);
Corp_BDID_Dedup 			:= rollup(Corp_BDID_Init, transform(recordof(Corp_BDID_Init),
	self.dt_vendor_first_reported := if(left.dt_vendor_first_reported < right.dt_vendor_first_reported	and left.dt_vendor_first_reported != 0, left.dt_vendor_first_reported	, right.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= if(left.dt_vendor_last_reported 	> right.dt_vendor_last_reported 	and left.dt_vendor_last_reported 	!= 0, left.dt_vendor_last_reported	, right.dt_vendor_last_reported	);
	self := left;
),bdid, corp_key);

Corp_BDID_Dedup_Dist	:= distribute(Corp_BDID_Dedup, hash(corp_key));

Corp_Stock_Dist				:= distribute(Stock_update, hash(corp_key));

// Join events to corp base to assign bdids
Corp2.Layout_Corporate_Direct_Stock_Base_expanded AssignStockBDID(Corp2.Layout_Corporate_Direct_Stock_Base_expanded l, Layout_Corp_BDID_List r) := transform
	self.bdid := r.bdid;
	self			:= l;
end;

Corp_Stock_Base := join(Corp_Stock_Dist,
                        Corp_BDID_Dedup_Dist,
												left.corp_key = right.corp_key and
												((left.dt_vendor_first_reported	>= right.dt_vendor_first_reported and
													left.dt_vendor_first_reported	<= right.dt_vendor_last_reported
													) or
												 (left.dt_vendor_last_reported	>= right.dt_vendor_first_reported and
													left.dt_vendor_last_reported	<= right.dt_vendor_last_reported
												 )
												),
												AssignStockBDID(left, right),
												left outer,
												local);
						
Corp_Stock_Base_Sort	:= sort (Corp_Stock_Base,record,local);	
returndataset					:= dedup(Corp_Stock_Base_Sort	,record,local) : persist(pPersistname);

return returndataset;

end;