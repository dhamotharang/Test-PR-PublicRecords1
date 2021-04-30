import doxie,Data_Services;

p := patriot.Baddies;

p1 :=
RECORD
	p;
	INTEGER nmscore;
END;

keyrec := doxie.key_header;

tmpi := INDEX(keyRec,{keyRec.s_did}, {keyrec}, Data_Services.Data_location.Prefix()+'thor_data400::key::header_QA'); 
redist := DISTRIBUTE(p, tmpi, LEFT.did = RIGHT.s_did);

p1 getBestName(redist le, tmpi ri) :=
TRANSFORM
	SELF.fname := ri.fname;
	SELF.mname := ri.mname;
	SELF.lname := ri.lname;
	SELF.nmscore := datalib.namematch(le.fname,le.mname,le.lname,ri.fname,ri.mname,ri.lname);
	SELF := le;
END;

j := JOIN(redist,tmpi,LEFT.did=RIGHT.s_did,getBestName(LEFT,RIGHT));


r := PROJECT(DEDUP(SORT(j,did,nmscore),did),TRANSFORM(recordof(p), SELF := LEFT));


export Key_Baddids_with_name := INDEX(r,{did},{r},Data_Services.Data_location.Prefix()+'thor_data400::key::patriot::Baddies_with_name_' + doxie.Version_SuperKey);