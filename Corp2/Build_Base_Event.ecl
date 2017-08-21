import ut, Corp2_Mapping;

export Build_Base_Event(DATASET(Corp2.Layout_Corporate_Direct_Event_Base_expanded)	inEventBase,
												DATASET(Corp2_Mapping.LayoutsCommon.Events)									inEventUpdate,
												string																			   							pversion,
												string pPersistname = corp2.persistnames.UpdateEvent) := function 
												
inEventUpdatedist	:=	dedup(sort(distribute(inEventUpdate,hash(corp_key)),record, local), record, local);

	// Project Event Update to Base Format
	Corp2.Layout_Corporate_Direct_Event_Base_expanded InitEventUpdate(Corp2_Mapping.LayoutsCommon.Events l) := transform
	self.event_filing_cd 						:= Stringlib.StringToUpperCase(l.event_filing_cd);
	self.event_filing_desc					:= Stringlib.StringToUpperCase(l.event_filing_desc);
	self.event_desc									:= if((	trim(l.event_desc,left,right) = '<CONT>' or 
																					trim(l.event_desc,left,right) = '<cont>') and 
																					trim(l.corp_state_origin,left,right) = 'NV',
																						'',
																						Stringlib.StringToUpperCase(l.event_desc));
	self.event_filing_reference_nbr := if(	trim(l.event_filing_date,left,right) = '' and 
																					trim(l.event_filing_desc,left,right) = '',
																						'',
																						l.event_filing_reference_nbr);
	// Set dates
	self.dt_first_seen 							:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_last_seen 							:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_vendor_first_reported 	:= (unsigned4)fCheckDate(l.corp_process_date);
	self.dt_vendor_last_reported 		:= (unsigned4)fCheckDate(l.corp_process_date);
	self.record_type 								:= 'H';
	self 														:= l;
	self														:= [];
end;

event_update_init 			:= project(inEventUpdatedist, InitEventUpdate(left));
					   
event_update_init_dist	:= distribute(event_update_init, hash(corp_key));
event_update_init_sort	:= sort(event_update_init_dist, except bdid, dt_first_seen, dt_last_seen,
																dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, 
																record_type, local);

corp2.Layout_Corporate_Direct_Event_Base_expanded RollupEventUpdate(corp2.Layout_Corporate_Direct_Event_Base_expanded l, corp2.Layout_Corporate_Direct_Event_Base_expanded r) := transform
	SELF.dt_first_seen						:= ut.EarliestDate(
																				ut.EarliestDate(l.dt_first_seen,r.dt_first_seen),
																				ut.EarliestDate(l.dt_last_seen,r.dt_last_seen)
																									);
	SELF.dt_last_seen							:= ut.LatestDate(l.dt_last_seen,r.dt_last_seen);
	SELF.dt_vendor_last_reported	:= ut.LatestDate(l.dt_vendor_last_reported, r.dt_vendor_last_reported);
	SELF.dt_vendor_first_reported := ut.EarliestDate(l.dt_vendor_first_reported, r.dt_vendor_first_reported);
	SELF.corp_process_date				:= if(l.corp_process_date > r.corp_process_date, l.corp_process_date, r.corp_process_date);
	self													:= l;
end;

event_update_init_rollup := rollup(event_update_init_sort, RollupEventUpdate(left, right), except bdid, dt_first_seen, 
																		dt_last_seen,	dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, 
																		record_type, local);
							   
// Initialize Current base file
corp2.Layout_Corporate_Direct_Event_Base_expanded InitCurrentEventBase(corp2.Layout_Corporate_Direct_Event_Base_expanded l) := transform
	self.bdid 											:= 0;
	self.record_type 								:= 'H';
	self.event_desc 								:= if((	trim(l.event_desc,left,right) = '<CONT>' or 
																					trim(l.event_desc,left,right) = '<cont>') and 
																					trim(l.corp_state_origin,left,right) = 'NV',
																						'',
																						Stringlib.StringToUpperCase(l.event_desc));
	self.event_filing_reference_nbr := if(	trim(l.event_filing_date,left,right) = '' and 
																					trim(l.event_filing_desc,left,right) = '',
																						'',
																						l.event_filing_reference_nbr);
	self 														:= l;
end;

event_current_init 				:= project(inEventBase, InitCurrentEventBase(left));
event_current_init_dist		:= dedup(sort(distribute(event_current_init, hash(corp_key)),record,local),record,local);

// Combine current base with update
event_update_combined 		:= map(	corp2.Flags.Update.events and corp2.flags.ExisteventsV2CurrentSprayed =>
																			event_current_init_dist + event_update_init_rollup,
																	corp2.Flags.Update.events =>
																			event_current_init_dist,
																	event_update_init_rollup
																);

						   
// Rollup dates for identical records
event_update_combined_sort 		:= sort(event_update_combined, except bdid, dt_first_seen, dt_last_seen,
																			dt_vendor_first_reported, dt_vendor_last_reported, corp_process_date, 
																			record_type, local);

event_update_combined_rollup	:= rollup(event_update_combined_sort, RollupEventUpdate(left, right), except bdid, 
																				dt_first_seen, dt_last_seen, dt_vendor_first_reported, 
																				dt_vendor_last_reported, corp_process_date, record_type, local);


// Set Current - Historical Indicator
event_update_combined_rollup_sort				:= sort(event_update_combined_rollup, corp_key, local);
event_update_combined_rollup_grpd 			:= group(event_update_combined_rollup_sort, corp_key, local);
event_update_combined_rollup_grpd_sort	:= sort(event_update_combined_rollup_grpd, -dt_vendor_last_reported, -dt_last_seen);

corp2.Layout_Corporate_Direct_Event_Base_expanded SetRecordType(corp2.Layout_Corporate_Direct_Event_Base_expanded L, corp2.Layout_Corporate_Direct_Event_Base_expanded R) := transform
	isdatethesame 					:= if(l.dt_vendor_last_reported != 0 and l.dt_vendor_last_reported = r.dt_vendor_last_reported, true,false);
	ispreviousrecordcurrent := if(l.record_type = 'C',true, false);
	isfirstrecord 					:= if(l.record_type = '',true, false);
	decision 								:= if(isfirstrecord or (isdatethesame and ispreviousrecordcurrent), 'C', r.record_type);

	self.record_type				:= decision;
	self 										:= r;
end;

event_update 					:= group(iterate(event_update_combined_rollup_grpd_sort, SetRecordType(left, right)));

event_update_dist 		:= distribute(event_update, hash(corp_key));

event_update_deduped 	:= dedup(sort(event_update_dist, record, local),record, except event_date_type_cd, event_date_type_desc, local); 

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

Corp_BDID_Init 				:= sort(project(distribute(pUpdate_Corp,hash(bdid)), InitCorpBDID(left)), bdid, corp_key,local);
Corp_BDID_Dedup 			:= rollup(Corp_BDID_Init, transform(recordof(Corp_BDID_Init),
	self.dt_vendor_first_reported := if(left.dt_vendor_first_reported < right.dt_vendor_first_reported	and left.dt_vendor_first_reported != 0, left.dt_vendor_first_reported	, right.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= if(left.dt_vendor_last_reported 	> right.dt_vendor_last_reported 	and left.dt_vendor_last_reported 	!= 0, left.dt_vendor_last_reported	, right.dt_vendor_last_reported	);
	self := left;
),bdid, corp_key,local);

Corp_BDID_Dedup_Dist 	:= distribute(Corp_BDID_Dedup, hash(corp_key));

Corp_Event_Dist				:= distribute(event_update_deduped, hash(corp_key));

// Join events to corp base to assign bdids
Corp2.Layout_Corporate_Direct_Event_Base_Expanded AssignEventBDID(Corp2.Layout_Corporate_Direct_Event_Base_Expanded l, Layout_Corp_BDID_List r) := transform
	self.bdid := r.bdid;
	self 			:= l;
end;

Corp_Event_Base := join(	Corp_Event_Dist,
													Corp_BDID_Dedup_Dist,
													left.corp_key = right.corp_key and
													((left.dt_vendor_first_reported	>= right.dt_vendor_first_reported and
														left.dt_vendor_first_reported	<= right.dt_vendor_last_reported
														) or
													 (left.dt_vendor_last_reported	>= right.dt_vendor_first_reported and
														left.dt_vendor_last_reported	<= right.dt_vendor_last_reported
													 )
													),
													AssignEventBDID(left, right),
													left outer,
													local);

Corp_Event_Base_Sort 	:= sort(Corp_Event_Base,record,local);						
returndataset 				:= dedup(Corp_Event_Base_Sort	,record,local) : persist(pPersistname);	

return returndataset;

end;
