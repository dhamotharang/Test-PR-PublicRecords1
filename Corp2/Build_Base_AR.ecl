import ut,corp2_mapping;

export Build_Base_AR(	DATASET(Corp2.Layout_Corporate_Direct_AR_Base_expanded)	inARBase,
											DATASET(Corp2_Mapping.LayoutsCommon.ar)									inARUpdate,
											string																			   					pversion,
											string pPersistname = corp2.persistnames.UpdateAR) := function
										
inARUpdatedist	:=	dedup(sort(distribute(inARUpdate,hash(corp_key)),record, local), record, local);

// Project AR Update to Base Format
Corp2.Layout_Corporate_Direct_AR_Base_expanded InitARUpdate(Corp2_Mapping.LayoutsCommon.ar l) := transform
	self.dt_first_seen 						:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_last_seen 						:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_vendor_first_reported := (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_vendor_last_reported 	:= (unsigned4)fCheckDate(l.corp_process_date);
	self.record_type 							:= 'H';
	self 													:= l;
end;

AR_update_init 			:= project(inARUpdatedist, InitARUpdate(left));
AR_update_init_dist := distribute(AR_update_init, hash(corp_key));

AR_update_init_sort := sort(AR_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

Corp2.Layout_Corporate_Direct_AR_Base_expanded RollupARUpdate(Corp2.Layout_Corporate_Direct_AR_Base_expanded l, Corp2.Layout_Corporate_Direct_AR_Base_expanded r) := transform
	self.dt_first_seen 						:=	ut.EarliestDate(
																							ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
																							ut.EarliestDate(l.dt_last_seen,r.dt_last_seen)
																										);
	self.dt_last_seen 						:= ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	self.dt_vendor_last_reported 	:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	self.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	self.corp_process_date 				:= if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
	self 													:= l;
end;

AR_update_init_rollup := rollup(AR_update_init_sort, RollupARUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);
							   
// Initialize Current base file
corp2.Layout_Corporate_Direct_AR_Base_expanded InitCurrentARBase(corp2.Layout_Corporate_Direct_AR_Base_expanded l) := transform
	self.bdid 				:= 0;
	self.record_type	:= 'H';
	self							:= l;
end;

AR_current_init 			:= project(inARBase, InitCurrentARBase(left));
AR_current_init_dist	:= dedup(sort(distribute(AR_current_init, hash(corp_key)),record,local),record,local);

// Combine current base with update
ar_update_combined 		:= map(Flags.Update.ar and flags.ExistarV2CurrentSprayed =>
															AR_current_init + ar_update_init_rollup,
														Flags.Update.ar =>
															AR_current_init,
															ar_update_init_rollup
													);
													
arUpdateCombinedDist			:=	distribute(ar_update_combined,hash(corp_key));
						   
// Rollup dates for identical records
AR_update_combined_sort 	:= sort(arUpdateCombinedDist, except bdid, dt_first_seen, dt_last_seen,
                                            dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);

AR_update_combined_rollup := rollup(AR_update_combined_sort, RollupARUpdate(left, right), except bdid, dt_first_seen, dt_last_seen,
                               dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, record_type, local);


// Set Current - Historical Indicator
AR_update_combined_rollup_sort 			:= sort(AR_update_combined_rollup, corp_key, local);
AR_update_combined_rollup_grpd 			:= group(AR_update_combined_rollup_sort, corp_key, local);
AR_update_combined_rollup_grpd_sort := sort(AR_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

corp2.Layout_Corporate_Direct_AR_Base_expanded SetRecordType(corp2.Layout_Corporate_Direct_AR_Base_expanded L, corp2.Layout_Corporate_Direct_AR_Base_expanded R) := transform
	isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord 					:= if(l.record_type = '',true, false);
	decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type				:= decision;
	self 										:= r;
end;

AR_update := group(iterate(AR_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

//////////////////////////////
//Assign BDIDs 
///////////////////////////////
Layout_Corp_BDID_List := record
	unsigned6 bdid;
	string30  corp_key;
	unsigned4 dt_vendor_first_reported;
	unsigned4 dt_vendor_last_reported;
end;

Layout_Corp_BDID_List InitCorpBDID(Corp2.Layout_Corporate_Direct_Corp_Base_Expanded l) := transform
	self := l;
end;

pUpdate_Corp					:=	corp2.files(pversion).base_xtnd.corp.new(bdid!=0);

Corp_BDID_Init 				:= sort(project(distribute(pUpdate_Corp,hash(bdid)), InitCorpBDID(left)), bdid, corp_key,local) : independent;
Corp_BDID_Dedup 			:= rollup(Corp_BDID_Init, transform(recordof(Corp_BDID_Init),
	self.dt_vendor_first_reported := if(left.dt_vendor_first_reported < right.dt_vendor_first_reported	and left.dt_vendor_first_reported != 0, left.dt_vendor_first_reported	, right.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= if(left.dt_vendor_last_reported 	> right.dt_vendor_last_reported 	and left.dt_vendor_last_reported 	!= 0, left.dt_vendor_last_reported	, right.dt_vendor_last_reported	);
	self := left;
),bdid, corp_key,local);

Corp_BDID_Dedup_Dist 	:= distribute(Corp_BDID_Dedup, hash(corp_key)) : independent;

Corp_AR_Dist					:= distribute(AR_update, hash(corp_key)) : independent;

// Join events to corp base to assign bdids
Corp2.Layout_Corporate_Direct_AR_Base_Expanded AssignARBDID(Corp2.Layout_Corporate_Direct_AR_Base_Expanded l, Layout_Corp_BDID_List r) := transform
	self.bdid := r.bdid;
	self 			:= l;
end;

Corp_AR_Base := join(	Corp_AR_Dist,
											Corp_BDID_Dedup_Dist,
											left.corp_key = right.corp_key and
											((left.dt_vendor_first_reported	>= right.dt_vendor_first_reported and
												left.dt_vendor_first_reported	<= right.dt_vendor_last_reported
												) or
											 (left.dt_vendor_last_reported	>= right.dt_vendor_first_reported and
												left.dt_vendor_last_reported	<= right.dt_vendor_last_reported
											 )
											),
											AssignARBDID(left, right),
											left outer,
											local);

Corp_AR_Base_Sort  := sort (Corp_AR_Base,record,local);	
returndataset      := dedup(Corp_AR_Base_Sort	,record,local) : persist(pPersistname);

return returndataset;

end;