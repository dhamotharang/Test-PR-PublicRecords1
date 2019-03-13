import header, watchdog, ut, data_services;


h_all := header.File_Headers;
h := dedup(sort(distribute(project(h_all(dob > 0), {h_all.did, h_all.dob}), hash((unsigned6)did)), did, dob, local), did, local);



fb := watchdog.File_Best;
b_all := distribute(project(fb, {fb.did, fb.dob, fb.fname, fb.mname, fb.lname}), hash((unsigned6)did));  //dist only needed on dataland
b 		:= join(b_all, h,
							left.dob = 0 and
							left.did = right.did,
							transform({b_all}, self.dob := if(right.dob > 0, right.dob, left.dob), self := left),
							local, left outer)
							(dob > 0);

// rel file where number_cohabits > 20
fr := header.File_Relatives_v3;
r_all := fr +
				 project(fr, transform({fr}, self.person1 := left.person2,
																		 self.person2 := left.person1,
																		 self := left));
				 
				 
r 		:= distribute(project(r_all(number_cohabits > 20), {r_all.person1, r_all.person2}), hash((unsigned6)person1));

// join those two to add person2
br := join(b(ut.GenderTools .gender(fname,mname) <> 'M'), r, 
					 left.did = right.person1, 
					 local);

// use my join criteria back to best file and hope to find the parents
wb := join(distribute(br, hash((unsigned6)person2)), b, 
					 left.person2 = right.did and
					 left.lname = right.lname and
					 ut.Age(left.dob) - ut.Age(right.dob) < -15, //right is 15 yrs older
					 transform({br.did, br.lname}, self := left),
					 local);
					 
t := table(wb, {wb.lname,wb.did, cnt := count(group)},did,lname);

// output(h_all, named('h_all'));
// output(h, named('h'));
// output(b_all, named('b_all'));
// output(b, named('b'));
// output(r_all, named('r_all'));
// output(r, named('r'));
// output(br, named('br'));
// output(wb, named('wb'));
// output(t, named('t'));

export key_ParentLnames := index(t, {did}, {t}, data_services.Data_Location.Person_header+'thor_data400::key::header.parentlnames_'+doxie.Version_SuperKey);

