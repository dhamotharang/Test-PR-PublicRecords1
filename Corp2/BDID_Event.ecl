// Join events to corp base to assign bdids
export BDID_Event(
	dataset(Layout_Corporate_Direct_Event_Base	) pUpdate_Event		= Update_Event()
	,dataset(Layout_Corporate_Direct_Corp_AID		) pUpdate_Corp		= Update_Corp	()
	,string																				pPersistname		= persistnames.BDIDEvent

) :=
function

Layout_Corp_BDID_List := record
unsigned6 bdid;
string30  corp_key;
unsigned4 dt_vendor_first_reported;
unsigned4 dt_vendor_last_reported;
end;

Layout_Corp_BDID_List InitCorpBDID(Layout_Corporate_Direct_Corp_AID l) := transform
self := l;
end;

Corp_BDID_Init := sort(project(pUpdate_Corp, InitCorpBDID(left)), bdid, corp_key);
Corp_BDID_Dedup := rollup(Corp_BDID_Init, transform(recordof(Corp_BDID_Init),
	self.dt_vendor_first_reported := if(left.dt_vendor_first_reported < right.dt_vendor_first_reported	and left.dt_vendor_first_reported != 0, left.dt_vendor_first_reported	, right.dt_vendor_first_reported);
	self.dt_vendor_last_reported 	:= if(left.dt_vendor_last_reported 	> right.dt_vendor_last_reported 	and left.dt_vendor_last_reported 	!= 0, left.dt_vendor_last_reported	, right.dt_vendor_last_reported	);
	self := left;
),bdid,corp_key);

Corp_BDID_Dedup_Dist := distribute(Corp_BDID_Dedup, hash(corp_key));

Corp_Event_Dist := distribute(pUpdate_Event, hash(corp_key));

// Join events to corp base to assign bdids
Layout_Corporate_Direct_Event_Base AssignEventBDID(Layout_Corporate_Direct_Event_Base l, Layout_Corp_BDID_List r) := transform
self.bdid := r.bdid;
self := l;
end;

Corp_Event_Base := join(Corp_Event_Dist,
                        Corp_BDID_Dedup_Dist,
						left.corp_key = right.corp_key
						and (right.bdid != 0)
		and (	(			left.dt_vendor_first_reported				>= right.dt_vendor_first_reported
						and left.dt_vendor_first_reported				<= right.dt_vendor_last_reported
					)
				or(			left.dt_vendor_last_reported					>= right.dt_vendor_first_reported
						and left.dt_vendor_last_reported					<= right.dt_vendor_last_reported
					)
			)
						,
						AssignEventBDID(left, right),
						left outer,
						local);
						
Corp_Event_Base_Sort 	:= sort(Corp_Event_Base,record,local);						
returndataset 				:= dedup(Corp_Event_Base_Sort	,record,local) : persist(pPersistname);						
						
return returndataset;

end;