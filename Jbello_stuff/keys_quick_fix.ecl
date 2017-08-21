// d:=FLAccidents.BaseFile_FLCrash2v;

// r1 := record
	// string12  did,
	// unsigned1 did_score,
	// string12  b_did, 
     // unsigned1 b_did_score,
	// flaccidents.Layout_FLCrash2v,
// end;

// r1 tr(d l) := transform
	// self.b_did:=l.bdid;
	// self.b_did_score:=l.bdid_score;
	// self:=l;
// end;

// d2:=project(d,tr(left));

// key_flcrash2v := index(d2
                             // ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							 // ,{d2}
							 // ,'~thor_data400::key::flcrash::20080814::flcrash2v');

// buildindex(key_flcrash2v,'~thor_data400::key::flcrash::20080814::flcrash2v',overwrite);

// output(key_flcrash2v);

// d:=FLAccidents.BaseFile_FLCrash7;

// r1 := record
	// string12  did,
	// unsigned1 did_score,
	// string12  b_did, 
     // unsigned1 b_did_score,
	// flaccidents.Layout_FLCrash7,
// end;

// r1 tr(d l) := transform
	// self.b_did:=l.bdid;
	// self.b_did_score:=l.bdid_score;
	// self:=l;
// end;

// d2:=project(d,tr(left));

// key_flcrash7 := index(d2
                             // ,{unsigned6 l_acc_nbr := (integer)accident_nbr}
							 // ,{d2}
							 // ,'~thor_data400::key::flcrash::20080814::flcrash7');

// buildindex(key_flcrash7,'~thor_data400::key::flcrash::20080814::flcrash7',overwrite);

// output(key_flcrash7);


// d:=FLAccidents.BaseFile_FLCrash2v;

// r1 := record
	// string12  did,
	// unsigned1 did_score,
	// string12  b_did, 
     // unsigned1 b_did_score,
	// flaccidents.Layout_FLCrash2v,
// end;

// r1 tr(d l) := transform
	// self.b_did:=l.bdid;
	// self.b_did_score:=l.bdid_score;
	// self:=l;
// end;

// d2:=project(d,tr(left));


// output(d2,,'~thor_data400::base::flcrash2vw20080414-temp');

d:=FLAccidents.BaseFile_FLCrash7;

r1 := record
	string12  did,
	unsigned1 did_score,
	string12  b_did, 
     unsigned1 b_did_score,
	flaccidents.Layout_FLCrash7,
end;

r1 tr(d l) := transform
	self.b_did:=l.bdid;
	self.b_did_score:=l.bdid_score;
	self:=l;
end;

d2:=project(d,tr(left));


output(d2,,'~thor_data400::base::flcrash7w20080414-temp');