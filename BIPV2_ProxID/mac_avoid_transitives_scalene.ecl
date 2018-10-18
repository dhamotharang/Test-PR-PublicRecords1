EXPORT mac_avoid_transitives_scalene(ifile,did1,did2,conf,dover,rule_num,thresh,bucketsize = 3) := 
FUNCTIONMACRO
import BIPV2_Tools;
//first, put the scores into buckets
All_Matchesp := project(ifile, transform({ifile}, self.conf := if(left.conf < thresh, left.conf, thresh+(integer)left.conf div bucketsize), self := left));

//then, call the regular macro
// SALT28.Mac_Avoid_Transitives(All_Matchesp,did1,did2,conf,dover,rule_num,ofile)
// BIPV2_Tools.mac_avoid_transitives (All_Matchesp,did1,did2,conf,dover,rule_num,ofile);
bipv2_tools.Mac_Avoid_Transitives(All_Matchesp,did1,did2,conf,dover,rule_num,ofile)

//then, join back to restore the orig scores
ifile_flipsome := ifile(did1 > did2) + project(ifile(did1 < did2), transform({ifile}, self.did1 := left.did2, self.did2 := left.did1, self := left));
// ifile_ddp := dedup(sort(ifile_flipsome, did1, did2, -conf, rule_num, -dover), did1, did2);

ifile_ddp1 := dedup(sort(ifile_flipsome, did1, did2, -conf, rule_num, -dover,local), did1, did2,local); //do this to cut down on skew, get low hanging fruit first
ifile_ddp  := dedup(sort(ifile_ddp1, did1, did2, -conf, rule_num, -dover), did1, did2);    

outfile :=
join(
	ofile,
	ifile_ddp,
	left.did1 = right.did1 and
	left.did2 = right.did2,
	transform(right)
  ,hash
  ,partition right
);

outfile2 :=
join(
	ofile,
	ifile_ddp,
	left.did1 = right.did1 and
	left.did2 = right.did2,
	transform(right)
  ,hash
);

//import lksd;
// lksd.o(All_Matchesp)
// lksd.o(ofile)
// lksd.o(ifile_flipsome)
// lksd.o(ifile_ddp)
// lksd.o(outfile)
return iff(count(ofile) > count(ifile_ddp) ,outfile2 ,outfile);

ENDMACRO;