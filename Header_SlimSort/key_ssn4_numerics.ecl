import header,data_services,ut,doxie,watchdog,mdr;

inf := header.fn_filter_for_keys_and_slimsorts(header.file_headers,true);

p := header.fn_populate_matchrecs(inf,watchdog.File_Best,'_slimsort',Header_Slimsort.Constants.UsePFNew,skipPreferredFirst := true);

r :=
RECORD
	unsigned2 ssn4;
	unsigned3 zip;
	UNSIGNED2 yob;
	UNSIGNED1 fi;
	UNSIGNED1 li;
	unsigned5 prim_range;
	unsigned3 ssn5;
	p.did;
	unsigned6 cnt := 1;
END;


r norm(p le, INTEGER i) :=
TRANSFORM
	pfname := datalib.preferredfirstNew(le.fname, Header_Slimsort.Constants.UsePFNew);

	SELF.ssn4 := (unsigned2)(IF(LENGTH(TRIM(le.ssn))=4, le.ssn[1..4], le.ssn[6..9]));
	SELF.ssn5 := (unsigned3) (IF(LENGTH(TRIM(le.ssn))=4, '', le.ssn[1..5]));
	SELF.zip := (unsigned3)le.zip;
	SELF.yob := (unsigned2)(le.dob[1..4]);
	SELF.fi := IF(i=1,ut.Chr2PhoneDigit(le.fname[1]),ut.Chr2PhoneDigit(pfname[1]));
	SELF.li := ut.Chr2PhoneDigit(le.lname[1]);
	SELF.prim_range := (unsigned5) stringlib.StringFilter(le.prim_range,'0123456789');
	SELF := le;
END;
normed := NORMALIZE(p,2,norm(LEFT,COUNTER))(ssn4<>0,zip<>0,fi<>0);
dist := DISTRIBUTE(normed,HASH(ssn4,zip,yob));
slimmed := DEDUP(SORT(dist,ssn4,zip,yob,fi,li, prim_range,ssn5,did,LOCAL),ssn4,zip,yob,fi,li,prim_range,ssn5,did,LOCAL);

cross :=
RECORD
	slimmed.ssn4;
	slimmed.zip;
	slimmed.yob;
	slimmed.did;
END;
tab := TABLE(slimmed,cross,ssn4,zip,yob,did, LOCAL);

cross2 := 
RECORD
	tab.ssn4;
	tab.zip;
	tab.yob;
	cnt := COUNT(GROUP);
END;	

tab2 := TABLE(tab,cross2,ssn4,zip,yob,LOCAL);

r joiner(r le, cross2 ri) :=
TRANSFORM
	SELF.cnt := ri.cnt;
	SELF := le;
END;
j := JOIN(slimmed,tab2,LEFT.ssn4=RIGHT.ssn4 AND 
											LEFT.zip=RIGHT.zip AND 
											LEFT.yob=RIGHT.yob
											, joiner(LEFT,RIGHT),LOCAL);


export key_ssn4_numerics := 
INDEX(
	j,
	{ssn4,zip,yob,fi,li},
	{j},
	data_services.foreign_prod+'thor_data400::key::header::ssn4_zip_yob_fi_' + doxie.Version_SuperKey
);
