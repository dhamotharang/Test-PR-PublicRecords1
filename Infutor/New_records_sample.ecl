import infutor;

//d01:= output(choosen(Infutor.File_Infutor_DID,1000),named('Infutor_tracker_sample_QA'));
 
//export New_records_sample := d01;

d01 := Infutor.File_Infutor_DID;
	
	
DedupRecs := dedup(sort(d01,{-d01.last_activity_dt,d01.RawAID}));
NewRecs := distribute(DedupRecs);//,HASH( -d01.last_activity_dt,d01.prim_range,d01.RAWAID,d01.dbpc,d01.chk_digit));
FIRST1000 := choosen(NewRecs,1000);

EXPORT New_records_sample := output(First1000,all);		