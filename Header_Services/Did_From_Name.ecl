import doxie, header;
// make sure the indata.rid field is populated with a unique value.
export Did_From_Name (DATASET(header.Layout_Header) indata, 
											boolean dodedup, boolean name_phonetics, boolean first_nicknames)
:=
MODULE
	shared unsigned4 reclimit := 9000;

	shared sortedindata := SORT(indata,lname,fname,st,city_name);
	shared indataLFSC := DEDUP(sortedindata,lname,fname,st,city_name);
	shared indataLFS := DEDUP(sortedindata,lname,fname,st);
	shared indataLF := DEDUP(sortedindata,lname,fname);

	shared parent := RECORD,maxlength(100 + (reclimit*6))
		boolean lafn;
		qstring20 fname;
		qstring20 lname;
		qstring25 city_name;
		string2   st;
		unsigned4 child_dids_count;
		DATASET(doxie.layout_references) child_dids;
	END;
// If you rearange any of this code be sure to check the execution graph!!
// This stuff is very sensitive to bloat!!
	parent tranLFSC(header.Layout_Header l) :=
	TRANSFORM
	,SKIP(l.city_name='' and l.st='')
		bignames := Header_Services.Fetch_Header_StCityLFname_Function(l.fname, 
																				l.lname,name_phonetics,first_nicknames,l.st,l.city_name);
		SELF.child_dids := CHOOSEN(DEDUP(SORT(bignames.outrec, did),did),reclimit);
		SELF.child_dids_count := count(SELF.child_dids);
		SELF.lafn := bignames.lafn;
		SELF := l;
	END;
	shared ParentRecsLFSC := project(indataLFSC,tranLFSC(LEFT));

	parent tranLFS(header.Layout_Header l) :=
	TRANSFORM
	,SKIP(l.st='')
		bignames := Header_Services.Fetch_Header_StFnameLname_Function(l.fname, 
																				l.lname,name_phonetics,first_nicknames,l.st,'');
		SELF.child_dids := CHOOSEN(DEDUP(SORT(bignames.outrec, did),did),reclimit);
		SELF.child_dids_count := count(SELF.child_dids);
		SELF.lafn := bignames.lafn;
		SELF := l;
	END;
	shared ParentRecsLFS := project(indataLFS,tranLFS(LEFT));

	parent tranLF(header.Layout_Header l) :=
	TRANSFORM
		bignames := Header_Services.Fetch_Header_Name_Function(l.fname, 
																				l.lname,name_phonetics,first_nicknames);
		SELF.child_dids := CHOOSEN(DEDUP(SORT(bignames.outrec, did),did),reclimit);
		SELF.child_dids_count := count(SELF.child_dids);
		SELF.lafn := bignames.lafn;
		SELF := l;
	END;
	shared ParentRecsLF := project(indataLF,tranLF(LEFT));
	
	doxie.layout_references NormIt(parent l, doxie.layout_references r) := TRANSFORM
		SELF.did := r.did;
	END;

	shared CountRecsLFSC := MAX(ParentRecsLFSC,ParentRecsLFSC.child_dids_count);
	shared CountRecsLFS := MAX(ParentRecsLFS,ParentRecsLFS.child_dids_count);

	shared ParentRecs := map(CountRecsLFSC != 0 => ParentRecsLFSC,
													CountRecsLFS != 0 => ParentRecsLFS,
													ParentRecsLF
													);
	
	ParentJoinRec := RECORD
		unsigned6 rid;
		boolean lafn;
	END;
	ParentJoinRec ParentJoin(header.Layout_Header l, parent r) :=
	TRANSFORM
		SELF.rid := l.rid;
		SELF.lafn := r.lafn;
	END;

	EXPORT LAFNRecs := JOIN(indata, ParentRecs, 
		LEFT.lname = RIGHT.lname 
		and LEFT.fname = RIGHT.fname
		and LEFT.st = RIGHT.st
		and LEFT.city_name = RIGHT.city_name
		, ParentJoin(LEFT,RIGHT)
		);

	doxie.layout_references NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
		SELF.did := r.did;
	END;

	NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));
	EXPORT Outrecs := IF(dodedup, DEDUP(SORT(NormRecs,did),did), NormRecs);

END;