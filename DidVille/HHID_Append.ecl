EXPORT HHID_Append
(
GROUPED DATASET(didville.Layout_Did_OutBatch) infile
):= FUNCTION
import ut, header_slimsort;

k := header_slimsort.Key_Household;

infile join_ss(infile l, k r) := TRANSFORM
	SELF.hhid := r.hhid_relat;
	SELF := l;
END;

j1 := JOIN(infile(hhid=0), k,
	keyed(LEFT.lname = RIGHT.lname) AND
	keyed(LEFT.prim_name = RIGHT.prim_name) AND
	keyed(LEFT.st = RIGHT.st) AND
	keyed(LEFT.z5 = RIGHT.zip) AND
	(
		(
			LEFT.sec_range = RIGHT.sec_range AND 
			RIGHT.sec_range != '' AND
			RIGHT.hhid_cnt = 1
		) OR
		RIGHT.hhid_nosec_cnt = 1
	),
	join_ss(LEFT, RIGHT), LEFT OUTER, LOCAL);

/*
// Don't think a rollup is warranted here
// if you end up in the rollup transform, then you're ambiguous
 infile roller(infile le, infile ri) :=
 TRANSFORM
  SELF.hhid := 0;
  SELF := le;
 END;
   
 j_ded := ROLLUP(DEDUP(SORT(j1,hhid),hhid), roller(LEFT,RIGHT), true)+infile(hhid<>0);
*/
j_ded := DEDUP(SORT(j1,did,hhid),did,hhid)+infile(hhid<>0);

RETURN j_ded;
END;