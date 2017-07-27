import doxie, header;
// make sure the indata.rid field is populated with a unique value
export Did_From_Address (DATASET(header.Layout_Header) indata,
					boolean dodedup,  boolean name_phonetics, unsigned2 zip_radius_value)
:=
MODULE
shared unsigned4 reclimit := 9000;

shared sortedindata := SORT(indata,prim_range,prim_name,city_name,st,zip,sec_range,lname,fname);
shared indataALF := DEDUP(sortedindata,prim_range,prim_name,city_name,st,zip,sec_range,lname,fname);
shared indataAL := DEDUP(sortedindata,prim_range,prim_name,city_name,st,zip,sec_range,lname);
shared indataA := DEDUP(sortedindata,prim_range,prim_name,city_name,st,zip,sec_range);

shared parent := RECORD,maxlength(150 + (reclimit*6))
	boolean lafn;
	qstring20 fname;
	qstring20 lname;
	qstring10 prim_range;
	qstring28 prim_name;
	qstring8  sec_range;
	qstring25 city_name;
	string2   st;
	qstring5  zip;
	unsigned4 child_dids_count;
	DATASET(doxie.layout_references) child_dids;
END;
// If you rearange any of this code be sure to check the execution graph!!
// This stuff is very sensitive to bloat!!
parent tranALF(header.Layout_Header l) :=
TRANSFORM
	,SKIP(l.prim_name = '' or l.lname = '' or l.fname = '')
	bigaddrs := Header_Services.Fetch_Address_Function(l.prim_range, l.prim_name, 
																			l.city_name,l.st,l.zip,zip_radius_value,l.sec_range,l.lname,l.fname,
																			name_phonetics);
	SELF.child_dids := CHOOSEN(DEDUP(SORT(bigaddrs.outrecs, did),did),reclimit);
	SELF.child_dids_count := count(SELF.child_dids);
	SELF.lafn := bigaddrs.lafn;
	SELF := l;
END;
shared ParentRecsALF := project(indataALF,tranALF(LEFT));

parent tranAL(header.Layout_Header l) :=
TRANSFORM
	,SKIP(l.prim_name = '' or l.lname = '')
	bigaddrs := Header_Services.Fetch_Address_Function(l.prim_range, l.prim_name, 
																			l.city_name,l.st,l.zip,zip_radius_value,l.sec_range,l.lname,'',
																			name_phonetics);
	SELF.child_dids := CHOOSEN(DEDUP(SORT(bigaddrs.outrecs, did),did),reclimit);
	SELF.child_dids_count := count(SELF.child_dids);
	SELF.lafn := bigaddrs.lafn;
	SELF := l;
END;
shared ParentRecsAL := project(indataAL,tranAL(LEFT));

parent tranA(header.Layout_Header l) :=
TRANSFORM
	,SKIP(l.prim_name = '')
	bigaddrs := Header_Services.Fetch_Address_Function(l.prim_range, l.prim_name, 
																			l.city_name,l.st,l.zip,zip_radius_value,l.sec_range,'','',
																			name_phonetics);
	SELF.child_dids := CHOOSEN(DEDUP(SORT(bigaddrs.outrecs, did),did),reclimit);
	SELF.child_dids_count := count(SELF.child_dids);
	SELF.lafn := bigaddrs.lafn;
	SELF := l;
END;
shared ParentRecsA := project(indataA,tranA(LEFT));

parent tranZ(header.Layout_Header l) :=
TRANSFORM
	,SKIP(l.zip = '')
	bigaddrs := Header_Services.Fetch_Header_Zip_Function(l.prim_range, l.prim_name, 
																			l.city_name,l.st,l.zip,zip_radius_value,l.sec_range,l.lname,l.fname,
																			name_phonetics);
	SELF.child_dids := CHOOSEN(DEDUP(SORT(bigaddrs.outrecszip, did),did),reclimit);
	SELF.child_dids_count := count(SELF.child_dids);
	SELF.lafn := bigaddrs.lafn;
	SELF := l;
END;
shared ParentRecsZ := project(indataALF,tranZ(LEFT));

doxie.layout_references NormIt(parent l, doxie.layout_references r) := TRANSFORM
	SELF.did := r.did;
END;

shared CountRecsALF := MAX(ParentRecsALF,ParentRecsALF.child_dids_count);
shared CountRecsAL := MAX(ParentRecsAL,ParentRecsAL.child_dids_count);
shared CountRecsA := MAX(ParentRecsA,ParentRecsA.child_dids_count);

shared ParentRecs := map(CountRecsALF != 0 => ParentRecsALF,
												CountRecsAL != 0 => ParentRecsAL,
												ParentRecsA + ParentRecsZ
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
	LEFT.prim_range = RIGHT.prim_range 
	and LEFT.prim_name = RIGHT.prim_name
	and LEFT.city_name = RIGHT.city_name
	and LEFT.st = RIGHT.st
	and LEFT.zip = RIGHT.zip
	and LEFT.sec_range = RIGHT.sec_range
	and LEFT.lname = RIGHT.lname
	and LEFT.fname = RIGHT.fname
	, ParentJoin(LEFT,RIGHT)
	);

doxie.layout_references NormIt(ParentRecs l, doxie.layout_references r) := TRANSFORM
	SELF.did := r.did;
END;

NormRecs := NORMALIZE(ParentRecs,LEFT.child_dids,NormIt(Left,Right));

EXPORT Outrecs := IF(dodedup, DEDUP(SORT(NormRecs,did),did), NormRecs);

END;