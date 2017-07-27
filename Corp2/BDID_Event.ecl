// Join events to corp base to assign bdids
Layout_Corp_BDID_List := record
unsigned6 bdid;
string30  corp_key;
end;

Layout_Corp_BDID_List InitCorpBDID(Layout_Corporate_Direct_Corp_Base l) := transform
self := l;
end;

Corp_Event_BDID_Init := project(Update_Corp, InitCorpBDID(left));
Corp_Event_BDID_Dedup := dedup(Corp_Event_BDID_Init, bdid, corp_key, all);
Corp_Event_BDID_Dedup_Dist := distribute(Corp_Event_BDID_Dedup, hash(corp_key));

Corp_Event_Dist := distribute(Update_Event, hash(corp_key));

// Join events to corp base to assign bdids
Layout_Corporate_Direct_Event_Base AssignEventBDID(Layout_Corporate_Direct_Event_Base l, Layout_Corp_BDID_List r) := transform
self.bdid := r.bdid;
self := l;
end;

Corp_Event_Base := join(Corp_Event_Dist,
                        Corp_Event_BDID_Dedup_Dist,
						left.corp_key = right.corp_key,
						AssignEventBDID(left, right),
						left outer,
						local);
						
export BDID_Event := Corp_Event_Base : persist(persistnames.BDIDEvent);