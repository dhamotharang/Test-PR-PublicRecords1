//helper transform to be used instead of creating inline RidRec datasets
export Layout_Rollup.RidRec makeRidRec(string30 rid, string2 src, unsigned6 dcnt)  := TRANSFORM
	self.rid := rid;
	self.src := src;
	self.doccnt := dcnt;
END;
