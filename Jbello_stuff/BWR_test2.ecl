/* ************************

//\/\/\/\/\/\/\/\   STEP 1	run ssn diffs and  PERSIST



x:=JBello_stuff.fn_ssn_mismatch_within_a_source(header.File_Headers) : persist('~thor_data400::persist::jbello_death_final');
output(x);



//\/\/\/\/\/\/\/\   STEP 2	obtain all DE recs, dedup, and PERSIST



import header;

ds := header.File_Headers(ssn<>'');

r := record
 string2   src;
 unsigned6 did;
 string9   ssn;
end;

r t0(ds le) := transform
 self := le;
end;

p0 := project(ds,t0(left));

x := dedup(sort(distribute(p0(src!='DE'), hash(did,ssn)),did,ssn,local),did,ssn,local) : persist('~thor_data400::persist::jbello_not_DE');
output(x);




//\/\/\/\/\/\/\/\   STEP 3	count DE and PERSIST


r := record
	string2		src;
	unsigned6	did;
	string9		ssn;
end;

not_DE := dataset('~thor_data400::persist::jbello_not_DE',r,flat);

r1 := record
	did					:=	not_DE.did;
	distinct_ssn_cnt	:=	count(group);
end;

x := distribute(table(not_DE,r1,did),hash(did)) : persist('~thor_data400::persist::jbello_not_DE_cnt');

output(x);


//\/\/\/\/\/\/\/\   STEP 4	choose sets to validate

 ************************ */


r := record
	unsigned6	did;
	integer		distinct_ssn_cnt;
end;

x := dataset('~thor_data400::persist::jbello_not_DE_cnt',r,flat);

output(x(distinct_ssn_cnt>65));
output(x(distinct_ssn_cnt<2));


//\/\/\/\/\/\/\/\   STEP 5	validate

/* ************************

r := record
 unsigned6	did;
 string9	ssn1;
 string9	ssn2;
 boolean	other_src_exist_with_ssn;
 boolean	ssn1_found_in_other_sources;
 boolean	ssn2_found_in_other_sources;
 string9	pos_diff;
end;

x := dataset('~thor_data400::persist::jbello_death_final',r,flat);

output(x(did IN [1762028053]));


**************************** */
