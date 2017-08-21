
import std, ut;

#OPTION('multiplePersistInstances',false);

pep := DATASET('~thor::in::globalwatchlists::innovative_systems::pep', 
                                                                Layout_Innovative_OFAC_Enhanced.Layout_pep, thor)
														                                     ;	
//output(pep, named('pep'));

OSC := DATASET('~thor::in::globalwatchlists::innovative_systems::osc', 
                                                                Layout_Innovative_OFAC_Enhanced.Layout_OSC, thor)
														                                     ;	
//output(choosen(OSC,all), named('OSC'));

OCC := DATASET('~thor::in::globalwatchlists::innovative_systems::occ', 
                                                                Layout_Innovative_OFAC_Enhanced.layout_cft, thor)
														                                     ;	
//output(OCC, named('OCC'));

FBI := DATASET('~thor::in::globalwatchlists::innovative_systems::fbi', 
                                                                Layout_Innovative_OFAC_Enhanced.Layout_FBI, thor)
														                                     ;	
//output(FBI, named('FBI'));

UNS := DATASET('~thor::in::globalwatchlists::innovative_systems::uns', 
                                                                Layout_Innovative_OFAC_Enhanced.Layout_UNS, thor)(original_primary_name_01 <> '' and location <> 'brow')
														                                     ;	
//output(UNS, named('UNS'));

cft := dataset('~thor::in::globalwatchlists::innovative_systems::cft',Layout_Innovative_OFAC_Enhanced.layout_cft,thor);

// fin file will always be same for all builds.
fin := dataset('~thor::in::patriot::innovative::ofac::enhanced::fin',Layout_Innovative_OFAC_Enhanced.layout_fin,thor);


// PEP
Patriot_preprocess.layout_patriot_common tr_patriot_common_pep(pep l ) := TRANSFORM

  remarks1 := map(l.Original_Designation_01 <> ''
	                         => 'Title: ' + l.Original_Designation_01, '');
  remarks2 := map(l.Line_Gender_1 <> ''
	                        => 'Gender: ' + map(l.Line_Gender_1 = 'M' => 'Male',
													                    l.Line_Gender_1 = 'F' => 'Female', l.Line_Gender_1)
													                                                , '');
  remarks3 := map(l.Original_Add_01_Line_01 <> '' => 'Country: ' + l.Original_Add_01_Line_01 , ''); 

  self.pty_key := trim(l.Application_Code) + (integer) regexreplace('^95',l.Serial_Number,'');
  self.source := 'Politically Exposed Persons';
  self.orig_pty_name := l.Original_Primary_Name;
  self.country := l.Original_Add_01_Line_01;
 
  self.remarks_1 := map(remarks1 <> '' => remarks1,
	                      remarks2 <> '' => remarks2, 
												remarks3 <> '' => remarks3, ''); 
												
  self.remarks_2 := map(remarks1 <> '' and remarks2 <> '' => remarks2,
	                      remarks1 <> '' and remarks2 = '' and remarks3 <> '' => remarks3,
												remarks1 = '' and remarks2 <> '' and remarks3 <> '' => remarks3,
	                      '');
	
  self.remarks_3 := map(remarks1 <> '' and  remarks2 <> '' and remarks3 <> '' => remarks3,	'');	
  
	self := [];
end;

patriot_common_pep := PROJECT(pep,tr_patriot_common_pep (left));
//output(patriot_common_pep,named('patriot_common_pep'));

// OSC
table_country := 
                  TABLE(OSC,{Original_Sanction_Name_01, count_1 := count(group)},Original_Sanction_Name_01);
//output(table_country,named('table_country'));

layout_table_country_seq := record
string country_seq;
string20 Original_Sanction_Name_01;
end; 

layout_table_country_seq tr_table_country_seq(table_country l,integer c ) := TRANSFORM

self.country_seq := (string) c;
self := l;
end;

table_country_seq := PROJECT(table_country,tr_table_country_seq(left,counter));
//output(table_country_seq, named('table_country_seq'));

attach_country_seq := join(OSC,table_country_seq,
                                 left.Original_Sanction_Name_01 = right.Original_Sanction_Name_01);

Patriot_preprocess.layout_patriot_common tr_patriot_common_OSC(attach_country_seq l) := TRANSFORM

	remarks1 := map(l.Original_Primary_Name <> ''
	                    => 'Primary Name: ' + l.Original_Sanction_Name_01, '');
	
	remarks2 := map(l.Original_Date_Added_To_List <> ''
	                    => 'Date Added To List: ' + l.Original_Date_Added_To_List, '');
	
  remarks3 := map(l.Original_Date_Removed_From_List <> ''
	                   => 'Date Removed From List: ' + l.Original_Date_Removed_From_List, '');
	
  self.pty_key := trim(l.Application_Code) + l.country_seq;
  self.source := 'OFAC Sanctioned Countries';
  self.orig_pty_name := l.Original_Primary_Name;
  self.country := trim(l.Original_Sanction_Name_01);
  self.name_type := 'Country';
  self.remarks_1 := map(remarks1 <> '' => remarks1,
	                      remarks2 <> '' => remarks2, 
												remarks3 <> '' => remarks3, ''); 
												
  self.remarks_2 := map(remarks1 <> '' and remarks2 <> '' => remarks2,
	                      remarks1 <> '' and remarks2 = '' and remarks3 <> '' => remarks3,
												remarks1 = '' and remarks2 <> '' and remarks3 <> '' => remarks3,
	                      '');
	
  self.remarks_3 := map(remarks1 <> '' and  remarks2 <> '' and remarks3 <> '' => remarks3,	'');	
  self.entity_flag := 'Y';	
	self := [];
	
end;

patriot_common_OSC := PROJECT(attach_country_seq,tr_patriot_common_OSC(left));
//output(patriot_common_OSC, named('patriot_common_OSC'));

//OCC

////////******** add normalizer fire count 
layout_add_normalizer_fire_count  := record
integer normalizer_fire_count;
Layout_Innovative_OFAC_Enhanced.Layout_cft;
end;

layout_add_normalizer_fire_count  tr_add_normalizer_fire_count(occ l ) := TRANSFORM

normalizer_fire_count := map( l.Original_Add_10_Line_01 <> '' => 10,
															l.Original_Add_09_Line_01 <> '' => 9,
															l.Original_Add_08_Line_01 <> '' => 8,
															l.Original_Add_07_Line_01 <> '' => 7,
															l.Original_Add_06_Line_01 <> '' => 6,
															l.Original_Add_05_Line_01 <> '' => 5,
															l.Original_Add_04_Line_01 <> '' => 4,
															l.Original_Add_03_Line_01 <> '' => 3,
															l.Original_Add_02_Line_01 <> '' => 2,
															l.Original_Add_01_Line_01 <> '' => 1,1);  // normalizer needs to fire at least 1 time
															
self.normalizer_fire_count := normalizer_fire_count;
self := l;
end;

add_normalizer_fire_count  := PROJECT(occ,tr_add_normalizer_fire_count (left));
//output(add_normalizer_fire_count, named('add_normalizer_fire_count'));

layout_normalize_occ_address := record
string50 Original_Address_01;
string50 Original_Address_02;
string50 Original_Address_03;
string50 Original_Address_04;
Layout_Innovative_OFAC_Enhanced.Layout_cft;
end;

layout_normalize_occ_address tr_normalize_occ_addresses(add_normalizer_fire_count l, integer c) := TRANSFORM 

self.Original_Address_01 := choose(c,l.Original_Add_01_Line_01,
                                     l.Original_Add_02_Line_01,
																		 l.Original_Add_03_Line_01,
																		 l.Original_Add_04_Line_01,
																		 l.Original_Add_05_Line_01,
																		 l.Original_Add_06_Line_01,
																		 l.Original_Add_07_Line_01,
																		 l.Original_Add_08_Line_01,
																		 l.Original_Add_09_Line_01,
																		 l.Original_Add_10_Line_01);

self.Original_Address_02 := choose(c,l.Original_Add_01_Line_02,
                                     l.Original_Add_02_Line_02,
																		 l.Original_Add_03_Line_02,
																		 l.Original_Add_04_Line_02,
																		 l.Original_Add_05_Line_02,
																		 l.Original_Add_06_Line_02,
																		 l.Original_Add_07_Line_02,
																		 l.Original_Add_08_Line_02,
																		 l.Original_Add_09_Line_02,
																		 l.Original_Add_10_Line_02);  																		 
																		 
self.Original_Address_03 := choose(c,l.Original_Add_01_Line_03,
                                     l.Original_Add_02_Line_03,
																		 l.Original_Add_03_Line_03,
																		 l.Original_Add_04_Line_03,
																		 l.Original_Add_05_Line_03,
																		 l.Original_Add_06_Line_03,
																		 l.Original_Add_07_Line_03,
																		 l.Original_Add_08_Line_03,
																		 l.Original_Add_09_Line_03,
																		 l.Original_Add_10_Line_03);


self.Original_Address_04 := choose(c,l.Original_Add_01_Line_04,
                                     l.Original_Add_02_Line_04,
																		 l.Original_Add_03_Line_04,
																		 l.Original_Add_04_Line_04,
																		 l.Original_Add_05_Line_04,
																		 l.Original_Add_06_Line_04,
																		 l.Original_Add_07_Line_04,
																		 l.Original_Add_08_Line_04,
																		 l.Original_Add_09_Line_04,
																		 l.Original_Add_10_Line_04);

self := l;
end; 

normalize_occ_addresses := normalize(add_normalizer_fire_count,left.normalizer_fire_count,tr_normalize_occ_addresses(left,counter));

Patriot_preprocess.layout_patriot_common tr_patriot_common_OCC(normalize_occ_addresses l) := TRANSFORM

  remarks1 := 'Date added to alert list: ' + l.Original_Date_Added_To_List;	
	remarks2 := 'Found in: ' + l.Original_Grounds_For_Addition;
	
	Additional_information_remarks :=  'Additional information: ' + l.Original_Additional_Info;
	remarks3 := Additional_information_remarks[1..75];
  remarks4 := Additional_information_remarks[76..150];
  remarks5 := Additional_information_remarks[151..225];
  remarks6 := Additional_information_remarks[226..300];
  remarks7 := Additional_information_remarks[301..375];
  remarks8 := Additional_information_remarks[376..450];
  remarks9 := Additional_information_remarks[451..525];
	remarks10 := Additional_information_remarks[526..600];
  remarks11 := Additional_information_remarks[601..675];
	remarks12 := Additional_information_remarks[676..750];
	remarks13 := Additional_information_remarks[751..825];	
	remarks14 := Additional_information_remarks[826..900];
	remarks15 := Additional_information_remarks[901..975];
	remarks16 := Additional_information_remarks[976..];
	
  self.pty_key := trim(l.Application_Code) + (integer) regexreplace('^93',l.Serial_Number,'');
  self.source := 'Office of the Comptroller of the Currency Alerts';
  self.orig_pty_name := STD.Str.CleanSpaces(l.Original_Primary_Name_01+ l.Original_Primary_Name_02+ l.Original_Primary_Name_03+ l.Original_Primary_Name_04);
	self.country := trim(l.Original_Sanction_Name_01);
  self.name_type := 'Entity'; 
  self.addr_1 := l.Original_Address_01;
  self.addr_2 := l.Original_Address_02;
  self.addr_3 := l.Original_Address_03 + ' ' + l.Original_Address_04;
  self.remarks_1 := remarks1; 												
  self.remarks_2 := remarks2;	  
	self.remarks_3 := remarks3;
  self.remarks_4 := remarks4;
  self.remarks_5 := remarks5;
  self.remarks_6 := remarks6;
  self.remarks_7 := remarks7;
  self.remarks_8 := remarks8;
  self.remarks_9 := remarks9;
	self.remarks_10 := remarks10;
  self.remarks_11 := remarks11;
	self.remarks_12 := remarks12;
  self.remarks_13 := remarks13;
	self.remarks_14 := remarks14;
	self.remarks_15 := remarks15;
  self.remarks_16 := remarks16;
  self.entity_flag := 'Y';	
	self := [];
	
end;

patriot_common_OCC := PROJECT(normalize_occ_addresses,tr_patriot_common_OCC(left));
//output(patriot_common_OCC, named('patriot_common_OCC'));


//FBI
////////******** add normalizer fire count 
layout_add_normalizer_fire_count_fbi  := record
integer normalizer_fire_count;
Layout_Innovative_OFAC_Enhanced.Layout_FBI;
end;

layout_add_normalizer_fire_count_fbi  tr_add_normalizer_fire_count_fbi(fbi l ) := TRANSFORM

normalizer_fire_count := map( l.Original_Alias_25 <> '' => 26,  // always add 1 for primary name
															l.Original_Alias_24 <> '' => 25,
															l.Original_Alias_23 <> '' => 24,
															l.Original_Alias_22 <> '' => 23,
															l.Original_Alias_21 <> '' => 22,
															l.Original_Alias_20 <> '' => 21,
															l.Original_Alias_19 <> '' => 20,
															l.Original_Alias_18 <> '' => 19,
															l.Original_Alias_17 <> '' => 18,
															l.Original_Alias_16 <> '' => 17,
															l.Original_Alias_15 <> '' => 16,
															l.Original_Alias_14 <> '' => 15,
															l.Original_Alias_13 <> '' => 14,
															l.Original_Alias_12 <> '' => 13,
															l.Original_Alias_11 <> '' => 12,
															l.Original_Alias_10 <> '' => 11,
															l.Original_Alias_09 <> '' => 10,
															l.Original_Alias_08 <> '' => 9,
															l.Original_Alias_07 <> '' => 8,
															l.Original_Alias_06 <> '' => 7,
															l.Original_Alias_05 <> '' => 6,
															l.Original_Alias_04 <> '' => 5,
															l.Original_Alias_03 <> '' => 4,
															l.Original_Alias_02 <> '' => 3,
															l.Original_Alias_01 <> '' => 2,1); // normalizer needs to fire at least 1 time
															
self.normalizer_fire_count := normalizer_fire_count;
self := l;
end;

add_normalizer_fire_count_fbi  := PROJECT(fbi,tr_add_normalizer_fire_count_fbi (left));
//output(add_normalizer_fire_count_fbi, named('add_normalizer_fire_count_fbi'));

layout_normalize_fbi_names := record
integer normalizer_fire_count;
string name_type;
Layout_Innovative_OFAC_Enhanced.Layout_FBI;
end;

layout_normalize_fbi_names  tr_normalize_fbi_names(add_normalizer_fire_count_fbi l, integer c) := TRANSFORM 

self.Original_Primary_Name := choose(c,l.Original_Primary_Name,
                                       l.Original_Alias_01,
                                       l.Original_Alias_02,
																	     l.Original_Alias_03,
																			 l.Original_Alias_04,
																	     l.Original_Alias_05,
																	     l.Original_Alias_06,
																	     l.Original_Alias_07,
																	     l.Original_Alias_08,
																	     l.Original_Alias_09,
																	     l.Original_Alias_10,
																	     l.Original_Alias_11,
																	     l.Original_Alias_12,
																   	   l.Original_Alias_13,
																	     l.Original_Alias_14,
																	     l.Original_Alias_15,
																	     l.Original_Alias_16,
																	     l.Original_Alias_17,
																	     l.Original_Alias_18,
																	     l.Original_Alias_19,
																	     l.Original_Alias_20,
																	     l.Original_Alias_21,
																	     l.Original_Alias_22,
																	     l.Original_Alias_23,
																			 l.Original_Alias_24,
																	     l.Original_Alias_25);					
																		 
self.name_type := choose(c,'',  // c = 1 is always primary name
                             'AKA',  
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA',
														 'AKA');
														 
self := l;
end; 

normalize_fbi_names := 
     normalize(add_normalizer_fire_count_fbi,left.normalizer_fire_count,tr_normalize_fbi_names(left,counter));


Patriot_preprocess.layout_patriot_common tr_patriot_common_FBI(normalize_fbi_names l) := TRANSFORM

	Original_Language_remarks := 
	    map(l.Original_Language_01 <> '' => '; Language/s: ' + trim(l.Original_Language_01) + ', ', '') +
			map(l.Original_Language_02 <> '' => trim(l.Original_Language_02) + ', ', '') +            
			map(l.Original_Language_03 <> '' => trim(l.Original_Language_03) + ', ', '') +
			map(l.Original_Language_04 <> '' => trim(l.Original_Language_04) + ', ', '') +
			map(l.Original_Language_05 <> '' => trim(l.Original_Language_05) + ', ', '') +
			map(l.Original_Language_06 <> '' => trim(l.Original_Language_06) + ', ', '') +
			map(l.Original_Language_07 <> '' => trim(l.Original_Language_07) + ', ', '') +
			map(l.Original_Language_08 <> '' => trim(l.Original_Language_08) + ', ', '') +
			map(l.Original_Language_09 <> '' => trim(l.Original_Language_09) + ', ', '') +
			map(l.Original_Language_10 <> '' => trim(l.Original_Language_10) ,'');	
	
	Original_POB_remarks := 
		  map(l.Original_POB_01 <> '' => '; Original Place of Births: ' + trim(l.Original_POB_01) + ', ', '') +
			map(l.Original_POB_02 <> '' => trim(l.Original_POB_02) + ', ', '') +            
			map(l.Original_POB_03 <> '' => trim(l.Original_POB_03) + ', ', '') +
			map(l.Original_POB_04 <> '' => trim(l.Original_POB_04) + ', ', '') +
			map(l.Original_POB_05 <> '' => trim(l.Original_POB_05) + ', ', '') +
			map(l.Original_POB_06 <> '' => trim(l.Original_POB_06) + ', ', '') +
			map(l.Original_POB_07 <> '' => trim(l.Original_POB_07) + ', ', '') +
			map(l.Original_POB_08 <> '' => trim(l.Original_POB_08) + ', ', '') +
			map(l.Original_POB_09 <> '' => trim(l.Original_POB_09) + ', ', '') +
			map(l.Original_POB_10 <> '' => trim(l.Original_POB_10) , '') ;

 	Original_DOB_remarks := 
		  map(l.Original_DOB_01 <> '' => '; Date of Births: ' + trim(l.Original_DOB_01) + ', ', '') +
			map(l.Original_DOB_02 <> '' => trim(l.Original_DOB_02) + ', ', '') +            
			map(l.Original_DOB_03 <> '' => trim(l.Original_DOB_03) + ', ', '') +
			map(l.Original_DOB_04 <> '' => trim(l.Original_DOB_04) + ', ', '') +
			map(l.Original_DOB_05 <> '' => trim(l.Original_DOB_05) + ', ', '') +
			map(l.Original_DOB_06 <> '' => trim(l.Original_DOB_06) + ', ', '') +
			map(l.Original_DOB_07 <> '' => trim(l.Original_DOB_07) + ', ', '') +
			map(l.Original_DOB_08 <> '' => trim(l.Original_DOB_08) + ', ', '') +
			map(l.Original_DOB_09 <> '' => trim(l.Original_DOB_09) + ', ', '') +
			map(l.Original_DOB_10 <> '' => trim(l.Original_DOB_10) ,'') ;

	Original_Crimes_remarks := 
		  map(l.Original_Crimes <> '' => '; Crimes: ' + trim(l.Original_Crimes), '');
	
	Original_NCIC_remarks := 
		  map(l.Original_NCIC <> '' => '; National Crime Information Center Number: ' + trim(l.Original_NCIC), '');
			
	Gender_remarks := trim(map(l.Original_Gender <> ''
	                          => map(l.Original_Gender = 'M' => '; Gender: ' + 'Male',
	                                 l.Original_Gender = 'F' => '; Gender: ' + 'Female', '; Gender: ' + 'Unknown')
																	 ,'')); 
																	 
	 Height_remarks := map(l.Original_Height <> '' => '; Height: ' + trim(l.Original_Height),'');
	 Weight_remarks := map(l.Original_Weight <> '' => '; Weight: ' + trim(l.Original_Weight),'');
	 Build_remarks := map(l.Original_Build <> '' => '; Build: ' + trim(l.Original_Build),'');
	 Hair_remarks := map(l.Original_Hair <> '' => '; Hair: ' + trim(l.Original_Hair),'');
	 Eyes_remarks := map(l.Original_Eyes <> '' => '; Eyes: ' + trim(l.Original_Eyes),'');
	 Complexion_remarks := map(l.Original_Complexion <> '' => '; Complexion: ' + trim(l.Original_Complexion),'');
	 Race_remarks := map(l.Original_Race <> '' => '; Race: ' + trim(l.Original_Race),'');
	 Scars_And_Marks_remarks := map(l.Original_Scars_And_Marks <> '' => '; Scars & Marks: ' + trim(l.Original_Scars_And_Marks),'');
	 Occupation_remarks := map(l.Original_Occupation <> '' => '; Occupation: ' + trim(l.Original_Occupation),'');
	 Country_01_remarks := map(l.Original_Country_01 <> '' => '; Nationality: ' + trim(l.Original_Country_01),'');
	
   Original_Additional_Info_remarks := map(l.Original_Additional_Info <> '' => '; Additional Information: ' + trim(l.Original_Additional_Info),'');
   Original_Caution_remarks := map(l.Original_Caution <> '' => '; Caution: ' + trim(l.Original_Caution),'');
	 Original_Reward_remarks := map(l.Original_Reward <> '' => '; Reward: ' + trim(l.Original_Reward),'');


//; Original Place of Births: California, ; Date of Births: 19690701, 1971011

   concat_remarks :=  
	                   Original_Language_remarks +
	                   Original_POB_remarks +
										 Original_DOB_remarks +
										 Original_Crimes_remarks +
										 Original_NCIC_remarks +
										 Gender_remarks +
										 Height_remarks +
										 Weight_remarks +
										 Build_remarks +
										 Hair_remarks +
										 Eyes_remarks +
										 Complexion_remarks +
										 Race_remarks +
										 Scars_And_Marks_remarks +
										 Occupation_remarks +
										 Country_01_remarks +
										 Original_Additional_Info_remarks +
										 Original_Caution_remarks +
                     Original_Reward_remarks;
										 
	concat_remarks_clean := regexreplace(', ;',concat_remarks[3..],';'); 
  
 	remarks1 := concat_remarks_clean[1..75];
  remarks2 := concat_remarks_clean[76..150];
  remarks3 := concat_remarks_clean[151..225];
  remarks4 := concat_remarks_clean[226..300];
  remarks5 := concat_remarks_clean[301..375];
  remarks6 := concat_remarks_clean[376..450];
  remarks7 := concat_remarks_clean[451..525];
	remarks8 := concat_remarks_clean[526..600];
  remarks9 := concat_remarks_clean[601..675];
	remarks10 := concat_remarks_clean[676..750];
	remarks11 := concat_remarks_clean[751..825];	
	remarks12 := concat_remarks_clean[826..900];
	remarks13 := concat_remarks_clean[901..975];
	remarks14 := concat_remarks_clean[976..1050];
	remarks15 := concat_remarks_clean[1051..1125];
	remarks16 := concat_remarks_clean[1126..1200];
	remarks17 := concat_remarks_clean[1201..1275];
	remarks18 := concat_remarks_clean[1276..1350];
	remarks19 := concat_remarks_clean[1351..1425];
	remarks20 := concat_remarks_clean[1426..];
	

  self.pty_key := trim(l.Application_Code) + (integer) l.Account_Number[1..9] ;
  self.source := 'FBI Fugitives 10 Most Wanted';
  self.orig_pty_name := l.Original_Primary_Name;
  self.country := l.Original_Country_01;
  self.name_type := l.name_type;		
  self.remarks_1 := remarks1; 												
  self.remarks_2 := remarks2;	  
	self.remarks_3 := remarks3;
  self.remarks_4 := remarks4;
  self.remarks_5 := remarks5;
  self.remarks_6 := remarks6;
  self.remarks_7 := remarks7;
  self.remarks_8 := remarks8;
  self.remarks_9 := remarks9;
	self.remarks_10 := remarks10;
  self.remarks_11 := remarks11;
	self.remarks_12 := remarks12;
  self.remarks_13 := remarks13;
	self.remarks_14 := remarks14;
	self.remarks_15 := remarks15;
  self.remarks_16 := remarks16;
	self.remarks_17 := remarks17;
  self.remarks_18 := remarks18;
	self.remarks_19 := remarks19;
	self.remarks_20 := remarks20;	
	
 self := [];
 end;


patriot_common_FBI := PROJECT(normalize_fbi_names,tr_patriot_common_FBI(left));

//UNS
////////******** add normalizer fire count 
layout_add_normalizer_fire_count_uns  := record
integer normalizer_fire_count;
Layout_Innovative_OFAC_Enhanced.Layout_uns;
end;

layout_add_normalizer_fire_count_uns  tr_add_normalizer_fire_count_uns(uns l ) := TRANSFORM

normalizer_fire_count := map( l.Original_Alias_25 <> '' => 26,  // always add 1 for primary name
															l.Original_Alias_24 <> '' => 25,
															l.Original_Alias_23 <> '' => 24,
															l.Original_Alias_22 <> '' => 23,
															l.Original_Alias_21 <> '' => 22,
															l.Original_Alias_20 <> '' => 21,
															l.Original_Alias_19 <> '' => 20,
															l.Original_Alias_18 <> '' => 19,
															l.Original_Alias_17 <> '' => 18,
															l.Original_Alias_16 <> '' => 17,
															l.Original_Alias_15 <> '' => 16,
															l.Original_Alias_14 <> '' => 15,
															l.Original_Alias_13 <> '' => 14,
															l.Original_Alias_12 <> '' => 13,
															l.Original_Alias_11 <> '' => 12,
															l.Original_Alias_10 <> '' => 11,
															l.Original_Alias_09 <> '' => 10,
															l.Original_Alias_08 <> '' => 9,
															l.Original_Alias_07 <> '' => 8,
															l.Original_Alias_06 <> '' => 7,
															l.Original_Alias_05 <> '' => 6,
															l.Original_Alias_04 <> '' => 5,
															l.Original_Alias_03 <> '' => 4,
															l.Original_Alias_02 <> '' => 3,
															l.Original_Alias_01 <> '' => 2,1); // normalizer needs to fire at least 1 time
															
self.normalizer_fire_count := normalizer_fire_count;
self := l;
end;

add_normalizer_fire_count_uns  := PROJECT(uns,tr_add_normalizer_fire_count_uns (left));

layout_normalize_uns_names := record
integer normalizer_fire_count;
string Original_Primary_Name;
string name_type;
Layout_Innovative_OFAC_Enhanced.Layout_uns;
end;

layout_normalize_uns_names  tr_normalize_uns_names(add_normalizer_fire_count_uns l, integer c) := TRANSFORM 

Original_Primary_Name_concat := trim(l.Original_Primary_Name_01 +
                                       l.Original_Primary_Name_02 + 
                                       l.Original_Primary_Name_03 + 
                                       l.Original_Primary_Name_04); 

self.Original_Primary_Name := choose(c,Original_Primary_Name_concat,
                                       l.Original_Alias_01,
                                       l.Original_Alias_02,
																	     l.Original_Alias_03,
																			 l.Original_Alias_04,
																	     l.Original_Alias_05,
																	     l.Original_Alias_06,
																	     l.Original_Alias_07,
																	     l.Original_Alias_08,
																	     l.Original_Alias_09,
																	     l.Original_Alias_10,
																	     l.Original_Alias_11,
																	     l.Original_Alias_12,
																   	   l.Original_Alias_13,
																	     l.Original_Alias_14,
																	     l.Original_Alias_15,
																	     l.Original_Alias_16,
																	     l.Original_Alias_17,
																	     l.Original_Alias_18,
																	     l.Original_Alias_19,
																	     l.Original_Alias_20,
																	     l.Original_Alias_21,
																	     l.Original_Alias_22,
																	     l.Original_Alias_23,
																			 l.Original_Alias_24,
																	     l.Original_Alias_25);					

self.name_type := choose(c,'',  // c = 1 is always primary name
                              map(l.Original_Alias_Code_01 = 'G' => 'Good AKA',
															l.Original_Alias_Code_01 = 'L' => 'Low AKA',
															l.Original_Alias_Code_01 = 'A' => 'AKA',
															l.Original_Alias_Code_01 = 'F' => 'FKA',''),
											
											         map(l.Original_Alias_Code_02 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_02 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_02 = 'A' => 'AKA',
											         l.Original_Alias_Code_02 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_03 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_03 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_03 = 'A' => 'AKA',
											         l.Original_Alias_Code_03 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_04 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_04 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_04 = 'A' => 'AKA',
											         l.Original_Alias_Code_04 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_05 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_05 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_05 = 'A' => 'AKA',
											         l.Original_Alias_Code_05 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_06 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_06 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_06 = 'A' => 'AKA',
											         l.Original_Alias_Code_06 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_07 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_07 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_07 = 'A' => 'AKA',
											         l.Original_Alias_Code_07 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_08 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_08 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_08 = 'A' => 'AKA',
											         l.Original_Alias_Code_08 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_09 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_09 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_09 = 'A' => 'AKA',
											         l.Original_Alias_Code_09 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_10 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_10 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_10 = 'A' => 'AKA',
											         l.Original_Alias_Code_10 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_11 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_11 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_11 = 'A' => 'AKA',
											         l.Original_Alias_Code_11 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_12 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_12 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_12 = 'A' => 'AKA',
											         l.Original_Alias_Code_12 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_13 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_13 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_13 = 'A' => 'AKA',
											         l.Original_Alias_Code_13 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_14 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_14 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_14 = 'A' => 'AKA',
											         l.Original_Alias_Code_14 = 'F' => 'FKA',''),
															 
															 
															 map(l.Original_Alias_Code_15 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_15 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_15 = 'A' => 'AKA',
											         l.Original_Alias_Code_15 = 'F' => 'FKA',''),

															 map(l.Original_Alias_Code_16 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_16 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_16 = 'A' => 'AKA',
											         l.Original_Alias_Code_16 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_17 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_17 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_17 = 'A' => 'AKA',
											         l.Original_Alias_Code_17 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_18 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_18 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_18 = 'A' => 'AKA',
											         l.Original_Alias_Code_18 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_19 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_19 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_19 = 'A' => 'AKA',
											         l.Original_Alias_Code_19 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_20 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_20 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_20 = 'A' => 'AKA',
											         l.Original_Alias_Code_20 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_21 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_21 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_21 = 'A' => 'AKA',
											         l.Original_Alias_Code_21 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_22 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_22 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_22 = 'A' => 'AKA',
											         l.Original_Alias_Code_22 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_23 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_23 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_23 = 'A' => 'AKA',
											         l.Original_Alias_Code_23 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_24 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_24 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_24 = 'A' => 'AKA',
											         l.Original_Alias_Code_24 = 'F' => 'FKA',''),
															 
															 map(l.Original_Alias_Code_25 = 'G' => 'Good AKA',
											         l.Original_Alias_Code_25 = 'L' => 'Low AKA',
											         l.Original_Alias_Code_25 = 'A' => 'AKA',
											         l.Original_Alias_Code_25 = 'F' => 'FKA',''));								
	
self := l;
end; 

normalize_uns_names := 
     normalize(add_normalizer_fire_count_uns,left.normalizer_fire_count,tr_normalize_uns_names(left,counter));


////////******** add normalizer fire count for addresses
layout_add_normalizer_fire_count_address_uns := record
integer normalizer_fire_count;
string Original_Primary_Name;
string name_type;
Layout_Innovative_OFAC_Enhanced.Layout_uns;
end;


layout_add_normalizer_fire_count_address_uns  tr_add_normalizer_fire_count_address_uns(normalize_uns_names l ) := TRANSFORM

normalizer_fire_count := map( l.Original_Add_10_Line_01 <> '' => 10,
															l.Original_Add_09_Line_01 <> '' => 9,
															l.Original_Add_08_Line_01 <> '' => 8,
															l.Original_Add_07_Line_01 <> '' => 7,
															l.Original_Add_06_Line_01 <> '' => 6,
															l.Original_Add_05_Line_01 <> '' => 5,
															l.Original_Add_04_Line_01 <> '' => 4,
															l.Original_Add_03_Line_01 <> '' => 3,
															l.Original_Add_02_Line_01 <> '' => 2,
															l.Original_Add_01_Line_01 <> '' => 1,1);  // normalizer needs to fire at least 1 time
															
self.normalizer_fire_count := normalizer_fire_count;
self := l;
end;

add_normalizer_fire_count_address_uns  := PROJECT(normalize_uns_names,tr_add_normalizer_fire_count_address_uns (left));

layout_normalize_uns_address := record
string50 Original_Address_01;
string50 Original_Address_02;
string50 Original_Address_03;
string50 Original_Address_04;
layout_add_normalizer_fire_count_address_uns;
end;

layout_normalize_uns_address tr_normalize_uns_addresses(add_normalizer_fire_count_address_uns l, integer c) := TRANSFORM 

self.Original_Address_01 := choose(c,l.Original_Add_01_Line_01,
                                     l.Original_Add_02_Line_01,
																		 l.Original_Add_03_Line_01,
																		 l.Original_Add_04_Line_01,
																		 l.Original_Add_05_Line_01,
																		 l.Original_Add_06_Line_01,
																		 l.Original_Add_07_Line_01,
																		 l.Original_Add_08_Line_01,
																		 l.Original_Add_09_Line_01,
																		 l.Original_Add_10_Line_01);

self.Original_Address_02 := choose(c,l.Original_Add_01_Line_02,
                                     l.Original_Add_02_Line_02,
																		 l.Original_Add_03_Line_02,
																		 l.Original_Add_04_Line_02,
																		 l.Original_Add_05_Line_02,
																		 l.Original_Add_06_Line_02,
																		 l.Original_Add_07_Line_02,
																		 l.Original_Add_08_Line_02,
																		 l.Original_Add_09_Line_02,
																		 l.Original_Add_10_Line_02);  																		 
																		 
self.Original_Address_03 := choose(c,l.Original_Add_01_Line_03,
                                     l.Original_Add_02_Line_03,
																		 l.Original_Add_03_Line_03,
																		 l.Original_Add_04_Line_03,
																		 l.Original_Add_05_Line_03,
																		 l.Original_Add_06_Line_03,
																		 l.Original_Add_07_Line_03,
																		 l.Original_Add_08_Line_03,
																		 l.Original_Add_09_Line_03,
																		 l.Original_Add_10_Line_03);


self.Original_Address_04 := choose(c,l.Original_Add_01_Line_04,
                                     l.Original_Add_02_Line_04,
																		 l.Original_Add_03_Line_04,
																		 l.Original_Add_04_Line_04,
																		 l.Original_Add_05_Line_04,
																		 l.Original_Add_06_Line_04,
																		 l.Original_Add_07_Line_04,
																		 l.Original_Add_08_Line_04,
																		 l.Original_Add_09_Line_04,
																		 l.Original_Add_10_Line_04);

self := l;
end; 

normalize_uns_addresses := normalize(add_normalizer_fire_count_address_uns,left.normalizer_fire_count,tr_normalize_uns_addresses(left,counter));


Patriot_preprocess.layout_patriot_common tr_patriot_common_UNS(normalize_uns_addresses l) := TRANSFORM
		 
		Original_natl_remarks :=  
			  map(l.original_natl_id_01 <> '' 
				        => '; Identifications: ' + map(l.Original_ID_Type_01 = 'PP' => 'Passport ',
									                             l.Original_ID_Type_01 = 'NI' => 'National ID ','') 
																					       + trim(l.original_natl_id_01,left,right) + ', ', '') + 									                                                                    
        map(l.original_natl_id_02 <> '' 
				        => map(l.Original_ID_Type_02 = 'PP' => 'Passport ',
								       l.Original_ID_Type_02 = 'NI' => 'National ID ','') 
											    + trim(l.original_natl_id_02,left,right), '');		
				
		Original_Title_remarks := 
		    map(l.Original_Title_01 <> '' => '; Titles: ' + trim(l.Original_Title_01) + ', ', '') +
			  map(l.Original_Title_02 <> '' => trim(l.Original_Title_02) + ', ', '') +            
			  map(l.Original_Title_03 <> '' => trim(l.Original_Title_03) , '') ;

	
		Original_Designation_remarks := 
		    map(l.Original_Designation_01 <> '' => '; Designations: ' + trim(l.Original_Designation_01) + ', ', '') +
			  map(l.Original_Designation_02 <> '' => trim(l.Original_Designation_02) + ', ', '') +            
			  map(l.Original_Designation_03 <> '' => trim(l.Original_Designation_03) , '') ;
	
	 	Original_DOB_remarks := 
		    map(l.Original_DOB_01 <> '' => '; Date of Births: ' + trim(l.Original_DOB_01) + ', ', '') +
			  map(l.Original_DOB_02 <> '' => trim(l.Original_DOB_02) + ', ', '') +            
			  map(l.Original_DOB_03 <> '' => trim(l.Original_DOB_03) + ', ', '') +
			  map(l.Original_DOB_04 <> '' => trim(l.Original_DOB_04) + ', ', '') +
			  map(l.Original_DOB_05 <> '' => trim(l.Original_DOB_05) + ', ', '') +
			  map(l.Original_DOB_06 <> '' => trim(l.Original_DOB_06) + ', ', '') +
			  map(l.Original_DOB_07 <> '' => trim(l.Original_DOB_07) + ', ', '') +
			  map(l.Original_DOB_08 <> '' => trim(l.Original_DOB_08) + ', ', '') +
			  map(l.Original_DOB_09 <> '' => trim(l.Original_DOB_09) + ', ', '') +
			  map(l.Original_DOB_10 <> '' => trim(l.Original_DOB_10) ,'') ;
			
	  Original_POB_remarks := 
		    map(l.Original_POB_01 <> '' => '; Places of Birth: ' + trim(l.Original_POB_01) + ', ', '') +
			  map(l.Original_POB_02 <> '' => trim(l.Original_POB_02) + ', ', '') +            
			  map(l.Original_POB_03 <> '' => trim(l.Original_POB_03) + ', ', '') +
			  map(l.Original_POB_04 <> '' => trim(l.Original_POB_04) + ', ', '') +
			  map(l.Original_POB_05 <> '' => trim(l.Original_POB_05) + ', ', '') +
			  map(l.Original_POB_06 <> '' => trim(l.Original_POB_06) + ', ', '') +
			  map(l.Original_POB_07 <> '' => trim(l.Original_POB_07) + ', ', '') +
			  map(l.Original_POB_08 <> '' => trim(l.Original_POB_08) + ', ', '') +
			  map(l.Original_POB_09 <> '' => trim(l.Original_POB_09) + ', ', '') +
			  map(l.Original_POB_10 <> '' => trim(l.Original_POB_10) , '') ;

    Original_Date_Added_To_List_remarks := 
        map(l.Original_Date_Added_To_List <> '' => '; Date Added to List: ' + trim(l.Original_Date_Added_To_List),'');
	
	  Original_Country_remarks := 
		   map(l.Original_Country_01 <> '' => '; Nationalities: ' + trim(l.Original_Country_01) + ', ', '') +
			 map(l.Original_Country_02 <> '' => trim(l.Original_Country_02) + ', ', '') +            
			 map(l.Original_Country_03 <> '' => trim(l.Original_Country_03) + ', ', '') +
			 map(l.Original_Country_04 <> '' => trim(l.Original_Country_04) + ', ', '') +
			 map(l.Original_Country_05 <> '' => trim(l.Original_Country_05) + ', ', '') +
			 map(l.Original_Country_06 <> '' => trim(l.Original_Country_06) + ', ', '') +
			 map(l.Original_Country_07 <> '' => trim(l.Original_Country_07) + ', ', '') +
			 map(l.Original_Country_08 <> '' => trim(l.Original_Country_08) + ', ', '') +
			 map(l.Original_Country_09 <> '' => trim(l.Original_Country_09) + ', ', '') +
			 map(l.Original_Country_10 <> '' => trim(l.Original_Country_10) ,'') ;
                                                                                                                                     
    Original_Additional_Info_remarks := 
       map(l.Original_Additional_Info <> '' => '; Additional Information: ' + trim(l.Original_Additional_Info),'');
	  	
	  concat_remarks :=  
	                   Original_natl_remarks +
	                   Original_Title_remarks +
										 Original_Designation_remarks +										 
										 Original_DOB_remarks +
										 Original_POB_remarks +
										 Original_Date_Added_To_List_remarks +
										 Original_Country_remarks +
										 Original_Additional_Info_remarks;
										 
	concat_remarks_clean := regexreplace(', ;',concat_remarks[3..],';'); 
  
 	remarks1 := concat_remarks_clean[1..75];
  remarks2 := concat_remarks_clean[76..150];
  remarks3 := concat_remarks_clean[151..225];
  remarks4 := concat_remarks_clean[226..300];
  remarks5 := concat_remarks_clean[301..375];
  remarks6 := concat_remarks_clean[376..450];
  remarks7 := concat_remarks_clean[451..525];
	remarks8 := concat_remarks_clean[526..600];
  remarks9 := concat_remarks_clean[601..675];
	remarks10 := concat_remarks_clean[676..750];
	remarks11 := concat_remarks_clean[751..825];	
	remarks12 := concat_remarks_clean[826..900];
	remarks13 := concat_remarks_clean[901..975];
	remarks14 := concat_remarks_clean[976..1050];
	remarks15 := concat_remarks_clean[1051..1125];
	remarks16 := concat_remarks_clean[1126..1200];
	remarks17 := concat_remarks_clean[1201..1275];
	remarks18 := concat_remarks_clean[1276..1350];
	remarks19 := concat_remarks_clean[1351..1425];
	remarks20 := concat_remarks_clean[1426..];	

  self.pty_key := trim(l.Location) + (integer) (l.Serial_Number);
  self.source := 'United Nations Named Terrorists';
  self.orig_pty_name := l.Original_Primary_Name;
  self.name_type := l.name_type;	
	self.addr_1 := l.Original_Address_01;
  self.addr_2 := l.Original_Address_02;
  self.addr_3 := l.Original_Address_03 + ' ' + l.Original_Address_04;
  self.remarks_1 := remarks1; 												
  self.remarks_2 := remarks2;	  
	self.remarks_3 := remarks3;
  self.remarks_4 := remarks4;
  self.remarks_5 := remarks5;
  self.remarks_6 := remarks6;
  self.remarks_7 := remarks7;
  self.remarks_8 := remarks8;
  self.remarks_9 := remarks9;
	self.remarks_10 := remarks10;
  self.remarks_11 := remarks11;
	self.remarks_12 := remarks12;
  self.remarks_13 := remarks13;
	self.remarks_14 := remarks14;
	self.remarks_15 := remarks15;
  self.remarks_16 := remarks16;
	self.remarks_17 := remarks17;
  self.remarks_18 := remarks18;
	self.remarks_19 := remarks19;
	self.remarks_20 := remarks20;	
	self.entity_flag := map(l.location = 'AQO' => 'Y', '');
 self := [];
 end;
 
patriot_common_UNS := PROJECT(normalize_uns_addresses,tr_patriot_common_UNS(left));


// cft

	Layout_Innovative_OFAC_Enhanced.TempLayoutCFT NormCommodityFutureTradingAliases1TO20(cft L, INTEGER C) := TRANSFORM
		self.Original_Primary_Name 	:= case(C, 1 => L.Original_Alias_01
																					,2 => L.Original_Alias_02
																					,3 => L.Original_Alias_03
																					,4 => L.Original_Alias_04
																					,5 => L.Original_Alias_05
																					,6 => L.Original_Alias_06
																					,7 => L.Original_Alias_07
																					,8 => L.Original_Alias_08
																					,9 => L.Original_Alias_09
																					,10 => L.Original_Alias_10
																					,11 => L.Original_Alias_11
																					,12 => L.Original_Alias_12
																					,13 => L.Original_Alias_13
																					,14 => L.Original_Alias_14
																					,15 => L.Original_Alias_15
																					,16 => L.Original_Alias_16
																					,17 => L.Original_Alias_17
																					,18 => L.Original_Alias_18
																					,19 => L.Original_Alias_19
																					,20 => L.Original_Alias_20
																					,'');
		self.Primary_Record 				:= 'N';
		self 												:= L;
	END;
	
	NormalizedCommodityFutureTradingAliases1TO20	:= NORMALIZE(cft, 20, NormCommodityFutureTradingAliases1TO20(LEFT,COUNTER));
	
	Layout_Innovative_OFAC_Enhanced.TempLayoutCFT NormCommodityFutureTradingAliases21TO25Plus(cft L, INTEGER C) := TRANSFORM
		self.Original_Primary_Name 	:= case(C, 1 => L.Original_Alias_21
																						,2 => L.Original_Alias_22
																						,3 => L.Original_Alias_23
																						,4 => L.Original_Alias_24
																						,5 => L.Original_Alias_25
																						,6 => ''
																						,'');
			self.Primary_Record 				:= 'N';
			self 												:= L;
	END;
	
	NormalizedCommodityFutureTradingAliases21TO25Plus	:= NORMALIZE(cft, 7, NormCommodityFutureTradingAliases21TO25Plus(LEFT,COUNTER));
	
	NormalizedCFT 				:= NormalizedCommodityFutureTradingAliases1TO20 + NormalizedCommodityFutureTradingAliases21TO25Plus;
	NotNullNormalizedCFT 	:= dedup(NormalizedCFT(TRIM(Original_Primary_Name, left, right) <> '' or TRIM(line_data_1, left, right) <> ''),all);
	
	Patriot_preprocess.layout_patriot_common ReformatCFT(NotNullNormalizedCFT L, integer C) := TRANSFORM
		
		v_serial_no 										:= regexfind('(^[0]*)(\\d+)', regexfind('\\d+', regexreplace('^94', L.Serial_Number, ''), 0), 2);
		self.pty_key 										:= TRIM(L.Application_Code, left, right) + TRIM(v_serial_no, left, right);
		self.source 										:= 'Cmmdty. Fut. Trad. Commission Lst. of Reg. & Self-Reg. Auth.';
		self.orig_pty_name 							:= ut.fnTrim2Upper(CHOOSE(C,L.line_data_1, L.Original_Primary_Name));
		self.country 										:= TRIM(L.Original_Add_01_Line_01, left, right);
		self.name_type 									:= CHOOSE(C,'',if(L.Primary_Record = 'N', 'AKA', ''));
		self.addr_1 										:= TRIM(L.Original_Add_01_Line_01);
		self.remarks_1 									:= if(TRIM(L.Original_Date_Added_To_List) <> ''
																				,'DATE ADDED TO LIST: ' + TRIM(L.Original_Date_Added_To_List)
                                        ,'');
		self.remarks_2 									:= if(TRIM(L.Original_Grounds_For_Addition) <> ''
																				,'GROUNDS FOR ADDITION: ' + TRIM(L.Original_Grounds_For_Addition)
                                        ,'');
    self.entity_flag := 'Y';
		self := [];
	END;

	NormCFT	:= SORT(NORMALIZE(NotNullNormalizedCFT,2,ReformatCFT(LEFT,COUNTER)),pty_key,orig_pty_name)(orig_pty_name <> '');
	
	patriot_common_cft := DEDUP(NormCFT,ALL);

// add entity flag to fin

Patriot_preprocess.layout_patriot_common tr_add_entity_flag_fin(fin l) := TRANSFORM

 self.entity_flag := '';	
	self := l;
	self := [];	
  end;

fin_with_entity_flag := PROJECT(fin,tr_add_entity_flag_fin(left));
		
EXPORT Mapping_Innovative_OFAC_Enhanced := patriot_common_PEP + 
																					 patriot_common_OSC + 
																					 patriot_common_OCC + 
																					 patriot_common_FBI + 
																					 patriot_common_UNS + 
																					 patriot_common_cft +
																					 fin_with_entity_flag																					 
				: persist('~thor::persist::out::patriot::preprocess::Innovative_OFAC_Enhanced');