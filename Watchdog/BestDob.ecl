import ut, header, did_add;

d_f := file_header_filtered(dob>18500000 and dob<19900000);

header.MAC_Best_DOB(d_f,did,dob,withDOB)

export BestDob := withDOB : persist('persist::Watchdog_BestDob');

/* OLD WAY....NOW USE MACRO

dob_count_rec := record
	counted := count(group);
	d_f.did;
	d_f.dob;
end;

//Count dob instances per DID
gdid := table(d_f,dob_count_rec,did,dob,local);

score_layout := record
 dob_count_rec;
 integer score := 0;
end;

score_layout add_score(dob_count_rec l):= transform
self.score := MAP(l.dob < 10000000 => 0, // invalid date
				  l.dob % 10000 = 101 => 3, // yyyy0101 -- prob not good
				  l.dob % 100 > 1 => 6, // yyyymmdd all good
				  l.dob % 100 = 1 => 5, // yyyymm01 - ok, but suspicious
				  l.dob % 1000 > 100 => 4, // yyyymm00 -- ok
				  l.dob % 10000 = 1100 => 4, // yyyy1100 -- nov, not jan
				  l.dob % 10000 = 1000 => 4, // yyyy1000 -- oct
				  l.dob % 1000 = 100 => 3,2); // yyyy0100 -- jan, 00 bad
self := l;
end;

//Assign Score
with_score := project(gdid,add_score(left));

srt_score := sort(with_score,did,-score,-counted,-dob,local);

//Two records per DID
dup := dedup(srt_score,did,keep 2,local);

//If dob count is 1.5x greater than the next, it is 'best'
score_layout score_join(score_layout le, score_layout rt) := transform
self.dob := MAP(le.score>rt.score and did_add.DOB_Match_Score(le.dob,rt.dob)in [100,80,40] => le.dob, //better score and close in date
			    le.score>rt.score and le.counted > rt.counted => le.dob,  //better in score and more frequent
				le.score>rt.score and did_add.DOB_Match_Score(le.dob,rt.dob)not in [100,80,40] and le.counted*3 < rt.counted => rt.dob, //most frequent is 3x more frequent
				le.score>rt.score and le.counted*1.5 > rt.counted => le.dob, //worse score is less than 1.5x the better score
			    le.score=rt.score and le.counted*1.2 < rt.counted => rt.dob, //same score one is more than 1.2x as frequent as the other
                le.score=rt.score and le.counted > rt.counted*1.2 => le.dob, //same score one is more than 1.2x as frequent as the other
				0);
self := le;
end;

join_cnt := join(dup,dup,left.did=right.did and
					left.dob <> right.dob,score_join(left,right),left outer,local);		

//sort and dedup by did
sorted_duped := dedup(sort(join_cnt,did,-score,-counted,-dob,local),did,local);		

export BestDob := sorted_duped(dob>0) : persist('persist::Watchdog_BestDob');*/