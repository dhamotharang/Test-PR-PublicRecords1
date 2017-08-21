// No longer uses DPPA recs to calc. best SSN.  2/24/04 CJM.
import ut,header,mdr;

export fn_BestSSN	(
					dataset(recordof(header.layout_header)) infile
					,thresh='2'
					)
	:= function


rfields := record
	unsigned6    did;
	qstring9     ssn;
	unsigned4	 dob;
	string1		 ssn_valid := 'Y';
	string1		 old_ssn := 'N';
end;

//Slim down and set ssn_valid for 9 digit ssns that aren't 0 padded
rfields slim(infile l) := transform
	self.ssn := intformat((integer)l.ssn,9,1);
	self.ssn_valid := if(	(length(trim((string)l.ssn))=9)
							,'Y'
							,'N');
	self := l;
end;

slim_h := project(infile(~mdr.Source_is_DPPA(src) and (integer)ssn>0),slim(left));

dis_infile := distribute(slim_h,hash(did));

//Set Old_SSN flag for SSNs that were issued before birth
dob_rec := record
	dis_infile.did;
	integer min_dob := min(group,(dis_infile.dob div 10000));
end;

min_dob := table(dis_infile(dob between 18500000 and (integer)ut.getdate),dob_rec,did,local);

rfields set_dob(rfields L, dob_rec R) := transform
	self.dob := r.min_dob;
	self := l;
end;

with_dob := join(dis_infile,min_dob
				,left.did=right.did
				,set_dob(left,right)
				,left outer
				,local);

//Compare with SSN Map file to get issue date

//TODO: why only year is compared?
rfields get_old(rfields L, header.Layout_SSN_Map R) := transform

	// new ssn-issue data have '20990101' for the current date intervals
	r_end := IF (R.end_date='20990101', '', R.end_date[1..4]);
	end_date_int := (INTEGER) r_end;

	self.old_ssn := if ((end_date_int = 0) OR (l.dob <= end_date_int),
					  'N', 'Y');
	self := l;
end;

with_old := join(with_dob, header.File_SSN_Map
					,	Left.ssn[1..5] <> ''
					and	Left.ssn[1..5] = Right.ssn5
					and	Left.ssn[6..9] between Right.start_serial and Right.end_serial
					,get_old (Left, Right)
					,LEFT OUTER
					,LOOKUP);

dis_again := distribute(with_old,hash(did));

//Count SSNs within a DID
cnt_table := record
	dis_again.did;
	dis_again.ssn;
	dis_again.ssn_valid;
	dis_again.old_ssn;
	ssn_total := count(group);
end;

cnt_ssns := table(dis_again,cnt_table,did,ssn,ssn_valid,old_ssn,local);

val_ssn		:= cnt_ssns(ssn_valid='Y');
inval_ssn	:= cnt_ssns(ssn_valid='N');

srt_inval := sort(inval_ssn,did,((unsigned)ssn % 10000),local);

typeof(srt_inval) rollInval(srt_inval l, srt_inval r) := transform
	self.ssn_total := l.ssn_total + r.ssn_total;
	self := l;
end;

inval_roll := rollup(inval_ssn
					,	left.did=right.did
					and ((unsigned)left.ssn % 10000)=((unsigned)right.ssn % 10000)
					,rollInval(left,right)
					,local);


//Join valids to invalids to count 4 digits in with respective 9 digits
cnt_table addinval(cnt_table L, cnt_table R) := transform
	self.ssn_total := l.ssn_total + r.ssn_total;
	self := l;
end;

withInval := join(val_ssn,inval_roll
					,	left.did=right.did
					and ((unsigned)left.ssn % 10000)=((unsigned)right.ssn % 10000)
					,addInval(left,right)
					,left outer
					,local);

cnt_table rm_matches(cnt_table L, cnt_table R) := transform
	self := l;
end;

//Find SSN that are ONLY invalid (not matching 9 digit number)
ex_inval := join(inval_ssn,val_ssn
					,	left.did=right.did
					and ((unsigned)left.ssn % 10000)=((unsigned)right.ssn % 10000)
					,rm_matches(left,right)
					,left only
					,local);

allRecs := withInval + ex_inval;

//Ungroup and resort
group_sort := sort(distribute(allRecs,hash(did)),did,-ssn_total,old_ssn,local);

//Dedup by DID keeping the top two most frequent
two_DID := dedup(group_sort,did,keep 2,local);


//If SSN count is 2x greater than the next and it is valid, it is 'best'
cnt_table ssn_join(cnt_table le, cnt_table rt) := transform
	self.ssn := map( fn_ssn_interception(le.ssn, rt.ssn) > 5
									and (unsigned)le.ssn div 1000000 > 0
									and le.ssn_total > rt.ssn_total => le.ssn
					,le.ssn_total >= (real8)thresh * rt.ssn_total => le.ssn
					,le.old_ssn='N' and rt.old_ssn='Y' and le.ssn_total >= rt.ssn_total => le.ssn
					,'');
	self := le;
end;

join_cnt := join(two_DID,two_DID
					,left.did=right.did
					and	left.ssn <> right.ssn
					,ssn_join(left,right)
					,left outer
					,local);

//output only the 'best' ssn records (at most one per DID)
outfile := join_cnt(ssn <> '');

return outfile;

end;