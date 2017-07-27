IMPORT	ut, iBehavior, lib_StringLib;

f := iBehavior.files.File_consumer;

behavior_consumer := PROJECT(f, TRANSFORM(ibehavior.layout_consumer_search,SELF := LEFT));
BehaviorConsumerSrt := 	SORT(DISTRIBUTE(behavior_consumer,HASH(IB_Individual_ID,IB_Household_ID,DID)),RECORD, EXCEPT date_first_seen,date_last_seen,err_stat,persistent_record_id,local);

ibehavior.layout_consumer_search  ConsumerRollupXform(ibehavior.layout_consumer_search L, layout_consumer_search R) := transform
		self.date_first_seen := if(L.date_first_seen > R.date_first_seen, R.date_first_seen, L.date_first_seen);
		self.date_last_seen  := if(L.date_last_seen  < R.date_last_seen,  R.date_last_seen, L.date_last_seen);
		self := L; 
	end;	
	
ConsumerRollup := ROLLUP(BehaviorConsumerSrt, ConsumerRollupXform(LEFT,RIGHT), EXCEPT date_first_seen,date_last_seen,err_stat,persistent_record_id,LOCAL);		

append_puid := ibehavior.fn_append_consumer(ConsumerRollup);

export file_consumer_searchfile := append_puid : PERSIST('~thor_data400::persist::ibehavior::consumer_searchfile');;





