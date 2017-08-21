import crim, Predator, didville, did_add, fair_isaac;

_persons := minibuild.FL_Crim_Person;

get_node(integer Le) := (Le - 1) % thorlib.nodes();

Layout_Person_ext :=
RECORD
	_persons;
	integer rec_id := 0;
END;
persons := TABLE(_persons, Layout_Person_ext);


//************************ Do Roxie DIDing ****************************
Layout_Person_ext compSeq(persons L,persons R, INTEGER C) := 
TRANSFORM
	SELF.rec_id :=  IF(C = 1, (thorlib.node() + 1), L.rec_id + thorlib.nodes());
	SELF := R;
END;

i := iterate(persons, compSeq(LEFT, RIGHT, COUNTER), LOCAL);

// project into roxie format
didville.Layout_Did_InBatch inBatch(i L) :=
TRANSFORM
	SELF.seq := L.rec_id;
	SELF.title := '';
	SELF.suffix := L.name_suffix;
	SELF.p_city_name := L.v_city;
	SELF.addr_suffix := L.suffix;
	SELF.z5 := L.zip;
	SELF.phone10 := '';
	SELF.dob := (STRING)L.dob;
	SELF := L;
END;
inPersons := PROJECT(i, inBatch(LEFT));

DID_Add.Mac_Match_Fast_Roxie(inPersons, outPersons)

idDid :=
RECORD
	outPersons.seq;
	outPersons.did;
	outPersons.score;
END;
justidDid := TABLE(outPersons(did>0), iddid);

rec_sidDid := record
 string12 sid;
 unsigned6 did;
end;

// join back to full person dataset
rec_sidDID addDID(Layout_Person_ext L, idDID R) :=
TRANSFORM
	SELF.did := R.did;
	SELF := L;
END;

sortedJustidDID := DISTRIBUTE(justidDid, get_node(seq));
personsDIDd := JOIN(SORTED(i, rec_id), sortedJustidDID, LEFT.rec_id = RIGHT.seq, addDID(LEFT, RIGHT), LOCAL);

siddids := dedup(personsDIDd,all);

dofirst := output(_persons,,'~matrixbuild::base::CrimHist', overwrite);
dosecond := output(siddids,,'~matrixbuild::base::CrimSidDid',overwrite);
dothird := buildindex(minibuild.key_crimhist_did, overwrite);
goforth := buildindex(minibuild.key_crimhist_sid, overwrite);
sequential(dofirst, dosecond, dothird, goforth);