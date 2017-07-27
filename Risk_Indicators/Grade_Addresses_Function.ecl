// Grade the addresses by quality and similarity to other
// addresses.  Used by Instant ID Common Function to pick
// the three addresses for the chronology.
export Grade_Addresses_Function(GROUPED DATASET(Layout_Output) inList) := FUNCTION

AddrEQInput(Layout_Output t) :=
		t.prim_range=t.chronoprim_range AND t.prim_name=t.chronoprim_name;

Layout_Graded_Address xform1(Layout_Output l) := TRANSFORM
	SELF.support 	:= 1;
	SELF.grade 		:= 0;
	SELF.hasDL		:= l.src = 'D';
	SELF.hasVoter	:= l.src = 'V';
	SELF.hasReg		:= l.src = 'W';
	SELF.hasProp	:= l.src = 'P';
	SELF.inData 	:= PROJECT(l, TRANSFORM(Layout_Input, SELF:=LEFT));
	SELF.dt_last_seen := l.dt_last_seen;
	SELF.prim_range := l.chronoprim_range;
	SELF.prim_name	:= l.chronoprim_name;
	SELF.sec_range	:= l.chronosec_range;
	SELF.zip				:= l.chronozip;
	SELF.inputMatch := AddrEQInput(l);
END;


ds1 := SORT(PROJECT(inList, xform1(LEFT)), 
											inData.seq,-dt_last_seen, zip, prim_range, prim_name, sec_range);

Layout_Graded_Address countSupport(Layout_Graded_Address l, Layout_Graded_Address r) := TRANSFORM
	SELF.support 	:= l.support + r.support;
	SELF.hasDL		:= l.hasDL OR r.hasDL;
	SELF.hasVoter	:= l.hasVoter OR r.hasVoter;
	SELF.hasReg		:= l.hasReg OR r.hasReg;
	SELF.hasProp	:= l.hasProp OR r.hasProp;
	SELF.inputMatch := l.inputMatch OR r.inputMatch;
	SELF.grade		:= MAP(SELF.inputMatch										=> 9,
											SELF.support>2 AND SELF.hasProp			=> 8,
											SELF.support > 3										=> 6,
											SELF.hasProp												=> 4,
											SELF.support > 1										=> 2,
											0);
	SELF := l;
END;

ds2 := ROLLUP(ds1, countSupport(LEFT, RIGHT), zip, prim_range, prim_name, sec_range);

ComprTest(Layout_Graded_Address l, Layout_Graded_Address r) :=
				(l.grade >= r.grade AND
					ga(AddrScore.AddressScore(l.prim_range, l.prim_name, l.sec_range,
																		r.prim_range, r.prim_name, r.sec_range)));
											

RETURN DEDUP(ds2, comprTest(LEFT, RIGHT), ALL);

END;