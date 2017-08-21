import	_control, PRTE_CSV;


export  Proc_Build_Sanctn_NP_Keys(string pIndexVersion)	:= function

	rKeySanctn__key__sanctn__np__autokey__address	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__address;
	END;

	rKeySanctn__key__sanctn__np__autokey__addressb2	:=
	record
	PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__addressb2;
	END;

	rKeySanctn__key__sanctn__np__autokey__citystname	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__citystname;
	END;

	rKeySanctn__key__sanctn__np__autokey__citystnameb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__citystnameb2;
	END;

	rKeySanctn__key__sanctn__np__autokey__fein2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__fein2;
	END;

	rKeySanctn__key__sanctn__np__autokey__name	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__name;
	END;

	rKeySanctn__key__sanctn__np__autokey__nameb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__nameb2;
	END;

	rKeySanctn__key__sanctn__np__autokey__namewords2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__namewords2;
	END;


	rKeySanctn__key__sanctn__np__autokey__payload	:=
	record
	PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__payload;
	END;

// Revised Layout
// addr := RECORD
		// STRING10 	prim_range;
		// STRING2 	predir;
		// STRING28 	prim_name;
		// STRING4 	addr_suffix;
		// STRING2 	postdir;
		// STRING10 	unit_desig;
		// STRING8 	sec_range;
		// STRING25 	v_city_name;
		// STRING2 	st;
		// STRING5 	zip5;
		// STRING4 	zip4;
		// STRING2 	addr_rec_type;
		// STRING2 	fips_state;
		// STRING3 	fips_county;
		// STRING10 	geo_lat;
		// STRING11 	geo_long;
		// STRING4 	cbsa;
		// STRING7 	geo_blk;
		// STRING1 	geo_match;
		// STRING4 	err_stat;
	// END;
	
	// name := RECORD
		// STRING5 	title;
		// STRING20 	fname;
		// STRING20 	mname;
		// STRING20 	lname;
		// STRING5 	name_suffix;
		// STRING3 	name_score;
	// END;
	// rKeySanctn__key__sanctn__np__autokey__payload	:=
	// record
  	// UNSIGNED6 fakeid;
		// UNSIGNED6 did;
		// UNSIGNED6 bdid;
		// UNSIGNED6 aid;
		// UNSIGNED4 lookups;
		// STRING10 	batch;
		// STRING8 	incident_num;
		// STRING7 	party_num;
		// STRING50 	name_first;
		// STRING50 	name_last;
		// STRING50 	name_middle;
		// STRING10 	suffix;
		// STRING150 party_firm;
		// STRING45 	address;
		// STRING45 	city;
		// STRING2 	state;
		// STRING9 	zip;
		// addr 			addr;
		// name 			name;
		// STRING100 company;
		// STRING8 	dob;
		// STRING10 	phone;
		// STRING9 	ssn_tin;
		// STRING11 	ssn;
		// STRING10 	tin;
		// STRING5 	srce_cd;
		// STRING1 	dbcode;
		// UNSIGNED1 zero;
		// STRING1 	blank;
		// UNSIGNED8 __internal_fpos__;
	// END;

	rKeySanctn__key__sanctn__np__autokey__phone2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__phone2;
	END;


	rKeySanctn__key__sanctn__np__autokey__phoneb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__phoneb2;
	END;

	rKeySanctn__key__sanctn__np__autokey__ssn2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__ssn2;
	END;

	rKeySanctn__key__sanctn__np__autokey__stname	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__stname;
	END;

	rKeySanctn__key__sanctn__np__autokey__stnameb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__stnameb2;
	END;

	rKeySanctn__key__sanctn__np__autokey__zip	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__zip;
	END;

	rKeySanctn__key__sanctn__np__autokey__zipb2	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__autokey__zipb2;
	END;


	rKeySanctn__key__sanctn__np__bdid	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__bdid;
	END;

	rKeySanctn__key__sanctn__np__did	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__did;
	END;

	rKeySanctn__key__sanctn__np__incident	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__incident;
	END;

	rKeySanctn__key__sanctn__np__incidentcode	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__incidentcode;
	END;

	rKeySanctn__key__sanctn__np__incidenttext	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__incidenttext;
	END;

	rKeySanctn__key__sanctn__np__license_midex	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__license_midex;
	END;

	rKeySanctn__key__sanctn__np__license_nbr	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__license_nbr;
	END;

	rKeySanctn__key__sanctn__np__midex_rpt_nbr	:=
	record
		// PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__midex_rpt_nbr;
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__midex_rpt_nbr_new;
		
	END;

// rKeySanctn__key__sanctn__np__midex_rpt_nbr	:=
	  // record
		// STRING26 	midex_rpt_nbr;
		// STRING8 	batch;
		// STRING1 	dbcode;
		// STRING8 	incident_num;
		// STRING7 	party_num;
		// STRING 		party_key;
		// UNSIGNED6 did;
		// UNSIGNED6 did_score;
		// UNSIGNED6 bdid;
		// UNSIGNED6 bdid_score;
		// STRING45 	party_position;
		// STRING150 party_employer;
		// STRING150 party_firm;
		// STRING1 	party_type;
		// STRING8 	dob;
		// STRING9 	ssn;
		// STRING5 	title;
		// STRING20 	fname;
		// STRING20 	mname;
		// STRING20 	lname;
		// STRING5 	name_suffix;
		// STRING3 	name_score;
		// STRING150 ename;
		// STRING150 cname;
		// STRING10 	tin;
		// STRING10 	prim_range;
		// STRING2 	predir;
		// STRING28 	prim_name;
		// STRING4 	addr_suffix;
		// STRING2 	postdir;
		// STRING10 	unit_desig;
		// STRING8 	sec_range;
		// STRING25 	p_city_name;
		// STRING25 	v_city_name;
		// STRING2 	st;
		// STRING5 	zip5;
		// STRING4 	zip4;
		// STRING2 	fips_state;
		// STRING3 	fips_county;
		// STRING2 	addr_rec_type;
		// STRING10 	geo_lat;
		// STRING11 	geo_long;
		// STRING4 	cbsa;
		// STRING7 	geo_blk;
		// STRING1 	geo_match;
		// STRING4 	cart;
		// STRING1 	cr_sort_sz;
		// STRING4 	lot;
		// STRING1 	lot_order;
		// STRING2 	dpbc;
		// STRING1 	chk_digit;
		// STRING4 	err_stat;
		// STRING 		sanctions;
		// string10	phone;
		// UNSIGNED8 __internal_fpos__;
	// END;
	
	rKeySanctn__key__sanctn__np__nmls_id	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__nmls_id;
	END;

	rKeySanctn__key__sanctn__np__nmls_midex	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__nmls_midex;
	END;

	rKeySanctn__key__sanctn__np__party	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__party;
	END;
	
// Revised Party Layout
 // rKeySanctn__key__sanctn__np__party	:=
	// record
	// STRING8 	batch;
		// STRING8 	incident_num;
		// STRING7 	party_num;
		// STRING1 	dbcode;
		// STRING 		sanctions;
		// STRING 		additional_info;
		// STRING150 party_firm;
		// STRING10 	tin;
		// STRING50 	name_first;
		// STRING50 	name_last;
		// STRING50 	name_middle;
		// STRING10 	suffix;
		// STRING20 	nickname;
		// STRING45 	party_position;
		// STRING150 party_employer;
		// STRING9 	ssn;
		// STRING8 	dob;
		// STRING45 	address;
		// STRING45 	city;
		// STRING2 	state;
		// STRING9 	zip;
		// STRING1 	party_type;
		// INTEGER8 	party_key;
		// INTEGER8 	int_key;
		// STRING20	phone;
		// STRING500 akaname;
		// STRING500 dbaname;
		// UNSIGNED8 aid;
		// UNSIGNED6 did;
		// UNSIGNED6 did_score;
		// UNSIGNED6 bdid;
		// UNSIGNED6 bdid_score;
	// END;
	

	rKeySanctn__key__sanctn__np__partytext	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__partytext;
	END;

	rKeySanctn__key__sanctn__np__ssn4	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__ssn4;
	END;

	rKeySanctn__key__sanctn__np__tin	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__tin;
	END;


	rKeySanctn__key__sanctn__np__party_aka_dba	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__party_aka_dba;
	END;

	rKeySanctn__key__sanctn__np__linkids_incident	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__linkids_incident;
	END;


	rKeySanctn__key__sanctn__np__linkids_party	:=
	record
		PRTE_CSV.Sanctn_NP.rthor_data400__key__sanctn__np__linkids_party;
	END;


dKeySanctn__key__sanctn__np__autokey__address 			:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__address 	,rKeySanctn__key__sanctn__np__autokey__address	);
dKeySanctn__key__sanctn__np__autokey__addressb2 		:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__addressb2 	,rKeySanctn__key__sanctn__np__autokey__addressb2	);
dKeySanctn__key__sanctn__np__autokey__citystname		:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__citystname	,rKeySanctn__key__sanctn__np__autokey__citystname	);
dKeySanctn__key__sanctn__np__autokey__citystnameb2 	:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__citystnameb2 	,rKeySanctn__key__sanctn__np__autokey__citystnameb2	);
dKeySanctn__key__sanctn__np__autokey__fein2 				:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__fein2 	,rKeySanctn__key__sanctn__np__autokey__fein2	);
dKeySanctn__key__sanctn__np__autokey__name 					:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__name 	,rKeySanctn__key__sanctn__np__autokey__name	);
dKeySanctn__key__sanctn__np__autokey__nameb2 				:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__nameb2 	,rKeySanctn__key__sanctn__np__autokey__nameb2	);
dKeySanctn__key__sanctn__np__autokey__namewords2 		:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__namewords2 	,rKeySanctn__key__sanctn__np__autokey__namewords2	);
dKeySanctn__key__sanctn__np__autokey__payload 			:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__payload 	,rKeySanctn__key__sanctn__np__autokey__payload);
dKeySanctn__key__sanctn__np__autokey__phone2 				:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__phone2 	,rKeySanctn__key__sanctn__np__autokey__phone2	);
dKeySanctn__key__sanctn__np__autokey__phoneb2 			:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__phoneb2 	,rKeySanctn__key__sanctn__np__autokey__phoneb2	);
dKeySanctn__key__sanctn__np__autokey__ssn2 					:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__ssn2 	,rKeySanctn__key__sanctn__np__autokey__ssn2	);
dKeySanctn__key__sanctn__np__autokey__stname 				:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__stname 	,rKeySanctn__key__sanctn__np__autokey__stname	);
dKeySanctn__key__sanctn__np__autokey__stnameb2 			:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__stnameb2 ,rKeySanctn__key__sanctn__np__autokey__stnameb2	);
dKeySanctn__key__sanctn__np__autokey__zip 					:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__zip 	,rKeySanctn__key__sanctn__np__autokey__zip	);
dKeySanctn__key__sanctn__np__autokey__zipb2 				:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__autokey__zipb2 	,rKeySanctn__key__sanctn__np__autokey__zipb2	);

dKeySanctn__key__sanctn__np__bdid 									:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__bdid 					,rKeySanctn__key__sanctn__np__bdid	);
dKeySanctn__key__sanctn__np__did 										:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__did 						,rKeySanctn__key__sanctn__np__did	);
dKeySanctn__key__sanctn__np__incident								:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__incident 			,rKeySanctn__key__sanctn__np__incident	);
dKeySanctn__key__sanctn__np__incidentcode						:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__incidentcode 	,rKeySanctn__key__sanctn__np__incidentcode	);
dKeySanctn__key__sanctn__np__incidenttext						:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__incidenttext 	,rKeySanctn__key__sanctn__np__incidenttext	);
dKeySanctn__key__sanctn__np__license_midex					:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__license_midex 	,rKeySanctn__key__sanctn__np__license_midex	);
dKeySanctn__key__sanctn__np__license_nbr						:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__license_nbr 		,rKeySanctn__key__sanctn__np__license_nbr	);
dKeySanctn__key__sanctn__np__midex_rpt_nbr					:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__midex_rpt_nbr 	,TRANSFORM(rKeySanctn__key__sanctn__np__midex_rpt_nbr, self := left; self := [];));
dKeySanctn__key__sanctn__np__nmls_id								:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__nmls_id				,TRANSFORM(rKeySanctn__key__sanctn__np__nmls_id, self.nmls_id := stringlib.stringfilterout(left.nmls_id,'#'); self := left;));
dKeySanctn__key__sanctn__np__nmls_midex							:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__nmls_midex			,TRANSFORM(rKeySanctn__key__sanctn__np__nmls_midex, self.nmls_id := stringlib.stringfilterout(left.nmls_id,'#'); self := left;));
dKeySanctn__key__sanctn__np__party									:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__party 					,rKeySanctn__key__sanctn__np__party );
dKeySanctn__key__sanctn__np__partytext							:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__partytext 			,rKeySanctn__key__sanctn__np__partytext	);
dKeySanctn__key__sanctn__np__ssn4										:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__ssn4 					,rKeySanctn__key__sanctn__np__ssn4	);
dKeySanctn__key__sanctn__np__tin										:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__tin 						,rKeySanctn__key__sanctn__np__tin	);
dKeySanctn__key__sanctn__np__party_aka_dba					:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__partyaka_dba 	,rKeySanctn__key__sanctn__np__party_aka_dba	);

dKeySanctn__key__sanctn__np__linkid_incident				:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__linkids_incident 	,rKeySanctn__key__sanctn__np__linkids_incident );
dKeySanctn__key__sanctn__np__linkids_party					:=project(PRTE_CSV.Sanctn_NP.dthor_data400__key__sanctn__np__linkids_party 			,rKeySanctn__key__sanctn__np__linkids_party	);

kKeySanctn__key__sanctn__np__autokey__address 		:= index(dKeySanctn__key__sanctn__np__autokey__address, {prim_name,prim_range,st,city_code,zip,sec_range,dph_lname,lname,pfname,fname,states,lname1,lname2,lname3,lookups}, {dKeySanctn__key__sanctn__np__autokey__address}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::address');
kKeySanctn__key__sanctn__np__autokey__addressb2 	:= index(dKeySanctn__key__sanctn__np__autokey__addressb2, {prim_name,prim_range,st,city_code,zip,sec_range,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__np__autokey__addressb2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::addressb2');
kKeySanctn__key__sanctn__np__autokey__citystname 	:= index(dKeySanctn__key__sanctn__np__autokey__citystname, {city_code,st,dph_lname,lname,pfname,fname,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__np__autokey__citystname}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::citystname');
kKeySanctn__key__sanctn__np__autokey__citystnameb2:= index(dKeySanctn__key__sanctn__np__autokey__citystnameb2, {city_code,st,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__np__autokey__citystnameb2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::citystnameb2');
kKeySanctn__key__sanctn__np__autokey__fein2 		  := index(dKeySanctn__key__sanctn__np__autokey__fein2, {f1,f2,f3,f4,f5,f6,f7,f8,f9,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__np__autokey__fein2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::fein2');
kKeySanctn__key__sanctn__np__autokey__name 		  	:= index(dKeySanctn__key__sanctn__np__autokey__name, {dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__np__autokey__name}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::name');
kKeySanctn__key__sanctn__np__autokey__nameb2 			:= index(dKeySanctn__key__sanctn__np__autokey__nameb2, {cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__np__autokey__nameb2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::nameb2');
kKeySanctn__key__sanctn__np__autokey__namewords2	:= index(dKeySanctn__key__sanctn__np__autokey__namewords2, {word,state,seq,bdid}, {dKeySanctn__key__sanctn__np__autokey__namewords2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::namewords2');
kKeySanctn__key__sanctn__np__autokey__payload 		:= index(dKeySanctn__key__sanctn__np__autokey__payload, {fakeid}, {dKeySanctn__key__sanctn__np__autokey__payload}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::payload');
kKeySanctn__key__sanctn__np__autokey__phone2 			:= index(dKeySanctn__key__sanctn__np__autokey__phone2, {p7,p3,dph_lname,pfname,st,did}, {dKeySanctn__key__sanctn__np__autokey__phone2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::phone2');
kKeySanctn__key__sanctn__np__autokey__phoneb2 		:= index(dKeySanctn__key__sanctn__np__autokey__phoneb2, {p7,p3,cname_indic,cname_sec,st,bdid}, {dKeySanctn__key__sanctn__np__autokey__phoneb2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::phoneb2');
kKeySanctn__key__sanctn__np__autokey__ssn2 		  	:= index(dKeySanctn__key__sanctn__np__autokey__ssn2, {s1,s2,s3,s4,s5,s6,s7,s8,s9,dph_lname,pfname,did}, {dKeySanctn__key__sanctn__np__autokey__ssn2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::ssn2');
kKeySanctn__key__sanctn__np__autokey__stname 			:= index(dKeySanctn__key__sanctn__np__autokey__stname, {st,dph_lname,lname,pfname,fname,minit,yob,s4,zip,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__np__autokey__stname}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::stname');
kKeySanctn__key__sanctn__np__autokey__stnameb2 		:= index(dKeySanctn__key__sanctn__np__autokey__stnameb2, {st,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__np__autokey__stnameb2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::stnameb2');
kKeySanctn__key__sanctn__np__autokey__zip 				:= index(dKeySanctn__key__sanctn__np__autokey__zip, {zip,dph_lname,lname,pfname,fname,minit,yob,s4,dob,states,lname1,lname2,lname3,city1,city2,city3,rel_fname1,rel_fname2,rel_fname3,lookups}, {dKeySanctn__key__sanctn__np__autokey__zip}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::zip');
kKeySanctn__key__sanctn__np__autokey__zipb2 			:= index(dKeySanctn__key__sanctn__np__autokey__zipb2, {zip,cname_indic,cname_sec,bdid}, {dKeySanctn__key__sanctn__np__autokey__zipb2}, '~prte::key::sanctn::np::'+pIndexVersion+'::autokey::zipb2');

kKeySanctn__key__sanctn__np__bdid 								:= index(dKeySanctn__key__sanctn__np__bdid, {bdid}, {dKeySanctn__key__sanctn__np__bdid}, '~prte::key::sanctn::np::'+pIndexVersion+'::bdid');
kKeySanctn__key__sanctn__np__did 									:= index(dKeySanctn__key__sanctn__np__did, {did}, {dKeySanctn__key__sanctn__np__did}, '~prte::key::sanctn::np::'+pIndexVersion+'::did');
kKeySanctn__key__sanctn__np__incident 						:= index(dKeySanctn__key__sanctn__np__incident, {INCIDENT_NUM}, {dKeySanctn__key__sanctn__np__incident}, '~prte::key::sanctn::np::'+pIndexVersion+'::incident');
kKeySanctn__key__sanctn__np__incidentcode 				:= index(dKeySanctn__key__sanctn__np__incidentcode, {INCIDENT_NUM}, {dKeySanctn__key__sanctn__np__incidentcode}, '~prte::key::sanctn::np::'+pIndexVersion+'::incidentcode');
kKeySanctn__key__sanctn__np__incidenttext 				:= index(dKeySanctn__key__sanctn__np__incidenttext, {INCIDENT_NUM}, {dKeySanctn__key__sanctn__np__incidenttext}, '~prte::key::sanctn::np::'+pIndexVersion+'::incidenttext');
kKeySanctn__key__sanctn__np__license_nbr 					:= index(dKeySanctn__key__sanctn__np__license_nbr, {CLN_LICENSE_NUMBER,LICENSE_STATE}, {dKeySanctn__key__sanctn__np__license_nbr}, '~prte::key::sanctn::np::'+pIndexVersion+'::license_nbr');
kKeySanctn__key__sanctn__np__license_midex 				:= index(dKeySanctn__key__sanctn__np__license_midex, {midex_rpt_nbr}, {dKeySanctn__key__sanctn__np__license_midex}, '~prte::key::sanctn::np::'+pIndexVersion+'::license_midex');
kKeySanctn__key__sanctn__np__midex_rpt_nbr 			  := index(dKeySanctn__key__sanctn__np__midex_rpt_nbr, {midex_rpt_nbr}, {dKeySanctn__key__sanctn__np__midex_rpt_nbr}, '~prte::key::sanctn::np::'+pIndexVersion+'::midex_rpt_nbr');
kKeySanctn__key__sanctn__np__nmls_id							:= index(dKeySanctn__key__sanctn__np__nmls_id, {NMLS_ID}, {dKeySanctn__key__sanctn__np__nmls_id}, '~prte::key::sanctn::np::'+pIndexVersion+'::nmls_id');
kKeySanctn__key__sanctn__np__nmls_midex						:= index(dKeySanctn__key__sanctn__np__nmls_midex, {MIDEX_RPT_NBR}, {dKeySanctn__key__sanctn__np__nmls_midex}, '~prte::key::sanctn::np::'+pIndexVersion+'::nmls_midex');
kKeySanctn__key__sanctn__np__party 								:= index(dKeySanctn__key__sanctn__np__party, {BATCH,INCIDENT_NUM,PARTY_NUM}, {dKeySanctn__key__sanctn__np__party}, '~prte::key::sanctn::np::'+pIndexVersion+'::party');
kKeySanctn__key__sanctn__np__partytext 			    	:= index(dKeySanctn__key__sanctn__np__partytext, {BATCH, INCIDENT_NUM, PARTY_NUM}, {dKeySanctn__key__sanctn__np__partytext}, '~prte::key::sanctn::np::'+pIndexVersion+'::partytext');
kKeySanctn__key__sanctn__np__ssn4 			    			:= index(dKeySanctn__key__sanctn__np__ssn4, {SSN4}, {dKeySanctn__key__sanctn__np__ssn4}, '~prte::key::sanctn::np::'+pIndexVersion+'::ssn4');
kKeySanctn__key__sanctn__np__tin 			    				:= index(dKeySanctn__key__sanctn__np__tin, {TIN}, {dKeySanctn__key__sanctn__np__tin}, '~prte::key::sanctn::np::'+pIndexVersion+'::tin');
kKeySanctn__key__sanctn__np__party_aka_dba 				:= index(dKeySanctn__key__sanctn__np__party_aka_dba, {BATCH,INCIDENT_NUM,PARTY_NUM}, {dKeySanctn__key__sanctn__np__party_aka_dba}, '~prte::key::sanctn::np::'+pIndexVersion+'::party_aka_dba');

kKeySanctn__key__sanctn__np__linkids_incident 		:= index(dKeySanctn__key__sanctn__np__linkid_incident, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, 
																															{dKeySanctn__key__sanctn__np__linkid_incident}, '~prte::key::sanctn::np::'+pIndexVersion+'::incident_linkids');
kKeySanctn__key__sanctn__np__linkids_party 				:= index(dKeySanctn__key__sanctn__np__linkids_party, {ultid,orgid,seleid,proxid,powid,empid,dotid,ultscore,orgscore,selescore,proxscore,powscore,empscore,dotscore,ultweight,orgweight,seleweight,proxweight,powweight,empweight,dotweight}, 
																															{dKeySanctn__key__sanctn__np__linkids_party}, '~prte::key::sanctn::np::'+pIndexVersion+'::party_linkids');


return	sequential(
														parallel(
																build(kKeySanctn__key__sanctn__np__autokey__address,  update),
																build(kKeySanctn__key__sanctn__np__autokey__addressb2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__citystname,  update),
																build(kKeySanctn__key__sanctn__np__autokey__citystnameb2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__fein2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__name,  update),
																build(kKeySanctn__key__sanctn__np__autokey__nameb2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__namewords2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__payload ,  update),
																build(kKeySanctn__key__sanctn__np__autokey__phone2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__phoneb2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__ssn2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__stname,  update),
																build(kKeySanctn__key__sanctn__np__autokey__stnameb2,  update),
																build(kKeySanctn__key__sanctn__np__autokey__zip,  update),
																build(kKeySanctn__key__sanctn__np__autokey__zipb2,  update),
																build(kKeySanctn__key__sanctn__np__bdid,  update),
																build(kKeySanctn__key__sanctn__np__did,  update),
																build(kKeySanctn__key__sanctn__np__incident,  update),
																build(kKeySanctn__key__sanctn__np__incidentcode,  update),
																build(kKeySanctn__key__sanctn__np__incidenttext,  update),
																build(kKeySanctn__key__sanctn__np__license_nbr,  update),
																build(kKeySanctn__key__sanctn__np__license_midex,  update),
																build(kKeySanctn__key__sanctn__np__midex_rpt_nbr,  update),
																build(kKeySanctn__key__sanctn__np__nmls_id,  update),
																build(kKeySanctn__key__sanctn__np__nmls_midex,  update),
																build(kKeySanctn__key__sanctn__np__party,  update),
																build(kKeySanctn__key__sanctn__np__partytext,  update),
																build(kKeySanctn__key__sanctn__np__ssn4,  update),
																build(kKeySanctn__key__sanctn__np__tin,  update),
																build(kKeySanctn__key__sanctn__np__party_aka_dba,  update),
																build(kKeySanctn__key__sanctn__np__linkids_incident, update),
																build(kKeySanctn__key__sanctn__np__linkids_party, update)

																)
																// ,
																
																
   											// PRTE.UpdateVersion('Sanctn_NPKeys ',										//	Package name
   																				 // pIndexVersion,												//	Package version
   																				 // _control.MyInfo.EmailAddressNormal,	//	Who to email with specifics
   																				 // 'B',																	//	B = Boca, A = Alpharetta
   																				 // 'N',																	//	N = Non-FCRA, F = FCRA
   																				 // 'N'																	//	N = Do not also include boolean, Y = Include boolean, too
   																// )
												
								);
								 

END;

