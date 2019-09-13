
#OPTION('multiplePersistInstances',false);

//Primary
Primary := DATASET('~thor::in::globalwatchlists::ofac', 
                     Layout_OFAC_Specially_Designated_Nationals.Layout_Primary, 
														   CSV(separator('|')))(record_type = 'Primary');	
//output(choosen(Primary,all), named('Primary'));

//Program
Program := DATASET('~thor::in::globalwatchlists::ofac', 
                     Layout_OFAC_Specially_Designated_Nationals.Layout_Program, 
														   CSV(separator('|')))(record_type = 'Program');	
//output(choosen(Program( SDN_ID = '10391'),all), named('Program'));

//lookup_ofac
lookup_ofac := DATASET('~thor::in::globalwatchlists::ofac', 
                            Layout_lookup.layout_ofac_sanction_programs, 
														       CSV(separator('|')));	
//output(choosen(lookup_ofac,all), named('lookup_ofac'));

//Address
Address := DATASET('~thor::in::globalwatchlists::ofac', 
                     Layout_OFAC_Specially_Designated_Nationals.Layout_Address, 
														   CSV(separator('|')))(record_type = 'Address');	
//output(choosen(Address( SDN_ID = '10391'),all), named('Address'));

//ID - no recs
ID := DATASET('~thor::in::globalwatchlists::ofac', 
                     Layout_OFAC_Specially_Designated_Nationals.Layout_ID, 
														   CSV(separator('|')))(record_type = 'ID'  
															      // and sdn_id = '12330' 
															        );	
//output(choosen(ID,all), named('ID'));

//Nationality - no recs
Nationality := DATASET('~thor::in::globalwatchlists::ofac', 
                     Layout_OFAC_Specially_Designated_Nationals.Layout_Nationality, 
														   CSV(separator('|')))(record_type = 'Nationality');	
//output(choosen(Nationality,all), named('Nationality'));

//Citizenship - no recs
Citizenship := DATASET('~thor::in::globalwatchlists::ofac', 
                         Layout_OFAC_Specially_Designated_Nationals.Layout_Citizenship, 
														   CSV(separator('|')))(record_type = 'Citizenship');	
//output(choosen(Citizenship,all), named('Citizenship'));

//DOB
DOB := DATASET('~thor::in::globalwatchlists::ofac', 
                              Layout_OFAC_Specially_Designated_Nationals.Layout_DOB, 
														   CSV(separator('|')))(record_type = 'DOB');	
//output(choosen(DOB,all), named('DOB'));

//POB
POB := DATASET('~thor::in::globalwatchlists::ofac', 
                              Layout_OFAC_Specially_Designated_Nationals.Layout_POB, 
														   CSV(separator('|')))(record_type = 'POB');	
//output(choosen(POB,all), named('POB'));

// Rollup program_and_lookup_ofac after join.
program_and_lookup_ofac := join(Program,lookup_ofac,left.program = right.sanction_code,left outer);
//output(choosen(lookup_ofac,all),named('lookup_ofac'));  
//output(choosen(program_and_lookup_ofac,all), named('program_and_lookup_ofac'));

layout_rollup_program_and_lookup_ofac := record
recordof(program_and_lookup_ofac);
string rollup_program_and_lookup_ofac;
end;

layout_rollup_program_and_lookup_ofac tr_initialize_rollup_program_and_lookup_ofac
                                         (program_and_lookup_ofac l) := TRANSFORM
self.rollup_program_and_lookup_ofac := 'Program/s:';
self.sanction_name := map(l.sanction_name <> ''
                           => l.sanction_name, l.program);
self := l;
end;
		
initialize_rollup_program_and_lookup_ofac
               := PROJECT(program_and_lookup_ofac,tr_initialize_rollup_program_and_lookup_ofac(left));
//output(initialize_rollup_program_and_lookup_ofac, named('initialize_rollup_program_and_lookup_ofac'));

sort_program_and_lookup_ofac := sort(initialize_rollup_program_and_lookup_ofac,sdn_id);
//output(sort_program_and_lookup_ofac,named('sort_program_and_lookup_ofac'));

layout_rollup_program_and_lookup_ofac  tr_rollup_program_and_lookup_ofac
                                         (sort_program_and_lookup_ofac l,sort_program_and_lookup_ofac r) := TRANSFORM

rollup_program_and_lookup_ofac_info := map(l.rollup_program_and_lookup_ofac = 'Program/s:'  // means get initial left and right recs (rec1 and rec2)
                                     =>  l.rollup_program_and_lookup_ofac  + ' ' + 
													               l.sanction_name + ', ' + 
														             r.sanction_name,
														                l.rollup_program_and_lookup_ofac + ', ' +  // get rec 3 and above left recs
																	          r.sanction_name 
																	             );

self.sdn_id := l.sdn_id;
self.rollup_program_and_lookup_ofac := rollup_program_and_lookup_ofac_info;
self := l;
end;

rollup_program_and_lookup_ofac := ROLLUP(sort_program_and_lookup_ofac,
                                    left.SDN_ID = right.SDN_ID, 
				                            tr_rollup_program_and_lookup_ofac(left,right));
				 
//output(rollup_program_and_lookup_ofac,named('rollup_program_and_lookup_ofac'));	

// Rollup rest.  Needed to get single sanction_name recs for which rollup does not fire. 
layout_rollup_program_and_lookup_ofac  tr_rollup_singleprogram_and_lookup_ofac
                                         (rollup_program_and_lookup_ofac l) := TRANSFORM

rollup_program_and_lookup_ofac_info := map(l.rollup_program_and_lookup_ofac = 'Program/s:'  
                                         => l.rollup_program_and_lookup_ofac  + ' ' +  
													                 l.sanction_name,
													                  l.rollup_program_and_lookup_ofac);

self.sdn_id := l.sdn_id;
self.rollup_program_and_lookup_ofac := rollup_program_and_lookup_ofac_info;
self := l;
end;

rollup_singleprogram_and_lookup_ofac := PROJECT(rollup_program_and_lookup_ofac,tr_rollup_singleprogram_and_lookup_ofac(left));
//output(rollup_singleprogram_and_lookup_ofac, named('rollup_singleprogram_and_lookup_ofac'));

// Rollup ID
layout_rollup_id := record
Layout_OFAC_Specially_Designated_Nationals.Layout_ID;
string rollup_id;
end;

layout_rollup_id tr_initialize_rollup_id(ID l) := TRANSFORM
self.rollup_id := 'IDs:';
self := l;
end;
		
initialize_rollup_id := PROJECT(ID,tr_initialize_rollup_id(left));
//output(initialize_rollup_id, named('initialize_rollup_id'));

sort_id := sort(initialize_rollup_id,sdn_id);
//output(sort_id,named('sort_id'));

layout_rollup_id  tr_rollup_id(sort_id l,sort_id r) := TRANSFORM

rolled_up_id_info := map(l.rollup_id = 'IDs:'  // means get initial left and right recs (rec1 and rec2)
                          =>  l.rollup_id  + ' ' + 
													    l.id_type + ' ' + 
															l.id_number + ' ' +
													    map(l.id_country <> '' => '(' + l.id_country + '), ','') +
															map(l.id_issue_date <> '' => 'Issue Dt: ' + l.id_issue_date + ' ','') +
															map(l.id_expiration_date <> '' => 'Exp. Dt: ' + l.id_expiration_date,'') +
													    r.id_type + ' ' + 
															r.id_number + ' ' + 
															map(r.id_country <> '' => '(' + r.id_country + '), ','') +
															map(r.id_issue_date <> '' => 'Issue Dt: ' + r.id_issue_date + ' ','') +
															map(r.id_expiration_date <> '' => 'Exp. Dt: ' + r.id_expiration_date,'') ,
														      l.rollup_id +   // get rec 3 and above left recs
																	r.id_type + ' ' + 
																	r.id_number + ' ' + 
																	map(r.id_country <> '' => '(' + r.id_country + '), ','') +
															    map(r.id_issue_date <> '' => 'Issue Dt: ' + r.id_issue_date + ' ','') +
															    map(r.id_expiration_date <> '' => 'Exp. Dt: ' + r.id_expiration_date,'') 
																	);

self.sdn_id := l.sdn_id;
self.rollup_id := rolled_up_id_info;
self := l;
end;

rollup_id := ROLLUP(sort_id,
                     left.SDN_ID = right.SDN_ID, 
				               tr_rollup_id(left,right));
				 
//output(rollup_id,named('rollup_id'));	

// Rollup rest.  Needed to get single ID recs for which rollup does not fire. 
layout_rollup_id  tr_rollup_singleIDs(rollup_id l) := TRANSFORM

rolled_up_id_info := map(l.rollup_id = 'IDs:'  
                          =>  l.rollup_id  + ' ' + 
													    l.id_type + ' ' + 
															l.id_number + ' ' +
													    map(l.id_country <> '' => '(' + l.id_country + '), ','') +
															map(l.id_issue_date <> '' => 'Issue Dt: ' + l.id_issue_date + ' ','') +
															map(l.id_expiration_date <> '' => 'Exp. Dt: ' + l.id_expiration_date,''), 
																l.rollup_id	);

self.sdn_id := l.sdn_id;
self.rollup_id := rolled_up_id_info;
self := l;
end;

rollup_singleIDs := PROJECT(rollup_id,tr_rollup_singleIDs(left));
//output(rollup_singleIDs, named('rollup_singleIDs'));

// Rollup Nationality
layout_rollup_Nationality := record
Layout_OFAC_Specially_Designated_Nationals.Layout_Nationality;
string rollup_Nationality;
end;

layout_rollup_Nationality tr_initialize_rollup_Nationality(Nationality l) := TRANSFORM
self.rollup_Nationality := 'Nationalities:';
self := l;
end;
		
initialize_rollup_Nationality := PROJECT(Nationality,tr_initialize_rollup_Nationality(left));
//output(initialize_rollup_Nationality, named('initialize_rollup_Nationality'));

sort_Nationality := sort(initialize_rollup_Nationality,sdn_id);
//output(sort_Nationality,named('sort_Nationality'));

layout_rollup_Nationality  tr_rollup_Nationality(sort_Nationality l,sort_Nationality r) := TRANSFORM

rolled_up_Nationality_info := map(l.rollup_Nationality = 'Nationalities:'  // means get initial left and right recs (rec1 and rec2)
                                     =>  l.rollup_Nationality  + ' ' + 
													               l.Nationality + ', ' + 
														             r.Nationality,
														                l.rollup_Nationality + ', ' +  // get rec 3 and above left recs
																	          r.Nationality 
																	             );

self.sdn_id := l.sdn_id;
self.rollup_Nationality := rolled_up_Nationality_info;
self := l;
end;

rollup_Nationality := ROLLUP(sort_Nationality,
                        left.SDN_ID = right.SDN_ID, 
				                  tr_rollup_Nationality(left,right));
				 
//output(rollup_Nationality,named('rollup_Nationality'));	

// Rollup rest.  Needed to get single Nationality recs for which rollup does not fire. 
layout_rollup_Nationality  tr_rollup_singleNationality(rollup_Nationality l) := TRANSFORM

rolled_up_Nationality_info := map(l.rollup_Nationality = 'Nationalities:'  
                                   => l.rollup_Nationality  + ' ' +  
													            l.Nationality,
													            l.rollup_Nationality);

self.sdn_id := l.sdn_id;
self.rollup_Nationality := rolled_up_Nationality_info;
self := l;
end;

rollup_singleNationality := PROJECT(rollup_Nationality,tr_rollup_singleNationality(left));
//output(rollup_singleNationality, named('rollup_singleNationality'));

// Rollup Citizenship
layout_rollup_Citizenship := record
Layout_OFAC_Specially_Designated_Nationals.Layout_Citizenship;
string rollup_Citizenship;
end;

layout_rollup_Citizenship tr_initialize_rollup_Citizenship(Citizenship l) := TRANSFORM
self.rollup_Citizenship := 'Citizenships:';
self := l;
end;
		
initialize_rollup_Citizenship := PROJECT(Citizenship,tr_initialize_rollup_Citizenship(left));
//output(initialize_rollup_Citizenship, named('initialize_rollup_Citizenship'));

sort_Citizenship := sort(initialize_rollup_Citizenship,sdn_id);
//output(sort_Citizenship,named('sort_Citizenship'));

layout_rollup_Citizenship  tr_rollup_Citizenship(sort_Citizenship l,sort_Citizenship r) := TRANSFORM

rolled_up_Citizenship_info := map(l.rollup_Citizenship = 'Citizenships:'  // means get initial left and right recs (rec1 and rec2)
                                     =>  l.rollup_Citizenship  + ' ' + 
													               l.Citizenship + ', ' + 
														             r.Citizenship,
														                l.rollup_Citizenship + ', ' +  // get rec 3 and above left recs
																	          r.Citizenship 
																	             );

self.sdn_id := l.sdn_id;
self.rollup_Citizenship := rolled_up_Citizenship_info;
self := l;
end;

rollup_Citizenship := ROLLUP(sort_Citizenship,
                        left.SDN_ID = right.SDN_ID, 
				                  tr_rollup_Citizenship(left,right));
				 
//output(rollup_Citizenship,named('rollup_Citizenship'));	

// Rollup rest.  Needed to get single Citizenship recs for which rollup does not fire. 
layout_rollup_Citizenship  tr_rollup_singleCitizenship(rollup_Citizenship l) := TRANSFORM

rolled_up_Citizenship_info := map(l.rollup_Citizenship = 'Citizenships:'  
                                   => l.rollup_Citizenship  + ' ' +  
													            l.Citizenship,
													            l.rollup_Citizenship);

self.sdn_id := l.sdn_id;
self.rollup_Citizenship := rolled_up_Citizenship_info;
self := l;
end;

rollup_singleCitizenship := PROJECT(rollup_Citizenship,tr_rollup_singleCitizenship(left));
//output(rollup_singleCitizenship, named('rollup_singleCitizenship'));

// Rollup DOB
layout_rollup_DOB := record
Layout_OFAC_Specially_Designated_Nationals.Layout_DOB;
string rollup_DOB;
end;

layout_rollup_DOB tr_initialize_rollup_DOB(DOB l) := TRANSFORM
self.rollup_DOB := 'DOBs:';
self := l;
end;
		
initialize_rollup_DOB := PROJECT(DOB,tr_initialize_rollup_DOB(left));
//output(initialize_rollup_DOB, named('initialize_rollup_DOB'));

sort_DOB := sort(initialize_rollup_DOB,sdn_id);
//output(sort_DOB,named('sort_DOB'));

layout_rollup_DOB  tr_rollup_DOB(sort_DOB l,sort_DOB r) := TRANSFORM

rolled_up_DOB_info := map(l.rollup_DOB = 'DOBs:'  // means get initial left and right recs (rec1 and rec2)
                                     =>  l.rollup_DOB  + ' ' + 
													               l.DOB + ', ' + 
														             r.DOB,
														                l.rollup_DOB + ', ' +  // get rec 3 and above left recs
																	          r.DOB 
																	             );

self.sdn_id := l.sdn_id;
self.rollup_DOB := rolled_up_DOB_info;
self := l;
end;

rollup_DOB := ROLLUP(sort_DOB,
                        left.SDN_ID = right.SDN_ID, 
				                  tr_rollup_DOB(left,right));
				 
//output(rollup_DOB,named('rollup_DOB'));	

// Rollup rest.  Needed to get single DOB recs for which rollup does not fire. 
layout_rollup_DOB  tr_rollup_singleDOB(rollup_DOB l) := TRANSFORM

rolled_up_DOB_info := map(l.rollup_DOB = 'DOBs:'  
                                   => l.rollup_DOB  + ' ' +  
													            l.DOB,
													            l.rollup_DOB);

self.sdn_id := l.sdn_id;
self.rollup_DOB := rolled_up_DOB_info;
self := l;
end;

rollup_singleDOB := PROJECT(rollup_DOB,tr_rollup_singleDOB(left));
//output(rollup_singleDOB, named('rollup_singleDOB'));


// Rollup POB
layout_rollup_POB := record
Layout_OFAC_Specially_Designated_Nationals.Layout_POB;
string rollup_POB;
end;

layout_rollup_POB tr_initialize_rollup_POB(POB l) := TRANSFORM
self.rollup_POB := 'POBs:';
self := l;
end;
		
initialize_rollup_POB := PROJECT(POB,tr_initialize_rollup_POB(left));
//output(initialize_rollup_POB, named('initialize_rollup_POB'));

sort_POB := sort(initialize_rollup_POB,sdn_id);
//output(sort_POB,named('sort_POB'));

layout_rollup_POB  tr_rollup_POB(sort_POB l,sort_POB r) := TRANSFORM

rolled_up_POB_info := map(l.rollup_POB = 'POBs:'  // means get initial left and right recs (rec1 and rec2)
                                     =>  l.rollup_POB  + ' ' + 
													               l.POB + ', ' + 
														             r.POB,
														                l.rollup_POB + ', ' +  // get rec 3 and above left recs
																	          r.POB 
																	             );

self.sdn_id := l.sdn_id;
self.rollup_POB := rolled_up_POB_info;
self := l;
end;

rollup_POB := ROLLUP(sort_POB,
                        left.SDN_ID = right.SDN_ID, 
				                  tr_rollup_POB(left,right));
				 
//output(rollup_POB,named('rollup_POB'));	

// Rollup rest.  Needed to get single POB recs for which rollup does not fire. 
layout_rollup_POB  tr_rollup_singlePOB(rollup_POB l) := TRANSFORM

rolled_up_POB_info := map(l.rollup_POB = 'POBs:'  
                                   => l.rollup_POB  + ' ' +  
													            l.POB,
													            l.rollup_POB);

self.sdn_id := l.sdn_id;
self.rollup_POB := rolled_up_POB_info;
self := l;
end;

rollup_singlePOB := PROJECT(rollup_POB,tr_rollup_singlePOB(left));
//output(rollup_singlePOB, named('rollup_singlePOB'));

// Join all files
j1 := join(Primary,Address,
            left.sdn_id = right.sdn_id, left outer);

j2 := join(j1,rollup_singleprogram_and_lookup_ofac,
                  left.sdn_id = right.sdn_id, left outer);
									
j3 := join(j2,rollup_singleIDs,
                  left.sdn_id = right.sdn_id, left outer);
									
j4 := join(j3,rollup_singleNationality,	
            left.sdn_id = right.sdn_id, left outer);
									
j5 := join(j4,rollup_singleCitizenship,	
            left.sdn_id = right.sdn_id, left outer);	
									
j6 := join(j5,rollup_singleDOB,	
            left.sdn_id = right.sdn_id, left outer);
									
j7 := join(j6,rollup_singlePOB,
            left.sdn_id = right.sdn_id, left outer);		
//output(j7,named('j7'));

Patriot_preprocess.layout_patriot_common tr_patriot_common(j7 l ) := TRANSFORM

clean_aka_type :=  regexreplace('f.k.a.',
                       regexreplace('n.k.a.',l.aka_type,'a.k.a.'),'a.k.a.');

name_type := map(clean_aka_type= 'a.k.a.'
               => StringLib.StringToUpperCase(l.AKA_Category)
   				      + ' ' + StringLib.StringToUpperCase(StringLib.StringFindReplace(l.aka_type,'.',''))
								            ,'');
														
city := map(l.Address_city <> '' => l.Address_city + ' ','');
state := map(l.Address_state <> '' => l.Address_state + ' ','');
postal_code := map(l.Address_postal_code <> '' => l.Address_postal_code + ' ','');
country := map(l.Address_country <> '' => l.Address_country + ' ','');

city_state_postal_code_country := 	trim(city + state + postal_code + country);	

addr_1 := map(l.address_line_1 <> ''
                => l.address_line_1,
								     l.address_line_2 <> ''
                      => l.address_line_2,
									       l.address_line_3 <> ''
                          => l.address_line_3,
									           city_state_postal_code_country <> ''
                               => city_state_postal_code_country,
							                    '');				

addr_2 := map(addr_1 <> l.address_line_2 and addr_1 <> '' and l.address_line_2 <> '' 
                 => l.address_line_2,
							      addr_1 <> l.address_line_3 and addr_1 <> '' and l.address_line_3 <> ''
                         => l.address_line_3,
								            addr_1 <> city_state_postal_code_country  and addr_1 <> '' and city_state_postal_code_country <> ''
                                => city_state_postal_code_country,
							                    '');

addr_3 := map(addr_2 <> l.address_line_3  and addr_2 <> '' and l.address_line_3 <> ''
                  => l.address_line_3,
							       addr_2 <> city_state_postal_code_country and addr_2 <> ''  and city_state_postal_code_country <> ''
                        => city_state_postal_code_country,
							           '');

addr_4 := map(addr_3 <> city_state_postal_code_country and addr_3 <> '' and city_state_postal_code_country <> ''
                        => city_state_postal_code_country,
							           '');									 

remarks_1 := l.rollup_program_and_lookup_ofac[1..75];

remarks_2 := l.rollup_program_and_lookup_ofac[76..150];

rest_of_remarks := map(l.rollup_id <> '' => trim(l.rollup_id) + '; ', '') +
                    map(l.rollup_nationality <> '' => l.rollup_nationality + '; ', '') +
										 map(l.rollup_citizenship <> '' => l.rollup_citizenship + '; ', '') +
										  map(l.rollup_dob <> '' => l.rollup_dob + '; ', '') +
											 map(l.rollup_pob <> '' => l.rollup_pob + '; ', '');

remarks_3 := rest_of_remarks[1..75];
remarks_4 := rest_of_remarks[76..150];
remarks_5 := rest_of_remarks[151..225];
remarks_6 := rest_of_remarks[226..300];
remarks_7 := rest_of_remarks[301..375];
remarks_8 := rest_of_remarks[376..450];
remarks_9 := rest_of_remarks[451..525];

orig_pty_name := l.last_name + map(l.first_name <> '' => ', ' + l.first_name, '');

self.pty_key := 'OFAC' + l.SDN_ID;
self.source := 'Office of Foreign Asset Control';
//self.orig_pty_name := l.last_name + ', ' + l.first_name;
self.orig_pty_name := orig_pty_name;
self.name_type := name_type;
self.addr_1 := addr_1;
self.addr_2 := addr_2;
self.addr_3 := addr_3;
self.addr_4 := addr_4;
self.country := l.Address_country;
self.remarks_1 := remarks_1;
self.remarks_2 := remarks_2;
self.remarks_3 := remarks_3;
self.remarks_4 := remarks_4;
self.remarks_5 := remarks_5;
self.remarks_6 := remarks_6;
self.remarks_7 := remarks_7;
self.remarks_8 := remarks_8;
self.remarks_9 := remarks_9;
//self.entity_flag := map(l.GIV_Designator = 'Entity' => 'Y', '');  
self.entity_flag := map(l.giv_designator <> 'Individual' => 'Y','');
self := [];
end;
 
patriot_common := PROJECT(j7,tr_patriot_common (left));
//output(choosen(sort(patriot_common,pty_key), all),named('patriot_common'));

EXPORT Mapping_OFAC_Specially_Designated_Nationals := patriot_common
        : persist('~thor::persist::out::patriot::preprocess::OFAC_Specially_Designated_Nationals');