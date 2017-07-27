import header, ut;

na_match := header.Matched2Util;
util_seq := utilfile.Sequenced;
final_rec := header.Layout_New_Records;

stat_Rec := record
	unsigned6 util_seq2 := 0;
end;

stat_rec pulloff(na_match l) := transform
	self.util_seq2 := l.util_seq;
end;

stats := project(na_match(util_seq > 0), pulloff(left));

stdd := dedup(sort(distribute(stats, hash(util_seq2)), util_seq2, local), util_seq2, local);

//count(stdd) /  count(util);*/

//****** Match results back to the util file
util_seq_dist := distribute(util_seq, hash(uid));
stdd_dist := distribute(stdd, hash(util_seq2));

final_rec tra(util_seq_dist l, stdd_dist r) := transform
	self := l;
end;

misses := join(util_seq_dist, stdd_dist, left.uid = right.util_seq2,
			   tra(left, right), left only, local);

export misses_as_header := misses : persist('persist::headerbuild_util_misses');