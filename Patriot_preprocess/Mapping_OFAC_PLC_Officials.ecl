
#OPTION('multiplePersistInstances',false);

//Primary
Primary := DATASET('~thor::in::globalwatchlists::ofac::new_plc', 
                              Layout_ofac_plc_officials.Layout_Primary_ofac_plc_officials, 
														   CSV(separator('|')))(record_type = 'Primary');	
//output(choosen(Primary,all), named('Primary'));

//Program
Program := DATASET('~thor::in::globalwatchlists::ofac::new_plc', 
                              Layout_ofac_plc_officials.Layout_Program_ofac_plc_officials, 
														   CSV(separator('|')))(record_type = 'Program');	
//output(choosen(Program,all), named('Program'));

//Address
Address := DATASET('~thor::in::globalwatchlists::ofac::new_plc', 
                              Layout_ofac_plc_officials.Layout_Address_ofac_plc_officials, 
														   CSV(separator('|')))(record_type = 'Address');	
//output(choosen(Address,all), named('Address'));

//lookup_ofac
lookup_ofac := DATASET('~thor::in::globalwatchlists::ofac_sanctions_lookup', 
                              Layout_lookup.layout_ofac_sanction_programs, 
														       CSV(separator('|')));	
//output(choosen(lookup_ofac,all), named('lookup_ofac'));



//DOB
DOB := DATASET('~thor::in::globalwatchlists::ofac::new_plc', 
                              Layout_ofac_plc_officials.Layout_DOB_ofac_plc_officials, 
														   CSV(separator('|')))(record_type = 'DOB');	
//output(choosen(DOB,all), named('DOB'));

//POB
POB := DATASET('~thor::in::globalwatchlists::ofac::new_plc', 
                              Layout_ofac_plc_officials.Layout_POB_ofac_plc_officials, 
														   CSV(separator('|')))(record_type = 'POB');	
//output(choosen(POB,all), named('POB'));


j1 := join(Program,Primary,left.SDN_ID = right.SDN_ID);

//output(count(j1));

j2 := join(j1,DOB,left.SDN_ID = right.SDN_ID, left outer);

j3 := join(j2,POB,left.SDN_ID = right.SDN_ID, left outer);

j4 := join(j3,Address,left.SDN_ID = right.SDN_ID, left outer);

j5 := join(j4,lookup_ofac,left.program = right.sanction_code , left outer);     

//output(choosen(j5,all),named('j5'));

Patriot_preprocess.layout_patriot_common tr_patriot_common(j5 l ) := TRANSFORM

name_type := map(l.aka_type = 'a.k.a.'
               => StringLib.StringToUpperCase(l.AKA_Category)
   				      + ' ' + StringLib.StringToUpperCase(StringLib.StringFindReplace(l.aka_type,'.',''))
								            ,'');

city := map(l.Address_city <> '' => l.Address_city + ' ','');
state := map(l.Address_state <> '' => l.Address_state + ' ','');
country := map(l.Address_country <> '' => l.Address_country + ' ','');

address_1 := 	trim(city + state + country);					
								
remarks_1 := map(l.program <> '' 
                     => 'Program/s: ' + l.program + ' - ' + l.sanction_name, ''); 

remarks_2 := map(l.Date_of_Birth <> '' and l.Place_of_Birth <> ''
                     => 'DOB: ' + l.Date_of_Birth + ', ' + 'POB: ' + l.Place_of_Birth,
										     l.Date_of_Birth <> '' 
												  => 'DOB: ' + l.Date_of_Birth,
													  l.Place_of_Birth <> ''
													  => 'POB: ' + l.Place_of_Birth,
														    '');
																
remarks_3 := map(l.remarks <> '' 
                     => 'Remarks: ' + l.remarks, '');

self.pty_key := 'OFAC' + l.SDN_ID;
self.source := 'OFAC - Palestinian Legislative Council';
self.orig_pty_name := map(l.first_name = '' => l.last_name,
                              l.last_name + ', ' + l.first_name);
self.name_type := name_type;
self.addr_1 := address_1;
self.country := l.Address_country;
self.remarks_1 := remarks_1;
self.remarks_2 := remarks_2;
self.remarks_3 := remarks_3;
self.entity_flag := map(l.giv_designator <> 'Individual' => 'Y','');
self := [];
end;
 
patriot_common := PROJECT(j5,tr_patriot_common (left));
//output(choosen(sort(patriot_common,pty_key), all),named('patriot_common'));

EXPORT Mapping_OFAC_PLC_Officials := patriot_common
         : persist('~thor::persist::out::patriot::preprocess::OFAC_PLC_Officials');