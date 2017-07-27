IMPORT	ut, iBehavior, lib_StringLib;

f := iBehavior.files.File_behavior;

behavior_purchase := PROJECT(f, TRANSFORM(ibehavior.layout_behavior_search, SELF := LEFT));
BehaviorSrt := 	SORT(DISTRIBUTE(behavior_purchase,HASH(IB_Individual_ID)),RECORD,EXCEPT date_first_seen,date_last_seen,persistent_record_id,LOCAL);

ibehavior.layout_behavior_search  PurchaseRollupXform(ibehavior.layout_behavior_search L, ibehavior.layout_behavior_search R) := transform
		self.date_first_seen := if(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
		self.date_last_seen  := if(L.date_last_seen  < R.date_last_seen,  R.date_last_seen, L.date_last_seen);
		self := L; 
	end;	

BehaviorRollup := ROLLUP(BehaviorSrt,PurchaseRollupXform(LEFT,RIGHT),RECORD, EXCEPT date_first_seen, date_last_seen,persistent_record_id,LOCAL);

append_puid := ibehavior.fn_append_puid(BehaviorRollup);		
	
export file_behavior_searchfile := append_puid : PERSIST('~thor_data400::persist::ibehavior::behavior_searchfile');
