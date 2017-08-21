import header, ut;

na_match := header.Matched2Util;
util_seq := utilfile.Sequenced;

stat_Rec := record
	unsigned6 util_seq2 := 0;
end;

stat_rec pulloff(na_match l) := transform
	self.util_seq2 := l.util_seq;
end;

stats      := project(na_match(util_seq > 0), pulloff(left));
stdd_dist  := dedup(sort(distribute(stats, hash(util_seq2)), util_seq2, local), util_seq2, local);

//****** Match results back to the util file
util_seq_dist := distribute(util_seq,hash(uid));

header.Layout_New_Records tra(util_seq_dist l, stdd_dist r) := transform
	self := l;
end;

misses := join(util_seq_dist,stdd_dist,left.uid=right.util_seq2,tra(left, right), left only, local);

new_eq_recs   := distribute(header.preprocess,hash(fname,mname,lname,name_suffix,prim_range,predir,prim_name,postdir,sec_range,city_name,st,zip,zip4));
misses_redist := distribute(misses,           hash(fname,mname,lname,name_suffix,prim_range,predir,prim_name,postdir,sec_range,city_name,st,zip,zip4));

header.layout_new_records tra2(misses_redist le, new_eq_recs ri) := transform
 self := le;
end;

j1 := join(misses_redist(ssn<>''),new_eq_recs,
           left.fname      =right.fname       and
		   left.mname      =right.mname       and
		   left.lname      =right.lname       and
		   left.name_suffix=right.name_suffix and
		   left.prim_range =right.prim_range  and
		   left.predir     =right.predir      and
		   left.prim_name  =right.prim_name   and
		   left.postdir    =right.postdir     and
		   left.sec_range  =right.sec_range   and
		   left.city_name  =right.city_name   and
		   left.st         =right.st          and
		   left.zip        =right.zip         and
		   left.zip4       =right.zip4        and
		   //condition below returns the same count as j1 and j2
		   //(ut.nneq(left.ssn,right.ssn) or trim(right.ssn)=''),
		   ut.nneq(left.ssn,right.ssn),
		   tra2(left,right),
		   left only,
		   local
		  );

j2 := join(misses_redist(trim(ssn)=''),new_eq_recs,
           left.fname      =right.fname       and
		   left.mname      =right.mname       and
		   left.lname      =right.lname       and
		   left.name_suffix=right.name_suffix and
		   left.prim_range =right.prim_range  and
		   left.predir     =right.predir      and
		   left.prim_name  =right.prim_name   and
		   left.postdir    =right.postdir     and
		   left.sec_range  =right.sec_range   and
		   left.city_name  =right.city_name   and
		   left.st         =right.st          and
		   left.zip        =right.zip         and
		   left.zip4       =right.zip4,
		   tra2(left,right),
		   left only,
		   local
		  );
		  
//misses was the old way and let in utility records by looking at the previous header only
//j1+j2 also checks to make sure those records are not in the new equifax monthly credit file				 
export misses_as_header := j1+j2 : persist('persist::headerbuild_util_misses');